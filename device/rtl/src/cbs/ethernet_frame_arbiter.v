// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module ethernet_frame_arbiter (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream In 7
  input  wire [7:0] s_axis_7_tdata,
  input  wire       s_axis_7_tvalid,
  output reg        s_axis_7_tready,
  input  wire       s_axis_7_tlast,
  input  wire       s_axis_7_tuser,

  // AXI4-Stream In 6
  input  wire [7:0] s_axis_6_tdata,
  input  wire       s_axis_6_tvalid,
  output reg        s_axis_6_tready,
  input  wire       s_axis_6_tlast,
  input  wire       s_axis_6_tuser,

  // AXI4-Stream In 5
  input  wire [7:0] s_axis_5_tdata,
  input  wire       s_axis_5_tvalid,
  output reg        s_axis_5_tready,
  input  wire       s_axis_5_tlast,
  input  wire       s_axis_5_tuser,

  // AXI4-Stream In 4
  input  wire [7:0] s_axis_4_tdata,
  input  wire       s_axis_4_tvalid,
  output reg        s_axis_4_tready,
  input  wire       s_axis_4_tlast,
  input  wire       s_axis_4_tuser,

  // AXI4-Stream In 3
  input  wire [7:0] s_axis_3_tdata,
  input  wire       s_axis_3_tvalid,
  output reg        s_axis_3_tready,
  input  wire       s_axis_3_tlast,
  input  wire       s_axis_3_tuser,

  // AXI4-Stream In 2
  input  wire [7:0] s_axis_2_tdata,
  input  wire       s_axis_2_tvalid,
  output reg        s_axis_2_tready,
  input  wire       s_axis_2_tlast,
  input  wire       s_axis_2_tuser,

  // AXI4-Stream In 1
  input  wire [7:0] s_axis_1_tdata,
  input  wire       s_axis_1_tvalid,
  output reg        s_axis_1_tready,
  input  wire       s_axis_1_tlast,
  input  wire       s_axis_1_tuser,

  // AXI4-Stream In 0
  input  wire [7:0] s_axis_0_tdata,
  input  wire       s_axis_0_tvalid,
  output reg        s_axis_0_tready,
  input  wire       s_axis_0_tlast,
  input  wire       s_axis_0_tuser,

  // AXI4-Stream Out
  output reg  [7:0] m_axis_tdata,
  output reg        m_axis_tvalid,
  input  wire       m_axis_tready,
  output reg        m_axis_tlast,
  output reg        m_axis_tuser
);

  // Important registers
  reg [2:0] arbitrate_tmp;
  reg [2:0] arbitrate_reg;
  reg is_first_beat = 1'b1;

  // Utility wires
  wire stream_outgoing = m_axis_tvalid & m_axis_tready;
  wire [2:0] arbitrate = (is_first_beat)? arbitrate_tmp: arbitrate_reg;

  // AXI4-Stream connection
  always @ (*) begin
    case (arbitrate)
      3'd7:
        begin
          m_axis_tdata    <= s_axis_7_tdata;
          m_axis_tvalid   <= s_axis_7_tvalid;
          m_axis_tlast    <= s_axis_7_tlast;
          m_axis_tuser    <= s_axis_7_tuser;
          s_axis_7_tready <= m_axis_tready;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd6:
        begin
          m_axis_tdata    <= s_axis_6_tdata;
          m_axis_tvalid   <= s_axis_6_tvalid;
          m_axis_tlast    <= s_axis_6_tlast;
          m_axis_tuser    <= s_axis_6_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= m_axis_tready;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd5:
        begin
          m_axis_tdata    <= s_axis_5_tdata;
          m_axis_tvalid   <= s_axis_5_tvalid;
          m_axis_tlast    <= s_axis_5_tlast;
          m_axis_tuser    <= s_axis_5_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= m_axis_tready;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd4:
        begin
          m_axis_tdata    <= s_axis_4_tdata;
          m_axis_tvalid   <= s_axis_4_tvalid;
          m_axis_tlast    <= s_axis_4_tlast;
          m_axis_tuser    <= s_axis_4_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= m_axis_tready;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd3:
        begin
          m_axis_tdata    <= s_axis_3_tdata;
          m_axis_tvalid   <= s_axis_3_tvalid;
          m_axis_tlast    <= s_axis_3_tlast;
          m_axis_tuser    <= s_axis_3_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= m_axis_tready;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd2:
        begin
          m_axis_tdata    <= s_axis_2_tdata;
          m_axis_tvalid   <= s_axis_2_tvalid;
          m_axis_tlast    <= s_axis_2_tlast;
          m_axis_tuser    <= s_axis_2_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= m_axis_tready;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
      3'd1:
        begin
          m_axis_tdata    <= s_axis_1_tdata;
          m_axis_tvalid   <= s_axis_1_tvalid;
          m_axis_tlast    <= s_axis_1_tlast;
          m_axis_tuser    <= s_axis_1_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= m_axis_tready;
          s_axis_0_tready <= 1'b0;
        end
      3'd0:
        begin
          m_axis_tdata    <= s_axis_0_tdata;
          m_axis_tvalid   <= s_axis_0_tvalid;
          m_axis_tlast    <= s_axis_0_tlast;
          m_axis_tuser    <= s_axis_0_tuser;
          s_axis_7_tready <= 1'b0;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= m_axis_tready;
        end
      default:
        begin
          m_axis_tdata    <= s_axis_7_tdata;
          m_axis_tvalid   <= s_axis_7_tvalid;
          m_axis_tlast    <= s_axis_7_tlast;
          m_axis_tuser    <= s_axis_7_tuser;
          s_axis_7_tready <= m_axis_tready;
          s_axis_6_tready <= 1'b0;
          s_axis_5_tready <= 1'b0;
          s_axis_4_tready <= 1'b0;
          s_axis_3_tready <= 1'b0;
          s_axis_2_tready <= 1'b0;
          s_axis_1_tready <= 1'b0;
          s_axis_0_tready <= 1'b0;
        end
    endcase
  end

  // Decide arbitrate_tmp
  always @ (*) begin
    if (s_axis_7_tvalid) begin
      arbitrate_tmp <= 3'd7;
    end else if (s_axis_6_tvalid) begin
      arbitrate_tmp <= 3'd6;
    end else if (s_axis_5_tvalid) begin
      arbitrate_tmp <= 3'd5;
    end else if (s_axis_4_tvalid) begin
      arbitrate_tmp <= 3'd4;
    end else if (s_axis_3_tvalid) begin
      arbitrate_tmp <= 3'd3;
    end else if (s_axis_2_tvalid) begin
      arbitrate_tmp <= 3'd2;
    end else if (s_axis_1_tvalid) begin
      arbitrate_tmp <= 3'd1;
    end else if (s_axis_0_tvalid) begin
      arbitrate_tmp <= 3'd0;
    end else begin
      arbitrate_tmp <= 3'd7;
    end
  end

  // Control arbitrate_reg
  always @ (posedge clk) begin
    if (!rstn) begin
      arbitrate_reg <= 3'd7;
    end else begin
      if (stream_outgoing) begin
        if (is_first_beat) begin
          arbitrate_reg <= arbitrate_tmp;
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
      if (stream_outgoing) begin
        if (m_axis_tlast) begin
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
