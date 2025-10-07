// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module et_deadline #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter TIMESTAMP_WIDTH = 72  // Must be aligned to C_AXIS_TDATA_WIDTH
) (
  // clock, negative-reset
  input wire                          clk,
  input wire                          rstn,

  // AXI4-Stream In without timestamp
  // [Ethernet Frame]
  input wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input wire                          s_axis_tvalid,
  output wire                         s_axis_tready,
  input wire                          s_axis_tlast,

  // AXI4-Stream Timestamp In
  input wire [TIMESTAMP_WIDTH-1:0]    s_axis_timestamp_tdata,
  input wire                          s_axis_timestamp_tvalid,
  output wire                         s_axis_timestamp_tready,

  // AXI4-Stream Out with timestamp
  // [Ethernet Frame]/[Timestamp]
  output reg [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output reg [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output reg                          m_axis_tvalid,
  input wire                          m_axis_tready,
  output reg                          m_axis_tlast,

  // AXI4-Stream Timestamp In
  output reg [TIMESTAMP_WIDTH-1:0]    m_axis_timestamp_tdata,
  output reg                          m_axis_timestamp_tvalid,
  input wire                          m_axis_timestamp_tready
);

  // State machine
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_READ_TIMESTAMP = 0;
  localparam STATE_TRANS_ETHERNET_FRAME = 1;
  localparam STATE_DISCARD_FRAME = 2;
  always @ (posedge clk) begin
    if (!rstn) begin
      state <= STATE_READ_TIMESTAMP;
    end else begin
      case (state)
        STATE_READ_TIMESTAMP: begin
          if (s_axis_timestamp_tvalid & s_axis_timestamp_tready) begin
            if (s_axis_timestamp_tdata != 'd0) begin
              state <= STATE_TRANS_ETHERNET_FRAME;
            end else begin
              // Discard frame
              state <= STATE_DISCARD_FRAME;
            end
          end else begin
            // Do nothing
          end
        end
        STATE_TRANS_ETHERNET_FRAME: begin
          if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
            // Wait MASTER port
            state <= STATE_READ_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        STATE_DISCARD_FRAME: begin
          if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
            // Wait SLAVE port
            state <= STATE_READ_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        default: begin
          state <= STATE_READ_TIMESTAMP;
        end
      endcase
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_timestamp_tdata <= 0;
      m_axis_timestamp_tvalid <= 0;
    end else begin
      if (s_axis_timestamp_tvalid && s_axis_timestamp_tready && s_axis_timestamp_tdata != 0) begin
        m_axis_timestamp_tdata <= s_axis_timestamp_tdata;
        m_axis_timestamp_tvalid <= s_axis_timestamp_tvalid;
      end else if (m_axis_timestamp_tready) begin
        m_axis_timestamp_tdata <= s_axis_timestamp_tdata;
        m_axis_timestamp_tvalid <= 1'b0;
      end
    end
  end

  always @(posedge clk) begin
    if (!rstn) begin
      m_axis_tdata <= 0;
      m_axis_tkeep <= 0;
      m_axis_tvalid <= 0;
      m_axis_tlast <= 0;
    end else begin
      case (state)
        STATE_TRANS_ETHERNET_FRAME: begin
          if (s_axis_tvalid && s_axis_tready) begin
            m_axis_tdata <= s_axis_tdata;
            m_axis_tkeep <= s_axis_tkeep;
            m_axis_tvalid <= s_axis_tvalid;
            m_axis_tlast <= s_axis_tlast;
          end else if (m_axis_tready) begin
            m_axis_tdata <= s_axis_tdata;
            m_axis_tkeep <= s_axis_tkeep;
            m_axis_tvalid <= 1'b0;
            m_axis_tlast <= s_axis_tlast;
          end
        end
        default: begin
          if (m_axis_tready) begin
            m_axis_tdata <= s_axis_tdata;
            m_axis_tkeep <= s_axis_tkeep;
            m_axis_tvalid <= 1'b0;
            m_axis_tlast <= s_axis_tlast;
          end
        end
      endcase
    end
  end

  assign s_axis_timestamp_tready = (state == STATE_READ_TIMESTAMP) && (!m_axis_timestamp_tvalid || m_axis_timestamp_tready);
  assign s_axis_tready = (state == STATE_DISCARD_FRAME) || (state == STATE_TRANS_ETHERNET_FRAME && (!m_axis_tvalid || m_axis_tready));

endmodule

`default_nettype wire
