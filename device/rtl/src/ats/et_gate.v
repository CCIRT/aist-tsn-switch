// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module et_gate #(
  parameter DATA_WIDTH = 8,
  parameter TIMESTAMP_WIDTH = 72      // Must be aligned to DATA_WIDTH
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // Transmission Selection Timer input
  input  wire [TIMESTAMP_WIDTH-1:0] transmission_selection_timer,
  input  wire [TIMESTAMP_WIDTH-1:0] processing_delay_max,

  // AXI4-Stream Data In
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Timestamp In
  input  wire [TIMESTAMP_WIDTH-1:0] s_axis_eligibility_timestamp_tdata,
  input  wire                       s_axis_eligibility_timestamp_tvalid,
  output wire                       s_axis_eligibility_timestamp_tready,

  // AXI4-Stream Data Out
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast
);

  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tvalid = (state == STATE_PASS_DATA_STREAM)? s_axis_tvalid: 1'b0;
  assign s_axis_tready = (state == STATE_PASS_DATA_STREAM)? m_axis_tready: 1'b0;
  assign m_axis_tlast = s_axis_tlast;
  assign s_axis_eligibility_timestamp_tready = (state == STATE_WAIT_FOR_TIMESTAMP);

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_WAIT_FOR_TIMESTAMP = 0;
  localparam STATE_COMPARE_TIMESTAMP_WITH_TIMER = 1;
  localparam STATE_PASS_DATA_STREAM = 2;
  // Important registers
  reg [TIMESTAMP_WIDTH-1:0] assigned_eligibility_timestamp_reg = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      assigned_eligibility_timestamp_reg <= 'd0;
      state <= STATE_WAIT_FOR_TIMESTAMP;
    end else begin
      case (state)
        STATE_WAIT_FOR_TIMESTAMP: begin
          if (s_axis_eligibility_timestamp_tvalid & s_axis_eligibility_timestamp_tready) begin
            assigned_eligibility_timestamp_reg <= s_axis_eligibility_timestamp_tdata + processing_delay_max;
            state <= STATE_COMPARE_TIMESTAMP_WITH_TIMER;
          end else begin
            // Do nothing
          end
        end
        STATE_COMPARE_TIMESTAMP_WITH_TIMER: begin
          if (assigned_eligibility_timestamp_reg < transmission_selection_timer) begin
            state <= STATE_PASS_DATA_STREAM;
          end else begin
            // Do nothing
          end
        end
        STATE_PASS_DATA_STREAM: begin
          if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
            state <= STATE_WAIT_FOR_TIMESTAMP;
          end else begin
            // Do nothing
          end
        end
        default: begin
          assigned_eligibility_timestamp_reg <= 'd0;
          state <= STATE_WAIT_FOR_TIMESTAMP;
        end
      endcase
    end
  end

endmodule

`default_nettype wire
