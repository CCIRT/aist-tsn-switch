// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module tb_separate_frame_length;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam DATA_WIDTH = 8;
  localparam FRAME_LENGTH_WIDTH = 16;                   // Must be aligned to DATA_WIDTH
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream In with frame_length
  // [Frame length]/[Ethernet Frame]
  wire [DATA_WIDTH-1:0] s_axis_tdata;
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;

  // AXI4-Stream Out without frame_length
  // [Ethernet Frame]
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;

  // AXI4-Stream Out only frame_length
  // [Frame length]
  wire [DATA_WIDTH-1:0] m_axis_frame_length_tdata;
  wire                  m_axis_frame_length_tvalid;
  reg                   m_axis_frame_length_tready = 1'b0;
  wire                  m_axis_frame_length_tlast;

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
        m_axis_frame_length_tready = 1'b1;
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
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_FRAME_LENGTH_HEADER(1),
    .ENABLE_TIMESTAMP_FOOTER(0),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(0),
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
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_FRAME_LENGTH_HEADER(0),
    .ENABLE_TIMESTAMP_FOOTER(0),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .ETHERNET_FRAME_WIDTH(ETHERNET_FRAME_WIDTH),
    .TIMESTAMP_WIDTH(0),
    .COMPARE_WITH_FRAME_LENGTH(0),
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
  separate_frame_length #(
    .DATA_WIDTH(DATA_WIDTH),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH)
  ) separate_frame_length_i (
    clk,
    rstn,
    s_axis_tdata,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_frame_length_tdata,
    m_axis_frame_length_tvalid,
    m_axis_frame_length_tready,
    m_axis_frame_length_tlast
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, separate_frame_length_i);
  end

endmodule

`default_nettype wire
