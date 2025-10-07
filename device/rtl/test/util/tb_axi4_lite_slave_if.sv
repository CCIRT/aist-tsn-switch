// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module tb_axi4_lite_slave_if;
  parameter PCAP_FILENAME = "";
  parameter VCD_FILENAME = "";
  parameter integer REPEAT_NUM = 1;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;
  localparam integer M_AXIS_TVALID_OUT_CYCLE = 20;
  localparam integer S_AXIS_TREADY_OUT_CYCLE = 50;

  parameter C_S_AXI_DATA_WIDTH = 32;
  parameter REG_ADDR_BIT = 8;
  parameter C_S_AXI_ADDR_WIDTH = REG_ADDR_BIT + $clog2((C_S_AXI_DATA_WIDTH / 8));

  parameter OFFSET_BIT = $clog2((C_S_AXI_DATA_WIDTH / 8));

  //-------------------------
  // Port definition
  //-------------------------

  // clock, negative-reset
  reg  clk;
  reg  rstn;

  wire S_AXI_ACLK = clk;
  wire S_AXI_ARESETN = rstn;
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
  reg                              S_AXI_ARVALID = 0;
  wire                             S_AXI_ARREADY;
  wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA;
  wire [1:0]                       S_AXI_RRESP;
  wire                             S_AXI_RVALID;
  reg                              S_AXI_RREADY = 0;

  wire [REG_ADDR_BIT-1:0]          local_waddr;
  wire [REG_ADDR_BIT-1:0]          local_raddr;
  wire                             local_ren;
  wire                             local_wen;
  wire [C_S_AXI_DATA_WIDTH-1:0]    local_wdata;
  reg [C_S_AXI_DATA_WIDTH-1:0]     local_rdata = 0;
  reg                              local_rdatavalid = 0;


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
                      input [31:0] wdata,
                      input addr_first);
    // write address and data
    S_AXI_AWADDR <= {awaddr, {OFFSET_BIT{1'b0}}};
    S_AXI_AWPROT <= 0;
    S_AXI_WDATA <= wdata;
    S_AXI_WSTRB <= 32'hffff_ffff;
    S_AXI_BREADY <= 1'b0;

    if (addr_first) begin
      S_AXI_AWVALID <= 1;
      S_AXI_WVALID <= 0;

      @(posedge clk);

      S_AXI_AWVALID <= 1;
      S_AXI_WVALID <= 1;

      if (S_AXI_AWREADY) begin
        S_AXI_AWVALID <= 1'b0;
      end

      @(posedge clk);
    end else begin // if (addr_first)
      S_AXI_AWVALID <= 0;
      S_AXI_WVALID <= 1;

      @(posedge clk);

      S_AXI_AWVALID <= 1;
      S_AXI_WVALID <= 1;

      if (S_AXI_WREADY) begin
        S_AXI_WVALID <= 1'b0;
      end

      @(posedge clk);
    end

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

  task read_register(input [31:0] araddr,
                     output [31:0] rdata);
    // read address
    S_AXI_ARADDR <= {araddr, {OFFSET_BIT{1'b0}}};
    S_AXI_ARPROT <= 0;
    S_AXI_ARVALID <= 1'b1;
    S_AXI_RREADY <= 1'b0;

    @(posedge clk);

    // wait arready
    while (!S_AXI_ARREADY) begin
      @(posedge clk);
    end
    S_AXI_ARVALID <= 1'b0;

    // wait arvalid
    while (!S_AXI_RVALID) begin
      @(posedge clk);
    end
    S_AXI_RREADY <= 1'b1;

    @(posedge clk);

    rdata <= S_AXI_RDATA;
    S_AXI_RREADY <= 1'b0;
    @(posedge clk);
  endtask

  //-------------------------
  // Test memory
  //-------------------------
  localparam READ_DELAY = 4;
  reg [C_S_AXI_DATA_WIDTH-1:0]     mem[(1<<REG_ADDR_BIT)-1:0];
  reg [READ_DELAY-1:0]             read_delay_reg;

  always @(posedge clk) begin
    if (!rstn) begin
      read_delay_reg <= 1'b0;
      local_rdatavalid <= 1'b0;
    end else begin
      read_delay_reg <= {read_delay_reg[READ_DELAY-2:0], local_ren};
      local_rdatavalid <= read_delay_reg[READ_DELAY-1];
    end
  end

  always @(posedge clk) begin
    if (local_wen) begin
      mem[local_waddr] <= local_wdata;
    end

    if (local_ren) begin
      local_rdata <= mem[local_raddr];
    end
  end

  //-------------------------
  // Test module
  //-------------------------
  axi4_lite_slave_if #(.C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
                       .REG_ADDR_BIT(REG_ADDR_BIT),
                       .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH))
  axi4_lite_slave_if_i (.*);

  //-------------------------
  // Test Scenario
  //-------------------------
  reg [C_S_AXI_DATA_WIDTH-1:0] temp_reg;
  reg [C_S_AXI_DATA_WIDTH-1:0] rdata_reg;
  initial begin
    // wait device reset
    @(posedge clk);
    @(posedge rstn);

    // wait 5 cycle
    repeat (5) @(posedge clk);

    //-----------------------------------
    // scenario1: write-all and read-all
    //-----------------------------------
    for (int i = 0; i < (1 << REG_ADDR_BIT); i += 1) begin
      write_register(i, i, i & 1);
    end

    for (int i = 0; i < (1 << REG_ADDR_BIT); i += 1) begin
      read_register(i, rdata_reg);

      if (i != rdata_reg) begin
        $display("Error(sc1): wrong read value. i=%d, expect %d but got %d", i,i,  rdata_reg);
        `FATAL;
      end
    end

    //-----------------------------------
    // scenario2: overwrite
    //-----------------------------------
    write_register(0, $random, 0);
    temp_reg = $random;
    write_register(0, temp_reg, 1);
    read_register(0, rdata_reg);
    if (temp_reg != rdata_reg) begin
      $display("Error(sc2): wrong read value. expect %d but got %d", temp_reg, rdata_reg);
      `FATAL;
    end
    read_register(0, rdata_reg);
    if (temp_reg != rdata_reg) begin
      $display("Error(sc2): wrong read value. expect %d but got %d", temp_reg, rdata_reg);
      `FATAL;
    end

    // test end
    repeat (5) @(posedge clk);
    $display("Test done with no error");

    $finish(0);
  end

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, axi4_lite_slave_if_i);
  end

endmodule

`default_nettype wire
