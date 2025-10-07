// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

/**
 * axi4_lite_slave_if
 * This module has only the interface between user logic (RAM interface) and register interface (AXI4-Lite).
 * This module doesn't have any memories to store register value.
 */
module axi4_lite_slave_if #(
    parameter C_S_AXI_DATA_WIDTH = 32,
    // word address
    parameter REG_ADDR_BIT = 8,
    // byte address
    parameter C_S_AXI_ADDR_WIDTH = REG_ADDR_BIT + $clog2((C_S_AXI_DATA_WIDTH / 8))
)(
    input wire                                              S_AXI_ACLK,
    input wire                                              S_AXI_ARESETN,
    input wire [C_S_AXI_ADDR_WIDTH-1:0]                     S_AXI_AWADDR,
    input wire [2:0]                                        S_AXI_AWPROT,
    input wire                                              S_AXI_AWVALID,
    output wire                                             S_AXI_AWREADY,
    input wire [C_S_AXI_DATA_WIDTH-1:0]                     S_AXI_WDATA,
    input wire [(C_S_AXI_DATA_WIDTH/8)-1:0]                 S_AXI_WSTRB,
    input wire                                              S_AXI_WVALID,
    output wire                                             S_AXI_WREADY,
    output wire [1:0]                                       S_AXI_BRESP,
    output wire                                             S_AXI_BVALID,
    input wire                                              S_AXI_BREADY,
    input wire [C_S_AXI_ADDR_WIDTH-1:0]                     S_AXI_ARADDR,
    input wire [2:0]                                        S_AXI_ARPROT,
    input wire                                              S_AXI_ARVALID,
    output wire                                             S_AXI_ARREADY,
    output wire [C_S_AXI_DATA_WIDTH-1:0]                    S_AXI_RDATA,
    output wire [1:0]                                       S_AXI_RRESP,
    output wire                                             S_AXI_RVALID,
    input wire                                              S_AXI_RREADY,

    output wire [REG_ADDR_BIT-1:0]                          local_waddr,
    output wire [REG_ADDR_BIT-1:0]                          local_raddr,
    output wire                                             local_wen,
    output wire                                             local_ren,
    output wire [C_S_AXI_DATA_WIDTH-1:0]                    local_wdata,
    input wire [C_S_AXI_DATA_WIDTH-1:0]                     local_rdata,
    input wire                                              local_rdatavalid
  );

  // AXI4LITE signals
  reg [C_S_AXI_ADDR_WIDTH-1:0] axi_awaddr;
  reg                          axi_awready;
  reg [C_S_AXI_DATA_WIDTH-1:0] axi_wdata;
  reg                          axi_wready;
  reg [1:0]                    axi_bresp;
  reg                          axi_bvalid;
  reg [C_S_AXI_ADDR_WIDTH-1:0] axi_araddr;
  reg                          axi_arready;
  reg [C_S_AXI_DATA_WIDTH-1:0] axi_rdata;
  reg [1:0]                    axi_rresp;
  reg                          axi_rvalid;

  // Example-specific design signals
  localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
  localparam integer OPT_MEM_ADDR_BITS = C_S_AXI_ADDR_WIDTH - ADDR_LSB;

  // Registers and wires
  reg     aw_en;

  // I/O Connections assignments
  assign S_AXI_AWREADY = axi_awready;
  assign S_AXI_WREADY  = axi_wready;
  assign S_AXI_BRESP   = axi_bresp;
  assign S_AXI_BVALID  = axi_bvalid;
  assign S_AXI_ARREADY = axi_arready;
  assign S_AXI_RDATA   = axi_rdata;
  assign S_AXI_RRESP   = axi_rresp;
  assign S_AXI_RVALID  = axi_rvalid;

  // Implement axi_awready generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_awready <= 1'b0;
      aw_en <= 1'b1;
    end else begin
      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
        axi_awready <= 1'b1;
        aw_en <= 1'b0;
      end else if (S_AXI_BREADY && axi_bvalid) begin
        aw_en <= 1'b1;
        axi_awready <= 1'b0;
      end else begin
        axi_awready <= 1'b0;
      end
    end
  end

  // Implement axi_awaddr latching
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_awaddr <= 0;
    end else begin
      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
        axi_awaddr <= S_AXI_AWADDR;
      end
    end
  end

  // Implement axi_wdata latching
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_wdata <= 0;
    end else begin
      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en) begin
        axi_wdata <= S_AXI_WDATA;
      end
    end
  end

  // Implement axi_wready generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_wready <= 1'b0;
    end else begin
      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en) begin
        axi_wready <= 1'b1;
      end else begin
        axi_wready <= 1'b0;
      end
    end
  end

  assign local_waddr = axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS-1:ADDR_LSB];
  assign local_wen = axi_wready;
  assign local_wdata = axi_wdata;

  // Implement write response logic generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_bvalid  <= 0;
      axi_bresp   <= 2'b0;
    end else begin
      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID) begin
        axi_bvalid <= 1'b1;
        axi_bresp  <= 2'b0;
      end else begin
        if (S_AXI_BREADY && axi_bvalid) begin
          axi_bvalid <= 1'b0;
        end
      end
    end
  end

  // Implement axi_arready generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_arready <= 1'b0;
      axi_araddr  <= 32'b0;
    end else begin
      if (~axi_arready && S_AXI_ARVALID) begin
        axi_arready <= 1'b1;
        axi_araddr  <= S_AXI_ARADDR;
      end else begin
        axi_arready <= 1'b0;
      end
    end
  end

  reg local_ren_reg;
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      local_ren_reg <= 1'b0;
    end else begin
      if (~axi_arready && S_AXI_ARVALID) begin
        local_ren_reg <= 1'b1;
      end else begin
        local_ren_reg <= 1'b0;
      end
    end
  end

  assign local_raddr = axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS-1:ADDR_LSB];
  assign local_ren = local_ren_reg;

  // Implement axi_arvalid generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_rvalid <= 0;
      axi_rresp  <= 0;
    end else begin
      if (local_rdatavalid) begin
        axi_rvalid <= 1'b1;
        axi_rresp  <= 2'b0;
      end else if (axi_rvalid && S_AXI_RREADY) begin
        axi_rvalid <= 1'b0;
      end
    end
  end

  // Output register or memory read data
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
        axi_rdata  <= 0;
    end else begin
      if (local_rdatavalid) begin
        axi_rdata <= local_rdata;
      end
    end
  end

endmodule

`default_nettype wire
