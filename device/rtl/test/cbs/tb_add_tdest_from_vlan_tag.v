// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_add_tdest_from_vlan_tag;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;
  parameter integer EXPECTED_TDEST = 0;
  parameter integer OPT_LEVEL = 1;
  parameter integer DATA_WIDTH = 8;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 160;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 200;

  localparam C_S_AXI_DATA_WIDTH = 32;
  localparam NUM_OF_REGISTERS = 9;
  localparam C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8));
  localparam OFFSET_BIT = $clog2((C_S_AXI_DATA_WIDTH / 8));
  localparam integer KEEP_WIDTH = DATA_WIDTH / 8;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream In
  wire [7:0] s_axis_tdata;
  wire       s_axis_tvalid;
  wire       s_axis_tready;
  wire       s_axis_tlast;
  wire [1:0] s_axis_tuser;

  // AXI4-Stream Out
  wire [7:0] m_axis_tdata;
  wire       m_axis_tvalid;
  wire       m_axis_tready;
  wire       m_axis_tlast;
  wire [1:0] m_axis_tuser;
  wire [2:0] m_axis_tdest;
  reg  init_done;

  // AXI4-Stream In
  wire [DATA_WIDTH-1:0] s_axis_tdata;
  wire [KEEP_WIDTH-1:0] s_axis_tkeep;
  wire                  s_axis_tvalid;
  wire                  s_axis_tready;
  wire                  s_axis_tlast;
  wire [1:0]            s_axis_tuser;

  // AXI4-Stream Out
  wire [DATA_WIDTH-1:0] m_axis_tdata;
  wire [KEEP_WIDTH-1:0] m_axis_tkeep;
  wire                  m_axis_tvalid;
  wire                  m_axis_tready;
  wire                  m_axis_tlast;
  wire [1:0]            m_axis_tuser;
  wire [2:0]            m_axis_tdest;

  reg [C_S_AXI_ADDR_WIDTH-1:0] S_AXI_AWADDR = 0;
  reg [2:0]                    S_AXI_AWPROT = 0;
  reg                          S_AXI_AWVALID = 0;
  wire                         S_AXI_AWREADY;
  reg [C_S_AXI_DATA_WIDTH-1:0] S_AXI_WDATA = 0;
  reg [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB = 0;
  reg                              S_AXI_WVALID = 0;
  wire                             S_AXI_WREADY;
  wire [1:0]                       S_AXI_BRESP;
  wire                             S_AXI_BVALID;
  reg                              S_AXI_BREADY = 0;
  reg [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR = 0;
  reg [2:0]                        S_AXI_ARPROT = 0;
  wire                             S_AXI_ARVALID = rstn && init_done;
  wire                             S_AXI_ARREADY;
  wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA;
  wire [1:0]                       S_AXI_RRESP;
  wire                             S_AXI_RVALID;
  wire                             S_AXI_RREADY = rstn && init_done;

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
    `FATAL;
  end

  //-------------------------
  // Generate clock
  //-------------------------
  always clk = #10 ~clk;

  //-------------------------
  // Test tasks
  //-------------------------
  task write_register(input [31:0] awaddr,
                      input [31:0] wdata);
    // write address and data
    S_AXI_AWADDR <= {awaddr, {OFFSET_BIT{1'b0}}};
    S_AXI_AWPROT <= 0;
    S_AXI_WDATA <= wdata;
    S_AXI_WSTRB <= 32'hffff_ffff;
    S_AXI_BREADY <= 1'b0;
    S_AXI_AWVALID <= 1;
    S_AXI_WVALID <= 1;
    @(posedge clk);

    // wait write
    while (S_AXI_AWVALID || S_AXI_WVALID) begin
      if (S_AXI_AWREADY) begin
        S_AXI_AWVALID <= 1'b0;
      end

      if (S_AXI_WREADY) begin
        S_AXI_WVALID <= 1'b0;
      end

      @(posedge clk);
    end

    // wait b
    while (!S_AXI_BVALID) begin
      @(posedge clk);
    end

    S_AXI_BREADY <= 1'b1;
    @(posedge clk);

    S_AXI_BREADY <= 1'b0;
    @(posedge clk);
  endtask

  //-------------------------
  // Initialize registers
  //-------------------------
  initial begin
    init_done = 0;

    // wait device reset
    @(posedge clk);
    @(posedge rstn);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    write_register(0, 3'd1);
    write_register(1, 3'd0);
    write_register(2, 3'd6);
    write_register(3, 3'd7);
    write_register(4, 3'd2);
    write_register(5, 3'd3);
    write_register(6, 3'd4);
    write_register(7, 3'd5);
    write_register(8, 3'd1);

    init_done <= 1;
    @(posedge clk);
  end

  //-------------------------
  // Utility modules
  //-------------------------
  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME),
    .REPEAT_NUM(REPEAT_NUM),
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE)
    .M_AXIS_TVALID_OUT_CYCLE(M_AXIS_TVALID_OUT_CYCLE),
    .DATA_WIDTH(DATA_WIDTH)
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
    .REPEAT_NUM(REPEAT_NUM),
    .S_AXIS_TREADY_OUT_CYCLE(S_AXIS_TREADY_OUT_CYCLE)
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
  // Verify tdest
  //-------------------------
  always @(posedge clk) begin
    if (m_axis_tvalid && m_axis_tready) begin
      if (m_axis_tdest != EXPECTED_TDEST) begin
        $display("Error: expect tdest %d but got %d", EXPECTED_TDEST, m_axis_tdest);
        `FATAL;
      end
    end
  end

  //-------------------------
  // Test module
  //-------------------------
  assign s_axis_tuser = 2'b00;

  add_tdest_from_vlan_tag_core
  add_tdest_from_vlan_tag_core_i (
    clk,
    rstn,
    3'd1,
    3'd0,
    3'd6,
    3'd7,
    3'd2,
    3'd3,
    3'd4,
    3'd5,
    3'd1,
    s_axis_tdata,
  add_tdest_from_vlan_tag #(
    .OPT_LEVEL(OPT_LEVEL),
    .C_AXIS_TDATA_WIDTH(DATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(KEEP_WIDTH)
  ) add_tdest_from_vlan_tag_i (
    clk,
    rstn,
    S_AXI_AWADDR,
    S_AXI_AWPROT,
    S_AXI_AWVALID,
    S_AXI_AWREADY,
    S_AXI_WDATA,
    S_AXI_WSTRB,
    S_AXI_WVALID,
    S_AXI_WREADY,
    S_AXI_BRESP,
    S_AXI_BVALID,
    S_AXI_BREADY,
    S_AXI_ARADDR,
    S_AXI_ARPROT,
    S_AXI_ARVALID,
    S_AXI_ARREADY,
    S_AXI_RDATA,
    S_AXI_RRESP,
    S_AXI_RVALID,
    S_AXI_RREADY,
    s_axis_tdata,
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_tuser,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_tuser,
    m_axis_tdest
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, add_tdest_from_vlan_tag_core_i);
    $dumpvars(0, add_tdest_from_vlan_tag_i);
  end

endmodule

`default_nettype wire
