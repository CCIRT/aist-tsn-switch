// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_process_frame;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
  parameter integer FRAME_LENGTH_WIDTH = 16;            // Must be aligned to DATA_WIDTH
  parameter integer TIMESTAMP_WIDTH = 72;               // Must be aligned to DATA_WIDTH

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam DATA_WIDTH = 8;
  localparam FLOW_NUM = 16;
  localparam FLOW_WIDTH = 8;
  localparam TIMESTAMP_LENGTH = 72;
  localparam FRAME_LENGTH_WIDTH = 16;
  localparam COMMIT_VALUE_WIDTH = 32;

  localparam [FLOW_WIDTH-1:0] FLOW                                   = 'd0;
  localparam [FRAME_LENGTH_WIDTH-1:0] FRAME_LENGTH                   = 'd1514;
  localparam [TIMESTAMP_LENGTH-1:0] ARRIVAL_TIMESTAMP_VAL_OFFSET     = 'd1000000000;                 // [ps]
  localparam [TIMESTAMP_LENGTH-1:0] ELIGIBILITY_TIMESTAMP_VAL_OFFSET = ARRIVAL_TIMESTAMP_VAL_OFFSET; // [ps]

  localparam [COMMIT_VALUE_WIDTH-1:0] COMMITTED_INFORMATION_RATE_INV = 72'h000000000000000001;  // [ps/Byte] = [sec/TByte]: 1Gbps -> 8,000, 10Gbps -> 800 ...
  localparam [COMMIT_VALUE_WIDTH-1:0] COMMITTED_BURST_SIZE           = 72'hFFFFFFFFFFFFFFFFFF;  // [Byte]
  localparam [TIMESTAMP_LENGTH-1:0] MAX_RESIDENCE_TIME               = 72'hFFFFFFFFFFFFFFFFFF;  // [ps]

  wire [TIMESTAMP_LENGTH-1:0] arrival_timestamp_input      = ARRIVAL_TIMESTAMP_VAL_OFFSET + FRAME_LENGTH * arrival_repeat_counter * 8000; // cycle(ns/8) -> ps
  wire [TIMESTAMP_LENGTH-1:0] eligibility_timestamp_expect = ELIGIBILITY_TIMESTAMP_VAL_OFFSET + FRAME_LENGTH * (arrival_repeat_counter - 1);
  localparam FLOW_NUM = 16;
  localparam FLOW_WIDTH = 8;
  localparam COMMIT_VALUE_WIDTH = 32;
  localparam C_S_AXI_DATA_WIDTH = 32;
  localparam NUM_OF_REGISTERS = 36;
  localparam C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8));
  localparam OFFSET_BIT = $clog2((C_S_AXI_DATA_WIDTH / 8));

  localparam [FLOW_WIDTH-1:0] FLOW                                   = 'd0;
  localparam [FRAME_LENGTH_WIDTH-1:0] FRAME_LENGTH                   = 'd1514;
  localparam [TIMESTAMP_WIDTH-1:0] ARRIVAL_TIMESTAMP_VAL_OFFSET     = 'd1000000000;                 // [ps]
  localparam [TIMESTAMP_WIDTH-1:0] ELIGIBILITY_TIMESTAMP_VAL_OFFSET = ARRIVAL_TIMESTAMP_VAL_OFFSET; // [ps]

  localparam [COMMIT_VALUE_WIDTH-1:0] COMMITTED_INFORMATION_RATE_INV = 72'h000000000000000001;  // [ps/Byte] = [sec/TByte]: 1Gbps -> 8,000, 10Gbps -> 800 ...
  localparam [COMMIT_VALUE_WIDTH-1:0] COMMITTED_BURST_SIZE           = 72'hFFFFFFFFFFFFFFFFFF;  // [Byte]
  localparam [TIMESTAMP_WIDTH-1:0] MAX_RESIDENCE_TIME               = 72'hFFFFFFFFFFFFFFFFFF;  // [ps]

  wire [TIMESTAMP_WIDTH-1:0] arrival_timestamp_input      = ARRIVAL_TIMESTAMP_VAL_OFFSET + FRAME_LENGTH * arrival_repeat_counter * 8000; // cycle(ns/8) -> ps
  wire [TIMESTAMP_WIDTH-1:0] eligibility_timestamp_expect = ELIGIBILITY_TIMESTAMP_VAL_OFFSET + FRAME_LENGTH * (arrival_repeat_counter - 1) * 8000;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream Timestamp In
  wire [TIMESTAMP_LENGTH-1:0] s_axis_arrival_timestamp_tdata;
  wire                        s_axis_arrival_timestamp_tvalid;
  wire                        s_axis_arrival_timestamp_tready;

  // AXI4-Stream Flow In
  wire [FLOW_WIDTH-1:0] s_axis_flow_tdata = FLOW;
  wire                  s_axis_flow_tvalid = 1'b1;
  reg  init_done;

  // AXI4-Stream Timestamp In
  wire [TIMESTAMP_WIDTH-1:0] s_axis_arrival_timestamp_tdata;
  wire                       s_axis_arrival_timestamp_tvalid;
  wire                       s_axis_arrival_timestamp_tready;

  // AXI4-Stream Flow In
  wire [FLOW_WIDTH-1:0] s_axis_flow_tdata = FLOW;
  wire                  s_axis_flow_tvalid = rstn && init_done;
  wire                  s_axis_flow_tready;

  // AXI4-Stream Frame length In
  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata = FRAME_LENGTH;
  wire                          s_axis_frame_length_tvalid = 1'b1;
  wire                          s_axis_frame_length_tready;

  // AXI4-Stream Timestamp Out
  wire [TIMESTAMP_LENGTH-1:0] m_axis_eligibility_timestamp_tdata;
  wire                        m_axis_eligibility_timestamp_tvalid;
  wire                        m_axis_eligibility_timestamp_tready;
  wire                          s_axis_frame_length_tvalid = rstn && init_done;
  wire                          s_axis_frame_length_tready;

  // AXI4-Stream Timestamp Out
  wire [TIMESTAMP_WIDTH-1:0] m_axis_eligibility_timestamp_tdata;
  wire                       m_axis_eligibility_timestamp_tvalid;
  wire                       m_axis_eligibility_timestamp_tready;

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
  wire [127:0] max_residence_time_i128 = MAX_RESIDENCE_TIME;
  initial begin
    init_done = 0;

    // wait device reset
    @(posedge clk);
    @(posedge rstn);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    // write per flow registers
    for (int i = 0; i < 16; i += 1) begin
      write_register(i * 2 + 0, COMMITTED_INFORMATION_RATE_INV);
      write_register(i * 2 + 1, COMMITTED_BURST_SIZE);
    end

    // write max_residence_time
    write_register(32, max_residence_time_i128[0 +: 32]);
    write_register(33, max_residence_time_i128[32 +: 32]);
    write_register(34, max_residence_time_i128[64 +: 32]);
    write_register(35, max_residence_time_i128[96 +: 32]);

    init_done <= 1;
    @(posedge clk);
  end

  //-------------------------
  // Utility modules
  //-------------------------
  integer arrival_repeat_counter = 'd0;
  always @ (posedge clk) begin
    if (!rstn) begin
    if (!rstn || !init_done) begin
      arrival_repeat_counter <= 'd0;
    end else begin
      if (s_axis_arrival_timestamp_tvalid & s_axis_arrival_timestamp_tready) begin
        # 1 arrival_repeat_counter <= arrival_repeat_counter + 'd1;
      end else begin
        // Do nothing
      end
    end
  end

  assign s_axis_arrival_timestamp_tdata  = arrival_timestamp_input;
  assign s_axis_arrival_timestamp_tvalid = (arrival_repeat_counter < REPEAT_NUM);

  reg [TIMESTAMP_LENGTH-1:0] eligibility_timestamp_actual = 'd0;
  integer eligibility_repeat_counter = 'd0;
  always @ (posedge clk) begin
    if (!rstn) begin
  assign s_axis_arrival_timestamp_tvalid = (arrival_repeat_counter < REPEAT_NUM) && rstn && init_done;

  reg [TIMESTAMP_WIDTH-1:0] eligibility_timestamp_actual = 'd0;
  integer eligibility_repeat_counter = 'd0;
  always @ (posedge clk) begin
    if (!rstn || !init_done) begin
      eligibility_timestamp_actual <= 'd0;
    end else begin
      if (m_axis_eligibility_timestamp_tvalid & m_axis_eligibility_timestamp_tready) begin
        eligibility_timestamp_actual <= m_axis_eligibility_timestamp_tdata;
        #1
        if (eligibility_timestamp_actual != eligibility_timestamp_expect) begin
          $display("Error: eligibility_timestamp_actual != eligibility_timestamp_expect");
          $display("  Actual: 0x%h", eligibility_timestamp_actual);
          $display("  Expect: 0x%h", eligibility_timestamp_expect);
          $fatal();
          `FATAL;
        end else begin
          if (eligibility_repeat_counter == REPEAT_NUM - 1) begin
            $display("Test finished successfully.");
            #100
            $finish();
          end else begin
            // Continue testing
            #1 eligibility_timestamp_actual <= 'd0;
                eligibility_repeat_counter <= eligibility_repeat_counter + 'd1;
          end
        end
      end else begin
        // Do nothing
      end
    end
  end

  assign m_axis_eligibility_timestamp_tready = 1'b1;

  //-------------------------
  // Test module
  //-------------------------
  process_frame_core #(
    .DATA_WIDTH(DATA_WIDTH),
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_LENGTH),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .COMMIT_VALUE_WIDTH(COMMIT_VALUE_WIDTH)
  ) process_frame_core_i (
    clk,
    rstn,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_INFORMATION_RATE_INV,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    COMMITTED_BURST_SIZE,
    MAX_RESIDENCE_TIME,
  process_frame #(
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH),
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .FRAME_LENGTH_WIDTH(FRAME_LENGTH_WIDTH),
    .COMMIT_VALUE_WIDTH(COMMIT_VALUE_WIDTH),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) process_frame_core_i (
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
    s_axis_arrival_timestamp_tdata,
    s_axis_arrival_timestamp_tvalid,
    s_axis_arrival_timestamp_tready,
    s_axis_flow_tdata,
    s_axis_flow_tvalid,
    s_axis_flow_tready,
    s_axis_frame_length_tdata,
    s_axis_frame_length_tvalid,
    s_axis_frame_length_tready,
    m_axis_eligibility_timestamp_tdata,
    m_axis_eligibility_timestamp_tvalid,
    m_axis_eligibility_timestamp_tready
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, process_frame_core_i);
  end

endmodule

`default_nettype wire
