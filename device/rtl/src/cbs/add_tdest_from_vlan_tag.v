// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

<<<<<<< HEAD
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
=======
module add_tdest_from_vlan_tag_core #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter C_AXIS_TUSER_WIDTH = 2
) (
  // clock, negative-reset
  input wire                          clk,
  input wire                          rstn,

  // Settings
  input wire [2:0]                    priority_mapper_0,
  input wire [2:0]                    priority_mapper_1,
  input wire [2:0]                    priority_mapper_2,
  input wire [2:0]                    priority_mapper_3,
  input wire [2:0]                    priority_mapper_4,
  input wire [2:0]                    priority_mapper_5,
  input wire [2:0]                    priority_mapper_6,
  input wire [2:0]                    priority_mapper_7,
  input wire [2:0]                    priority_mapper_default,

  // AXI4-Stream In
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,
  input wire [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,

  // AXI4-Stream Out
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast,
  output reg [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
  output reg [2:0]                    m_axis_tdest
);

  localparam BUF_DEPTH = 128 / C_AXIS_TDATA_WIDTH + 1; // DO NOT CHANGE

  // Important registers
  reg [C_AXIS_TDATA_WIDTH*BUF_DEPTH-1:0] buf_data;
  reg [C_AXIS_TKEEP_WIDTH*BUF_DEPTH-1:0] buf_keep;
  reg [BUF_DEPTH-1:0]                    buf_last;
  reg [BUF_DEPTH-1:0]                    buf_valid;
  reg [C_AXIS_TUSER_WIDTH*BUF_DEPTH-1:0] buf_user;
  reg [2:0]                              priority_;

  // Utility wires
  wire cke = !m_axis_tvalid || m_axis_tready;
  wire stream_incoming = s_axis_tvalid & s_axis_tready;
  wire stream_outgoing = m_axis_tvalid & m_axis_tready;

  always @(posedge clk) begin
    if (!rstn) begin
      buf_valid <= 0;
      buf_last <= 0;
    end else begin
      if (cke) begin
        if (stream_incoming || (|buf_last)) begin
          buf_data <= {s_axis_tdata, buf_data[C_AXIS_TDATA_WIDTH +: C_AXIS_TDATA_WIDTH * (BUF_DEPTH - 1)]};
          buf_keep <= {s_axis_tkeep, buf_keep[C_AXIS_TKEEP_WIDTH +: C_AXIS_TKEEP_WIDTH * (BUF_DEPTH - 1)]};
          buf_valid <= {stream_incoming, buf_valid[1 +: (BUF_DEPTH - 1)]};
          buf_last <= {s_axis_tlast && stream_incoming, buf_last[1 +: (BUF_DEPTH - 1)]};
          buf_user <= {s_axis_tuser, buf_user[C_AXIS_TUSER_WIDTH +: C_AXIS_TUSER_WIDTH * (BUF_DEPTH - 1)]};
        end
      end
    end
  end

  // AXI4-Stream connection
  assign s_axis_tready = cke && !(|buf_last);
  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_tdata <= {C_AXIS_TDATA_WIDTH{1'bx}};
      m_axis_tkeep <= {C_AXIS_TKEEP_WIDTH{1'b1}};
      m_axis_tvalid <= 1'b0;
      m_axis_tlast <= 1'b0;
      m_axis_tuser <= {C_AXIS_TUSER_WIDTH{1'bx}};
      m_axis_tdest <= 3'hx;
    end else begin
      if (cke) begin
        if (stream_incoming || (|buf_last)) begin
          m_axis_tdata <= buf_data[C_AXIS_TDATA_WIDTH-1:0];
          m_axis_tkeep <= buf_keep[C_AXIS_TKEEP_WIDTH-1:0];
          m_axis_tvalid <= buf_valid[0];
          m_axis_tlast <= buf_last[0];
          m_axis_tuser <= buf_user[C_AXIS_TUSER_WIDTH-1:0];
          m_axis_tdest <= priority_;
        end else begin
          m_axis_tdata <= buf_data[C_AXIS_TDATA_WIDTH-1:0];
          m_axis_tkeep <= buf_keep[C_AXIS_TKEEP_WIDTH-1:0];
          m_axis_tvalid <= 1'b0;
          m_axis_tlast <= buf_last[0];
          m_axis_tuser <= buf_user[C_AXIS_TUSER_WIDTH-1:0];
          m_axis_tdest <= priority_;
        end
      end
    end
  end

  // Combination logic that detect priority.
  always @ (posedge clk) begin
    if (buf_valid == {{BUF_DEPTH-1{1'b1}}, 1'b0}) begin
      if ((buf_data[C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*3 +: 8] == 8'h00 && buf_data[C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*4 +: 8] == 8'h81) ||
          (buf_data[C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*3 +: 8] == 8'h00 && buf_data[C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*4 +: 8] == 8'h91) ) begin
        // Detect 802.1Q tag.
        case (buf_data[C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*2+7:C_AXIS_TDATA_WIDTH*BUF_DEPTH-8*2+5])
          3'd0: priority_ <= priority_mapper_0;
          3'd1: priority_ <= priority_mapper_1;
          3'd2: priority_ <= priority_mapper_2;
          3'd3: priority_ <= priority_mapper_3;
          3'd4: priority_ <= priority_mapper_4;
          3'd5: priority_ <= priority_mapper_5;
          3'd6: priority_ <= priority_mapper_6;
          3'd7: priority_ <= priority_mapper_7;
          default: priority_ <= priority_mapper_default;
        endcase
      end else begin
        // Treat as Ethernet II frame.
        priority_ <= priority_mapper_default;
      end
    end
  end
endmodule

module add_tdest_from_vlan_tag_register #(
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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

<<<<<<< HEAD
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
=======
  // Settings
  output  wire [2:0] priority_mapper_0,
  output  wire [2:0] priority_mapper_1,
  output  wire [2:0] priority_mapper_2,
  output  wire [2:0] priority_mapper_3,
  output  wire [2:0] priority_mapper_4,
  output  wire [2:0] priority_mapper_5,
  output  wire [2:0] priority_mapper_6,
  output  wire [2:0] priority_mapper_7,
  output  wire [2:0] priority_mapper_default
);

  localparam REG_ADDR_BIT = $clog2(NUM_OF_REGISTERS);

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
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
    init_val,
    val
=======
    local_waddr,
    local_raddr,
    local_wen,
    local_ren,
    local_wdata,
    local_rdata,
    local_rdatavalid
  );

  reg [2:0]          priority_mappers[8:0];
  assign priority_mapper_0 = priority_mappers[0];
  assign priority_mapper_1 = priority_mappers[1];
  assign priority_mapper_2 = priority_mappers[2];
  assign priority_mapper_3 = priority_mappers[3];
  assign priority_mapper_4 = priority_mappers[4];
  assign priority_mapper_5 = priority_mappers[5];
  assign priority_mapper_6 = priority_mappers[6];
  assign priority_mapper_7 = priority_mappers[7];
  assign priority_mapper_default = priority_mappers[8];

  // cond_flows read/write
  always @(posedge clk) begin
    if (!rstn) begin
      local_rdata <= 0;
      local_rdatavalid <= 0;
      priority_mappers[0] <= INIT_VAL_OF_PRIORITY_MAPPER_0;
      priority_mappers[1] <= INIT_VAL_OF_PRIORITY_MAPPER_1;
      priority_mappers[2] <= INIT_VAL_OF_PRIORITY_MAPPER_2;
      priority_mappers[3] <= INIT_VAL_OF_PRIORITY_MAPPER_3;
      priority_mappers[4] <= INIT_VAL_OF_PRIORITY_MAPPER_4;
      priority_mappers[5] <= INIT_VAL_OF_PRIORITY_MAPPER_5;
      priority_mappers[6] <= INIT_VAL_OF_PRIORITY_MAPPER_6;
      priority_mappers[7] <= INIT_VAL_OF_PRIORITY_MAPPER_7;
      priority_mappers[8] <= INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT;
    end else begin
      // write port
      if (local_wen) begin
        case (local_waddr)
          0: priority_mappers[0] <= local_wdata[2:0];
          1: priority_mappers[1] <= local_wdata[2:0];
          2: priority_mappers[2] <= local_wdata[2:0];
          3: priority_mappers[3] <= local_wdata[2:0];
          4: priority_mappers[4] <= local_wdata[2:0];
          5: priority_mappers[5] <= local_wdata[2:0];
          6: priority_mappers[6] <= local_wdata[2:0];
          7: priority_mappers[7] <= local_wdata[2:0];
          8: priority_mappers[8] <= local_wdata[2:0];
        endcase
      end

      // read port 1
      local_rdatavalid <= 1'b0;
      if (local_ren) begin
        case (local_raddr)
          0: local_rdata <= {29'b0, priority_mappers[0]};
          1: local_rdata <= {29'b0, priority_mappers[1]};
          2: local_rdata <= {29'b0, priority_mappers[2]};
          3: local_rdata <= {29'b0, priority_mappers[3]};
          4: local_rdata <= {29'b0, priority_mappers[4]};
          5: local_rdata <= {29'b0, priority_mappers[5]};
          6: local_rdata <= {29'b0, priority_mappers[6]};
          7: local_rdata <= {29'b0, priority_mappers[7]};
          8: local_rdata <= {29'b0, priority_mappers[8]};
        endcase
        local_rdatavalid <= 1'b1;
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
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8)),
  parameter OPT_LEVEL = 1,
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter C_AXIS_TUSER_WIDTH = 2
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
  input  wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input  wire                          s_axis_tvalid,
  output wire                          s_axis_tready,
  input  wire                          s_axis_tlast,
  input  wire [C_AXIS_TUSER_WIDTH-1:0] s_axis_tuser,

  // AXI4-Stream Out
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input  wire                          m_axis_tready,
  output wire                          m_axis_tlast,
  output wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
  output wire [2:0]                    m_axis_tdest
);

  wire [2:0] priority_mapper_0;
  wire [2:0] priority_mapper_1;
  wire [2:0] priority_mapper_2;
  wire [2:0] priority_mapper_3;
  wire [2:0] priority_mapper_4;
  wire [2:0] priority_mapper_5;
  wire [2:0] priority_mapper_6;
  wire [2:0] priority_mapper_7;
  wire [2:0] priority_mapper_default;

  //-------------------------
  // Main module
  //-------------------------
  generate
    if (OPT_LEVEL >= 1) begin
      reg        iturn;
      reg        oturn;
      always @(posedge clk) begin
        if (!rstn) begin
          iturn <= 0;
          oturn <= 0;
        end else begin
          if (s_axis_tvalid && s_axis_tready && s_axis_tlast) begin
            iturn <= ~iturn;
          end
          if (m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
            oturn <= ~oturn;
          end
        end
      end

      wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_i0_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_i0_tkeep;
      wire                          s_axis_i0_tvalid;
      wire                          s_axis_i0_tready;
      wire                          s_axis_i0_tlast;
      wire [C_AXIS_TUSER_WIDTH-1:0] s_axis_i0_tuser;
      wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_i0_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_i0_tkeep;
      wire                          m_axis_i0_tvalid;
      wire                          m_axis_i0_tready;
      wire                          m_axis_i0_tlast;
      wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_i0_tuser;
      wire [2:0]                    m_axis_i0_tdest;

      wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_i1_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_i1_tkeep;
      wire                          s_axis_i1_tvalid;
      wire                          s_axis_i1_tready;
      wire                          s_axis_i1_tlast;
      wire [C_AXIS_TUSER_WIDTH-1:0] s_axis_i1_tuser;
      wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_i1_tdata;
      wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_i1_tkeep;
      wire                          m_axis_i1_tvalid;
      wire                          m_axis_i1_tready;
      wire                          m_axis_i1_tlast;
      wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_i1_tuser;
      wire [2:0]                    m_axis_i1_tdest;

      assign s_axis_i0_tdata = s_axis_tdata;
      assign s_axis_i0_tkeep = s_axis_tkeep;
      assign s_axis_i0_tvalid = (iturn == 0) ? s_axis_tvalid : 0;
      assign s_axis_i0_tlast = s_axis_tlast;
      assign s_axis_i0_tuser = s_axis_tuser;
      assign m_axis_i0_tready = (oturn == 0) ? m_axis_tready : 0;

      assign s_axis_i1_tdata = s_axis_tdata;
      assign s_axis_i1_tkeep = s_axis_tkeep;
      assign s_axis_i1_tvalid = (iturn == 1) ? s_axis_tvalid : 0;
      assign s_axis_i1_tlast = s_axis_tlast;
      assign s_axis_i1_tuser = s_axis_tuser;
      assign m_axis_i1_tready = (oturn == 1) ? m_axis_tready : 0;

      assign s_axis_tready = (iturn == 0) ? s_axis_i0_tready : s_axis_i1_tready;
      assign m_axis_tdata = (oturn == 0) ? m_axis_i0_tdata : m_axis_i1_tdata;
      assign m_axis_tkeep = (oturn == 0) ? m_axis_i0_tkeep : m_axis_i1_tkeep;
      assign m_axis_tvalid = (oturn == 0) ? m_axis_i0_tvalid : m_axis_i1_tvalid;
      assign m_axis_tlast = (oturn == 0) ? m_axis_i0_tlast : m_axis_i1_tlast;
      assign m_axis_tuser = (oturn == 0) ? m_axis_i0_tuser : m_axis_i1_tuser;
      assign m_axis_tdest = (oturn == 0) ? m_axis_i0_tdest : m_axis_i1_tdest;

      add_tdest_from_vlan_tag_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .C_AXIS_TUSER_WIDTH(C_AXIS_TUSER_WIDTH)
      ) add_tdest_from_vlan_tag_core_i0 (
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
        s_axis_i0_tdata,
        s_axis_i0_tkeep,
        s_axis_i0_tvalid,
        s_axis_i0_tready,
        s_axis_i0_tlast,
        s_axis_i0_tuser,
        m_axis_i0_tdata,
        m_axis_i0_tkeep,
        m_axis_i0_tvalid,
        m_axis_i0_tready,
        m_axis_i0_tlast,
        m_axis_i0_tuser,
        m_axis_i0_tdest
      );

      add_tdest_from_vlan_tag_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .C_AXIS_TUSER_WIDTH(C_AXIS_TUSER_WIDTH)
      ) add_tdest_from_vlan_tag_core_i1 (
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
        s_axis_i1_tdata,
        s_axis_i1_tkeep,
        s_axis_i1_tvalid,
        s_axis_i1_tready,
        s_axis_i1_tlast,
        s_axis_i1_tuser,
        m_axis_i1_tdata,
        m_axis_i1_tkeep,
        m_axis_i1_tvalid,
        m_axis_i1_tready,
        m_axis_i1_tlast,
        m_axis_i1_tuser,
        m_axis_i1_tdest
      );
    end else begin // if (OPT_LEVEL >= 1)
      add_tdest_from_vlan_tag_core #(
        .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
        .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
        .C_AXIS_TUSER_WIDTH(C_AXIS_TUSER_WIDTH)
      ) add_tdest_from_vlan_tag_core_i (
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
        s_axis_tkeep,
        s_axis_tvalid,
        s_axis_tready,
        s_axis_tlast,
        s_axis_tuser,
        m_axis_tdata,
        m_axis_tkeep,
        m_axis_tvalid,
        m_axis_tready,
        m_axis_tlast,
        m_axis_tuser,
        m_axis_tdest
      );
    end // else: !if(OPT_LEVEL >= 1)
  endgenerate


  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  add_tdest_from_vlan_tag_register #(
    .INIT_VAL_OF_PRIORITY_MAPPER_0(INIT_VAL_OF_PRIORITY_MAPPER_0),
    .INIT_VAL_OF_PRIORITY_MAPPER_1(INIT_VAL_OF_PRIORITY_MAPPER_1),
    .INIT_VAL_OF_PRIORITY_MAPPER_2(INIT_VAL_OF_PRIORITY_MAPPER_2),
    .INIT_VAL_OF_PRIORITY_MAPPER_3(INIT_VAL_OF_PRIORITY_MAPPER_3),
    .INIT_VAL_OF_PRIORITY_MAPPER_4(INIT_VAL_OF_PRIORITY_MAPPER_4),
    .INIT_VAL_OF_PRIORITY_MAPPER_5(INIT_VAL_OF_PRIORITY_MAPPER_5),
    .INIT_VAL_OF_PRIORITY_MAPPER_6(INIT_VAL_OF_PRIORITY_MAPPER_6),
    .INIT_VAL_OF_PRIORITY_MAPPER_7(INIT_VAL_OF_PRIORITY_MAPPER_7),
    .INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT(INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) add_tdest_from_vlan_tag_register_i (
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
    priority_mapper_0,
    priority_mapper_1,
    priority_mapper_2,
    priority_mapper_3,
    priority_mapper_4,
    priority_mapper_5,
    priority_mapper_6,
    priority_mapper_7,
    priority_mapper_default
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  );

endmodule

`default_nettype wire
