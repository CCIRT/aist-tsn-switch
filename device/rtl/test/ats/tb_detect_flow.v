// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module tb_detect_flow;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
  parameter integer INPUT_FRAME_LENGTH = 0;

  localparam integer ENABLE_RANDAMIZE = 1;
  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam DATA_WIDTH = 8;
  localparam FLOW_NUM = 16;
  localparam FLOW_WIDTH = 8;
  localparam FRAME_LENGTH_WIDTH = 16;                   // Must be aligned to DATA_WIDTH
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH
  localparam TIMESTAMP_WIDTH = 72;                      // Must be aligned to DATA_WIDTH

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  wire [95:0] cond_flow_1 = {8'd192, 8'd168, 8'd1, 8'd2, 16'd0, 32'd0, 16'd0};
  wire [95:0] cond_flow_2 = {96{1'b1}};
  wire [95:0] cond_flow_3 = {96{1'b1}};
  wire [95:0] cond_flow_4 = {96{1'b1}};
  wire [95:0] cond_flow_5 = {96{1'b1}};
  wire [95:0] cond_flow_6 = {96{1'b1}};
  wire [95:0] cond_flow_7 = {96{1'b1}};
  wire [95:0] cond_flow_8 = {96{1'b1}};
  wire [95:0] cond_flow_9 = {96{1'b1}};
  wire [95:0] cond_flow_10 = {96{1'b1}};
  wire [95:0] cond_flow_11 = {96{1'b1}};
  wire [95:0] cond_flow_12 = {96{1'b1}};
  wire [95:0] cond_flow_13 = {96{1'b1}};
  wire [95:0] cond_flow_14 = {96{1'b1}};
  wire [95:0] cond_flow_15 = {8'd192, 8'd168, 8'd1, 8'd1, 16'd0, 32'd0, 16'd0};

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  wire [DATA_WIDTH-1:0] s_axis_tdata;
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;

  // AXI4-Stream Timestamp Out
  wire [FLOW_WIDTH-1:0] m_axis_flow_tdata;
  wire                  m_axis_flow_tvalid;
  reg                   m_axis_flow_tready = 1'b0;

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
        m_axis_flow_tready = 1'b1;
      end
    end

    $display("Error: Timeout");
    $fatal();
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
    .ENABLE_TIMESTAMP_FOOTER(0),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .TIMESTAMP_VAL(0)
  ) pcap_to_stream_i (
    clk,
    rstn,
    s_axis_tdata,
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
    .TIMESTAMP_VAL(0)
  ) compare_stream_with_pcap_i (
    clk,
    rstn,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast
  );

  //-------------------------
  // Test module
  //-------------------------
  detect_flow_core #(
    .DATA_WIDTH(DATA_WIDTH),
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH)
  ) detect_flow_core_i (
    clk,
    rstn,
    cond_flow_1,
    cond_flow_2,
    cond_flow_3,
    cond_flow_4,
    cond_flow_5,
    cond_flow_6,
    cond_flow_7,
    cond_flow_8,
    cond_flow_9,
    cond_flow_10,
    cond_flow_11,
    cond_flow_12,
    cond_flow_13,
    cond_flow_14,
    cond_flow_15,
    s_axis_tdata,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_flow_tdata,
    m_axis_flow_tvalid,
    m_axis_flow_tready
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, detect_flow_core_i);
  end

endmodule

`default_nettype wire
