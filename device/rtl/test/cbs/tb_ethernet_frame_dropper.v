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

module tb_ethernet_frame_dropper;
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
  localparam DROP_ENABLE = 1;
=======
  localparam integer KEEP_WIDTH = DATA_WIDTH / 8;
  localparam [0:0] DROP_ENABLE = 1;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
<<<<<<< HEAD
  reg  clk;
  reg  rstn;

  // almost_full input from rear FIFO
  reg  fifo_is_almost_full;

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
=======
  reg                           clk;
  reg                           rstn;

  // almost_full input from rear FIFO
  reg                           fifo_is_almost_full;

  // AXI4-Stream In
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
    .DATA_WIDTH(DATA_WIDTH)
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
    .DATA_WIDTH(DATA_WIDTH)
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
<<<<<<< HEAD
  assign s_axis_tuser = 1'b0;

  ethernet_frame_dropper
  ethernet_frame_dropper_i (
=======
  ethernet_frame_dropper #(
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH)
  ) ethernet_frame_dropper_i (
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
    clk,
    rstn,
    DROP_ENABLE,
    fifo_is_almost_full,
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
    $dumpvars(0, ethernet_frame_dropper_i);
  end

endmodule

`default_nettype wire
