// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module set_timestamp #(
  parameter DATA_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72  // Must be aligned to DATA_WIDTH
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // ATS Scheduler Timer input
  input  wire [TIMESTAMP_WIDTH-1:0] ats_scheduler_timer,

  // AXI4-Stream Data In
  // [Ethernet Frame]
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Data Out
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
  assign m_axis_tdata  = (is_timestamp_beat)? timestamp >> (DATA_WIDTH * timestamp_counter): s_axis_tdata;
  assign m_axis_tvalid = (is_timestamp_beat)? 1'b1                                         : s_axis_tvalid;
  assign s_axis_tready = (is_timestamp_beat)? 1'b0                                         : m_axis_tready;
  assign m_axis_tlast  = (is_timestamp_beat & (timestamp_counter == TIMESTAMP_BEAT_NUM - 1));


  // Important registers
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  reg is_timestamp_beat = 1'b0;

  always @ (posedge clk) begin
    if (!rstn) begin
      timestamp <= 'd0;
      timestamp_counter <= 'd0;
      is_timestamp_beat <= 1'b0;
    end else begin
      if (is_timestamp_beat) begin
        if (m_axis_tvalid & m_axis_tready) begin
          if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
            timestamp_counter <= 'd0;
            is_timestamp_beat <= 1'b0;
          end else begin
            timestamp_counter <= timestamp_counter + 'd1;
          end
        end else begin
          // Do nothing
        end
      end else begin
        if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
          timestamp <= ats_scheduler_timer;
          is_timestamp_beat <= 1'b1;
        end else begin
          // Do nothing
        end
      end
    end
  end

endmodule

`default_nettype wire
