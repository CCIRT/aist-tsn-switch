// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module pulse_generator
  #(parameter NUM_INPUTS = 64,
    parameter NUM_OUTPUTS = 2,
    parameter C_S_AXI_DATA_WIDTH = 32,
    parameter C_S_AXI_ADDR_WIDTH = 12)
  (
   input wire                              clk,
   input wire                              rstn,
   input wire [NUM_INPUTS-1:0]             data_in,
   output reg [NUM_OUTPUTS-1:0]            pulse_out,

   // AXI4-Lite
   input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_AWADDR,
   input wire [2:0]                        S_AXI_AWPROT,
   input wire                              S_AXI_AWVALID,
   output wire                             S_AXI_AWREADY,
   input wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_WDATA,
   input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
   input wire                              S_AXI_WVALID,
   output wire                             S_AXI_WREADY,
   output wire [1:0]                       S_AXI_BRESP,
   output wire                             S_AXI_BVALID,
   input wire                              S_AXI_BREADY,
   input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR,
   input wire [2:0]                        S_AXI_ARPROT,
   input wire                              S_AXI_ARVALID,
   output wire                             S_AXI_ARREADY,
   output wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA,
   output wire [1:0]                       S_AXI_RRESP,
   output wire                             S_AXI_RVALID,
   input wire                              S_AXI_RREADY
   );

  reg [NUM_INPUTS-1:0]                     d_data;
  wire [NUM_INPUTS*NUM_OUTPUTS-1:0]        selector;
  wire [23:0]                              pulse_width;

  always @(posedge clk) begin
    d_data <= data_in;
  end

  integer i;
  reg [NUM_OUTPUTS-1:0] in_valids;
  always @(posedge clk) begin
    for (i = 0; i < NUM_OUTPUTS; i = i + 1) begin
      in_valids[i] <= |(d_data & selector[NUM_INPUTS * i +: NUM_INPUTS]);
    end
  end

  reg [23:0] counters [NUM_OUTPUTS-1:0];
  always @(posedge clk) begin
    if (!rstn) begin
      for (i = 0; i < NUM_OUTPUTS; i = i + 1) begin
        counters[i] <= 0;
      end
    end else begin
      for (i = 0; i < NUM_OUTPUTS; i = i + 1) begin
        counters[i] <= (in_valids[i]) ? pulse_width : (counters[i] == 0) ? 0 : counters[i] - 1;
      end
    end
  end

  always @(posedge clk) begin
    for (i = 0; i < NUM_OUTPUTS; i = i + 1) begin
      pulse_out[i] <= counters[i] != 0;
    end
  end

  pulse_generator_register #(
                             // Parameters
                             .NUM_INPUTS        (NUM_INPUTS),
                             .NUM_OUTPUTS       (NUM_OUTPUTS),
                             .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
                             .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH))
  pulse_generator_register_i (
                              // Outputs
                              .S_AXI_AWREADY    (S_AXI_AWREADY),
                              .S_AXI_WREADY     (S_AXI_WREADY),
                              .S_AXI_BRESP      (S_AXI_BRESP[1:0]),
                              .S_AXI_BVALID     (S_AXI_BVALID),
                              .S_AXI_ARREADY    (S_AXI_ARREADY),
                              .S_AXI_RDATA      (S_AXI_RDATA[C_S_AXI_DATA_WIDTH-1:0]),
                              .S_AXI_RRESP      (S_AXI_RRESP[1:0]),
                              .S_AXI_RVALID     (S_AXI_RVALID),
                              .selector         (selector[NUM_INPUTS*NUM_OUTPUTS-1:0]),
                              .pulse_width      (pulse_width[23:0]),
                              // Inputs
                              .clk              (clk),
                              .rstn             (rstn),
                              .S_AXI_AWADDR     (S_AXI_AWADDR[C_S_AXI_ADDR_WIDTH-1:0]),
                              .S_AXI_AWPROT     (S_AXI_AWPROT[2:0]),
                              .S_AXI_AWVALID    (S_AXI_AWVALID),
                              .S_AXI_WDATA      (S_AXI_WDATA[C_S_AXI_DATA_WIDTH-1:0]),
                              .S_AXI_WSTRB      (S_AXI_WSTRB[(C_S_AXI_DATA_WIDTH/8)-1:0]),
                              .S_AXI_WVALID     (S_AXI_WVALID),
                              .S_AXI_BREADY     (S_AXI_BREADY),
                              .S_AXI_ARADDR     (S_AXI_ARADDR[C_S_AXI_ADDR_WIDTH-1:0]),
                              .S_AXI_ARPROT     (S_AXI_ARPROT[2:0]),
                              .S_AXI_ARVALID    (S_AXI_ARVALID),
                              .S_AXI_RREADY     (S_AXI_RREADY));


endmodule

module pulse_generator_register
#(
  parameter NUM_INPUTS = 8,
  parameter NUM_OUTPUTS = 2,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter C_S_AXI_ADDR_WIDTH = 12
  )
  (
   // clock, negative-reset
   input wire                              clk,
   input wire                              rstn,

   // AXI4-Lite
   input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_AWADDR,
   input wire [2:0]                        S_AXI_AWPROT,
   input wire                              S_AXI_AWVALID,
   output wire                             S_AXI_AWREADY,
   input wire [C_S_AXI_DATA_WIDTH-1:0]     S_AXI_WDATA,
   input wire [(C_S_AXI_DATA_WIDTH/8)-1:0] S_AXI_WSTRB,
   input wire                              S_AXI_WVALID,
   output wire                             S_AXI_WREADY,
   output wire [1:0]                       S_AXI_BRESP,
   output wire                             S_AXI_BVALID,
   input wire                              S_AXI_BREADY,
   input wire [C_S_AXI_ADDR_WIDTH-1:0]     S_AXI_ARADDR,
   input wire [2:0]                        S_AXI_ARPROT,
   input wire                              S_AXI_ARVALID,
   output wire                             S_AXI_ARREADY,
   output wire [C_S_AXI_DATA_WIDTH-1:0]    S_AXI_RDATA,
   output wire [1:0]                       S_AXI_RRESP,
   output wire                             S_AXI_RVALID,
   input wire                              S_AXI_RREADY,

   // Settings
   output reg [NUM_INPUTS*NUM_OUTPUTS-1:0] selector,
   output reg [23:0]                       pulse_width
);

  localparam REG_ADDR_BIT = C_S_AXI_ADDR_WIDTH - 2;

  wire [REG_ADDR_BIT-1:0]                 local_waddr;
  wire [REG_ADDR_BIT-1:0]                 local_raddr;
  wire                                    local_wen;
  wire                                    local_ren;
  wire [C_S_AXI_DATA_WIDTH-1:0]           local_wdata;
  reg [C_S_AXI_DATA_WIDTH-1:0]            local_rdata;
  reg                                     local_rdatavalid;

  axi4_lite_slave_if #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .REG_ADDR_BIT(REG_ADDR_BIT),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) axi4_lite_slave_if_i (
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
    local_waddr,
    local_raddr,
    local_wen,
    local_ren,
    local_wdata,
    local_rdata,
    local_rdatavalid
  );

  wire [63:0] output_selector = {{64-NUM_INPUTS{1'b0}}, selector[(local_raddr>>1) * NUM_INPUTS +: NUM_INPUTS]};
  wire [31:0] output_selector_lo = output_selector[31:0];
  wire [31:0] output_selector_hi = output_selector[63:32];
  always @(posedge clk) begin
    if (!rstn) begin
      local_rdata <= 0;
      local_rdatavalid <= 0;
    end else begin
      local_rdatavalid <= 0;

      if (local_ren) begin
        local_rdatavalid <= 1'b1;
        if (local_raddr == 'h40) begin
          // address 0x100
          local_rdata <= {8'h0, pulse_width};
        end else if (local_raddr < NUM_OUTPUTS * 2) begin
          // address 0x0-0x8*(NUM_OUTPUTS)-4
          if (local_raddr[0]) begin
            local_rdata <= output_selector_hi;
          end else begin
            local_rdata <= output_selector_lo;
          end
        end
      end
    end
  end

  reg [63:0] input_selector;
  always @(*) begin
    input_selector = selector[(local_waddr>>1) * NUM_INPUTS +: NUM_INPUTS];

    // update value
    if (local_waddr[0]) begin
      input_selector[63:32] = local_wdata;
    end else begin
      input_selector[31:0] = local_wdata;
    end
  end
  always @(posedge clk) begin
    if (!rstn) begin
      selector <= 'h0;
      pulse_width <= 'h0;
    end else begin
      if (local_wen) begin
        if (local_waddr == 'h40) begin
          // address 0x100
          pulse_width <= local_wdata[23:0];
        end else if (local_waddr < NUM_OUTPUTS * 2) begin
          // address 0x0-0x8*(NUM_OUTPUTS)-4
          selector[(local_waddr>>1) * NUM_INPUTS +: NUM_INPUTS] <= input_selector;
        end
      end
    end
  end
endmodule

`default_nettype wire
