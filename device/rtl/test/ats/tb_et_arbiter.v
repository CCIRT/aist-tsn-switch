// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_et_arbiter;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 3;
  parameter integer DATA_WIDTH = 8;
  parameter integer NUM_INPUT_PORTS = 8;

  localparam integer ENABLE_RANDAMIZE = 1;
  localparam integer TIMEOUT_CYCLE = 50000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  localparam KEEP_WIDTH = DATA_WIDTH / 8;
  localparam FRAME_LENGTH_WIDTH = 16;                   // Must be aligned to DATA_WIDTH
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH;  // Must be aligned to DATA_WIDTH
  localparam TIMESTAMP_WIDTH = 72;                      // Must be aligned to DATA_WIDTH
  localparam [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 72'hABFEDCBA9876543210;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg                       clk;
  reg                       rstn;

  // ET-passed AXI4-Stream Timestamp In
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p0_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p0_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p0_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p1_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p1_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p1_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p2_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p2_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p2_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p3_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p3_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p3_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p4_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p4_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p4_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p5_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p5_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p5_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p6_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p6_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p6_tready;
  reg [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_p7_tdata = 0;
  reg                       s_axis_eligibility_timestamp_p7_tvalid = 0;
  wire                      s_axis_eligibility_timestamp_p7_tready;

  // AXI4-Stream Data In
  reg [DATA_WIDTH-1:0]      s_axis_p0_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p0_tkeep = 0;
  reg                       s_axis_p0_tvalid = 0;
  wire                      s_axis_p0_tready;
  reg                       s_axis_p0_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p1_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p1_tkeep = 0;
  reg                       s_axis_p1_tvalid = 0;
  wire                      s_axis_p1_tready;
  reg                       s_axis_p1_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p2_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p2_tkeep = 0;
  reg                       s_axis_p2_tvalid = 0;
  wire                      s_axis_p2_tready;
  reg                       s_axis_p2_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p3_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p3_tkeep = 0;
  reg                       s_axis_p3_tvalid = 0;
  wire                      s_axis_p3_tready;
  reg                       s_axis_p3_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p4_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p4_tkeep = 0;
  reg                       s_axis_p4_tvalid = 0;
  wire                      s_axis_p4_tready;
  reg                       s_axis_p4_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p5_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p5_tkeep = 0;
  reg                       s_axis_p5_tvalid = 0;
  wire                      s_axis_p5_tready;
  reg                       s_axis_p5_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p6_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p6_tkeep = 0;
  reg                       s_axis_p6_tvalid = 0;
  wire                      s_axis_p6_tready;
  reg                       s_axis_p6_tlast = 0;
  reg [DATA_WIDTH-1:0]      s_axis_p7_tdata = 0;
  reg [KEEP_WIDTH-1:0]      s_axis_p7_tkeep = 0;
  reg                       s_axis_p7_tvalid = 0;
  wire                      s_axis_p7_tready;
  reg                       s_axis_p7_tlast = 0;

   // AXI4-Stream Data Out
  wire [DATA_WIDTH-1:0]      m_axis_tdata;
  wire [KEEP_WIDTH-1:0]      m_axis_tkeep;
  wire                       m_axis_tvalid;
  reg                        m_axis_tready = 0;
  wire                       m_axis_tlast;


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
  task push_frame_impl_0 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p0_tdata <= data_val;
      s_axis_p0_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p0_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p0_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p0_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p0_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_1 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p1_tdata <= data_val;
      s_axis_p1_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p1_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p1_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p1_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p1_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_2 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p2_tdata <= data_val;
      s_axis_p2_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p2_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p2_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p2_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p2_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_3 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p3_tdata <= data_val;
      s_axis_p3_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p3_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p3_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p3_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p3_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_4 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p4_tdata <= data_val;
      s_axis_p4_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p4_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p4_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p4_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p4_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_5 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p5_tdata <= data_val;
      s_axis_p5_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p5_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p5_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p5_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p5_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_6 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p6_tdata <= data_val;
      s_axis_p6_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p6_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p6_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p6_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p6_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame_impl_7 (input logic [31:0] length, input logic [DATA_WIDTH-1:0] data_val);
    for (int i = 0; i < length; i = i + 1) begin
      s_axis_p7_tdata <= data_val;
      s_axis_p7_tkeep <= {KEEP_WIDTH{1'b1}};
      s_axis_p7_tlast <= (i == length - 1) ? 1 : 0;
      s_axis_p7_tvalid <= 1;
      @(posedge clk);
      while (!s_axis_p7_tready) begin
        @(posedge clk);
      end
    end
    s_axis_p7_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_frame(
                   input logic [31:0]           port,
                   input logic [31:0]           length,
                   input logic [DATA_WIDTH-1:0] data_val);
    if (port == 0) begin
      push_frame_impl_0(length, data_val);
    end else if (port == 1) begin
      push_frame_impl_1(length, data_val);
    end else if (port == 2) begin
      push_frame_impl_2(length, data_val);
    end else if (port == 3) begin
      push_frame_impl_3(length, data_val);
    end else if (port == 4) begin
      push_frame_impl_4(length, data_val);
    end else if (port == 5) begin
      push_frame_impl_5(length, data_val);
    end else if (port == 6) begin
      push_frame_impl_6(length, data_val);
    end else if (port == 7) begin
      push_frame_impl_7(length, data_val);
    end
  endtask

  task pop_frame(
                  input logic [31:0]           exp_length,
                  input logic [DATA_WIDTH-1:0] exp_data);
    integer                                    rand_val;
    for (int i = 0; i < exp_length; i = i + 1) begin
      rand_val = $random % 3;
      m_axis_tready <= 0;
      
      if (ENABLE_RANDAMIZE) begin
        for (int j = 0; j < rand_val; j = j + 1) begin
          @(posedge clk);
        end
      end

      m_axis_tready <= 1;
      @(posedge clk);
      while (!m_axis_tvalid) begin
        @(posedge clk);
      end

      if (m_axis_tdata != exp_data) begin
        $display("Error: wrong tdata value. expect = 0x%x, but got 0x%x", exp_data, m_axis_tdata);
        `FATAL;
      end

      if (i == exp_length - 1) begin
        if (!m_axis_tlast) begin
          $display("Error: tlast must be assigned only at the end of frame. i = %d, exp_length = %d", i, exp_length);
          `FATAL;
        end
      end else begin
        if (m_axis_tlast) begin
          $display("Error: tlast must be assigned only at the end of frame. i = %d, exp_length = %d", i, exp_length);
          `FATAL;
        end
      end
    end

    m_axis_tready <= 0;
    @(posedge clk);
  endtask

  task push_et_impl_0(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p0_tdata <= val;
    s_axis_eligibility_timestamp_p0_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p0_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p0_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_1(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p1_tdata <= val;
    s_axis_eligibility_timestamp_p1_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p1_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p1_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_2(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p2_tdata <= val;
    s_axis_eligibility_timestamp_p2_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p2_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p2_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_3(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p3_tdata <= val;
    s_axis_eligibility_timestamp_p3_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p3_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p3_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_4(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p4_tdata <= val;
    s_axis_eligibility_timestamp_p4_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p4_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p4_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_5(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p5_tdata <= val;
    s_axis_eligibility_timestamp_p5_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p5_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p5_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_6(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p6_tdata <= val;
    s_axis_eligibility_timestamp_p6_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p6_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p6_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et_impl_7(input logic [TIMESTAMP_WIDTH-1:0] val);
    s_axis_eligibility_timestamp_p7_tdata <= val;
    s_axis_eligibility_timestamp_p7_tvalid <= 1'b1;
    @(posedge clk);
    while (!s_axis_eligibility_timestamp_p7_tready) begin
      @(posedge clk);
    end

    s_axis_eligibility_timestamp_p7_tvalid <= 1'b0;
    @(posedge clk);
  endtask

  task push_et(
               input logic [31:0]                port,
               input logic [TIMESTAMP_WIDTH-1:0] val);
    if (port == 0) begin
      push_et_impl_0(val);
    end else if (port == 1) begin
      push_et_impl_1(val);
    end else if (port == 2) begin
      push_et_impl_2(val);
    end else if (port == 3) begin
      push_et_impl_3(val);
    end else if (port == 4) begin
      push_et_impl_4(val);
    end else if (port == 5) begin
      push_et_impl_5(val);
    end else if (port == 6) begin
      push_et_impl_6(val);
    end else if (port == 7) begin
      push_et_impl_7(val);
    end
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

    fork
      begin // port 0: et thread
        // first ET. This must be scheduled soon
        push_et_impl_0(10000);

        // Push x8 ETs (reverse order)
        push_et_impl_0(1007);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_0(2000);

        // Push x4 ETs
        push_et_impl_0(3000);

        // Push x2 ETs
        push_et_impl_0(4000);

        // Push x1 ETs
        push_et_impl_0(5000);
      end
      begin // port 1: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_1(1006);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_1(2000);

        // Push x4 ETs
        push_et_impl_1(3001);

        // Push x2 ETs
        push_et_impl_1(4001);
      end
      begin // port 2: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_2(1005);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_2(2000);

        // Push x4 ETs
        push_et_impl_2(3002);
      end
      begin // port 3: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_3(1004);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_3(2000);

        // Push x4 ETs
        push_et_impl_3(3003);
      end
      begin // port 4: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_4(1003);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_4(2000);
      end
      begin // port 5: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_5(1002);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_5(2000);
      end
      begin // port 6: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_6(1001);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_6(2000);
      end
      begin // port 7: et thread
        // wait 10 cycle
        repeat (10) @(posedge clk);

        // Push x8 ETs (reverse order)
        push_et_impl_7(1000);

        // Push x8 ETs (same value, younger port has higher prio.)
        push_et_impl_7(2000);
      end
      begin
        // port 0: x6 times
        push_frame(0, 1000, 0);
        push_frame(0, 1000, 0);
        push_frame(0, 1000, 0);
        push_frame(0, 1000, 0);
        push_frame(0, 1000, 0);
        push_frame(0, 1000, 0);
      end
      begin // port 1: x4 times
        push_frame(1, 1000, 1);
        push_frame(1, 1000, 1);
        push_frame(1, 1000, 1);
        push_frame(1, 1000, 1);
      end
      begin // port 2: x3 times
        push_frame(2, 1000, 2);
        push_frame(2, 1000, 2);
        push_frame(2, 1000, 2);
      end
      begin // port 3: x3 times
        push_frame(3, 1000, 3);
        push_frame(3, 1000, 3);
        push_frame(3, 1000, 3);
      end
      begin // port 4: x2 times
        push_frame(4, 1000, 4);
        push_frame(4, 1000, 4);
      end
      begin // port 5: x2 times
        push_frame(5, 1000, 5);
        push_frame(5, 1000, 5);
      end
      begin // port 6: x2 times
        push_frame(6, 1000, 6);
        push_frame(6, 1000, 6);
      end
      begin // port 7: x2 times
        push_frame(7, 1000, 7);
        push_frame(7, 1000, 7);
      end
      begin // recv port
        // expected order
        // 0 ->
        // 7 -> 6 -> 5 -> 4 -> 3 -> 2 -> 1 -> 0 ->
        // 0 -> 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 ->
        // 0 -> 1 -> 2 -> 3 ->
        // 0 -> 1 ->
        // 0

        // 0
        pop_frame(1000, 0);

        // 7 -> 0
        pop_frame(1000, 7);
        pop_frame(1000, 6);
        pop_frame(1000, 5);
        pop_frame(1000, 4);
        pop_frame(1000, 3);
        pop_frame(1000, 2);
        pop_frame(1000, 1);
        pop_frame(1000, 0);

        // 0 -> 7
        pop_frame(1000, 0);
        pop_frame(1000, 1);
        pop_frame(1000, 2);
        pop_frame(1000, 3);
        pop_frame(1000, 4);
        pop_frame(1000, 5);
        pop_frame(1000, 6);
        pop_frame(1000, 7);

        // 0 -> 3
        pop_frame(1000, 0);
        pop_frame(1000, 1);
        pop_frame(1000, 2);
        pop_frame(1000, 3);

        // 0 -> 1
        pop_frame(1000, 0);
        pop_frame(1000, 1);

        // 0
        pop_frame(1000, 0);
      end
    join

    // wait 10 cycle
    repeat (10) @(posedge clk);

    $display("Test success");
    $finish;
  end

  // Utility modules
  //-------------------------
  // we don't use these modules, but instantiate them to avoid errors.
  pcap_to_stream #(
    .PCAP_FILENAME(PCAP_FILENAME)
  ) pcap_to_stream_i ();

  compare_stream_with_pcap #(
    .PCAP_FILENAME(PCAP_FILENAME)
  ) compare_stream_with_pcap_i ();

  //-------------------------
  // Test module
  //-------------------------
  et_arbiter #(
               // Parameters
               .DATA_WIDTH              (DATA_WIDTH),
               .KEEP_WIDTH              (KEEP_WIDTH),
               .TIMESTAMP_WIDTH         (TIMESTAMP_WIDTH),
               .NUM_INPUT_PORTS         (NUM_INPUT_PORTS))
  et_arbiter_i (
                // Outputs
                .s_axis_eligibility_timestamp_p0_tready(s_axis_eligibility_timestamp_p0_tready),
                .s_axis_eligibility_timestamp_p1_tready(s_axis_eligibility_timestamp_p1_tready),
                .s_axis_eligibility_timestamp_p2_tready(s_axis_eligibility_timestamp_p2_tready),
                .s_axis_eligibility_timestamp_p3_tready(s_axis_eligibility_timestamp_p3_tready),
                .s_axis_eligibility_timestamp_p4_tready(s_axis_eligibility_timestamp_p4_tready),
                .s_axis_eligibility_timestamp_p5_tready(s_axis_eligibility_timestamp_p5_tready),
                .s_axis_eligibility_timestamp_p6_tready(s_axis_eligibility_timestamp_p6_tready),
                .s_axis_eligibility_timestamp_p7_tready(s_axis_eligibility_timestamp_p7_tready),
                .s_axis_p0_tready       (s_axis_p0_tready),
                .s_axis_p1_tready       (s_axis_p1_tready),
                .s_axis_p2_tready       (s_axis_p2_tready),
                .s_axis_p3_tready       (s_axis_p3_tready),
                .s_axis_p4_tready       (s_axis_p4_tready),
                .s_axis_p5_tready       (s_axis_p5_tready),
                .s_axis_p6_tready       (s_axis_p6_tready),
                .s_axis_p7_tready       (s_axis_p7_tready),
                .m_axis_tdata           (m_axis_tdata[DATA_WIDTH-1:0]),
                .m_axis_tkeep           (m_axis_tkeep[KEEP_WIDTH-1:0]),
                .m_axis_tvalid          (m_axis_tvalid),
                .m_axis_tlast           (m_axis_tlast),
                // Inputs
                .clk                    (clk),
                .rstn                   (rstn),
                .s_axis_eligibility_timestamp_p0_tdata(s_axis_eligibility_timestamp_p0_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p0_tvalid(s_axis_eligibility_timestamp_p0_tvalid),
                .s_axis_eligibility_timestamp_p1_tdata(s_axis_eligibility_timestamp_p1_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p1_tvalid(s_axis_eligibility_timestamp_p1_tvalid),
                .s_axis_eligibility_timestamp_p2_tdata(s_axis_eligibility_timestamp_p2_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p2_tvalid(s_axis_eligibility_timestamp_p2_tvalid),
                .s_axis_eligibility_timestamp_p3_tdata(s_axis_eligibility_timestamp_p3_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p3_tvalid(s_axis_eligibility_timestamp_p3_tvalid),
                .s_axis_eligibility_timestamp_p4_tdata(s_axis_eligibility_timestamp_p4_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p4_tvalid(s_axis_eligibility_timestamp_p4_tvalid),
                .s_axis_eligibility_timestamp_p5_tdata(s_axis_eligibility_timestamp_p5_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p5_tvalid(s_axis_eligibility_timestamp_p5_tvalid),
                .s_axis_eligibility_timestamp_p6_tdata(s_axis_eligibility_timestamp_p6_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p6_tvalid(s_axis_eligibility_timestamp_p6_tvalid),
                .s_axis_eligibility_timestamp_p7_tdata(s_axis_eligibility_timestamp_p7_tdata[TIMESTAMP_WIDTH-1:0]),
                .s_axis_eligibility_timestamp_p7_tvalid(s_axis_eligibility_timestamp_p7_tvalid),
                .s_axis_p0_tdata        (s_axis_p0_tdata[DATA_WIDTH-1:0]),
                .s_axis_p0_tkeep        (s_axis_p0_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p0_tvalid       (s_axis_p0_tvalid),
                .s_axis_p0_tlast        (s_axis_p0_tlast),
                .s_axis_p1_tdata        (s_axis_p1_tdata[DATA_WIDTH-1:0]),
                .s_axis_p1_tkeep        (s_axis_p1_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p1_tvalid       (s_axis_p1_tvalid),
                .s_axis_p1_tlast        (s_axis_p1_tlast),
                .s_axis_p2_tdata        (s_axis_p2_tdata[DATA_WIDTH-1:0]),
                .s_axis_p2_tkeep        (s_axis_p2_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p2_tvalid       (s_axis_p2_tvalid),
                .s_axis_p2_tlast        (s_axis_p2_tlast),
                .s_axis_p3_tdata        (s_axis_p3_tdata[DATA_WIDTH-1:0]),
                .s_axis_p3_tkeep        (s_axis_p3_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p3_tvalid       (s_axis_p3_tvalid),
                .s_axis_p3_tlast        (s_axis_p3_tlast),
                .s_axis_p4_tdata        (s_axis_p4_tdata[DATA_WIDTH-1:0]),
                .s_axis_p4_tkeep        (s_axis_p4_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p4_tvalid       (s_axis_p4_tvalid),
                .s_axis_p4_tlast        (s_axis_p4_tlast),
                .s_axis_p5_tdata        (s_axis_p5_tdata[DATA_WIDTH-1:0]),
                .s_axis_p5_tkeep        (s_axis_p5_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p5_tvalid       (s_axis_p5_tvalid),
                .s_axis_p5_tlast        (s_axis_p5_tlast),
                .s_axis_p6_tdata        (s_axis_p6_tdata[DATA_WIDTH-1:0]),
                .s_axis_p6_tkeep        (s_axis_p6_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p6_tvalid       (s_axis_p6_tvalid),
                .s_axis_p6_tlast        (s_axis_p6_tlast),
                .s_axis_p7_tdata        (s_axis_p7_tdata[DATA_WIDTH-1:0]),
                .s_axis_p7_tkeep        (s_axis_p7_tkeep[KEEP_WIDTH-1:0]),
                .s_axis_p7_tvalid       (s_axis_p7_tvalid),
                .s_axis_p7_tlast        (s_axis_p7_tlast),
                .m_axis_tready          (m_axis_tready));

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
