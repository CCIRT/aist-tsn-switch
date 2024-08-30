// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module dest_to_user (
  // clk, rstn
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In
  input  wire [7:0] s_axis_tdata,
  input  wire       s_axis_tvalid,
  output wire       s_axis_tready,
  input  wire       s_axis_tlast,
  input  wire [1:0] s_axis_tdest,

  // AXI4-Stream Out
  output wire [7:0] m_axis_tdata,
  output wire       m_axis_tvalid,
  input  wire       m_axis_tready,
  output wire       m_axis_tlast,
  output wire [1:0] m_axis_tuser
);
  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tvalid = s_axis_tvalid;
  assign s_axis_tready = m_axis_tready;
  assign m_axis_tlast = s_axis_tlast;
  assign m_axis_tuser = s_axis_tdest;

endmodule

`default_nettype wire
