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

module tb_credit_based_shaper;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
<<<<<<< HEAD
=======
  parameter integer DATA_WIDTH = 8;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;
<<<<<<< HEAD
=======
  localparam integer ENABLE_RANDAMIZE = 1;

  localparam integer KEEP_WIDTH = DATA_WIDTH / 8;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
<<<<<<< HEAD
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
=======
  wire [DATA_WIDTH-1:0] s_axis_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_tkeep;
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;

  // AXI4-Stream Out
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire [KEEP_WIDTH-1:0] m_axis_tkeep;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
<<<<<<< HEAD
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE)
=======
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE)
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE)
=======
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH),
    .ENABLE_RANDAMIZE(ENABLE_RANDAMIZE)
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
  // Test module
  //-------------------------
  assign idle_slope = 1;
  assign send_slope = -1;
  assign idle_slope = 1;
  assign max_credit = 32'h7FFFFFFF;
  assign min_credit = 32'h80000000;
<<<<<<< HEAD
  assign s_axis_tuser = 1'b0;

  credit_based_shaper
  credit_based_shaper_i (
=======

  credit_based_shaper #(
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH)
  ) credit_based_shaper_i (
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_tuser,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_tuser
=======
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
