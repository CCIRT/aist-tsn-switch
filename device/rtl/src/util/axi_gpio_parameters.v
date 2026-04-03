// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module axi_gpio_parameters  #(
  parameter PROCCESSING_DELAY_MAX = 50000000, // 50 us
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_WRITE_REGISTERS = 3,
  parameter NUM_OF_READ_REGISTERS = 0,
  parameter C_S_AXI_ADDR_WIDTH = $clog2((NUM_OF_WRITE_REGISTERS + NUM_OF_READ_REGISTERS) * (C_S_AXI_DATA_WIDTH / 8)),
  parameter TIMESTAMP_WIDTH = 72
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Lite
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_AWADDR,
  input  wire [2:0]                        S_AXI_AWPROT,
  input  wire                              S_AXI_AWVALID,
  output wire                              S_AXI_AWREADY,
  input  wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_WDATA,
  input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
  input  wire                              S_AXI_WVALID,
  output wire                              S_AXI_WREADY,
  output wire [1:0]                        S_AXI_BRESP,
  output wire                              S_AXI_BVALID,
  input  wire                              S_AXI_BREADY,
  input  wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR,
  input  wire [2:0]                        S_AXI_ARPROT,
  input  wire                              S_AXI_ARVALID,
  output wire                              S_AXI_ARREADY,
  output wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_RDATA,
  output wire [1:0]                        S_AXI_RRESP,
  output wire                              S_AXI_RVALID,
  input  wire                              S_AXI_RREADY,

  // Transmission Selection Timer input
  output  wire [TIMESTAMP_WIDTH-1:0] processing_delay_max
);

  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_WRITE_REGISTERS)-1:0] init_write_val;
  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_WRITE_REGISTERS)-1:0] write_val;
  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_READ_REGISTERS)-1:0]  read_val;
  wire [31:0] usr_access;

  generate
    if (NUM_OF_WRITE_REGISTERS > 0) begin
      assign init_write_val[C_S_AXI_DATA_WIDTH*0+31:C_S_AXI_DATA_WIDTH*0] = PROCCESSING_DELAY_MAX;
      assign init_write_val[C_S_AXI_DATA_WIDTH*1+31:C_S_AXI_DATA_WIDTH*1] = 32'd0;
      assign init_write_val[C_S_AXI_DATA_WIDTH*2+31:C_S_AXI_DATA_WIDTH*2] = 32'd0;
    end else begin
      assign init_write_val = 0;
    end

    assign processing_delay_max = write_val;
  endgenerate

  assign read_val = usr_access;


  //-------------------------
  // USR_ACCESS read module
  //-------------------------
  generate
    if (NUM_OF_READ_REGISTERS > 0) begin
      read_usr_access read_usr_access_inst (
        .CFGCLK(),
        .DATA(usr_access),
        .DATAVALID()
      );
    end else begin
      assign usr_access = 0;
    end
  endgenerate

  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  axi4_lite_slave2 #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_WRITE_REGISTERS(NUM_OF_WRITE_REGISTERS),
    .NUM_OF_READ_REGISTERS(NUM_OF_READ_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) axi4_lite_slave_i (
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
    init_write_val,
    write_val,
    read_val
  );

endmodule

module read_usr_access (
    output wire                              CFGCLK,
    output wire [31:0]                       DATA,
    output wire                              DATAVALID
);

USR_ACCESSE2 USR_ACCESSE2_inst (
   .CFGCLK(CFGCLK),       // 1-bit output: Configuration Clock
   .DATA(DATA),           // 32-bit output: Configuration Data reflecting the contents of the AXSS register
   .DATAVALID(DATAVALID)  // 1-bit output: Active-High Data Valid
);

endmodule

`default_nettype wire
