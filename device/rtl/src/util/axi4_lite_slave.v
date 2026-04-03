// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module axi4_lite_slave #(
    parameter C_S_AXI_DATA_WIDTH = 32,
    parameter NUM_OF_REGISTERS = 16,
    parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8))
)(
    input  wire S_AXI_ACLK,
    input  wire S_AXI_ARESETN,
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
    input  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] init_val,
    output wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] val
);

  // AXI4LITE signals
  reg [C_S_AXI_ADDR_WIDTH-1:0] axi_awaddr;
  reg                          axi_awready;
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
  reg  [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] val_reg;
  wire [C_S_AXI_DATA_WIDTH-1:0] reg_data_out;
  wire    val_reg_rden;
  wire    val_reg_wren;
  integer byte_index;
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
  assign val           = val_reg;

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

  // Implement memory mapped register select and write logic generation
  reg [C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS-1:0] write_mask;
  always @ (*) begin
    for (byte_index = 0; byte_index <= ((C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)/8)-1; byte_index = byte_index+1) begin
      if (byte_index <= (C_S_AXI_DATA_WIDTH/8)-1) begin
        if (S_AXI_WSTRB[byte_index] == 1) begin
          write_mask[(byte_index*8) +: 8] = 8'hFF;
        end else begin
          write_mask[(byte_index*8) +: 8] = 8'h00;
        end
      end else begin
        write_mask[(byte_index*8) +: 8] = 8'h00;
      end
    end
  end

  assign val_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;
  wire [OPT_MEM_ADDR_BITS-1:0] awaddr = axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS-1:ADDR_LSB];
  wire [C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS-1:0] write_mask_shift = write_mask << (C_S_AXI_DATA_WIDTH * awaddr);
  wire [C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS-1:0] write_mask_shift_inv = ~write_mask_shift;
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
        val_reg <= init_val;
    end else begin
      if (val_reg_wren) begin
        val_reg <= (val_reg & write_mask_shift_inv) | ((S_AXI_WDATA & write_mask) << (C_S_AXI_DATA_WIDTH * awaddr));
      end
    end
  end

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

  // Implement axi_arvalid generation
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
      axi_rvalid <= 0;
      axi_rresp  <= 0;
    end else begin
      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid) begin
        axi_rvalid <= 1'b1;
        axi_rresp  <= 2'b0;
      end else if (axi_rvalid && S_AXI_RREADY) begin
        axi_rvalid <= 1'b0;
      end
    end
  end

	// Implement memory mapped register select and read logic generation
  wire [OPT_MEM_ADDR_BITS-1:0] araddr = axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS-1:ADDR_LSB];
  assign reg_data_out = val_reg >> (C_S_AXI_DATA_WIDTH * araddr);

  // Output register or memory read data
  assign val_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
  always @ (posedge S_AXI_ACLK) begin
    if (S_AXI_ARESETN == 1'b0) begin
        axi_rdata  <= 0;
    end else begin
      if (val_reg_rden) begin
        axi_rdata <= reg_data_out;
      end
    end
  end

endmodule

`default_nettype wire
