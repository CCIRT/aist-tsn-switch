// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_et_deadline;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 3;
  parameter integer DATA_WIDTH = 8;
  parameter integer FRAME_LENGTH_WIDTH = 16;            // Must be aligned to DATA_WIDTH
  parameter integer TIMESTAMP_WIDTH = 72;               // Must be aligned to DATA_WIDTH

  localparam integer ENABLE_RANDAMIZE = 1;
  localparam integer TIMEOUT_CYCLE = 50000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam KEEP_WIDTH = DATA_WIDTH / 8;
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH
  localparam [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 72'hABFEDCBA9876543210;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream In without timestamp
  // [Ethernet Frame]
  wire [DATA_WIDTH-1:0] s_axis_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_tkeep;
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;

  // AXI4-Stream Timestamp In
  reg [TIMESTAMP_WIDTH-1:0] s_axis_timestamp_tdata;
  reg                       s_axis_timestamp_tvalid = 1'b0;
  wire                      s_axis_timestamp_tready;

  // AXI4-Stream Out with timestamp
  // [Ethernet Frame]/[Timestamp]
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire [KEEP_WIDTH-1:0] m_axis_tkeep;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;

  // AXI4-Stream Timestamp out
  wire [TIMESTAMP_WIDTH-1:0] m_axis_timestamp_tdata;
  wire                       m_axis_timestamp_tvalid;
  reg                        m_axis_timestamp_tready = 1'b0;

  //-------------------------
  // Timer
  //-------------------------
  integer i = 0;
  initial begin
    clk = 0;
    rstn = 0;

    for (i = 0; i < TIMEOUT_CYCLE; i++) begin
      @(posedge clk);
      if (i == RESET_CYCLE) begin
        rstn = 1;
      end
    end

    $display("Error: Timeout");
    `FATAL;
  end

  //-------------------------
  // Generate clock
  //-------------------------
  always clk = #10 ~clk;

  //-------------------------
  // Test tasks
  //-------------------------
  task push_timestamp(input [TIMESTAMP_WIDTH-1:0] timestamp);
    s_axis_timestamp_tdata <= timestamp;
    s_axis_timestamp_tvalid <= 1'b1;
    @(posedge clk);

    while (!s_axis_timestamp_tready) begin
      @(posedge clk);
    end

    s_axis_timestamp_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task pop_timestamp(output [TIMESTAMP_WIDTH-1:0] timestamp);
    m_axis_timestamp_tready <= 1'b1;
    @(posedge clk);

    while (!m_axis_timestamp_tvalid) begin
      @(posedge clk);
    end

    timestamp <= m_axis_timestamp_tdata;
    m_axis_timestamp_tready <= 1'b0;
    @(posedge clk);
  endtask

  //-------------------------
  // Generate timestamps
  //-------------------------
  reg [71:0] out_ts;
  localparam [71:0] TEST_TS = 72'h01234567_89abcdef_0;
  initial begin
    // wait device reset
    @(posedge clk);
    @(posedge rstn);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    if (REPEAT_NUM != 8) begin
      $display("Error: this test is designed for REPEAT_NUM = 8, but got %d", REPEAT_NUM);
      `FATAL;
    end

    fork
      begin
        // 0-timestamp. must be dropped
        push_timestamp(0);
        push_timestamp(0);

        // non-zero timestamp. must be output
        push_timestamp(TEST_TS);
        push_timestamp(TEST_TS + 1);

        push_timestamp(0);
        push_timestamp(TEST_TS + 2);
        push_timestamp(0);
        push_timestamp(TEST_TS + 3);
      end
      begin
        // add delay for test...
        repeat (20) @(posedge clk);

        // pop x4
        for (int i = 0; i < 4; i = i + 1) begin
          pop_timestamp(out_ts);
          if (out_ts != TEST_TS + i) begin
            $display("Error: wrong timestamp: expect %x but got %x", TEST_TS + i, out_ts);
            @(posedge clk);
            `FATAL;
          end
        end
      end
    join

    @(posedge clk);
  end

  //-------------------------
  // Utility modules
  //-------------------------
  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_FRAME_LENGTH_HEADER(0),
    .ENABLE_TIMESTAMP_FOOTER(0),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .TIMESTAMP_VAL(TIMESTAMP_VAL)
  ) pcap_to_stream_i (
    clk,
    rstn,
    s_axis_tdata,
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast
  );

  compare_stream_with_pcap #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM - 4),
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_FRAME_LENGTH_HEADER(0),
    .ENABLE_TIMESTAMP_FOOTER(0),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .COMPARE_WITH_FRAME_LENGTH(1),
    .COMPARE_WITH_TIMESTAMP(0),
    .TIMESTAMP_VAL(TIMESTAMP_VAL)
  ) compare_stream_with_pcap_i (
    clk,
    rstn,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast
  );

  //-------------------------
  // Test module
  //-------------------------
  et_deadline #(
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH)
  ) et_deadline_i (
    clk,
    rstn,
    s_axis_tdata,
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_timestamp_tdata,
    s_axis_timestamp_tvalid,
    s_axis_timestamp_tready,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_timestamp_tdata,
    m_axis_timestamp_tvalid,
    m_axis_timestamp_tready
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0);
  end

endmodule

`default_nettype wire
