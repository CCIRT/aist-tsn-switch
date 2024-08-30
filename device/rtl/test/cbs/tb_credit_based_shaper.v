// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module tb_credit_based_shaper;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // Settings
  wire signed [31:0] idle_slope; // Expect positive value.
  wire signed [31:0] send_slope; // Expect negative value.
  wire signed [31:0] max_credit; // Expect positive value.
  wire signed [31:0] min_credit; // Expect negative value.

  // Debug wires
  wire signed [31:0] credit;
  wire               transmit_until_frame_end;

  // AXI4-Stream In
  wire [7:0] s_axis_tdata;
  wire       s_axis_tvalid;
  wire       s_axis_tready;
  wire       s_axis_tlast;
  wire       s_axis_tuser;

  // AXI4-Stream Out
  wire [7:0] m_axis_tdata;
  wire       m_axis_tvalid;
  wire       m_axis_tready;
  wire       m_axis_tlast;
  wire       m_axis_tuser;

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
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE)
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
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE)
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
  assign idle_slope = 1;
  assign send_slope = -1;
  assign idle_slope = 1;
  assign max_credit = 32'h7FFFFFFF;
  assign min_credit = 32'h80000000;
  assign s_axis_tuser = 1'b0;

  credit_based_shaper
  credit_based_shaper_i (
    clk,
    rstn,
    idle_slope,
    send_slope,
    max_credit,
    min_credit,
    m_axis_tready,
    credit,
    transmit_until_frame_end,
    s_axis_tdata,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_tuser,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_tuser
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, credit_based_shaper_i);
  end

endmodule

`default_nettype wire
