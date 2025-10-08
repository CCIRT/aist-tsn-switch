// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module ethernet_frame_dropper (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // frame drop enable(1) or not(0)
  input  wire drop_enable,

  // almost_full input from rear FIFO
  input  wire fifo_is_almost_full,

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
module ethernet_frame_dropper #(
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8
) (
  // clock, negative-reset
  input  wire                          clk,
  input  wire                          rstn,

  // frame drop enable(1) or not(0)
  input  wire                          drop_enable,

  // almost_full input from rear FIFO
  input  wire                          fifo_is_almost_full,

  // AXI4-Stream In
  input  wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input  wire                          s_axis_tvalid,
  output wire                          s_axis_tready,
  input  wire                          s_axis_tlast,

  // AXI4-Stream Out
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input  wire                          m_axis_tready,
  output wire                          m_axis_tlast
);

  // Important registers
  reg drop_frame_reg = 1'b0;
  reg is_first_beat = 1'b1;

  // Utility wires
  wire stream_incoming = s_axis_tvalid & m_axis_tready;
  wire drop_frame = (!drop_enable)? 1'b0:
                    (stream_incoming & is_first_beat & fifo_is_almost_full) | drop_frame_reg;

  // AXI4-Stream connection
  assign m_axis_tdata = s_axis_tdata;
  assign m_axis_tvalid = (drop_frame)? 1'b0: s_axis_tvalid;
  assign s_axis_tready = (drop_frame)? 1'b1: m_axis_tready;
  assign m_axis_tlast = s_axis_tlast;
  assign m_axis_tuser = s_axis_tuser;
  assign m_axis_tkeep = s_axis_tkeep;
  assign m_axis_tvalid = (drop_frame)? 1'b0: s_axis_tvalid;
  assign s_axis_tready = (drop_frame)? 1'b1: m_axis_tready;
  assign m_axis_tlast = s_axis_tlast;

  // Control drop_frame_reg
  always @ (posedge clk) begin
    if (!rstn) begin
      drop_frame_reg <= 1'b0;
    end else begin
      if (stream_incoming) begin
        if (is_first_beat & fifo_is_almost_full) begin
          drop_frame_reg <= 1'b1;
        end else if (s_axis_tlast) begin
          drop_frame_reg <= 1'b0;
        end else begin
          // Do nothing
        end
      end else begin
        // Do nothing
      end
    end
  end

  // Control is_first_beat
  always @ (posedge clk) begin
    if (!rstn) begin
      is_first_beat <= 1'b1;
    end else begin
      if (stream_incoming) begin
        if (s_axis_tlast) begin
          is_first_beat <= 1'b1;
        end else begin
          is_first_beat <= 1'b0;
        end
      end else begin
        // Do nothing
      end
    end
  end

endmodule

`default_nettype wire
