// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module axis_stream_detector #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter C_AXIS_TUSER_WIDTH = 2
) (
   input wire                           aclk,
   input wire                           aresetn,

   input wire [C_AXIS_TDATA_WIDTH-1:0]  s_axis_tdata,
   input wire [C_AXIS_TKEEP_WIDTH-1:0]  s_axis_tkeep,
   input wire [C_AXIS_TUSER_WIDTH-1:0]  s_axis_tuser,
   input wire                           s_axis_tlast,
   input wire                           s_axis_tvalid,
   output wire                          s_axis_tready,

   output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
   output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
   output wire [C_AXIS_TUSER_WIDTH-1:0] m_axis_tuser,
   output wire                          m_axis_tlast,
   output wire                          m_axis_tvalid,
   input wire                           m_axis_tready,

   output wire                          streaming,
   output wire                          streaming_with_last
   );

  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tkeep = s_axis_tkeep;
  assign m_axis_tuser = s_axis_tuser;
  assign m_axis_tlast = s_axis_tlast;
  assign m_axis_tvalid = s_axis_tvalid;
  assign s_axis_tready = m_axis_tready;

  assign streaming = m_axis_tvalid && m_axis_tready;
  assign streaming_with_last = m_axis_tvalid && m_axis_tready && m_axis_tlast;

endmodule // axis_stream_detector

`default_nettype none
