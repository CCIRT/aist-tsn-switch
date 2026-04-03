// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_pulse_generator;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;
  parameter integer EXPECTED_TDEST = 0;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 160;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 200;

  localparam C_S_AXI_DATA_WIDTH = 32;
  localparam C_S_AXI_ADDR_WIDTH = 12;
  localparam OFFSET_BIT = $clog2((C_S_AXI_DATA_WIDTH / 8));
  localparam NUM_INPUTS = 64;
  localparam NUM_OUTPUTS = 4;

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  // AXI4-Stream In
  reg  [NUM_INPUTS-1:0] data_in = 0;
  wire [NUM_OUTPUTS-1:0] pulse_out;

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
  wire                             S_AXI_ARVALID = 0;
  wire                             S_AXI_ARREADY;
  wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA;
  wire [1:0]                       S_AXI_RRESP;
  wire                             S_AXI_RVALID;
  wire                             S_AXI_RREADY = 1;

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

  task expect_no_pulse(input [NUM_INPUTS-1:0] mask);
    data_in <= mask;
    @(posedge clk);

    data_in <= '0;
    @(posedge clk);

    // No pulse occurs
    for (int i = 0; i < 10; i++) begin
      if (pulse_out) begin
        $display("Error: pulse triggered when expected pulse width is 0.");
        `FATAL;
      end
      @(posedge clk);
    end
  endtask

  reg timeout = 0;
  task expect_pulse(input [NUM_INPUTS-1:0] mask, input [NUM_OUTPUTS-1:0] expect_output, input [23:0] expect_pulse_width);
    data_in <= mask;
    @(posedge clk);

    data_in <= '0;
    @(posedge clk);

    timeout = 1;
    for (int i = 0; i < 10; i++) begin
      if (pulse_out != 0) begin
        timeout = 0;
      end else begin
        @(posedge clk);
      end
    end

    if (timeout == 1) begin
      @(posedge clk);
      $display("Error: pulse is not asserted");
      `FATAL;
    end

    // pulse triggered.
    // verify pulse width
    for (int i = 0; i < expect_pulse_width; i++) begin
      if (pulse_out != expect_output) begin
        $display("Error: pulse is deasserted at %d cycle, expected pulse width = %d, expect pulse output = %b, actual pulse output = %b",
                 i, expect_pulse_width, expect_output, pulse_out);
        `FATAL;
      end
      @(posedge clk);
    end

    // pulse must be deasserted.
    if (pulse_out) begin
      $display("Error: pulse width is larger than expected pulse width, expected pulse width = %d, expect pulse output = %b, actual pulse output = %b",
               expect_pulse_width, expect_output, pulse_out);
      `FATAL;
    end
    @(posedge clk);
  endtask

  //-------------------------
  // Test routine
  //-------------------------
  initial begin
    // wait device reset
    @(posedge clk);
    @(posedge rstn);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    // Register settings:
    // - data_in[0] -> data_out[0]
    // - data_in[63] -> data_out[1]
    // - data_in[32] -> data_out[2]
    // - data_in[16] -> data_out[3]
    write_register(0, 32'h0000_0001);
    write_register(1, 32'h0000_0000);
    write_register(2, 32'h0000_0000);
    write_register(3, 32'h8000_0000);
    write_register(4, 32'h0000_0000);
    write_register(5, 32'h0000_0001);
    write_register(6, 32'h0001_0000);
    write_register(7, 32'h0000_0000);

    // No pulse width
    expect_no_pulse(64'hffff_ffff_ffff_ffff);

    // Register settings:
    // - pulse_width = 16
    write_register(32'h40, 16);

    // pulse width set, output to port[0]
    expect_pulse(64'h0000_0000_0000_0001, 4'b0001, 16);

    // pulse width set, output to port[1]
    expect_pulse(64'h8000_0000_0000_0000, 4'b0010, 16);

    // pulse width set, output to port[2]
    expect_pulse(64'h0000_0001_0000_0000, 4'b0100, 16);

    // pulse width set, output to port[3]
    expect_pulse(64'h0000_0000_0001_0000, 4'b1000, 16);

    // pulse width set, output to both
    expect_pulse(64'h8000_0001_0001_0001, 4'b1111, 16);

    // other bits
    expect_no_pulse(~64'h8000_0001_0001_0001);


    // Register settings:
    // - none -> data_out[0]
    // - none -> data_out[1]
    write_register(0, 32'h0);
    write_register(1, 32'h0);
    write_register(2, 32'h0);
    write_register(3, 32'h0);
    write_register(4, 32'h0);
    write_register(5, 32'h0);
    write_register(6, 32'h0);
    write_register(7, 32'h0);

    // No pulse will occur
    expect_no_pulse(64'hffff_ffff_ffff_ffff);

    // Other register settings:
    // - data_in[1] -> data_out[0]
    // - data_in[6] -> data_out[1]
    // - data_in[12:11] -> data_out[2]
    // - data_in[33:30] -> data_out[3]
    // - pulse_width = 1024
    write_register(0, 32'h0000_0002);
    write_register(1, 32'h0000_0000);
    write_register(2, 32'h0000_0020);
    write_register(3, 32'h0000_0000);
    write_register(4, 32'h0000_1800);
    write_register(5, 32'h0000_0000);
    write_register(6, 32'h0000_c000);
    write_register(7, 32'h0003_0000);
    write_register(32'h40, 1024);

    expect_pulse(64'h0001_0000_0000_1022, 4'b1111, 1024);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    $display("Test completed with no error");
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
  pulse_generator #(
                    // Parameters
                    .NUM_INPUTS         (NUM_INPUTS),
                    .NUM_OUTPUTS        (NUM_OUTPUTS),
                    .C_S_AXI_DATA_WIDTH (C_S_AXI_DATA_WIDTH),
                    .C_S_AXI_ADDR_WIDTH (C_S_AXI_ADDR_WIDTH))
  pulse_generator_i (
                     // Outputs
                     .pulse_out         (pulse_out),
                     .S_AXI_AWREADY     (S_AXI_AWREADY),
                     .S_AXI_WREADY      (S_AXI_WREADY),
                     .S_AXI_BRESP       (S_AXI_BRESP),
                     .S_AXI_BVALID      (S_AXI_BVALID),
                     .S_AXI_ARREADY     (S_AXI_ARREADY),
                     .S_AXI_RDATA       (S_AXI_RDATA),
                     .S_AXI_RRESP       (S_AXI_RRESP),
                     .S_AXI_RVALID      (S_AXI_RVALID),
                     // Inputs
                     .clk               (clk),
                     .rstn              (rstn),
                     .data_in           (data_in),
                     .S_AXI_AWADDR      (S_AXI_AWADDR),
                     .S_AXI_AWPROT      (S_AXI_AWPROT),
                     .S_AXI_AWVALID     (S_AXI_AWVALID),
                     .S_AXI_WDATA       (S_AXI_WDATA),
                     .S_AXI_WSTRB       (S_AXI_WSTRB),
                     .S_AXI_WVALID      (S_AXI_WVALID),
                     .S_AXI_BREADY      (S_AXI_BREADY),
                     .S_AXI_ARADDR      (S_AXI_ARADDR),
                     .S_AXI_ARPROT      (S_AXI_ARPROT),
                     .S_AXI_ARVALID     (S_AXI_ARVALID),
                     .S_AXI_RREADY      (S_AXI_RREADY));

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, pulse_generator_i);
  end

endmodule

`default_nettype wire
