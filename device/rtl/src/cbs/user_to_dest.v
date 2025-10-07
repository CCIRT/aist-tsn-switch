// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

<<<<<<< HEAD
module user_to_dest (
  // clk, rstn
  input  wire clk,
  input  wire rstn,

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
  output wire [1:0] m_axis_tdest
);
  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
=======
module user_to_dest #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter C_AXIS_TUSER_WIDTH = 2
) (
  // clk, rstn
  input  wire                          clk,
  input  wire                          rstn,

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
  output wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_tdest
);
  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tkeep = s_axis_tkeep;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  assign m_axis_tvalid = s_axis_tvalid;
  assign s_axis_tready = m_axis_tready;
  assign m_axis_tlast = s_axis_tlast;
  assign m_axis_tdest = s_axis_tuser;

endmodule

`default_nettype wire
