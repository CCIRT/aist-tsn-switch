// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module connect_timestamp #(
  parameter DATA_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72  // Must be aligned to DATA_WIDTH
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In without timestamp
  // [Ethernet Frame]
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Timestamp In
  input  wire [TIMESTAMP_WIDTH-1:0] s_axis_timestamp_tdata,
  input  wire                       s_axis_timestamp_tvalid,
  output wire                       s_axis_timestamp_tready,

  // AXI4-Stream Out with timestamp
  // [Ethernet Frame]/[Timestamp]
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast
);

  // Parameter for timestamp
  localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / DATA_WIDTH;
  localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

  // AXI4-Stream connection
  //// Common
  assign m_axis_tdata  = (state == STATE_TRANS_ETHERNET_FRAME)? s_axis_tdata: timestamp >> (DATA_WIDTH * timestamp_counter);
  assign m_axis_tvalid = (state == STATE_TRANS_ETHERNET_FRAME)? s_axis_tvalid: (state == STATE_WRITE_TIMESTAMP);
  assign m_axis_tlast  = (state == STATE_WRITE_TIMESTAMP)? (timestamp_counter == TIMESTAMP_BEAT_NUM - 1): 1'b0;
  //// Data
  assign s_axis_tready = (state == STATE_TRANS_ETHERNET_FRAME)? m_axis_tready: (state == STATE_DISCARD_FRAME);
  //// Timestamp
  assign s_axis_timestamp_tready = (state == STATE_READ_TIMESTAMP);
  // Important registers
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  // State machine
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_READ_TIMESTAMP = 0;
  localparam STATE_TRANS_ETHERNET_FRAME = 1;
  localparam STATE_WRITE_TIMESTAMP = 2;
  localparam STATE_DISCARD_FRAME = 3;
  always @ (posedge clk) begin
    if (!rstn) begin
      state <= STATE_READ_TIMESTAMP;
    end else begin
      case (state)
        STATE_READ_TIMESTAMP: begin
          if (s_axis_timestamp_tvalid & s_axis_timestamp_tready) begin
            if (s_axis_timestamp_tdata != 'd0) begin
              timestamp <= s_axis_timestamp_tdata;
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
            state <= STATE_WRITE_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        STATE_WRITE_TIMESTAMP: begin
          if (m_axis_tvalid & m_axis_tready) begin
            if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
              timestamp_counter <= 'd0;
              state <= STATE_READ_TIMESTAMP;
            end else begin
              timestamp_counter <= timestamp_counter + 'd1;
            end
          end else begin
            // Do nothing
          end
        end
        STATE_DISCARD_FRAME: begin
          if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
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

endmodule

`default_nettype wire
