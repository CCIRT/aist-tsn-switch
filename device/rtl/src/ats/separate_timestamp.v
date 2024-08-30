// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module separate_timestamp #(
  parameter DATA_WIDTH = 8,
  parameter FRAME_LENGTH_WIDTH = 16,                  // Must be aligned to DATA_WIDTH
  parameter ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH, // Must be aligned to DATA_WIDTH
  parameter TIMESTAMP_WIDTH = 72                      // Must be aligned to DATA_WIDTH
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In with timestamp
  // [Ethernet Frame]/[Timestamp]
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Frame length In
  input  wire [FRAME_LENGTH_WIDTH-1:0] s_axis_frame_length_tdata,
  input  wire                          s_axis_frame_length_tvalid,
  output wire                          s_axis_frame_length_tready,

  // AXI4-Stream Out without timestamp
  // [Ethernet Frame]
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast,

  // AXI4-Stream Timestamp Out
  output wire [TIMESTAMP_WIDTH-1:0] m_axis_timestamp_tdata,
  output wire                       m_axis_timestamp_tvalid,
  input  wire                       m_axis_timestamp_tready
);

  // Parameter for ethernet_frame
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / DATA_WIDTH;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);
  // Parameter for timestamp
  localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / DATA_WIDTH;
  localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

  // AXI4-Stream connection
  //// Common
  assign s_axis_tready = (state == STATE_READ_ETHERNET_FRAME)? m_axis_tready: (state == STATE_READ_TIMESTAMP);
  //// Length
  assign s_axis_frame_length_tready = (state == STATE_READ_FRAME_LENGTH);
  //// Data
  assign m_axis_tdata  = s_axis_tdata;
  assign m_axis_tvalid = (state == STATE_READ_ETHERNET_FRAME)? s_axis_tvalid: 1'b0;
  assign m_axis_tlast  = (state == STATE_READ_ETHERNET_FRAME && ethernet_frame_counter == frame_length - 1);
  //// Timestamp
  assign m_axis_timestamp_tdata  = timestamp;
  assign m_axis_timestamp_tvalid = (state == STATE_WRITE_TIMESTAMP);

  // Utility wires
  wire stream_incoming = s_axis_tvalid & s_axis_tready;

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_READ_FRAME_LENGTH = 0;
  localparam STATE_READ_ETHERNET_FRAME = 1;
  localparam STATE_READ_TIMESTAMP = 2;
  localparam STATE_WRITE_TIMESTAMP = 3;
  // Important registers
  reg [FRAME_LENGTH_WIDTH-1:0] frame_length = 'd0;
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      frame_length <= 'd0;
      ethernet_frame_counter <='d0;
      timestamp <= 'd0;
      timestamp_counter <= 'd0;
      state <= STATE_READ_FRAME_LENGTH;
    end else begin
      case (state)
        STATE_READ_FRAME_LENGTH: begin
          if (s_axis_frame_length_tvalid & s_axis_frame_length_tready) begin
            frame_length <= s_axis_frame_length_tdata;
            state <= STATE_READ_ETHERNET_FRAME;
          end else begin
            // Do nothing
          end
        end
        STATE_READ_ETHERNET_FRAME: begin
          if (stream_incoming) begin
            if (ethernet_frame_counter == frame_length - 1) begin
              ethernet_frame_counter <= 'd0;
              state <= STATE_READ_TIMESTAMP;
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
            end
          end
        end
        STATE_READ_TIMESTAMP: begin
          if (stream_incoming) begin
            timestamp <= s_axis_tdata << (DATA_WIDTH * timestamp_counter) | timestamp;
            if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
              timestamp_counter <= 'd0;
              state <= STATE_WRITE_TIMESTAMP;
            end else begin
              timestamp_counter <= timestamp_counter + 'd1;
            end
          end
        end
        STATE_WRITE_TIMESTAMP: begin
          if (m_axis_timestamp_tvalid & m_axis_timestamp_tready) begin
            timestamp <= 'd0;
            state <= STATE_READ_FRAME_LENGTH;
          end else begin
            // Do nothing
          end
        end
        default: begin
          frame_length <= 'd0;
          ethernet_frame_counter <='d0;
          timestamp <= 'd0;
          timestamp_counter <= 'd0;
          state <= STATE_READ_FRAME_LENGTH;
        end
      endcase
    end
  end

endmodule

`default_nettype wire
