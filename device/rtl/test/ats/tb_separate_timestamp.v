// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
<<<<<<< HEAD
=======
`include "fatal.vh"
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

module tb_separate_timestamp;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
  parameter integer INPUT_FRAME_LENGTH = 0;
<<<<<<< HEAD
=======
  parameter integer DATA_WIDTH = 8;
  parameter integer FRAME_LENGTH_WIDTH = 16;            // Must be aligned to DATA_WIDTH
  parameter integer TIMESTAMP_WIDTH = 72;               // Must be aligned to DATA_WIDTH
  parameter integer OPT_LEVEL = 0;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  localparam integer ENABLE_RANDAMIZE = 1;
  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

<<<<<<< HEAD
  localparam DATA_WIDTH = 8;
  localparam FRAME_LENGTH_WIDTH = 16;                   // Must be aligned to DATA_WIDTH
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH
  localparam TIMESTAMP_WIDTH = 72;                      // Must be aligned to DATA_WIDTH
=======
  localparam KEEP_WIDTH = DATA_WIDTH / 8;
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  localparam [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 72'hABFEDCBA9876543210;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  wire [DATA_WIDTH-1:0] s_axis_tdata;
<<<<<<< HEAD
=======
  wire [KEEP_WIDTH-1:0] s_axis_tkeep;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;

<<<<<<< HEAD
  // AXI4-Stream Frame length In
  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata = INPUT_FRAME_LENGTH;
  wire                          s_axis_frame_length_tvalid = 1'b1;
  wire                          s_axis_frame_length_tready;

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  wire [DATA_WIDTH-1:0] m_axis_tdata;
=======
  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire [KEEP_WIDTH-1:0] m_axis_tkeep;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;

  // AXI4-Stream Timestamp Out
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
      if (i == S_AXIS_TREADY_OUT_CYCLE) begin
        m_axis_timestamp_tready = 1'b1;
      end
    end

    $display("Error: Timeout");
<<<<<<< HEAD
    $fatal();
=======
    `FATAL;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  end

  //-------------------------
  // Generate clock
  //-------------------------
  always clk = #10 ~clk;

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
    .ENABLE_TIMESTAMP_FOOTER(1),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .TIMESTAMP_VAL(TIMESTAMP_VAL)
  ) pcap_to_stream_i (
    clk,
    rstn,
    s_axis_tdata,
<<<<<<< HEAD
=======
    s_axis_tkeep,
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast
  );

  compare_stream_with_pcap #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
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
<<<<<<< HEAD
=======
    m_axis_tkeep,
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast
  );

  //-------------------------
<<<<<<< HEAD
  // Test module
  //-------------------------
  separate_timestamp #(
    .DATA_WIDTH(DATA_WIDTH),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH)
=======
  // Verify timestamp
  //-------------------------
  always @(posedge clk) begin
    if (m_axis_timestamp_tvalid && m_axis_timestamp_tready) begin
      if (m_axis_timestamp_tdata != TIMESTAMP_VAL) begin
        $display("Error: expect timestamp 0x%x but got 0x%x", TIMESTAMP_VAL, m_axis_timestamp_tdata);
        `FATAL;
      end else begin
        $display("Received correct timestamp");
      end
    end
  end

  //-------------------------
  // Test module
  //-------------------------
  separate_timestamp #(
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .OPT_LEVEL(OPT_LEVEL)
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  ) separate_timestamp_i (
    clk,
    rstn,
    s_axis_tdata,
<<<<<<< HEAD
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_frame_length_tdata,
    s_axis_frame_length_tvalid,
    s_axis_frame_length_tready,
    m_axis_tdata,
=======
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tkeep,
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
    $dumpvars(0, separate_timestamp_i);
  end

endmodule

`default_nettype wire
