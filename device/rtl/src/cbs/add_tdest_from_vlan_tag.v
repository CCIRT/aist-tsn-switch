// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module add_tdest_from_vlan_tag_core (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // Settings
  input  wire [2:0] priority_mapper_0,
  input  wire [2:0] priority_mapper_1,
  input  wire [2:0] priority_mapper_2,
  input  wire [2:0] priority_mapper_3,
  input  wire [2:0] priority_mapper_4,
  input  wire [2:0] priority_mapper_5,
  input  wire [2:0] priority_mapper_6,
  input  wire [2:0] priority_mapper_7,
  input  wire [2:0] priority_mapper_default,

  // AXI4-Stream In
  input  wire [7:0] s_axis_tdata,
  input  wire       s_axis_tvalid,
  output wire       s_axis_tready,
  input  wire       s_axis_tlast,
  input  wire [1:0] s_axis_tuser,

  // AXI4-Stream Out
  output wire [7:0] m_axis_tdata,
  output wire       m_axis_tvalid,
  input  wire       m_axis_tready,
  output wire       m_axis_tlast,
  output wire [1:0] m_axis_tuser,
  output wire [2:0] m_axis_tdest
);

  localparam BUF_DEPTH = 16; // DO NOT CHANGE

  // Important registers
  reg [7:0] buf_data[BUF_DEPTH-1:0];
  reg       buf_last[BUF_DEPTH-1:0];
  reg [1:0] buf_user[BUF_DEPTH-1:0];
  reg [4:0] buf_input_counter = 5'd0;
  reg [4:0] buf_output_counter = 5'd0;
  reg [2:0] priority;

  // Utility wires
  wire stream_incoming = s_axis_tvalid & s_axis_tready;
  wire stream_outgoing = m_axis_tvalid & m_axis_tready;

  // AXI4-Stream connection
  assign m_axis_tdata = (buf_output_counter < BUF_DEPTH)? buf_data[buf_output_counter]:
                                                          s_axis_tdata;
  assign m_axis_tvalid = (buf_input_counter < BUF_DEPTH)?  1'b0:  // Store data to buffer
                         (buf_output_counter < BUF_DEPTH)? 1'b1:  // Flush data from buffer
                                                           s_axis_tvalid; // Pass through
  assign s_axis_tready = (buf_input_counter < BUF_DEPTH)?  1'b1:  // Store data to buffer
                         (buf_output_counter < BUF_DEPTH)? 1'b0:  // Flush data from buffer
                                                           m_axis_tready; // Pass through
  assign m_axis_tlast = (buf_output_counter < BUF_DEPTH)? buf_last[buf_output_counter]:
                                                          s_axis_tlast;
  assign m_axis_tuser = (buf_output_counter < BUF_DEPTH)? buf_user[buf_output_counter]:
                                                          s_axis_tuser;
  assign m_axis_tdest = priority;

  // Combination logic that detect priority.
  always @ (*) begin
    if ((buf_data[13] == 16'h00 && buf_data[12] == 16'h81) ||
        (buf_data[13] == 16'h00 && buf_data[12] == 16'h91) ) begin
      // Detect 802.1Q tag.
      case (buf_data[14][7:5])
        3'd0: priority <= priority_mapper_0;
        3'd1: priority <= priority_mapper_1;
        3'd2: priority <= priority_mapper_2;
        3'd3: priority <= priority_mapper_3;
        3'd4: priority <= priority_mapper_4;
        3'd5: priority <= priority_mapper_5;
        3'd6: priority <= priority_mapper_6;
        3'd7: priority <= priority_mapper_7;
        default: priority <= priority_mapper_default;
      endcase
    end else begin
      // Treat as Ethernet II frame.
      priority <= priority_mapper_default;
    end
  end

  // Store first 16 Byte data to buffer.
  always @ (posedge clk) begin
    if (!rstn) begin
      // Do nothing
    end else begin
      if (stream_incoming && buf_input_counter < BUF_DEPTH) begin
        buf_data[buf_input_counter] <= s_axis_tdata;
        buf_last[buf_input_counter] <= s_axis_tlast;
        buf_user[buf_input_counter] <= s_axis_tuser;
      end else begin
        // Do nothing
      end
    end
  end

  // Control buf_input_counter value.
  always @ (posedge clk) begin
    if (!rstn) begin
      buf_input_counter <= 5'd0;
    end else begin
      if (stream_incoming) begin
        if (s_axis_tlast) begin
          buf_input_counter <= 5'd0;
        end else if (buf_input_counter < BUF_DEPTH) begin
          buf_input_counter <= buf_input_counter + 5'd1;
        end else begin
          // Do nothing
        end
      end else begin
        // Do nothing
      end
    end
  end

  // Control buf_output_counter value.
  always @ (posedge clk) begin
    if (!rstn) begin
      buf_output_counter <= 5'd0;
    end else begin
      if (stream_outgoing) begin
        if (m_axis_tlast) begin
          buf_output_counter <= 5'd0;
        end else if (buf_output_counter < BUF_DEPTH) begin
          buf_output_counter <= buf_output_counter + 5'd1;
        end else begin
          // Do nothing
        end
      end else begin
        // Do nothing
      end
    end
  end

endmodule

module add_tdest_from_vlan_tag  #(
  parameter INIT_VAL_OF_PRIORITY_MAPPER_0 = 1,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_1 = 0,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_2 = 6,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_3 = 7,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_4 = 2,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_5 = 3,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_6 = 4,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_7 = 5,
  parameter INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT = 1,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 9,
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8))
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

  // AXI4-Stream In
  input  wire [7:0] s_axis_tdata,
  input  wire       s_axis_tvalid,
  output wire       s_axis_tready,
  input  wire       s_axis_tlast,
  input  wire [1:0] s_axis_tuser,

  // AXI4-Stream Out
  output wire [7:0] m_axis_tdata,
  output wire       m_axis_tvalid,
  input  wire       m_axis_tready,
  output wire       m_axis_tlast,
  output wire [1:0] m_axis_tuser,
  output wire [2:0] m_axis_tdest
);

  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] init_val;
  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] val;

  assign init_val[32*0+31:32*0] = INIT_VAL_OF_PRIORITY_MAPPER_0;
  assign init_val[32*1+31:32*1] = INIT_VAL_OF_PRIORITY_MAPPER_1;
  assign init_val[32*2+31:32*2] = INIT_VAL_OF_PRIORITY_MAPPER_2;
  assign init_val[32*3+31:32*3] = INIT_VAL_OF_PRIORITY_MAPPER_3;
  assign init_val[32*4+31:32*4] = INIT_VAL_OF_PRIORITY_MAPPER_4;
  assign init_val[32*5+31:32*5] = INIT_VAL_OF_PRIORITY_MAPPER_5;
  assign init_val[32*6+31:32*6] = INIT_VAL_OF_PRIORITY_MAPPER_6;
  assign init_val[32*7+31:32*7] = INIT_VAL_OF_PRIORITY_MAPPER_7;
  assign init_val[32*8+31:32*8] = INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT;

  wire [2:0] priority_mapper_0 = val[32*0+2:32*0];
  wire [2:0] priority_mapper_1 = val[32*1+2:32*1];
  wire [2:0] priority_mapper_2 = val[32*2+2:32*2];
  wire [2:0] priority_mapper_3 = val[32*3+2:32*3];
  wire [2:0] priority_mapper_4 = val[32*4+2:32*4];
  wire [2:0] priority_mapper_5 = val[32*5+2:32*5];
  wire [2:0] priority_mapper_6 = val[32*6+2:32*6];
  wire [2:0] priority_mapper_7 = val[32*7+2:32*7];
  wire [2:0] priority_mapper_default = val[32*8+2:32*8];

  //-------------------------
  // Main module
  //-------------------------
  add_tdest_from_vlan_tag_core
  add_tdest_from_vlan_tag_core_i (
    clk,
    rstn,
    priority_mapper_0,
    priority_mapper_1,
    priority_mapper_2,
    priority_mapper_3,
    priority_mapper_4,
    priority_mapper_5,
    priority_mapper_6,
    priority_mapper_7,
    priority_mapper_default,
    s_axis_tdata,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    s_axis_tuser,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_tuser,
    m_axis_tdest
  );

  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  axi4_lite_slave #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
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
    init_val,
    val
  );

endmodule

`default_nettype wire
