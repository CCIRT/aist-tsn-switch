// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_ethernet_frame_arbiter;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;

  parameter integer FRAME_GAP = 0;
  parameter integer DATA_WIDTH = 8;

  localparam integer ENABLE_RANDAMIZE = 1;
  localparam integer TIMEOUT_CYCLE = 1000000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam DROP_ENABLE = 1;
  localparam [0:0] DROP_ENABLE = 1;
  localparam integer KEEP_WIDTH = DATA_WIDTH / 8;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // almost_full input from rear FIFO
  reg  fifo_is_almost_full;

  // AXI4-Stream In 7
  wire [7:0] s_axis_7_tdata;
  wire       s_axis_7_tvalid;
  wire       s_axis_7_tready;
  wire       s_axis_7_tlast;
  wire       s_axis_7_tuser;

  // AXI4-Stream In 6
  wire [7:0] s_axis_6_tdata;
  wire       s_axis_6_tvalid;
  wire       s_axis_6_tready;
  wire       s_axis_6_tlast;
  wire       s_axis_6_tuser;

  // AXI4-Stream In 5
  wire [7:0] s_axis_5_tdata;
  wire       s_axis_5_tvalid;
  wire       s_axis_5_tready;
  wire       s_axis_5_tlast;
  wire       s_axis_5_tuser;

  // AXI4-Stream In 4
  wire [7:0] s_axis_4_tdata;
  wire       s_axis_4_tvalid;
  wire       s_axis_4_tready;
  wire       s_axis_4_tlast;
  wire       s_axis_4_tuser;

  // AXI4-Stream In 3
  wire [7:0] s_axis_3_tdata;
  wire       s_axis_3_tvalid;
  wire       s_axis_3_tready;
  wire       s_axis_3_tlast;
  wire       s_axis_3_tuser;

  // AXI4-Stream In 2
  wire [7:0] s_axis_2_tdata;
  wire       s_axis_2_tvalid;
  wire       s_axis_2_tready;
  wire       s_axis_2_tlast;
  wire       s_axis_2_tuser;

  // AXI4-Stream In 1
  wire [7:0] s_axis_1_tdata;
  wire       s_axis_1_tvalid;
  wire       s_axis_1_tready;
  wire       s_axis_1_tlast;
  wire       s_axis_1_tuser;

  // AXI4-Stream In 0
  wire [7:0] s_axis_0_tdata;
  wire       s_axis_0_tvalid;
  wire       s_axis_0_tready;
  wire       s_axis_0_tlast;
  wire       s_axis_0_tuser;

  // AXI4-Stream Out
  wire [7:0] m_axis_tdata;
  wire       m_axis_tvalid;
  wire       m_axis_tready;
  wire       m_axis_tlast;
  wire       m_axis_tuser;
  wire [DATA_WIDTH-1:0] s_axis_7_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_7_tkeep;
  wire                  s_axis_7_tvalid;
  wire                  s_axis_7_tready;
  wire                  s_axis_7_tlast;

  // AXI4-Stream In 6
  wire [DATA_WIDTH-1:0] s_axis_6_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_6_tkeep;
  wire                  s_axis_6_tvalid;
  wire                  s_axis_6_tready;
  wire                  s_axis_6_tlast;

  // AXI4-Stream In 5
  wire [DATA_WIDTH-1:0] s_axis_5_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_5_tkeep;
  wire                  s_axis_5_tvalid;
  wire                  s_axis_5_tready;
  wire                  s_axis_5_tlast;

  // AXI4-Stream In 4
  wire [DATA_WIDTH-1:0] s_axis_4_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_4_tkeep;
  wire                  s_axis_4_tvalid;
  wire                  s_axis_4_tready;
  wire                  s_axis_4_tlast;

  // AXI4-Stream In 3
  wire [DATA_WIDTH-1:0] s_axis_3_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_3_tkeep;
  wire                  s_axis_3_tvalid;
  wire                  s_axis_3_tready;
  wire                  s_axis_3_tlast;

  // AXI4-Stream In 2
  wire [DATA_WIDTH-1:0] s_axis_2_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_2_tkeep;
  wire                  s_axis_2_tvalid;
  wire                  s_axis_2_tready;
  wire                  s_axis_2_tlast;

  // AXI4-Stream In 1
  wire [DATA_WIDTH-1:0] s_axis_1_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_1_tkeep;
  wire                  s_axis_1_tvalid;
  wire                  s_axis_1_tready;
  wire                  s_axis_1_tlast;

  // AXI4-Stream In 0
  wire [DATA_WIDTH-1:0] s_axis_0_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_0_tkeep;
  wire                  s_axis_0_tvalid;
  wire                  s_axis_0_tready;
  wire                  s_axis_0_tlast;

  // AXI4-Stream Out
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire [KEEP_WIDTH-1:0] m_axis_tkeep;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;

  //-------------------------
  // Timer
  //-------------------------
  integer i = 0;
  initial begin
    clk = 0;
    rstn = 0;
    fifo_is_almost_full = 0;

    for (i = 0; i < TIMEOUT_CYCLE; i++) begin
      @(posedge clk);
      if (i == RESET_CYCLE) begin
        rstn = 1;
      end
      if (i == S_AXIS_TREADY_OUT_CYCLE + 1) begin
        fifo_is_almost_full = 1;
      end else begin
        fifo_is_almost_full = 0;
      end
    end

    $display("Error: Timeout");
    $fatal();
    `FATAL;
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
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*7)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*7),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_7_i (
    clk,
    rstn,
    s_axis_7_tdata,
    s_axis_7_tkeep,
    s_axis_7_tvalid,
    s_axis_7_tready,
    s_axis_7_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*6)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*6),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_6_i (
    clk,
    rstn,
    s_axis_6_tdata,
    s_axis_6_tkeep,
    s_axis_6_tvalid,
    s_axis_6_tready,
    s_axis_6_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*5)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*5),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_5_i (
    clk,
    rstn,
    s_axis_5_tdata,
    s_axis_5_tkeep,
    s_axis_5_tvalid,
    s_axis_5_tready,
    s_axis_5_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*4)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*4),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_4_i (
    clk,
    rstn,
    s_axis_4_tdata,
    s_axis_4_tkeep,
    s_axis_4_tvalid,
    s_axis_4_tready,
    s_axis_4_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*3)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*3),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_3_i (
    clk,
    rstn,
    s_axis_3_tdata,
    s_axis_3_tkeep,
    s_axis_3_tvalid,
    s_axis_3_tready,
    s_axis_3_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*2)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*2),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_2_i (
    clk,
    rstn,
    s_axis_2_tdata,
    s_axis_2_tkeep,
    s_axis_2_tvalid,
    s_axis_2_tready,
    s_axis_2_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*1)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*1),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_1_i (
    clk,
    rstn,
    s_axis_1_tdata,
    s_axis_1_tkeep,
    s_axis_1_tvalid,
    s_axis_1_tready,
    s_axis_1_tlast
  );

  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*0)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE+1600*0),
    .DATA_WIDTH(DATA_WIDTH)
  ) pcap_to_stream_0_i (
    clk,
    rstn,
    s_axis_0_tdata,
    s_axis_0_tkeep,
    s_axis_0_tvalid,
    s_axis_0_tready,
    s_axis_0_tlast
  );

  compare_stream_with_pcap #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM * 8),
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE)
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE),
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH)
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
  assign s_axis_7_tuser = 1'b0;
  assign s_axis_6_tuser = 1'b0;
  assign s_axis_5_tuser = 1'b0;
  assign s_axis_4_tuser = 1'b0;
  assign s_axis_3_tuser = 1'b0;
  assign s_axis_2_tuser = 1'b0;
  assign s_axis_1_tuser = 1'b0;
  assign s_axis_0_tuser = 1'b0;

  ethernet_frame_arbiter #(
    .DROP_ENABLE(DROP_ENABLE)
  ethernet_frame_arbiter #(
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH)
  ) ethernet_frame_arbiter_i (
    clk,
    rstn,
    s_axis_7_tdata,
    s_axis_7_tvalid,
    s_axis_7_tready,
    s_axis_7_tlast,
    s_axis_7_tuser,
    s_axis_6_tdata,
    s_axis_6_tvalid,
    s_axis_6_tready,
    s_axis_6_tlast,
    s_axis_6_tuser,
    s_axis_5_tdata,
    s_axis_5_tvalid,
    s_axis_5_tready,
    s_axis_5_tlast,
    s_axis_5_tuser,
    s_axis_4_tdata,
    s_axis_4_tvalid,
    s_axis_4_tready,
    s_axis_4_tlast,
    s_axis_4_tuser,
    s_axis_3_tdata,
    s_axis_3_tvalid,
    s_axis_3_tready,
    s_axis_3_tlast,
    s_axis_3_tuser,
    s_axis_2_tdata,
    s_axis_2_tvalid,
    s_axis_2_tready,
    s_axis_2_tlast,
    s_axis_2_tuser,
    s_axis_1_tdata,
    s_axis_1_tvalid,
    s_axis_1_tready,
    s_axis_1_tlast,
    s_axis_1_tuser,
    s_axis_0_tdata,
    s_axis_0_tvalid,
    s_axis_0_tready,
    s_axis_0_tlast,
    s_axis_0_tuser,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_tuser
    s_axis_7_tkeep,
    s_axis_7_tvalid,
    s_axis_7_tready,
    s_axis_7_tlast,
    s_axis_6_tdata,
    s_axis_6_tkeep,
    s_axis_6_tvalid,
    s_axis_6_tready,
    s_axis_6_tlast,
    s_axis_5_tdata,
    s_axis_5_tkeep,
    s_axis_5_tvalid,
    s_axis_5_tready,
    s_axis_5_tlast,
    s_axis_4_tdata,
    s_axis_4_tkeep,
    s_axis_4_tvalid,
    s_axis_4_tready,
    s_axis_4_tlast,
    s_axis_3_tdata,
    s_axis_3_tkeep,
    s_axis_3_tvalid,
    s_axis_3_tready,
    s_axis_3_tlast,
    s_axis_2_tdata,
    s_axis_2_tkeep,
    s_axis_2_tvalid,
    s_axis_2_tready,
    s_axis_2_tlast,
    s_axis_1_tdata,
    s_axis_1_tkeep,
    s_axis_1_tvalid,
    s_axis_1_tready,
    s_axis_1_tlast,
    s_axis_0_tdata,
    s_axis_0_tkeep,
    s_axis_0_tvalid,
    s_axis_0_tready,
    s_axis_0_tlast,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, ethernet_frame_arbiter_i);
  end

endmodule

`default_nettype wire
