// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module credit_based_shaper (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // Settings
  input  wire signed [31:0] idle_slope, // Expect positive value.
  input  wire signed [31:0] send_slope, // Expect negative value.
  input  wire signed [31:0] max_credit, // Expect positive value.
  input  wire signed [31:0] min_credit, // Expect negative value.

  // Transmission gate status
  input wire transmission_gate_is_open,

  // Debug wires
  output wire signed [31:0] credit,
  output wire               transmit_until_frame_end,

  // AXI4-Stream In
  input  wire [7:0] s_axis_tdata,
  input  wire       s_axis_tvalid,
  output wire       s_axis_tready,
  input  wire       s_axis_tlast,
  input  wire       s_axis_tuser,

  // AXI4-Stream Out
  output wire [7:0] m_axis_tdata,
  output wire       m_axis_tvalid,
  input  wire       m_axis_tready,
  output wire       m_axis_tlast,
  output wire       m_axis_tuser
);

  localparam signed [31:0] TRANSMIT_CREDIT_LIMIT = 0;
module credit_based_shaper #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter L1_LENGTH_OFFSET = 24 // Offset to modify L2 frame length to L1 frame length. Default to 24 (FCS + preamble + IPG)
) (
  // clock, negative-reset
  input wire                           clk,
  input wire                           rstn,

  // Settings
  input wire signed [31:0]             idle_slope, // Expect positive value.
  input wire signed [31:0]             send_slope, // Expect negative value.
  input wire signed [31:0]             max_credit, // Expect positive value.
  input wire signed [31:0]             min_credit, // Expect negative value.

  // Transmission gate status
  input wire                           transmission_gate_is_open,

  // Debug wires
  output wire signed [31:0]            credit,
  output wire                          transmit_until_frame_end,

  // AXI4-Stream In
  input wire [C_AXIS_TDATA_WIDTH-1:0]  s_axis_tdata,
  input wire [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_tkeep,
  input wire                           s_axis_tvalid,
  output wire                          s_axis_tready,
  input wire                           s_axis_tlast,

  // AXI4-Stream Out
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input wire                           m_axis_tready,
  output wire                          m_axis_tlast
);

  localparam signed [31:0] TRANSMIT_CREDIT_LIMIT = 0;
  localparam L1_LENGTH_OFFSET_COUNTER_WIDTH = $clog2(L1_LENGTH_OFFSET);
  localparam L1_LENGTH_OFFSET_COUNTER_INC = C_AXIS_TKEEP_WIDTH;

  // Important registers
  reg signed [31:0] credit_reg = 32'd0;
  reg transmit_until_frame_end_reg = 1'b0;

  // Utility wires
  wire transmit_allowed = (credit_reg >= TRANSMIT_CREDIT_LIMIT) | transmit_until_frame_end_reg;
  reg transmitting_extra = 1'b0;
  reg [L1_LENGTH_OFFSET_COUNTER_WIDTH-1:0] l1counter = L1_LENGTH_OFFSET - L1_LENGTH_OFFSET_COUNTER_INC;

  // Utility wires
  wire transmit_allowed = ((credit_reg >= TRANSMIT_CREDIT_LIMIT) | transmit_until_frame_end_reg) && !transmitting_extra;
  wire transmitting = m_axis_tvalid & m_axis_tready;
  wire queue_contains_some_frames = s_axis_tvalid;

  // Debug wires
  assign credit = credit_reg;
  assign transmit_until_frame_end = transmit_until_frame_end_reg;

  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tvalid = (transmit_allowed)? s_axis_tvalid: 1'b0;
  assign s_axis_tready = (transmit_allowed)? m_axis_tready: 1'b0;
  assign m_axis_tlast = s_axis_tlast;
  assign m_axis_tuser = s_axis_tuser;
  assign m_axis_tkeep = s_axis_tkeep;
  assign m_axis_tvalid = (transmit_allowed)? s_axis_tvalid: 1'b0;
  assign s_axis_tready = (transmit_allowed)? m_axis_tready: 1'b0;
  assign m_axis_tlast = s_axis_tlast;

  // L1 offset counter controller
  always @ (posedge clk) begin
    if (!rstn) begin
      l1counter <= L1_LENGTH_OFFSET - L1_LENGTH_OFFSET_COUNTER_INC;
    end else begin
      if (transmitting && m_axis_tlast && (l1counter >= L1_LENGTH_OFFSET - L1_LENGTH_OFFSET_COUNTER_INC)) begin
        l1counter <= 0;
        transmitting_extra <= 1'b1;
      end else begin
        if (l1counter < L1_LENGTH_OFFSET - L1_LENGTH_OFFSET_COUNTER_INC) begin
          l1counter <= l1counter + L1_LENGTH_OFFSET_COUNTER_INC;
        end else begin
          transmitting_extra <= 1'b0;
        end
      end
    end
  end

  // Transmit controller
  always @ (posedge clk) begin
    if (!rstn) begin
      transmit_until_frame_end_reg <= 1'b0;
    end else begin
      if (transmitting) begin
        if (m_axis_tlast) begin
          transmit_until_frame_end_reg <= 1'b0;
        end else begin
          transmit_until_frame_end_reg <= 1'b1;
        end
      end else begin
        // When idling, does not change transmit_until_frame_end_reg value.
      end
    end
  end

  // Credit counter
  wire signed [31:0] tmp_idle_credit = credit_reg + idle_slope;
  wire signed [31:0] tmp_send_credit = credit_reg + send_slope;
  always @ (posedge clk) begin
    if (!rstn) begin
      credit_reg <= 32'd0;
    end else begin
      if (!queue_contains_some_frames & transmission_gate_is_open & !credit_reg[31]) begin
        // Queue does not contain any frames, transmission gate is open and credit_reg is positive.
        credit_reg <= 32'd0;
      end else begin
        if (!transmitting) begin
        if (!transmitting && !transmitting_extra) begin
          // Idling
          if (!credit_reg[31] & tmp_idle_credit[31]) begin
            // Overflow detected
            credit_reg <= max_credit;
          end else if (tmp_idle_credit > max_credit) begin
            // Hit the upper limit
            credit_reg <= max_credit;
          end else begin
            credit_reg <= tmp_idle_credit;
          end
        end else begin
          // Sending
          if (credit_reg[31] & !tmp_send_credit[31]) begin
            // Underflow detected
            credit_reg <= min_credit;
          end else if (tmp_send_credit < min_credit) begin
            // Hit the lower limit
            credit_reg <= min_credit;
          end else begin
            credit_reg <= tmp_send_credit;
          end
        end
      end
    end
  end

endmodule

`default_nettype wire
