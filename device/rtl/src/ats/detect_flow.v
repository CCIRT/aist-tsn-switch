// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module detect_flow_core #(
  parameter DATA_WIDTH = 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8
module detect_flow_parse_header #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FLOW_BITS = 4
) (
  // clock, negative-reset
  input wire                  clk,
  input wire                  rstn,

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  output reg [95:0]           flow_cond_tdata,
  output reg                  flow_cond_tvalid,
  output reg                  flow_cond_tuser, // If 1, frame is TCP or UDP, otherwize 0.
  input wire                  flow_cond_tready,

  // AXI4-Stream Data In
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,

  // AXI4-Stream Data Out
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast);

  assign s_axis_tready = (!m_axis_tvalid || m_axis_tready) && (!flow_cond_tvalid || flow_cond_tready);

  // m_axis
  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_tdata <= 'd0;
      m_axis_tkeep <= 'd0;
      m_axis_tvalid <= 1'b0;
      m_axis_tlast <= 1'b0;
    end else begin
      if (!m_axis_tvalid || m_axis_tready) begin
        m_axis_tdata <= s_axis_tdata;
        m_axis_tkeep <= s_axis_tkeep;
        m_axis_tvalid <= s_axis_tvalid && s_axis_tready;
        m_axis_tlast <= s_axis_tlast;
      end
    end
  end

  // counter logic
  // Parameter for ethernet_frame
  localparam ETHERNET_FRAME_WIDTH = 1600 * 8; // Must be aligned to C_AXIS_TDATA_WIDTH
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / 8;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);
  localparam BYTES_PER_CYCLE = C_AXIS_TKEEP_WIDTH;

  // Extract information
  localparam INFO_WIDTH = ((42 + C_AXIS_TKEEP_WIDTH - 1) / C_AXIS_TKEEP_WIDTH) * C_AXIS_TDATA_WIDTH;
  reg [INFO_WIDTH-1:0] info;
  reg [INFO_WIDTH/C_AXIS_TDATA_WIDTH:0] valids;

  always @(posedge clk) begin
    if (!rstn) begin
      info <= 0;
      valids <= 0;
    end else begin
      if (s_axis_tvalid && s_axis_tready) begin
        if (s_axis_tlast) begin
          info <= 0;
          valids <= 0;
        end else begin
          info <= {s_axis_tdata, info[INFO_WIDTH-1:C_AXIS_TDATA_WIDTH]};
          valids <= {1'b1, valids[INFO_WIDTH/C_AXIS_TDATA_WIDTH:1]};
        end
      end
    end
  end

  wire frame_has_vlan_tag = (info[12*8 +: 16] == 16'h0081 || info[12*8 +: 16] == 16'h0091);
  wire payload_is_ipv4 = (frame_has_vlan_tag) ? (info[16*8 +: 16] == 16'h0008) : (info[12*8 +: 16] == 16'h0008);
  wire payload_is_tcp = (frame_has_vlan_tag) ? (info[27*8 +: 8] == 8'h06) : (info[23*8 +: 8] == 8'h06);
  wire payload_is_udp = (frame_has_vlan_tag) ? (info[27*8 +: 8] == 8'h11) : (info[23*8 +: 8] == 8'h11);
  wire [95:0] ip_ports = (frame_has_vlan_tag) ? info[30*8 +: 96] : info[26*8 +: 96];
  wire [31:0] src_ip = {ip_ports[0 +: 8], ip_ports[8 +: 8], ip_ports[16 +: 8], ip_ports[24 +: 8]};
  wire [31:0] dst_ip = {ip_ports[32 +: 8], ip_ports[40 +: 8], ip_ports[48 +: 8], ip_ports[56 +: 8]};
  wire [15:0] src_port = {ip_ports[64 +: 8], ip_ports[72 +: 8]};
  wire [15:0] dst_port = {ip_ports[80 +: 8], ip_ports[88 +: 8]};

  always @(posedge clk) begin
    if (!rstn) begin
      flow_cond_tdata <= 'd0;
      flow_cond_tuser <= 'd0;
      flow_cond_tvalid <= 1'b0;
    end else begin
      if (!flow_cond_tvalid || flow_cond_tready) begin
        flow_cond_tdata <= {src_ip, src_port, dst_ip, dst_port};
        flow_cond_tuser <= payload_is_ipv4 && (payload_is_tcp || payload_is_udp);
        flow_cond_tvalid <= !valids[0] && (&valids[INFO_WIDTH/C_AXIS_TDATA_WIDTH:1]) && s_axis_tvalid && s_axis_tready;
      end
    end
  end

endmodule

module detect_flow_match_flow #(
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FLOW_BITS = 4,
  parameter FLOW_MATCH_RATE = 1
) (
  // clock, negative-reset
  input wire                            clk,
  input wire                            rstn,

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  input wire [95:0]                     flow_cond_tdata,
  input wire                            flow_cond_tvalid,
  input wire                            flow_cond_tuser, // If 1, frame is TCP or UDP, otherwize 0.
  output wire                           flow_cond_tready,

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  output reg [FLOW_BITS-1:0]            flow_id,
  output reg                            flow_ren,
  input wire [96 * FLOW_MATCH_RATE-1:0] flow_val,

  // AXI4-Stream Flow Out
  output reg [FLOW_WIDTH-1:0]           m_axis_flow_tdata,
  output reg                            m_axis_flow_tvalid,
  input wire                            m_axis_flow_tready
);

  reg [1:0]                             state;
  localparam [1:0] STATE_WAIT_COND = 2'b00;
  localparam [1:0] STATE_MATCH = 2'b01;
  localparam [1:0] STATE_SEND = 2'b10;
  localparam [1:0] STATE_SEND_UNDETECTED = 2'b11;

  wire                                  match_done;
  assign flow_cond_tready = (state == STATE_WAIT_COND);

  // state machine
  always @(posedge clk) begin
    if (!rstn) begin
      state <= STATE_WAIT_COND;
    end else begin
      case (state)
        STATE_WAIT_COND: begin
          if (flow_cond_tvalid && flow_cond_tready) begin
            if (flow_cond_tuser) begin
              state <= STATE_MATCH;
            end else begin
              state <= STATE_SEND_UNDETECTED;
            end
          end
        end
        STATE_MATCH: begin
          if (match_done) begin
            state <= STATE_SEND;
          end
        end
        STATE_SEND: begin
          if (m_axis_flow_tvalid && m_axis_flow_tready) begin
            state <= STATE_WAIT_COND;
          end
        end
        STATE_SEND_UNDETECTED: begin
          if (m_axis_flow_tvalid && m_axis_flow_tready) begin
            state <= STATE_WAIT_COND;
          end
        end
      endcase
    end
  end

  // latch input
  reg [95:0] flow_cond;
  always @(posedge clk) begin
    if (flow_cond_tvalid && flow_cond_tready && flow_cond_tuser) begin
      flow_cond <= flow_cond_tdata;
    end
  end

  reg [FLOW_BITS-1:0] flow_id_r;
  reg                 flow_rdatavalid;
  always @(posedge clk) begin
    flow_id_r <= flow_id;
    flow_rdatavalid <= flow_ren;
  end
  // at last comparison
  assign match_done = !flow_ren && flow_rdatavalid;

  // match logic
  wire [31:0] src_ip = flow_cond[95:64];
  wire [15:0] src_port = flow_cond[63:48];
  wire [31:0] dst_ip = flow_cond[47:16];
  wire [15:0] dst_port = flow_cond[15:0];

  reg [FLOW_WIDTH-1:0] detected_flow;
  integer              i;
  always @(posedge clk) begin
    if (!rstn) begin
      flow_id <= 'd0;
      flow_ren <= 1'b0;
      detected_flow <= 'd0;
    end else begin
      if (state == STATE_WAIT_COND) begin
        if (flow_cond_tvalid && flow_cond_tready && flow_cond_tuser) begin
          flow_id <= 0;
          flow_ren <= 1'b1;
          detected_flow <= 'd0;
        end
      end else if (state == STATE_MATCH) begin
        flow_id <= flow_id + FLOW_MATCH_RATE;
        if (flow_id == FLOW_NUM - FLOW_MATCH_RATE) begin
          flow_ren <= 1'b0;
        end

        if (flow_rdatavalid && detected_flow == 'd0) begin
          for (i = FLOW_MATCH_RATE - 1; i >= 0; i = i - 1) begin
            if ((src_ip == flow_val[i * 96 + 64 +: 32] || flow_val[i * 96 + 64 +: 32] == 'd0) &&
                (src_port == flow_val[i * 96 + 48 +: 16] || flow_val[i * 96 + 48 +: 16] == 'd0) &&
                (dst_ip == flow_val[i * 96 + 16 +: 32] || flow_val[i * 96 + 16 +: 32] == 'd0) &&
                (dst_port == flow_val[i * 96 + 0 +: 16] || flow_val[i * 96 + 0 +: 16] == 'd0)) begin

              detected_flow <= flow_id_r + i[3:0] + 4'b1;
            end
          end
        end
      end
    end
  end

  // output
  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_flow_tdata <= 'd0;
      m_axis_flow_tvalid <= 1'b0;
    end else begin
      if (m_axis_flow_tvalid && m_axis_flow_tready) begin
        m_axis_flow_tdata <= m_axis_flow_tdata;
        m_axis_flow_tvalid <= 1'b0;
      end else if (state == STATE_SEND) begin
        m_axis_flow_tdata <= detected_flow;
        m_axis_flow_tvalid <= 1'b1;
      end else if (state == STATE_SEND_UNDETECTED) begin
        m_axis_flow_tdata <= 'd0;
        m_axis_flow_tvalid <= 1'b1;
      end
    end
  end

endmodule

module detect_flow_core_legacy #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FLOW_BITS = 4
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  input  wire [95:0] cond_flow_1,
  input  wire [95:0] cond_flow_2,
  input  wire [95:0] cond_flow_3,
  input  wire [95:0] cond_flow_4,
  input  wire [95:0] cond_flow_5,
  input  wire [95:0] cond_flow_6,
  input  wire [95:0] cond_flow_7,
  input  wire [95:0] cond_flow_8,
  input  wire [95:0] cond_flow_9,
  input  wire [95:0] cond_flow_10,
  input  wire [95:0] cond_flow_11,
  input  wire [95:0] cond_flow_12,
  input  wire [95:0] cond_flow_13,
  input  wire [95:0] cond_flow_14,
  input  wire [95:0] cond_flow_15,

  // AXI4-Stream Data In
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  output wire [FLOW_BITS-1:0] flow_id,
  output wire                 flow_ren,
  input  wire [95:0]          cond_flow,

  // AXI4-Stream Data In
  input  wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tkeep,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Data Out
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tkeep,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast,

  // AXI4-Stream Flow Out
  output wire [FLOW_WIDTH-1:0] m_axis_flow_tdata,
  output wire                  m_axis_flow_tvalid,
  input  wire                  m_axis_flow_tready
);

  // Parameter for ethernet_frame
  localparam ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH; // Must be aligned to DATA_WIDTH
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / DATA_WIDTH;
  localparam ETHERNET_FRAME_WIDTH = 1600 * C_AXIS_TDATA_WIDTH; // Must be aligned to C_AXIS_TDATA_WIDTH
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / C_AXIS_TDATA_WIDTH;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);

  // AXI4-Stream connection
  //// Data
  assign m_axis_tdata  = s_axis_tdata;
  assign m_axis_tkeep  = s_axis_tkeep;
  assign m_axis_tvalid = (state == STATE_PASS_DATA_STREAM)? s_axis_tvalid: 1'b0;
  assign s_axis_tready = (state == STATE_PASS_DATA_STREAM)? m_axis_tready: 1'b0;
  assign m_axis_tlast  = s_axis_tlast;
  //// Flow
  assign m_axis_flow_tdata  = detected_flow;
  assign m_axis_flow_tvalid = (state == STATE_OUTPUT_FLOW);

  // State machine
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_PASS_DATA_STREAM = 'd0;
  localparam STATE_OUTPUT_FLOW = 'd1;
  always @ (posedge clk) begin
    if (!rstn) begin
      ethernet_frame_counter <= 'd0;
      state <= STATE_PASS_DATA_STREAM;
    end else begin
      case (state)
        STATE_PASS_DATA_STREAM: begin
          if (s_axis_tvalid & s_axis_tready) begin
            if (s_axis_tlast) begin
              state <= STATE_OUTPUT_FLOW;
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
            end
          end else begin
            // Do nothing
          end
        end
        STATE_OUTPUT_FLOW: begin
          if (m_axis_flow_tvalid & m_axis_flow_tready) begin
            ethernet_frame_counter <= 'd0;
            state <= STATE_PASS_DATA_STREAM;
          end else begin
            // Do nothing
          end
        end
        default: begin
          ethernet_frame_counter <= 'd0;
          state <= STATE_PASS_DATA_STREAM;
        end
      endcase
    end
  end

  // Extract information
  reg [15:0] frame_12_13 = 'd0;
  reg [15:0] frame_16_17 = 'd0;
  reg [ 7:0] frame_23 = 'd0;
  reg [ 7:0] frame_27 = 'd0;
  reg [31:0] src_ip = 'd0;
  reg [31:0] dst_ip = 'd0;
  reg [15:0] src_port = 'd0;
  reg [15:0] dst_port = 'd0;
  wire frame_has_vlan_tag = (frame_12_13 == 16'h8100 || frame_12_13 == 16'h9100);
  wire payload_is_ipv4    = (frame_has_vlan_tag)? (frame_16_17 == 16'h0800): (frame_12_13 == 16'h0800);
  wire payload_is_tcp     = (frame_has_vlan_tag)? (frame_27 == 8'h06): (frame_23 == 8'h06);
  wire payload_is_udp     = (frame_has_vlan_tag)? (frame_27 == 8'h11): (frame_23 == 8'h11);

  always @ (posedge clk) begin
    if (!rstn) begin
      frame_12_13 <= 'd0;
      frame_16_17 <= 'd0;
      frame_23 <= 'd0;
      frame_27 <= 'd0;
      src_ip <= 'd0;
      dst_ip <= 'd0;
      src_port <= 'd0;
      dst_port <= 'd0;
    end else begin
      if (s_axis_tvalid & s_axis_tready) begin
        case (ethernet_frame_counter)
          0: begin frame_12_13 <= 'd0; frame_16_17 <= 'd0; frame_23 <= 'd0; frame_27 <= 'd0; end
          12: frame_12_13[15:8] <= s_axis_tdata;
          13: frame_12_13[ 7:0] <= s_axis_tdata;
          16: frame_16_17[15:8] <= s_axis_tdata;
          17: frame_16_17[ 7:0] <= s_axis_tdata;
          23: frame_23 <= s_axis_tdata;
          27: frame_27 <= s_axis_tdata;
          default:; // Do nothing
        endcase
        if (frame_has_vlan_tag) begin
          case (ethernet_frame_counter)
            0: begin src_ip <= 'd0; dst_ip <= 'd0; src_port <= 'd0; dst_port <= 'd0; end
            30: src_ip[31:24] <= s_axis_tdata;
            31: src_ip[23:16] <= s_axis_tdata;
            32: src_ip[15: 8] <= s_axis_tdata;
            33: src_ip[ 7: 0] <= s_axis_tdata;
            34: dst_ip[31:24] <= s_axis_tdata;
            35: dst_ip[23:16] <= s_axis_tdata;
            36: dst_ip[15: 8] <= s_axis_tdata;
            37: dst_ip[ 7: 0] <= s_axis_tdata;
            38: src_port[15:8] <= s_axis_tdata;
            39: src_port[ 7:0] <= s_axis_tdata;
            40: dst_port[15:8] <= s_axis_tdata;
            41: dst_port[ 7:0] <= s_axis_tdata;
            default:; // Do nothing
          endcase
        end else begin
          case (ethernet_frame_counter)
            0: begin src_ip <= 'd0; dst_ip <= 'd0; src_port <= 'd0; dst_port <= 'd0; end
            26: src_ip[31:24] <= s_axis_tdata;
            27: src_ip[23:16] <= s_axis_tdata;
            28: src_ip[15: 8] <= s_axis_tdata;
            29: src_ip[ 7: 0] <= s_axis_tdata;
            30: dst_ip[31:24] <= s_axis_tdata;
            31: dst_ip[23:16] <= s_axis_tdata;
            32: dst_ip[15: 8] <= s_axis_tdata;
            33: dst_ip[ 7: 0] <= s_axis_tdata;
            34: src_port[15:8] <= s_axis_tdata;
            35: src_port[ 7:0] <= s_axis_tdata;
            36: dst_port[15:8] <= s_axis_tdata;
            37: dst_port[ 7:0] <= s_axis_tdata;
            default:; // Do nothing
          endcase
        end
      end else begin
        // Do nothing
      end
    end
  end

  // Condition of flow detection
  wire [95:0] cond_flow[FLOW_NUM-1:0];  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB x FLOW_NUM pattern
  assign cond_flow[0] = 'd0; // Default flow
  assign cond_flow[1] = cond_flow_1;
  assign cond_flow[2] = cond_flow_2;
  assign cond_flow[3] = cond_flow_3;
  assign cond_flow[4] = cond_flow_4;
  assign cond_flow[5] = cond_flow_5;
  assign cond_flow[6] = cond_flow_6;
  assign cond_flow[7] = cond_flow_7;
  assign cond_flow[8] = cond_flow_8;
  assign cond_flow[9] = cond_flow_9;
  assign cond_flow[10] = cond_flow_10;
  assign cond_flow[11] = cond_flow_11;
  assign cond_flow[12] = cond_flow_12;
  assign cond_flow[13] = cond_flow_13;
  assign cond_flow[14] = cond_flow_14;
  assign cond_flow[15] = cond_flow_15;

  // Detect flow
  wire [FLOW_WIDTH-1:0] flow_counter = (ethernet_frame_counter < 42 || ethernet_frame_counter >= 42 + FLOW_NUM)? 'd0: ethernet_frame_counter - 'd42;
  wire [31:0] src_ip_ref   = cond_flow[flow_counter][95:64];
  wire [15:0] src_port_ref = cond_flow[flow_counter][63:48];
  wire [31:0] dst_ip_ref   = cond_flow[flow_counter][47:16];
  wire [15:0] dst_port_ref = cond_flow[flow_counter][15: 0];
  // Read cond flow
  assign flow_id = ethernet_frame_counter - 'd42;
  assign flow_ren = !(ethernet_frame_counter < 41 || ethernet_frame_counter >= 41 + FLOW_NUM) && s_axis_tvalid && s_axis_tready;

  // Detect flow
  wire [FLOW_WIDTH-1:0] flow_counter = (ethernet_frame_counter < 42 || ethernet_frame_counter >= 42 + FLOW_NUM)? 'd0: ethernet_frame_counter - 'd42;
  wire [31:0] src_ip_ref   = cond_flow[95:64];
  wire [15:0] src_port_ref = cond_flow[63:48];
  wire [31:0] dst_ip_ref   = cond_flow[47:16];
  wire [15:0] dst_port_ref = cond_flow[15: 0];
  wire src_ip_matched   = (src_ip_ref   == 'd0 || src_ip   == src_ip_ref);
  wire src_port_matched = (src_port_ref == 'd0 || src_port == src_port_ref);
  wire dst_ip_matched   = (dst_ip_ref   == 'd0 || dst_ip   == dst_ip_ref);
  wire dst_port_matched = (dst_port_ref == 'd0 || dst_port == dst_port_ref);
  reg [FLOW_WIDTH-1:0] detected_flow = 'd0;
  always @ (posedge clk) begin
    if (!rstn) begin
      detected_flow <= 'd0;
    end else begin
      if (ethernet_frame_counter == 'd0) begin
        detected_flow <= 'd0;
      end else if (payload_is_ipv4 & (payload_is_tcp | payload_is_udp)) begin
        if (detected_flow == 'd0 && flow_counter != 'd0) begin
          if (src_ip_matched & src_port_matched & dst_ip_matched & dst_port_matched) begin
            detected_flow <= flow_counter;
          end else begin
            // Do nothing
          end
        end else begin
          // Do nothing
        end
      end else begin
        // When frame payload is not IPv4
        // When frame payload is not TCP or UDP
      end
    end
  end

endmodule

module detect_flow #(
  parameter DATA_WIDTH = 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 60,
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

  // AXI4-Stream Data In
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Data Out
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast,

  // AXI4-Stream Flow Out
  output wire [FLOW_WIDTH-1:0] m_axis_flow_tdata,
  output wire                  m_axis_flow_tvalid,
  input  wire                  m_axis_flow_tready
);

  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] init_val = {(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS){1'b1}};
  wire [(C_S_AXI_DATA_WIDTH*NUM_OF_REGISTERS)-1:0] val;
  reg  [95:0] cond_flow_1_15[14:0];

  //--------------------------------------------------
  // Connection of AXI4-Lite Slave and Main module
  //--------------------------------------------------
  genvar i;
  generate
    for (i = 0; i < 15; i = i + 1) begin
      always @ (*) begin
        cond_flow_1_15[i][95:64] <= val[128*i+31 :128*i+0];   // src_ip
        cond_flow_1_15[i][63:48] <= val[128*i+47 :128*i+32];  // src_port
        cond_flow_1_15[i][47:16] <= val[128*i+95 :128*i+64];  // dst_ip
        cond_flow_1_15[i][15: 0] <= val[128*i+111:128*i+96];  // dst_port
      end
    end
  endgenerate

  //-------------------------
  // Main module
  //-------------------------
  detect_flow_core #(
    .DATA_WIDTH(DATA_WIDTH),
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH)
  ) detect_flow_core_i (
    clk,
    rstn,
    cond_flow_1_15[1-1],
    cond_flow_1_15[2-1],
    cond_flow_1_15[3-1],
    cond_flow_1_15[4-1],
    cond_flow_1_15[5-1],
    cond_flow_1_15[6-1],
    cond_flow_1_15[7-1],
    cond_flow_1_15[8-1],
    cond_flow_1_15[9-1],
    cond_flow_1_15[10-1],
    cond_flow_1_15[11-1],
    cond_flow_1_15[12-1],
    cond_flow_1_15[13-1],
    cond_flow_1_15[14-1],
    cond_flow_1_15[15-1],
    s_axis_tdata,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_flow_tdata,
    m_axis_flow_tvalid,
    m_axis_flow_tready
  );

  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  axi4_lite_slave #(
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH)
  ) axi4_lite_slave_i (
endmodule


module detect_flow_core #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FLOW_BITS = 4,
  parameter FLOW_MATCH_RATE = 1,
  parameter OPT_LEVEL = 1
) (
  // clock, negative-reset
  input wire                            clk,
  input wire                            rstn,

  // Condition of flow detection
  // MSB [src_ip(32bit)]/[src_port(16bit)]/[dst_ip(32bit)]/[dst_port(16bit)] LSB
  output wire [FLOW_BITS-1:0]           flow_id,
  output wire                           flow_ren,
  input wire [96 * FLOW_MATCH_RATE-1:0] flow_val,

  // AXI4-Stream Data In
  input wire [C_AXIS_TDATA_WIDTH-1:0]   s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]   s_axis_tkeep,
  input wire                            s_axis_tvalid,
  output wire                           s_axis_tready,
  input wire                            s_axis_tlast,

  // AXI4-Stream Data Out
  output wire [C_AXIS_TDATA_WIDTH-1:0]  m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0]  m_axis_tkeep,
  output wire                           m_axis_tvalid,
  input wire                            m_axis_tready,
  output wire                           m_axis_tlast,

  // AXI4-Stream Flow Out
  output wire [FLOW_WIDTH-1:0]          m_axis_flow_tdata,
  output wire                           m_axis_flow_tvalid,
  input wire                            m_axis_flow_tready
);

  generate
    if (OPT_LEVEL == 0 && C_AXIS_TDATA_WIDTH == 8) begin
      detect_flow_core_legacy #(
                                // Parameters
                                .C_AXIS_TDATA_WIDTH     (C_AXIS_TDATA_WIDTH),
                                .FLOW_NUM       (FLOW_NUM),
                                .FLOW_WIDTH     (FLOW_WIDTH),
                                .FLOW_BITS      (FLOW_BITS))
      detect_flow_core_legacy_i (
                                 // Outputs
                                 .flow_id               (flow_id[FLOW_BITS-1:0]),
                                 .flow_ren              (flow_ren),
                                 .s_axis_tready         (s_axis_tready),
                                 .m_axis_tdata          (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                                 .m_axis_tkeep          (m_axis_tkeep),
                                 .m_axis_tvalid         (m_axis_tvalid),
                                 .m_axis_tlast          (m_axis_tlast),
                                 .m_axis_flow_tdata     (m_axis_flow_tdata[FLOW_WIDTH-1:0]),
                                 .m_axis_flow_tvalid    (m_axis_flow_tvalid),
                                 // Inputs
                                 .clk                   (clk),
                                 .rstn                  (rstn),
                                 .cond_flow             (flow_val[95:0]),
                                 .s_axis_tdata          (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                                 .s_axis_tkeep          (s_axis_tkeep),
                                 .s_axis_tvalid         (s_axis_tvalid),
                                 .s_axis_tlast          (s_axis_tlast),
                                 .m_axis_tready         (m_axis_tready),
                                 .m_axis_flow_tready    (m_axis_flow_tready));
    end else if (OPT_LEVEL == 1) begin
      wire [95:0]                           flow_cond_tdata;
      wire                                  flow_cond_tuser;
      wire                                  flow_cond_tvalid;
      wire                                  flow_cond_tready;

      detect_flow_parse_header #(
                                 // Parameters
                                 .C_AXIS_TDATA_WIDTH        (C_AXIS_TDATA_WIDTH),
                                 .C_AXIS_TKEEP_WIDTH        (C_AXIS_TKEEP_WIDTH),
                                 .FLOW_NUM          (FLOW_NUM),
                                 .FLOW_WIDTH        (FLOW_WIDTH),
                                 .FLOW_BITS         (FLOW_BITS))
      detect_flow_parse_header_i (
                                  // Outputs
                                  .flow_cond_tdata  (flow_cond_tdata[95:0]),
                                  .flow_cond_tvalid (flow_cond_tvalid),
                                  .flow_cond_tuser  (flow_cond_tuser),
                                  .s_axis_tready    (s_axis_tready),
                                  .m_axis_tdata     (m_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                                  .m_axis_tkeep     (m_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                                  .m_axis_tvalid    (m_axis_tvalid),
                                  .m_axis_tlast     (m_axis_tlast),
                                  // Inputs
                                  .clk              (clk),
                                  .rstn             (rstn),
                                  .flow_cond_tready (flow_cond_tready),
                                  .s_axis_tdata     (s_axis_tdata[C_AXIS_TDATA_WIDTH-1:0]),
                                  .s_axis_tkeep     (s_axis_tkeep[C_AXIS_TKEEP_WIDTH-1:0]),
                                  .s_axis_tvalid    (s_axis_tvalid),
                                  .s_axis_tlast     (s_axis_tlast),
                                  .m_axis_tready    (m_axis_tready));

      detect_flow_match_flow #(
                               // Parameters
                               .FLOW_NUM            (FLOW_NUM),
                               .FLOW_WIDTH          (FLOW_WIDTH),
                               .FLOW_BITS           (FLOW_BITS),
                               .FLOW_MATCH_RATE     (FLOW_MATCH_RATE))
      detect_flow_match_flow_i (
                                // Outputs
                                .flow_cond_tready   (flow_cond_tready),
                                .flow_id            (flow_id[FLOW_BITS-1:0]),
                                .flow_ren           (flow_ren),
                                .m_axis_flow_tdata  (m_axis_flow_tdata[FLOW_WIDTH-1:0]),
                                .m_axis_flow_tvalid (m_axis_flow_tvalid),
                                // Inputs
                                .clk                (clk),
                                .rstn               (rstn),
                                .flow_cond_tdata    (flow_cond_tdata[95:0]),
                                .flow_cond_tvalid   (flow_cond_tvalid),
                                .flow_cond_tuser    (flow_cond_tuser),
                                .flow_val           (flow_val[96*FLOW_MATCH_RATE-1:0]),
                                .m_axis_flow_tready (m_axis_flow_tready));
    end else begin
      // Not supported
      // TODO: raise assertion
    end
  endgenerate

endmodule

module detect_flow_register #(
  parameter FLOW_NUM = 16,
  parameter FLOW_BITS = 4,
  parameter FLOW_MATCH_RATE = 1,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 60,
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8)),
  parameter RAM_STYLE = "distributed"
) (
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

  // To user interface
  input wire [FLOW_BITS-1:0]              flow_id,
  input wire                              flow_ren,
  output reg [96*FLOW_MATCH_RATE-1:0]     cond_flow
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
    local_waddr,
    local_raddr,
    local_wen,
    local_ren,
    local_wdata,
    local_rdata,
    local_rdatavalid
  );

  // Triple Port RAM x1
  // - cond_flows: Write (axi4lite), Read (axi4lite), Read (core logic)
  // cond_flows[FLOW_NUM - 1] is reserved and set to all-1.
  localparam RAM_WIDTH = 96 * FLOW_MATCH_RATE;
  localparam RAM_DEPTH = FLOW_NUM / FLOW_MATCH_RATE;
  (* ram_style = RAM_STYLE *)
  reg [RAM_WIDTH-1:0]            cond_flows[RAM_DEPTH - 1 : 0];

  // initialize commited_values
  integer                                 i;
  generate
    if (FLOW_MATCH_RATE == 1) begin
      initial begin
        for (i = 0; i < RAM_DEPTH - 1; i = i + 1) begin
          cond_flows[i] = {RAM_WIDTH{1'b1}};
        end
        cond_flows[FLOW_NUM - 1] = {{1'b0}};
      end
    end else begin
      initial begin
        for (i = 0; i < RAM_DEPTH - 1; i = i + 1) begin
          cond_flows[i] = {RAM_WIDTH{1'b1}};
        end
        cond_flows[RAM_DEPTH - 1] = {{96{1'b0}}, {(RAM_WIDTH - 96){1'b1}}};
      end
    end
  endgenerate

  // cond_flows read/write
  wire [REG_ADDR_BIT-1:0] waddr_q = local_waddr / (4 * FLOW_MATCH_RATE);
  wire [REG_ADDR_BIT-1:0] waddr_mod = local_waddr % 4;
  wire [REG_ADDR_BIT-1:0] waddr_mod2 = (local_waddr / 4) % FLOW_MATCH_RATE;
  wire [REG_ADDR_BIT-1:0] raddr_q = local_raddr / (4 * FLOW_MATCH_RATE);
  wire [REG_ADDR_BIT-1:0] raddr_mod = local_raddr % 4;
  wire [REG_ADDR_BIT-1:0] raddr_mod2 = (local_raddr / 4) % FLOW_MATCH_RATE;

  always @(posedge clk) begin
    if (!rstn) begin
      local_rdata <= 0;
      local_rdatavalid <= 0;
      cond_flow <= 0;
    end else begin
      // write port
      if (local_wen && (local_waddr[REG_ADDR_BIT-1:2] != FLOW_NUM - 1)) begin
        case (waddr_mod)
          0: cond_flows[waddr_q][waddr_mod2 * 96 + 64 +: 32] <= local_wdata; // src ip
          1: cond_flows[waddr_q][waddr_mod2 * 96 + 48 +: 16] <= local_wdata; // src port
          2: cond_flows[waddr_q][waddr_mod2 * 96 + 16 +: 32] <= local_wdata; // dst ip
          3: cond_flows[waddr_q][waddr_mod2 * 96 +  0 +: 16] <= local_wdata; // dst port
        endcase
      end

      // read port 1
      local_rdatavalid <= 1'b0;
      if (local_ren) begin
        case (raddr_mod)
          0: local_rdata <= cond_flows[raddr_q][raddr_mod2 * 96 + 64 +: 32];          // src ip
          1: local_rdata <= {16'd0, cond_flows[raddr_q][raddr_mod2 * 96 + 48 +: 16]}; // src port
          2: local_rdata <= cond_flows[raddr_q][raddr_mod2 * 96 + 16 +: 32];          // dst ip
          3: local_rdata <= {16'd0, cond_flows[raddr_q][raddr_mod2 * 96 +  0 +: 16]}; // dst port
        endcase
        local_rdatavalid <= 1'b1;
      end

      // read port 2
      if (flow_ren) begin
        cond_flow <= cond_flows[flow_id / FLOW_MATCH_RATE];
      end
    end
  end
endmodule

module detect_flow #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter FLOW_NUM = 16,
  parameter FLOW_WIDTH = 8,
  parameter FLOW_MATCH_RATE = 1,
  parameter C_S_AXI_DATA_WIDTH = 32,
  parameter NUM_OF_REGISTERS = 60,
  parameter C_S_AXI_ADDR_WIDTH = $clog2(NUM_OF_REGISTERS * (C_S_AXI_DATA_WIDTH / 8)),
  parameter OPT_LEVEL = 1,
  parameter RAM_STYLE = "distributed"
) (
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

  // AXI4-Stream Data In
  input wire [C_AXIS_TDATA_WIDTH-1:0]     s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]     s_axis_tkeep,
  input wire                              s_axis_tvalid,
  output wire                             s_axis_tready,
  input wire                              s_axis_tlast,

  // AXI4-Stream Data Out
  output wire [C_AXIS_TDATA_WIDTH-1:0]    m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0]    m_axis_tkeep,
  output wire                             m_axis_tvalid,
  input wire                              m_axis_tready,
  output wire                             m_axis_tlast,

  // AXI4-Stream Flow Out
  output wire [FLOW_WIDTH-1:0]            m_axis_flow_tdata,
  output wire                             m_axis_flow_tvalid,
  input wire                              m_axis_flow_tready
);

  localparam FLOW_BITS = $clog2(FLOW_NUM);

  wire [FLOW_BITS-1:0]          flow_id;
  wire                          flow_ren;
  wire [96*FLOW_MATCH_RATE-1:0] flow_val;

  //-------------------------
  // Main module
  //-------------------------
  detect_flow_core #(
    .C_AXIS_TDATA_WIDTH(C_AXIS_TDATA_WIDTH),
    .C_AXIS_TKEEP_WIDTH(C_AXIS_TKEEP_WIDTH),
    .FLOW_NUM(FLOW_NUM),
    .FLOW_WIDTH(FLOW_WIDTH),
    .FLOW_BITS(FLOW_BITS),
    .FLOW_MATCH_RATE(FLOW_MATCH_RATE),
    .OPT_LEVEL(OPT_LEVEL)
  ) detect_flow_core_i (
    clk,
    rstn,
    flow_id,
    flow_ren,
    flow_val,
    s_axis_tdata,
    s_axis_tkeep,
    s_axis_tvalid,
    s_axis_tready,
    s_axis_tlast,
    m_axis_tdata,
    m_axis_tkeep,
    m_axis_tvalid,
    m_axis_tready,
    m_axis_tlast,
    m_axis_flow_tdata,
    m_axis_flow_tvalid,
    m_axis_flow_tready
  );

  //-------------------------
  // AXI4-Lite Slave module
  //-------------------------
  detect_flow_register #(
    .FLOW_NUM(FLOW_NUM),
    .FLOW_BITS(FLOW_BITS),
    .FLOW_MATCH_RATE(FLOW_MATCH_RATE),
    .C_S_AXI_DATA_WIDTH(C_S_AXI_DATA_WIDTH),
    .NUM_OF_REGISTERS(NUM_OF_REGISTERS),
    .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
    .RAM_STYLE(RAM_STYLE)
  ) detect_flow_register_i (
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
    flow_id,
    flow_ren,
    flow_val
  );

endmodule

`default_nettype wire
