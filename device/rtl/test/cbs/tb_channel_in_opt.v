// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_channel_in_fifo
  #(parameter DWIDTH = 8,
    parameter AWIDTH = 10)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  reg [DWIDTH-1:0] s_axis_tdata;
  reg              s_axis_tvalid;
  wire             s_axis_tready;

  wire [DWIDTH-1:0] m_axis_tdata;
  wire              m_axis_tvalid;
  reg               m_axis_tready;

  localparam DEPTH = 2 ** AWIDTH;

  task try_push(input [DWIDTH-1:0] tdata, output [0:0] success);
    if (s_axis_tready == 0) begin
      success = 0;
    end else begin
      s_axis_tdata <= tdata;
      s_axis_tvalid <= 1;
      @(posedge aclk);
      s_axis_tvalid <= 0;

      success = 1;
    end
  endtask

  task push(input [DWIDTH-1:0] tdata);
    reg success;
    try_push(tdata, success);
    if (!success) begin
      $display("Error: push failed");
    end
  endtask

  task try_pop(output [DWIDTH-1:0] tdata, output [0:0] success);
    if (m_axis_tvalid == 0) begin
      success = 0;
    end else begin
      m_axis_tready <= 1;
      @(posedge aclk);
      tdata = m_axis_tdata;
      m_axis_tready <= 0;

      success = 1;
    end
  endtask

  task pop(output [DWIDTH-1:0] tdata);
    reg success;
    try_pop(tdata, success);
    if (!success) begin
      $display("Error: pop failed");
    end
  endtask

  reg [DWIDTH-1:0] out;
  reg success;
  initial begin
    s_axis_tdata = 0;
    s_axis_tvalid = 0;
    m_axis_tready = 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    @(posedge aclk);
    @(posedge aclk);
    @(posedge aclk);

    $display("fifo: push until full");
    for (int i = 0; i < DEPTH; i = i + 1) begin
      push(i);
    end
    @(posedge aclk);
    $display("fifo: FIFO must be full check");
    try_push(0, success);
    if (success) begin
      $display("Error: FIFO must be full");
      `FATAL;
    end

    $display("fifo: pull until empty");
    @(posedge aclk);
    for (int i = 0; i < DEPTH; i = i + 1) begin
      pop(out);

      if (out != i[DWIDTH-1:0]) begin
        $display("Error: wrong tdata: expect %d but got %d", i[DWIDTH-1:0], out);
        @(posedge aclk);
        `FATAL;
      end
    end

    $display("fifo: FIFO must be empty check");
    @(posedge aclk);
    try_pop(out, success);
    if (success) begin
      $display("Error: FIFO must be empty");
    end
    @(posedge aclk);

    $display("fifo: push and pop parallel");
    fork
      begin
        for (int i = 0; i < DEPTH + DEPTH / 2; i = i + 1) begin
          push(i);
        end
      end
      begin
        for (int i = 0; i < DEPTH / 2; i = i + 1) begin
          @(posedge aclk);
        end

        for (int i = 0; i < DEPTH + DEPTH / 2; i = i + 1) begin
          pop(out);

          if (out != i[DWIDTH-1:0]) begin
            $display("Error: wrong tdata: expect %d but got %d", i[DWIDTH-1:0], out);
            @(posedge aclk);
            `FATAL;
          end
        end
      end
    join

    $display("fifo: push and pop parallel, slower push");
    fork
      begin
        for (int i = 0; i < DEPTH * 2; i = i + 1) begin
          @(posedge aclk);
          @(posedge aclk);
          @(posedge aclk);
          push(i);
        end
      end
      begin
        for (int i = 0; i < DEPTH / 4; i = i + 1) begin
          // wait 1/16 of FIFO is filled..
          @(posedge aclk);
        end
        for (int i = 0; i < DEPTH * 2; i = i + 1) begin
          @(posedge aclk);
          success = 0;
          while (!success) begin
            @(posedge aclk);
            try_pop(out, success);
          end

          if (out != i[DWIDTH-1:0]) begin
            $display("Error: wrong tdata: expect %d but got %d", i[DWIDTH-1:0], out);
            @(posedge aclk);
            `FATAL;
          end
        end
      end
    join

    $display("fifo: push and pop parallel, slower pop");
    fork
      begin
        for (int i = 0; i < DEPTH * 3; i = i + 1) begin
          @(posedge aclk);
          success = 0;
          while (!success) begin
            @(posedge aclk);
            try_push(i, success);
          end
        end
      end
      begin
        for (int i = 0; i < DEPTH * 3; i = i + 1) begin
          @(posedge aclk);
          @(posedge aclk);
          @(posedge aclk);
          @(posedge aclk);
          @(posedge aclk);
          pop(out);

          if (out != i[DWIDTH-1:0]) begin
            $display("Error: wrong tdata: expect %d but got %d", i[DWIDTH-1:0], out);
            @(posedge aclk);
            `FATAL;
          end
        end
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end


  channel_in_fifo #(
                    // Parameters
                    .DWIDTH             (DWIDTH),
                    .AWIDTH             (AWIDTH))
  channel_in_fifo_i (
                     // Outputs
                     .s_axis_tready     (s_axis_tready),
                     .m_axis_tdata      (m_axis_tdata[DWIDTH-1:0]),
                     .m_axis_tvalid     (m_axis_tvalid),
                     // Inputs
                     .aclk              (aclk),
                     .aresetn           (aresetn),
                     .s_axis_tdata      (s_axis_tdata[DWIDTH-1:0]),
                     .s_axis_tvalid     (s_axis_tvalid),
                     .m_axis_tready     (m_axis_tready));

endmodule

module tb_channel_in_receiver
  #(
    parameter PORT_ADDR = 0,
    parameter PORT_HIGH = 3,
    parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
    parameter C_AXIS_TDATA_WIDTH = 8,
    parameter C_AXIS_TKEEP_WIDTH = 1)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  // Income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]  s_axis_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_tkeep;
  reg                           s_axis_tvalid;
  wire                          s_axis_tready;
  reg                           s_axis_tlast;
  // Regular outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_regular_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_regular_tkeep;
  wire                          m_axis_regular_tvalid;
  reg                           m_axis_regular_tready;
  wire                          m_axis_regular_tlast;
  // Broadcast outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_broadcast_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_broadcast_tkeep;
  wire                          m_axis_broadcast_tvalid;
  reg                           m_axis_broadcast_tready;
  wire                          m_axis_broadcast_tlast;
  // Table read request
  wire [95:0]                   m_axis_table_request_tdata;
  wire [PORT_WIDTH-1:0]         m_axis_table_request_tuser;
  wire                          m_axis_table_request_tvalid;
  reg                           m_axis_table_request_tready;

  // 1. regular
  // 2. broadcast
  task push_frame(input [47:0] src_mac, input [47:0] dst_mac, input [15:0] length, input [31:0] delay_cycles);
    reg [7:0] frame [2047:0];
    frame[0] = dst_mac[0 +: 8];
    frame[1] = dst_mac[8 +: 8];
    frame[2] = dst_mac[16 +: 8];
    frame[3] = dst_mac[24 +: 8];
    frame[4] = dst_mac[32 +: 8];
    frame[5] = dst_mac[40 +: 8];
    frame[6] = src_mac[0 +: 8];
    frame[7] = src_mac[8 +: 8];
    frame[8] = src_mac[16 +: 8];
    frame[9] = src_mac[24 +: 8];
    frame[10] = src_mac[32 +: 8];
    frame[11] = src_mac[40 +: 8];
    for (int i = 0; i < length - 12; i += 1) begin
      frame[i + 12] = i;
    end

    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_tdata <= 0;
      s_axis_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_tdata[j * 8 +: 8] <= frame[i + j];
          s_axis_tkeep[j] <= 1;
        end
      end
      s_axis_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_tready) begin
        @(posedge aclk);
      end

      s_axis_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_tvalid <= 0;
    @(posedge aclk);
  endtask

  task pop_regular(input [47:0] src_mac, input [47:0] dst_mac, input [15:0] length, input [31:0] delay_cycles);
    reg [7:0] frame [2047:0];
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;
    frame[0] = dst_mac[0 +: 8];
    frame[1] = dst_mac[8 +: 8];
    frame[2] = dst_mac[16 +: 8];
    frame[3] = dst_mac[24 +: 8];
    frame[4] = dst_mac[32 +: 8];
    frame[5] = dst_mac[40 +: 8];
    frame[6] = src_mac[0 +: 8];
    frame[7] = src_mac[8 +: 8];
    frame[8] = src_mac[16 +: 8];
    frame[9] = src_mac[24 +: 8];
    frame[10] = src_mac[32 +: 8];
    frame[11] = src_mac[40 +: 8];
    for (int i = 0; i < length - 12; i += 1) begin
      frame[i + 12] = i;
    end

    m_axis_regular_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_regular_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = frame[i + j];
          expect_keep[j] = 1;
        end
      end
      if (m_axis_regular_tdata != expect_data ||
          m_axis_regular_tkeep != expect_keep) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x",
                 expect_data, expect_keep);
        $display("Result: tdata=0x%x, tkeep=0x%x",
                 m_axis_regular_tdata, m_axis_regular_tkeep);
        @(posedge aclk);
        `FATAL;
      end

      m_axis_regular_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_regular_tready <= 1;
    end
    m_axis_regular_tready <= 0;
    @(posedge aclk);
  endtask

  task pop_broadcast(input [47:0] src_mac, input [47:0] dst_mac, input [15:0] length, input [31:0] delay_cycles);
    reg [7:0] frame [2047:0];
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;
    frame[0] = dst_mac[0 +: 8];
    frame[1] = dst_mac[8 +: 8];
    frame[2] = dst_mac[16 +: 8];
    frame[3] = dst_mac[24 +: 8];
    frame[4] = dst_mac[32 +: 8];
    frame[5] = dst_mac[40 +: 8];
    frame[6] = src_mac[0 +: 8];
    frame[7] = src_mac[8 +: 8];
    frame[8] = src_mac[16 +: 8];
    frame[9] = src_mac[24 +: 8];
    frame[10] = src_mac[32 +: 8];
    frame[11] = src_mac[40 +: 8];
    for (int i = 0; i < length - 12; i += 1) begin
      frame[i + 12] = i;
    end

    m_axis_broadcast_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_broadcast_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = frame[i + j];
          expect_keep[j] = 1;
        end
      end
      if (m_axis_broadcast_tdata != expect_data ||
          m_axis_broadcast_tkeep != expect_keep) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x",
                 expect_data, expect_keep);
        $display("Result: tdata=0x%x, tkeep=0x%x",
                 m_axis_broadcast_tdata, m_axis_broadcast_tkeep);
        @(posedge aclk);
        `FATAL;
      end
      m_axis_broadcast_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_broadcast_tready <= 1;
    end
    m_axis_broadcast_tready <= 0;
    @(posedge aclk);
  endtask

  task pop_request(input [47:0] src_mac, input [47:0] dst_mac, input [31:0] delay_cycles);
    for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
      @(posedge aclk);
    end

    m_axis_table_request_tready <= 1;
    @(posedge aclk);
    while (!m_axis_table_request_tvalid) begin
      @(posedge aclk);
    end
    m_axis_table_request_tready <= 0;
    @(posedge aclk);

    // $display("receiver: send request. src_mac=0x%012x, dst_mac=0x%012x, port=%d",
    //          m_axis_table_request_tdata[48 +: 48], m_axis_table_request_tdata[0 +: 48], m_axis_table_request_tuser);
    if (m_axis_table_request_tdata[0 +: 48] != dst_mac) begin
      $display("ERROR: expected dst_mac: 0x%012x", dst_mac);
      `FATAL;
    end
    if (m_axis_table_request_tdata[48 +: 48] != src_mac) begin
      $display("ERROR: expected src_mac: 0x%012x", src_mac);
      `FATAL;
    end
    if (m_axis_table_request_tuser != PORT_ADDR) begin
      $display("ERROR: expected port_addr: %d", PORT_ADDR);
      `FATAL;
    end
  endtask

  initial begin
    s_axis_tdata = 0;
    s_axis_tkeep <= 0;
    s_axis_tvalid = 0;
    s_axis_tlast <= 0;
    m_axis_regular_tready <= 0;
    m_axis_broadcast_tready <= 0;
    m_axis_table_request_tready <= 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    @(posedge aclk);
    @(posedge aclk);
    @(posedge aclk);

    $display("receiver: regular frame");
    fork
      begin
        push_frame(48'hffffffffffff, 48'h66778899aabb, 1500, 0);
      end
      begin
        pop_regular(48'hffffffffffff, 48'h66778899aabb, 1500, 0);
      end
      begin
        pop_request(48'hffffffffffff, 48'h66778899aabb, 0);
      end
    join

    $display("receiver: broadcast frame");
    fork
      begin
        push_frame(48'h001122334455, 48'hffffffffffff, 1500, 0);
      end
      begin
        pop_broadcast(48'h001122334455, 48'hffffffffffff, 1500, 0);
      end
    join

    $display("receiver: performance test: long x1 + short x32");
    fork
      begin
        push_frame(48'h001122334455, 48'h66778899aabb, 1500, 0);
        for (int i = 0; i < 32; i += 1) begin
          push_frame(48'h001122334455, 48'h66778899aabb, 64, 0);
        end
      end
      begin
        pop_regular(48'h001122334455, 48'h66778899aabb, 1500, 0);
        for (int i = 0; i < 32; i += 1) begin
          pop_regular(48'h001122334455, 48'h66778899aabb, 64, 0);
        end
      end
      begin
        for (int i = 0; i < 33; i += 1) begin
          pop_request(48'h001122334455, 48'h66778899aabb, 0);
        end
      end
    join

    $display("receiver: timing test: slower pop_regular");
    fork
      begin
        push_frame(48'h001122334455, 48'h66778899aabb, 1500, 0);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 0);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 0);
      end
      begin
        pop_regular(48'h001122334455, 48'h66778899aabb, 1500, 3);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 3);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 3);
      end
      begin
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
      end
    join

    $display("receiver: timing test: slower push frame");
    fork
      begin
        push_frame(48'h001122334455, 48'h66778899aabb, 1500, 3);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 3);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 3);
      end
      begin
        pop_regular(48'h001122334455, 48'h66778899aabb, 1500, 0);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 0);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 0);
      end
      begin
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
        pop_request(48'h001122334455, 48'h66778899aabb, 0);
      end
    join

    $display("receiver: timing test: delayed pop request");
    fork
      begin
        push_frame(48'h001122334455, 48'h66778899aabb, 1500, 3);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 3);
        push_frame(48'h001122334455, 48'h66778899aabb, 64, 3);
        push_frame(48'h001122334455, 48'h66778899aabb, 1500, 3);
      end
      begin
        pop_regular(48'h001122334455, 48'h66778899aabb, 1500, 2);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 2);
        pop_regular(48'h001122334455, 48'h66778899aabb, 64, 2);
        pop_regular(48'h001122334455, 48'h66778899aabb, 1500, 2);
      end
      begin
        pop_request(48'h001122334455, 48'h66778899aabb, 2000);
        pop_request(48'h001122334455, 48'h66778899aabb, 2000);
        pop_request(48'h001122334455, 48'h66778899aabb, 2000);
        pop_request(48'h001122334455, 48'h66778899aabb, 2000);
      end
    join

    $display("receiver: timing test: slower pop_broadcast");
    fork
      begin
        push_frame(48'h001122334455, 48'hffffffffffff, 1500, 2);
        push_frame(48'h001122334455, 48'hffffffffffff, 64, 2);
        push_frame(48'h001122334455, 48'hffffffffffff, 64, 2);
      end
      begin
        pop_broadcast(48'h001122334455, 48'hffffffffffff, 1500, 3);
        pop_broadcast(48'h001122334455, 48'hffffffffffff, 64, 3);
        pop_broadcast(48'h001122334455, 48'hffffffffffff, 64, 3);
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end

  channel_in_receiver #(
                        // Parameters
                        .PORT_ADDR                   (PORT_ADDR),
                        .PORT_HIGH                   (PORT_HIGH),
                        .PORT_WIDTH                  (PORT_WIDTH),
                        .C_AXIS_TDATA_WIDTH          (C_AXIS_TDATA_WIDTH),
                        .C_AXIS_TKEEP_WIDTH          (C_AXIS_TKEEP_WIDTH))
  channel_in_receiver_i (
                         // Outputs
                         .s_axis_tready              (s_axis_tready),
                         .m_axis_regular_tdata       (m_axis_regular_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                         .m_axis_regular_tkeep       (m_axis_regular_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                         .m_axis_regular_tvalid      (m_axis_regular_tvalid),
                         .m_axis_regular_tlast       (m_axis_regular_tlast),
                         .m_axis_broadcast_tdata     (m_axis_broadcast_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                         .m_axis_broadcast_tkeep     (m_axis_broadcast_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                         .m_axis_broadcast_tvalid    (m_axis_broadcast_tvalid),
                         .m_axis_broadcast_tlast     (m_axis_broadcast_tlast),
                         .m_axis_table_request_tdata (m_axis_table_request_tdata[95:0]),
                         .m_axis_table_request_tuser (m_axis_table_request_tuser[PORT_WIDTH-1:0]),
                         .m_axis_table_request_tvalid(m_axis_table_request_tvalid),
                         // Inputs
                         .aclk                       (aclk),
                         .aresetn                    (aresetn),
                         .s_axis_tdata               (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                         .s_axis_tkeep               (s_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                         .s_axis_tvalid              (s_axis_tvalid),
                         .s_axis_tlast               (s_axis_tlast),
                         .m_axis_regular_tready      (m_axis_regular_tready),
                         .m_axis_broadcast_tready    (m_axis_broadcast_tready),
                         .m_axis_table_request_tready(m_axis_table_request_tready));

endmodule

module tb_channel_in_regular
  #(
    parameter PORT_ADDR = 0,
    parameter PORT_HIGH = 3,
    parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
    parameter C_AXIS_TDATA_WIDTH = 8,
    parameter C_AXIS_TKEEP_WIDTH = 1)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  // Income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]   s_axis_tkeep;
  reg                            s_axis_tvalid;
  wire                           s_axis_tready;
  reg                            s_axis_tlast;
  // Table read response
  reg [7:0]                      s_axis_table_response_tdata;
  reg [PORT_WIDTH*2-1:0]         s_axis_table_response_tuser;
  reg                            s_axis_table_response_tvalid;
  // Outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0]  m_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]  m_axis_tkeep;
  wire [PORT_WIDTH-1:0]          m_axis_tdest;
  wire                           m_axis_tvalid;
  reg                            m_axis_tready;
  wire                           m_axis_tlast;

  task push_frame(input [15:0] length, input [31:0] delay_cycles);
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_tdata <= 0;
      s_axis_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_tdata[8 * j +: 8] <= i + j;
          s_axis_tkeep[j] <= 1;
        end
      end
      s_axis_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_tready) begin
        @(posedge aclk);
      end

      s_axis_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_tvalid <= 0;
    @(posedge aclk);
  endtask

  task push_response(input [7:0] status, input [PORT_WIDTH-1:0] src_port, input [PORT_WIDTH-1:0] dst_port, input [31:0] delay_cycles);
    for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
      @(posedge aclk);
    end

    s_axis_table_response_tdata <= status;
    s_axis_table_response_tuser <= {src_port, dst_port};
    s_axis_table_response_tvalid <= 1;
    @(posedge aclk);
    s_axis_table_response_tdata <= status;
    s_axis_table_response_tuser <= {src_port, dst_port};
    s_axis_table_response_tvalid <= 0;
  endtask

  task pop_frame(input [PORT_WIDTH-1:0] expect_dest, input [15:0] length, input [31:0] delay_cycles);
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;

    m_axis_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = i + j;
          expect_keep[j] = 1;
        end
      end
      if (m_axis_tdata != expect_data ||
          m_axis_tkeep != expect_keep ||
          m_axis_tdest != expect_dest) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 expect_data, expect_keep, expect_dest);
        $display("Result: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 m_axis_tdata, m_axis_tkeep, m_axis_tdest);
        @(posedge aclk);
        `FATAL;
      end

      m_axis_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_tready <= 1;
    end
    m_axis_tready <= 0;
    @(posedge aclk);
  endtask

  localparam [7:0]
    TABLE_STATUS_OK = 0,
    TABLE_STATUS_NOTINTABLE = 1,
    TABLE_STATUS_ERROR = 2;

  initial begin
    s_axis_tdata = 0;
    s_axis_tkeep <= 0;
    s_axis_tvalid = 0;
    s_axis_tlast <= 0;
    s_axis_table_response_tdata <= 0;
    s_axis_table_response_tuser <= 0;
    s_axis_table_response_tvalid <= 0;
    m_axis_tready <= 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    // 1. ok response (src=self, dest=others) -> pass
    // 2. ok response (src=self, dest=self) -> drop
    // 3. ok response (src != self, dest=*) -> ignore
    // 4. error response -> drop

    $display("regular: ok response x3");
    fork
      begin
        push_frame(1500, 0);
        push_frame(64, 0);
        push_frame(64, 0);
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR - 1, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 2, 0);
      end
      begin
        pop_frame(PORT_ADDR - 1, 1500, 0);
        pop_frame(PORT_ADDR + 1, 64, 0);
        pop_frame(PORT_ADDR + 2, 64, 0);
      end
    join

    $display("regular: ok response(src=self, dest=self) x3 -> drop");
    fork
      begin
        push_frame(1500, 0);
        push_frame(64, 0);
        push_frame(64, 0);
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR, 0);
      end
      begin
        // do nothing
      end
    join

    $display("regular: ok response(src!=self, dest=*) x3 -> ignored");
    fork
      begin
        // do nothing
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR + 1, PORT_ADDR + 1, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR + 2, PORT_ADDR + 2, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR + 3, PORT_ADDR + 3, 0);
      end
      begin
        // do nothing
      end
    join

    $display("regular: error response x3 -> drop");
    fork
      begin
        push_frame(1500, 0);
        push_frame(64, 0);
        push_frame(64, 0);
      end
      begin
        push_response(TABLE_STATUS_NOTINTABLE, PORT_ADDR, PORT_ADDR + 1, 0);
        push_response(TABLE_STATUS_ERROR, PORT_ADDR, PORT_ADDR + 2, 0);
        push_response(TABLE_STATUS_NOTINTABLE, PORT_ADDR, PORT_ADDR + 3, 0);
      end
      begin
        // do nothing
      end
    join

    $display("regular: timing test: slower pop frame");
    fork
      begin
        push_frame(1500, 0);
        push_frame(64, 0);
        push_frame(64, 0);
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 2, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 3, 0);
      end
      begin
        pop_frame(PORT_ADDR + 1, 1500, 4);
        pop_frame(PORT_ADDR + 2, 64, 4);
        pop_frame(PORT_ADDR + 3, 64, 4);
      end
    join

    $display("regular: timing test: slower push frame");
    fork
      begin
        push_frame(1500, 4);
        push_frame(64, 4);
        push_frame(64, 4);
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 2, 0);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 3, 0);
      end
      begin
        pop_frame(PORT_ADDR + 1, 1500, 0);
        pop_frame(PORT_ADDR + 2, 64, 0);
        pop_frame(PORT_ADDR + 3, 64, 0);
      end
    join

    $display("regular: timing test: delayed push response");
    fork
      begin
        push_frame(1500, 2);
        push_frame(64, 2);
        push_frame(64, 2);
        push_frame(1500, 2);
      end
      begin
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 2000);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 2, 2000);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 3, 2000);
        push_response(TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 3, 2000);
      end
      begin
        pop_frame(PORT_ADDR + 1, 1500, 2);
        pop_frame(PORT_ADDR + 2, 64, 2);
        pop_frame(PORT_ADDR + 3, 64, 2);
        pop_frame(PORT_ADDR + 3, 1500, 2);
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end

  channel_in_regular #(
                       // Parameters
                       .PORT_ADDR                    (PORT_ADDR),
                       .PORT_HIGH                    (PORT_HIGH),
                       .PORT_WIDTH                   (PORT_WIDTH),
                       .C_AXIS_TDATA_WIDTH           (C_AXIS_TDATA_WIDTH),
                       .C_AXIS_TKEEP_WIDTH           (C_AXIS_TKEEP_WIDTH))
  channel_in_regular_i (
                        // Outputs
                        .s_axis_tready               (s_axis_tready),
                        .m_axis_tdata                (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                        .m_axis_tkeep                (m_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                        .m_axis_tdest                (m_axis_tdest[PORT_WIDTH-1:0]),
                        .m_axis_tvalid               (m_axis_tvalid),
                        .m_axis_tlast                (m_axis_tlast),
                        // Inputs
                        .aclk                        (aclk),
                        .aresetn                     (aresetn),
                        .s_axis_tdata                (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                        .s_axis_tkeep                (s_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                        .s_axis_tvalid               (s_axis_tvalid),
                        .s_axis_tlast                (s_axis_tlast),
                        .s_axis_table_response_tdata (s_axis_table_response_tdata[7:0]),
                        .s_axis_table_response_tuser (s_axis_table_response_tuser[PORT_WIDTH*2-1:0]),
                        .s_axis_table_response_tvalid(s_axis_table_response_tvalid),
                        .m_axis_tready               (m_axis_tready));
endmodule

module tb_channel_in_broadcast
  #(
    parameter MAX_FRAME_SIZE = 2048,
    parameter PORT_ADDR = 0,
    parameter PORT_HIGH = 3,
    parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
    parameter C_AXIS_TDATA_WIDTH = 8,
    parameter C_AXIS_TKEEP_WIDTH = 1)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  // Income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]  s_axis_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_tkeep;
  reg                           s_axis_tvalid;
  wire                          s_axis_tready;
  reg                           s_axis_tlast;
  // Outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep;
  wire [PORT_WIDTH-1:0]         m_axis_tdest;
  wire                          m_axis_tvalid;
  reg                           m_axis_tready;
  wire                          m_axis_tlast;

  task push_frame(input [15:0] length, input [31:0] delay_cycles);
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_tdata <= 0;
      s_axis_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_tdata[8 * j +: 8] <= i + j;
          s_axis_tkeep[j] <= 1;
        end
      end
      s_axis_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_tready) begin
        @(posedge aclk);
      end

      s_axis_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_tvalid <= 0;
    @(posedge aclk);
  endtask

  task pop_frame(input [PORT_WIDTH-1:0] expect_dest, input [15:0] length, input [31:0] delay_cycles);
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;

    m_axis_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = i + j;
          expect_keep[j] = 1;
        end
      end
      if (m_axis_tdata != expect_data ||
          m_axis_tkeep != expect_keep ||
          m_axis_tdest != expect_dest) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 expect_data, expect_keep, expect_dest);
        $display("Result: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 m_axis_tdata, m_axis_tkeep, m_axis_tdest);
        @(posedge aclk);
        `FATAL;
      end

      m_axis_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_tready <= 1;
    end
    m_axis_tready <= 0;
    @(posedge aclk);
  endtask

  task pop_broadcast(input [15:0] length, input [31:0] delay_cycles);
    for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
      if (port != PORT_ADDR) begin
        pop_frame(port, length, delay_cycles);
      end
    end
  endtask

  initial begin
    s_axis_tdata = 0;
    s_axis_tkeep <= 0;
    s_axis_tvalid = 0;
    s_axis_tlast <= 0;
    m_axis_tready <= 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    $display("broadcast: long x1 -> short x32");
    fork
      begin
        push_frame(1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(64, 0);
        end
      end
      begin
        pop_broadcast(1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_broadcast(64, 0);
        end
      end
    join

    $display("broadcast: timing test: slower pop broadcast");
    fork
      begin
        push_frame(1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(64, 0);
        end
      end
      begin
        pop_broadcast(1500, 4);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_broadcast(64, 4);
        end
      end
    join

    $display("broadcast: timing test: slower push frame");
    fork
      begin
        push_frame(1500, 4);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(64, 4);
        end
      end
      begin
        pop_broadcast(1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_broadcast(64, 0);
        end
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end

  channel_in_broadcast #(
                         // Parameters
                         .MAX_FRAME_SIZE    (MAX_FRAME_SIZE),
                         .PORT_ADDR          (PORT_ADDR),
                         .PORT_HIGH          (PORT_HIGH),
                         .PORT_WIDTH         (PORT_WIDTH),
                         .C_AXIS_TDATA_WIDTH (C_AXIS_TDATA_WIDTH),
                         .C_AXIS_TKEEP_WIDTH (C_AXIS_TKEEP_WIDTH))
  channel_in_broadcast_i (
                          // Outputs
                          .s_axis_tready     (s_axis_tready),
                          .m_axis_tdata      (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                          .m_axis_tkeep      (m_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                          .m_axis_tdest      (m_axis_tdest[PORT_WIDTH-1:0]),
                          .m_axis_tvalid     (m_axis_tvalid),
                          .m_axis_tlast      (m_axis_tlast),
                          // Inputs
                          .aclk              (aclk),
                          .aresetn           (aresetn),
                          .s_axis_tdata      (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                          .s_axis_tkeep      (s_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                          .s_axis_tvalid     (s_axis_tvalid),
                          .s_axis_tlast      (s_axis_tlast),
                          .m_axis_tready     (m_axis_tready));

endmodule

module tb_channel_in_mux
  #(parameter PORT_ADDR = 0,
    parameter PORT_HIGH = 3,
    parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
    parameter C_AXIS_TDATA_WIDTH = 8,
    parameter C_AXIS_TKEEP_WIDTH = 1)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  // Regular income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]  s_axis_regular_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_regular_tkeep;
  reg [PORT_WIDTH-1:0]          s_axis_regular_tdest;
  reg                           s_axis_regular_tvalid;
  wire                          s_axis_regular_tready;
  reg                           s_axis_regular_tlast;

  // Broadcast income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]  s_axis_broadcast_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_broadcast_tkeep;
  reg [PORT_WIDTH-1:0]          s_axis_broadcast_tdest;
  reg                           s_axis_broadcast_tvalid;
  wire                          s_axis_broadcast_tready;
  reg                           s_axis_broadcast_tlast;

  // Outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep;
  wire [PORT_WIDTH-1:0]         m_axis_tdest;
  wire                          m_axis_tvalid;
  reg                           m_axis_tready;
  wire                          m_axis_tlast;

  task push_regular_frame(input [PORT_WIDTH-1:0] dest, input [15:0] length, input [31:0] delay_cycles);
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_regular_tdata <= 0;
      s_axis_regular_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_regular_tdata[8 * j +: 8] <= i + j;
          s_axis_regular_tkeep[j] <= 1;
        end
      end
      s_axis_regular_tdest <= dest;
      s_axis_regular_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_regular_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_regular_tready) begin
        @(posedge aclk);
      end

      s_axis_regular_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_regular_tvalid <= 0;
    @(posedge aclk);
  endtask

  task push_broadcast_frame_impl(input [PORT_WIDTH-1:0] dest, input [15:0] length, input [31:0] delay_cycles);
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_broadcast_tdata <= 0;
      s_axis_broadcast_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_broadcast_tdata[8 * j +: 8] <= i + j;
          s_axis_broadcast_tkeep[j] <= 1;
        end
      end
      s_axis_broadcast_tdest <= dest;
      s_axis_broadcast_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_broadcast_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_broadcast_tready) begin
        @(posedge aclk);
      end

      s_axis_broadcast_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_broadcast_tvalid <= 0;
    @(posedge aclk);
  endtask

  task push_broadcast_frame(input [15:0] length, input [31:0] delay_cycles);
    for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
      if (port != PORT_ADDR) begin
        push_broadcast_frame_impl(port, length, delay_cycles);
      end
    end
  endtask

  task pop_frame(input [PORT_WIDTH-1:0] expect_dest, input [15:0] length, input [31:0] delay_cycles);
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;

    m_axis_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = i + j;
          expect_keep[j] = 1;
        end
      end
      if (m_axis_tdata != expect_data ||
          m_axis_tkeep != expect_keep ||
          m_axis_tdest != expect_dest) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 expect_data, expect_keep, expect_dest);
        $display("Result: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 m_axis_tdata, m_axis_tkeep, m_axis_tdest);
        @(posedge aclk);
        `FATAL;
      end

      m_axis_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_tready <= 1;
    end
    m_axis_tready <= 0;
    @(posedge aclk);
  endtask

  initial begin
    s_axis_regular_tdata = 0;
    s_axis_regular_tkeep <= 0;
    s_axis_regular_tdest <= 0;
    s_axis_regular_tvalid = 0;
    s_axis_regular_tlast <= 0;
    s_axis_broadcast_tdata = 0;
    s_axis_broadcast_tkeep <= 0;
    s_axis_broadcast_tdest <= 0;
    s_axis_broadcast_tvalid = 0;
    s_axis_broadcast_tlast <= 0;
    m_axis_tready <= 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    $display("mux: 1 broadcast + 1 regular -> broadcast is higher priority");
    fork
      begin
        push_broadcast_frame(1500, 0);
      end
      begin
        // delay
        for (int i = 0; i < 10; i = i + 1) begin
          @(posedge aclk);
        end
        push_regular_frame(~PORT_ADDR, 1024, 0);
      end
      begin
        // broadcast
        for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(port, 1500, 0);
          end
        end

        // regular
        pop_frame(~PORT_ADDR, 1024, 0);
      end
    join

    $display("mux: timing test: slow broadcast");
    fork
      begin
        push_broadcast_frame(1500, 3);
        // To process frame in expected order, send regular frame after broadcast
        push_regular_frame(~PORT_ADDR, 1024, 0);
      end
      begin
        // broadcast
        for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(port, 1500, 0);
          end
        end

        // regular
        pop_frame(~PORT_ADDR, 1024, 0);
      end
    join

    $display("mux: timing test: slow regular (regular is processed earlier)");
    fork
      begin
        // delay
        for (int i = 0; i < 10; i = i + 1) begin
          @(posedge aclk);
        end
        push_broadcast_frame(1500, 0);
      end
      begin
        push_regular_frame(~PORT_ADDR, 1024, 3);
      end
      begin
        // regular
        pop_frame(~PORT_ADDR, 1024, 0);

        // broadcast
        for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(port, 1500, 0);
          end
        end
      end
    join

    $display("mux: timing test: slow pop");
    fork
      begin
        push_broadcast_frame(1500, 0);
      end
      begin
        // delay
        for (int i = 0; i < 10; i = i + 1) begin
          @(posedge aclk);
        end
        push_regular_frame(~PORT_ADDR, 1024, 0);
      end
      begin
        // broadcast
        for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(port, 1500, 3);
          end
        end

        // regular
        pop_frame(~PORT_ADDR, 1024, 3);
      end
    join

    $display("mux: timing test: slow all");
    fork
      begin
        push_broadcast_frame(1500, 4);
        // To process frame in expected order, send regular frame after broadcast
        push_regular_frame(~PORT_ADDR, 1024, 5);
      end
      begin
        // broadcast
        for (int port = 0; port <= PORT_HIGH; port = port + 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(port, 1500, (port % 2) == 0 ? 1 : 5);
          end
        end

        // regular
        pop_frame(~PORT_ADDR, 1024, 3);
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end

  channel_in_mux #(
                   // Parameters
                   .PORT_HIGH               (PORT_HIGH),
                   .PORT_WIDTH              (PORT_WIDTH),
                   .C_AXIS_TDATA_WIDTH      (C_AXIS_TDATA_WIDTH),
                   .C_AXIS_TKEEP_WIDTH      (C_AXIS_TKEEP_WIDTH))
  channel_in_mux_i (
                    // Outputs
                    .s_axis_regular_tready  (s_axis_regular_tready),
                    .s_axis_broadcast_tready(s_axis_broadcast_tready),
                    .m_axis_tdata           (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                    .m_axis_tkeep           (m_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                    .m_axis_tdest           (m_axis_tdest[PORT_WIDTH-1:0]),
                    .m_axis_tvalid          (m_axis_tvalid),
                    .m_axis_tlast           (m_axis_tlast),
                    // Inputs
                    .aclk                   (aclk),
                    .aresetn                (aresetn),
                    .s_axis_regular_tdata   (s_axis_regular_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                    .s_axis_regular_tkeep   (s_axis_regular_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                    .s_axis_regular_tdest   (s_axis_regular_tdest[PORT_WIDTH-1:0]),
                    .s_axis_regular_tvalid  (s_axis_regular_tvalid),
                    .s_axis_regular_tlast   (s_axis_regular_tlast),
                    .s_axis_broadcast_tdata (s_axis_broadcast_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                    .s_axis_broadcast_tkeep (s_axis_broadcast_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                    .s_axis_broadcast_tdest (s_axis_broadcast_tdest[PORT_WIDTH-1:0]),
                    .s_axis_broadcast_tvalid(s_axis_broadcast_tvalid),
                    .s_axis_broadcast_tlast (s_axis_broadcast_tlast),
                    .m_axis_tready          (m_axis_tready));


endmodule

module tb_channel_in_opt_all
  #(parameter PORT_ADDR = 0,
    parameter PORT_HIGH = 3,
    parameter PORT_WIDTH = $clog2(PORT_HIGH+1),
    parameter C_AXIS_TDATA_WIDTH = 8,
    parameter C_AXIS_TKEEP_WIDTH = 1)
  (input wire aclk,
   input wire aresetn,
   input wire test_start,
   output reg test_done);

  // Income frames
  reg [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata;
  reg [C_AXIS_TKEEP_WIDTH-1:0]   s_axis_tkeep;
  reg                            s_axis_tvalid;
  wire                           s_axis_tready;
  reg                            s_axis_tlast;
  // Outcome frames
  wire [C_AXIS_TDATA_WIDTH-1:0]  m_axis_tdata;
  wire [C_AXIS_TKEEP_WIDTH-1:0]  m_axis_tkeep;
  wire [PORT_WIDTH-1:0]          m_axis_tdest;
  wire                           m_axis_tvalid;
  reg                            m_axis_tready;
  wire                           m_axis_tlast;
  // Table read request
  wire [95:0]                    m_axis_table_request_tdata;
  wire [PORT_WIDTH-1:0]          m_axis_table_request_tuser;
  wire                           m_axis_table_request_tvalid;
  reg                            m_axis_table_request_tready;
  // Table read response
  reg [7:0]                      s_axis_table_response_tdata;
  reg [PORT_WIDTH*2-1:0]         s_axis_table_response_tuser;
  reg                            s_axis_table_response_tvalid;
  // Status: {frames, dropped, error_crc, error_len}
  wire [127:0]                   m_axis_status_tdata;
  wire                           m_axis_status_tvalid;

  task push_frame(input [47:0] src_mac, input [47:0] dst_mac, input [15:0] length, input [31:0] delay_cycles);
    reg [7:0] frame [2047:0];
    frame[0] = dst_mac[0 +: 8];
    frame[1] = dst_mac[8 +: 8];
    frame[2] = dst_mac[16 +: 8];
    frame[3] = dst_mac[24 +: 8];
    frame[4] = dst_mac[32 +: 8];
    frame[5] = dst_mac[40 +: 8];
    frame[6] = src_mac[0 +: 8];
    frame[7] = src_mac[8 +: 8];
    frame[8] = src_mac[16 +: 8];
    frame[9] = src_mac[24 +: 8];
    frame[10] = src_mac[32 +: 8];
    frame[11] = src_mac[40 +: 8];
    for (int i = 0; i < length - 12; i += 1) begin
      frame[i + 12] = i;
    end

    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      s_axis_tdata <= 0;
      s_axis_tkeep <= 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          s_axis_tdata[j * 8 +: 8] <= frame[i + j];
          s_axis_tkeep[j] <= 1;
        end
      end
      s_axis_tlast <= (i + C_AXIS_TKEEP_WIDTH >= length) ? 1 : 0;
      s_axis_tvalid <= 1;
      @(posedge aclk);

      while (!s_axis_tready) begin
        @(posedge aclk);
      end

      s_axis_tvalid <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
    end

    s_axis_tvalid <= 0;
    @(posedge aclk);
  endtask

  task process_request(input [47:0] src_mac, input [47:0] dst_mac, input [7:0] status, input [PORT_WIDTH-1:0] src_port, input [PORT_WIDTH-1:0] dst_port, input [31:0] delay_cycles, input [31:0] resp_delay_cycles);
    for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
      @(posedge aclk);
    end

    m_axis_table_request_tready <= 1;
    @(posedge aclk);
    while (!m_axis_table_request_tvalid) begin
      @(posedge aclk);
    end
    m_axis_table_request_tready <= 0;
    @(posedge aclk);

    // $display("all: send request. src_mac=0x%012x, dst_mac=0x%012x, port=%d",
    //          m_axis_table_request_tdata[48 +: 48], m_axis_table_request_tdata[0 +: 48], m_axis_table_request_tuser);
    if (m_axis_table_request_tdata[0 +: 48] != dst_mac) begin
      $display("ERROR: expected dst_mac: 0x%012x", dst_mac);
      `FATAL;
    end
    if (m_axis_table_request_tdata[48 +: 48] != src_mac) begin
      $display("ERROR: expected src_mac: 0x%012x", src_mac);
      `FATAL;
    end
    if (m_axis_table_request_tuser != PORT_ADDR) begin
      $display("ERROR: expected port_addr: %d", PORT_ADDR);
      `FATAL;
    end

    // send response
    for (int delay = 0; delay < resp_delay_cycles; delay = delay + 1) begin
      @(posedge aclk);
    end

    s_axis_table_response_tdata <= status;
    s_axis_table_response_tuser <= {src_port, dst_port};
    s_axis_table_response_tvalid <= 1;
    @(posedge aclk);
    s_axis_table_response_tvalid <= 0;
  endtask

  task pop_frame(input [47:0] src_mac, input [47:0] dst_mac, input [PORT_WIDTH-1:0] expect_dest, input [15:0] length, input [31:0] delay_cycles);
    reg [C_AXIS_TDATA_WIDTH-1:0] expect_data;
    reg [C_AXIS_TKEEP_WIDTH-1:0] expect_keep;
    reg [7:0] frame [2047:0];
    frame[0] = dst_mac[0 +: 8];
    frame[1] = dst_mac[8 +: 8];
    frame[2] = dst_mac[16 +: 8];
    frame[3] = dst_mac[24 +: 8];
    frame[4] = dst_mac[32 +: 8];
    frame[5] = dst_mac[40 +: 8];
    frame[6] = src_mac[0 +: 8];
    frame[7] = src_mac[8 +: 8];
    frame[8] = src_mac[16 +: 8];
    frame[9] = src_mac[24 +: 8];
    frame[10] = src_mac[32 +: 8];
    frame[11] = src_mac[40 +: 8];
    for (int i = 0; i < length - 12; i += 1) begin
      frame[i + 12] = i;
    end

    m_axis_tready <= 1;
    for (int i = 0; i < length; i += C_AXIS_TKEEP_WIDTH) begin
      @(posedge aclk);
      while (!m_axis_tvalid) begin
        @(posedge aclk);
      end
      // Data is received in current cycle. validate it.
      expect_data = 0;
      expect_keep = 0;
      for (int j = 0; j < C_AXIS_TKEEP_WIDTH; j += 1) begin
        if (i + j < length) begin
          expect_data[8 * j +: 8] = frame[i + j];
          expect_keep[j] = 1;
        end
      end
      if (m_axis_tdata != expect_data ||
          m_axis_tkeep != expect_keep ||
          m_axis_tdest != expect_dest) begin
        $display("Error: received unexpected word");
        $display("Expected: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 expect_data, expect_keep, expect_dest);
        $display("Result: tdata=0x%x, tkeep=0x%x, tdest=%d",
                 m_axis_tdata, m_axis_tkeep, m_axis_tdest);
        @(posedge aclk);
        `FATAL;
      end

      m_axis_tready <= 0;
      for (int delay = 0; delay < delay_cycles; delay = delay + 1) begin
        @(posedge aclk);
      end
      m_axis_tready <= 1;
    end
    m_axis_tready <= 0;
    @(posedge aclk);
  endtask

  localparam [7:0]
    TABLE_STATUS_OK = 0,
    TABLE_STATUS_NOTINTABLE = 1,
    TABLE_STATUS_ERROR = 2;

  reg [47:0] src_mac = 48'h001122334455;
  reg [47:0] dst_mac = 48'h66778899aabb;
  reg [47:0] dst_broadcast = 48'hffffffffffff;
  initial begin
    s_axis_tdata <= 0;
    s_axis_tkeep <= 0;
    s_axis_tvalid <= 0;
    s_axis_tlast <= 0;
    m_axis_tready <= 0;
    m_axis_table_request_tready <= 0;
    s_axis_table_response_tdata <= 0;
    s_axis_table_response_tuser <= 0;
    s_axis_table_response_tvalid <= 0;
    test_done = 0;

    // wait until test_start signal becomes high...
    @(posedge test_start);

    $display("all: regular frame: long x1 -> short x32");
    fork
      begin
        push_frame(src_mac, dst_mac, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(src_mac, dst_mac, 64, 0);
        end
      end
      begin
        // 10 cycle delay for resolving destination port
        process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        for (int i = 0; i < 32; i = i + 1) begin
          process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        end
      end
      begin
        pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 64, 0);
        end
      end
    join

    $display("all: broadcast");
    fork
      begin
        push_frame(src_mac, dst_broadcast, 1500, 0);
      end
      begin
        // no resolve request
      end
      begin
        for (int port = 0; port <= PORT_HIGH; port += 1) begin
          if (port != PORT_ADDR) begin
            pop_frame(src_mac, dst_broadcast, port, 1500, 0);
          end
        end
      end
    join

    $display("all: timing test: long x1 -> short x32, slow push frame");
    fork
      begin
        push_frame(src_mac, dst_mac, 1500, 3);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(src_mac, dst_mac, 64, 3);
        end
      end
      begin
        // 10 cycle delay for resolving destination port
        process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        for (int i = 0; i < 32; i = i + 1) begin
          process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        end
      end
      begin
        pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 64, 0);
        end
      end
    join

    $display("all: timing test: long x1 -> short x32, slow pop frame");
    fork
      begin
        push_frame(src_mac, dst_mac, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(src_mac, dst_mac, 64, 0);
        end
      end
      begin
        // 10 cycle delay for resolving destination port
        process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        for (int i = 0; i < 32; i = i + 1) begin
          process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 0, 10);
        end
      end
      begin
        pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 1500, 3);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 64, 3);
        end
      end
    join

    $display("all: timing test: long x1 -> short x32, slow process request");
    fork
      begin
        push_frame(src_mac, dst_mac, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(src_mac, dst_mac, 64, 0);
        end
      end
      begin
        process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 100, 1000);
        for (int i = 0; i < 32; i = i + 1) begin
          process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 100, 1000);
        end
      end
      begin
        pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 1500, 0);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 64, 0);
        end
      end
    join

    $display("all: timing test: long x1 -> short x32, slow all");
    fork
      begin
        push_frame(src_mac, dst_mac, 1500, 2);
        for (int i = 0; i < 32; i = i + 1) begin
          push_frame(src_mac, dst_mac, 64, 6);
        end
      end
      begin
        // 10 cycle delay for resolving destination port
        process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 100, 20);
        for (int i = 0; i < 32; i = i + 1) begin
          process_request(src_mac, dst_mac, TABLE_STATUS_OK, PORT_ADDR, PORT_ADDR + 1, 100, 20);
        end
      end
      begin
        pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 1500, 3);
        for (int i = 0; i < 32; i = i + 1) begin
          pop_frame(src_mac, dst_mac, PORT_ADDR + 1, 64, 2);
        end
      end
    join

    test_done <= 1;
    @(posedge aclk);
  end

  channel_in_opt #(
                   // Parameters
                   .PORT_ADDR           (PORT_ADDR),
                   .PORT_HIGH           (PORT_HIGH),
                   .PORT_WIDTH          (PORT_WIDTH),
                   .C_AXIS_TDATA_WIDTH  (C_AXIS_TDATA_WIDTH),
                   .C_AXIS_TKEEP_WIDTH  (C_AXIS_TKEEP_WIDTH))
  channel_in_opt_i (
                    // Outputs
                    .s_axis_tready               (s_axis_tready),
                    .m_axis_tdata                (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                    .m_axis_tkeep                (m_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                    .m_axis_tdest                (m_axis_tdest[PORT_WIDTH-1:0]),
                    .m_axis_tvalid               (m_axis_tvalid),
                    .m_axis_tlast                (m_axis_tlast),
                    .m_axis_table_request_tdata  (m_axis_table_request_tdata[95:0]),
                    .m_axis_table_request_tuser  (m_axis_table_request_tuser[PORT_WIDTH-1:0]),
                    .m_axis_table_request_tvalid (m_axis_table_request_tvalid),
                    .m_axis_status_tdata         (m_axis_status_tdata[127:0]),
                    .m_axis_status_tvalid        (m_axis_status_tvalid),
                    // Inputs
                    .aclk                        (aclk),
                    .aresetn                     (aresetn),
                    .s_axis_tdata                (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                    .s_axis_tkeep                (s_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                    .s_axis_tvalid               (s_axis_tvalid),
                    .s_axis_tlast                (s_axis_tlast),
                    .m_axis_tready               (m_axis_tready),
                    .m_axis_table_request_tready (m_axis_table_request_tready),
                    .s_axis_table_response_tdata (s_axis_table_response_tdata[7:0]),
                    .s_axis_table_response_tuser (s_axis_table_response_tuser[PORT_WIDTH*2-1:0]),
                    .s_axis_table_response_tvalid(s_axis_table_response_tvalid));

endmodule

module tb_channel_in_opt;
  // This tb consists of multiple child tests
  //
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
  parameter integer EXPECTED_TDEST = 0;

  localparam integer TIMEOUT_CYCLE = 2000000;
  localparam integer RESET_CYCLE = 10;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;
  reg  init_done;

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

  localparam NUM_TESTCASES = 28;
  localparam DO_REVERSE_ORDER = 0;
  reg [NUM_TESTCASES-1:0] test_start;
  wire [NUM_TESTCASES-1:0] test_done;

  always @(posedge clk) begin
    if (DO_REVERSE_ORDER) begin
      test_start[0 +: NUM_TESTCASES-1] <= test_done[1 +: NUM_TESTCASES-1];
    end else begin
      test_start[1 +: NUM_TESTCASES-1] <= test_done[0 +: NUM_TESTCASES-1];
    end
  end

  initial begin
    test_start = 0;
    // test_done = 0;
    @(posedge rstn);

    for (int i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
    end

    if (DO_REVERSE_ORDER) begin
      test_start[NUM_TESTCASES-1] <= 1;
    end else begin
      test_start[0] <= 1;
    end

    if (DO_REVERSE_ORDER) begin
      @(posedge test_done[0]);
    end else begin
      @(posedge test_done[NUM_TESTCASES-1]);
    end

    for (int i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
    end
    $finish();
  end

  //-------------------------
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
  wire aclk = clk;
  wire aresetn = rstn;
  tb_channel_in_fifo #(
                       // Parameters
                       .DWIDTH          (9),
                       .AWIDTH          (8))
  tb_channel_in_fifo_i (
                        // Outputs
                        .test_done      (test_done[0]),
                        // Inputs
                        .aclk           (aclk),
                        .aresetn        (aresetn),
                        .test_start     (test_start[0]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (0),
                           .PORT_HIGH           (3),
                           .PORT_WIDTH          (2),
                           .C_AXIS_TDATA_WIDTH  (8),
                           .C_AXIS_TKEEP_WIDTH  (1))
  tb_channel_in_receiver_1 (
                            // Outputs
                            .test_done          (test_done[1]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[1]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (3),
                           .PORT_HIGH           (3),
                           .PORT_WIDTH          (2),
                           .C_AXIS_TDATA_WIDTH  (8),
                           .C_AXIS_TKEEP_WIDTH  (1))
  tb_channel_in_receiver_2 (
                            // Outputs
                            .test_done          (test_done[2]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[2]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (0),
                           .PORT_HIGH           (7),
                           .PORT_WIDTH          (3),
                           .C_AXIS_TDATA_WIDTH  (64),
                           .C_AXIS_TKEEP_WIDTH  (8))
  tb_channel_in_receiver_3 (
                            // Outputs
                            .test_done          (test_done[3]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[3]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (7),
                           .PORT_HIGH           (7),
                           .PORT_WIDTH          (3),
                           .C_AXIS_TDATA_WIDTH  (64),
                           .C_AXIS_TKEEP_WIDTH  (8))
  tb_channel_in_receiver_4 (
                            // Outputs
                            .test_done          (test_done[4]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[4]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (0),
                           .PORT_HIGH           (7),
                           .PORT_WIDTH          (3),
                           .C_AXIS_TDATA_WIDTH  (128),
                           .C_AXIS_TKEEP_WIDTH  (16))
  tb_channel_in_receiver_5 (
                            // Outputs
                            .test_done          (test_done[5]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[5]));

  tb_channel_in_receiver #(
                           // Parameters
                           .PORT_ADDR           (7),
                           .PORT_HIGH           (7),
                           .PORT_WIDTH          (3),
                           .C_AXIS_TDATA_WIDTH  (128),
                           .C_AXIS_TKEEP_WIDTH  (16))
  tb_channel_in_receiver_6 (
                            // Outputs
                            .test_done          (test_done[6]),
                            // Inputs
                            .aclk               (aclk),
                            .aresetn            (aresetn),
                            .test_start         (test_start[6]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (3),
                          .PORT_WIDTH           (2),
                          .C_AXIS_TDATA_WIDTH   (8),
                          .C_AXIS_TKEEP_WIDTH   (1))
  tb_channel_in_regular_1 (
                           // Outputs
                           .test_done           (test_done[7]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[7]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (3),
                          .PORT_HIGH            (3),
                          .PORT_WIDTH           (2),
                          .C_AXIS_TDATA_WIDTH   (8),
                          .C_AXIS_TKEEP_WIDTH   (1))
  tb_channel_in_regular_2 (
                           // Outputs
                           .test_done           (test_done[8]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[8]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (64),
                          .C_AXIS_TKEEP_WIDTH   (8))
  tb_channel_in_regular_3 (
                           // Outputs
                           .test_done           (test_done[9]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[9]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (7),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (64),
                          .C_AXIS_TKEEP_WIDTH   (8))
  tb_channel_in_regular_4 (
                           // Outputs
                           .test_done           (test_done[10]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[10]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (128),
                          .C_AXIS_TKEEP_WIDTH   (16))
  tb_channel_in_regular_5 (
                           // Outputs
                           .test_done           (test_done[11]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[11]));

  tb_channel_in_regular #(
                          // Parameters
                          .PORT_ADDR            (7),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (128),
                          .C_AXIS_TKEEP_WIDTH   (16))
  tb_channel_in_regular_6 (
                           // Outputs
                           .test_done           (test_done[12]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[12]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (0),
                            .PORT_HIGH          (3),
                            .PORT_WIDTH         (2),
                            .C_AXIS_TDATA_WIDTH (8),
                            .C_AXIS_TKEEP_WIDTH (1))
  tb_channel_in_broadcast_1 (
                             // Outputs
                             .test_done         (test_done[13]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[13]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (3),
                            .PORT_HIGH          (3),
                            .PORT_WIDTH         (2),
                            .C_AXIS_TDATA_WIDTH (8),
                            .C_AXIS_TKEEP_WIDTH (1))
  tb_channel_in_broadcast_2 (
                             // Outputs
                             .test_done         (test_done[14]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[14]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (0),
                            .PORT_HIGH          (7),
                            .PORT_WIDTH         (3),
                            .C_AXIS_TDATA_WIDTH (64),
                            .C_AXIS_TKEEP_WIDTH (8))
  tb_channel_in_broadcast_3 (
                             // Outputs
                             .test_done         (test_done[15]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[15]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (7),
                            .PORT_HIGH          (7),
                            .PORT_WIDTH         (3),
                            .C_AXIS_TDATA_WIDTH (64),
                            .C_AXIS_TKEEP_WIDTH (8))
  tb_channel_in_broadcast_4 (
                             // Outputs
                             .test_done         (test_done[16]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[16]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (0),
                            .PORT_HIGH          (7),
                            .PORT_WIDTH         (3),
                            .C_AXIS_TDATA_WIDTH (128),
                            .C_AXIS_TKEEP_WIDTH (16))
  tb_channel_in_broadcast_5 (
                             // Outputs
                             .test_done         (test_done[17]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[17]));

  tb_channel_in_broadcast #(
                            // Parameters
                            .MAX_FRAME_SIZE    (2048),
                            .PORT_ADDR          (7),
                            .PORT_HIGH          (7),
                            .PORT_WIDTH         (3),
                            .C_AXIS_TDATA_WIDTH (128),
                            .C_AXIS_TKEEP_WIDTH (16))
  tb_channel_in_broadcast_6 (
                             // Outputs
                             .test_done         (test_done[18]),
                             // Inputs
                             .aclk              (aclk),
                             .aresetn           (aresetn),
                             .test_start        (test_start[18]));

  tb_channel_in_mux #(
                      // Parameters
                      .PORT_ADDR        (0),
                      .PORT_HIGH        (3),
                      .PORT_WIDTH       (2),
                      .C_AXIS_TDATA_WIDTH(8),
                      .C_AXIS_TKEEP_WIDTH(1))
  tb_channel_in_mux_1 (
                       // Outputs
                       .test_done       (test_done[19]),
                       // Inputs
                       .aclk            (aclk),
                       .aresetn         (aresetn),
                       .test_start      (test_start[19]));

  tb_channel_in_mux #(
                      // Parameters
                      .PORT_ADDR        (0),
                      .PORT_HIGH        (7),
                      .PORT_WIDTH       (3),
                      .C_AXIS_TDATA_WIDTH(64),
                      .C_AXIS_TKEEP_WIDTH(8))
  tb_channel_in_mux_2 (
                       // Outputs
                       .test_done       (test_done[20]),
                       // Inputs
                       .aclk            (aclk),
                       .aresetn         (aresetn),
                       .test_start      (test_start[20]));

  tb_channel_in_mux #(
                      // Parameters
                      .PORT_ADDR        (0),
                      .PORT_HIGH        (7),
                      .PORT_WIDTH       (3),
                      .C_AXIS_TDATA_WIDTH(128),
                      .C_AXIS_TKEEP_WIDTH(16))
  tb_channel_in_mux_3 (
                       // Outputs
                       .test_done       (test_done[21]),
                       // Inputs
                       .aclk            (aclk),
                       .aresetn         (aresetn),
                       .test_start      (test_start[21]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (3),
                          .PORT_WIDTH           (2),
                          .C_AXIS_TDATA_WIDTH   (8),
                          .C_AXIS_TKEEP_WIDTH   (1))
  tb_channel_in_opt_all_1 (
                           // Outputs
                           .test_done           (test_done[22]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[22]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (3),
                          .PORT_HIGH            (3),
                          .PORT_WIDTH           (2),
                          .C_AXIS_TDATA_WIDTH   (8),
                          .C_AXIS_TKEEP_WIDTH   (1))
  tb_channel_in_opt_all_2 (
                           // Outputs
                           .test_done           (test_done[23]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[23]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (64),
                          .C_AXIS_TKEEP_WIDTH   (8))
  tb_channel_in_opt_all_3 (
                           // Outputs
                           .test_done           (test_done[24]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[24]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (7),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (64),
                          .C_AXIS_TKEEP_WIDTH   (8))
  tb_channel_in_opt_all_4 (
                           // Outputs
                           .test_done           (test_done[25]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[25]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (0),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (128),
                          .C_AXIS_TKEEP_WIDTH   (16))
  tb_channel_in_opt_all_5 (
                           // Outputs
                           .test_done           (test_done[26]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[26]));

  tb_channel_in_opt_all #(
                          // Parameters
                          .PORT_ADDR            (7),
                          .PORT_HIGH            (7),
                          .PORT_WIDTH           (3),
                          .C_AXIS_TDATA_WIDTH   (128),
                          .C_AXIS_TKEEP_WIDTH   (16))
  tb_channel_in_opt_all_6 (
                           // Outputs
                           .test_done           (test_done[27]),
                           // Inputs
                           .aclk                (aclk),
                           .aresetn             (aresetn),
                           .test_start          (test_start[27]));


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
