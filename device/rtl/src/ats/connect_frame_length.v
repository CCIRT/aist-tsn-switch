// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module connect_frame_length #(
  parameter DATA_WIDTH = 8
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In without frame_length
  // [Ethernet Frame]
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream In only frame_length
  // [Frame length]
  input  wire [DATA_WIDTH-1:0] s_axis_frame_length_tdata,
  input  wire                  s_axis_frame_length_tvalid,
  output wire                  s_axis_frame_length_tready,
  input  wire                  s_axis_frame_length_tlast,

  // AXI4-Stream Out with frame_length
  // [Frame length]/[Ethernet Frame]
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast
);

  // Important registers
  reg is_frame_length_beat = 1'b1;

  // AXI4-Stream connection
  //// Common
  assign m_axis_tdata  = (is_frame_length_beat)? s_axis_frame_length_tdata : s_axis_tdata;
  assign m_axis_tvalid = (is_frame_length_beat)? s_axis_frame_length_tvalid: s_axis_tvalid;
  assign m_axis_tlast  = (is_frame_length_beat)? 1'b0: s_axis_tlast;
  //// Data
  assign s_axis_tready = (is_frame_length_beat)? 1'b0: m_axis_tready;
  //// Frame length
  assign s_axis_frame_length_tready = (is_frame_length_beat)? m_axis_tready: 1'b0;

  // Control is_frame_length_beat
  always @ (posedge clk) begin
    if (!rstn) begin
      is_frame_length_beat <= 1'b1;
    end else begin
      if (s_axis_frame_length_tvalid & s_axis_frame_length_tready & s_axis_frame_length_tlast) begin
        is_frame_length_beat <= 1'b0;
      end else if (s_axis_tvalid & s_axis_tready & s_axis_tlast) begin
        is_frame_length_beat <= 1'b1;
      end else begin
        // Do nothing
      end
    end
  end

endmodule

`default_nettype wire
