// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module get_frame_length #(
<<<<<<< HEAD
  parameter DATA_WIDTH = 8,
  parameter FRAME_LENGTH_WIDTH = 16,                  // Must be aligned to DATA_WIDTH
  parameter ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH, // Must be aligned to DATA_WIDTH
  parameter ENABLE_TIMESTAMP_FOOTER = 1,
  parameter TIMESTAMP_WIDTH = 72                      // Must be aligned to DATA_WIDTH
=======
  parameter C_AXIS_TDATA_WIDTH = 8,
  parameter C_AXIS_TKEEP_WIDTH = C_AXIS_TDATA_WIDTH / 8,
  parameter FRAME_LENGTH_WIDTH = 16,
  parameter ETHERNET_FRAME_WIDTH = 1600,
  parameter ENABLE_TIMESTAMP_FOOTER = 1,
  parameter TIMESTAMP_WIDTH = 72,
  parameter L1_LENGTH_OFFSET = 24                     // Offset to modify L2 frame length to L1 frame length. Default to 24 (FCS + preamble + IPG)
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,

  // AXI4-Stream Data In
  // [Ethernet Frame]/([Timestamp])
<<<<<<< HEAD
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast,

  // AXI4-Stream Data Out
  // [Ethernet Frame]/([Timestamp])
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast,
=======
  input  wire [C_AXIS_TDATA_WIDTH-1:0] s_axis_tdata,
  input  wire [C_AXIS_TKEEP_WIDTH-1:0] s_axis_tkeep,
  input  wire                          s_axis_tvalid,
  output wire                          s_axis_tready,
  input  wire                          s_axis_tlast,

  // AXI4-Stream Data Out
  // [Ethernet Frame]/([Timestamp])
  output wire [C_AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire [C_AXIS_TKEEP_WIDTH-1:0] m_axis_tkeep,
  output wire                          m_axis_tvalid,
  input  wire                          m_axis_tready,
  output wire                          m_axis_tlast,
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  // AXI4-Stream Frame length Out
  // [Frame length]
  output wire [FRAME_LENGTH_WIDTH-1:0] m_axis_frame_length_tdata,
  output wire                          m_axis_frame_length_tvalid,
  input  wire                          m_axis_frame_length_tready
);

  // Parameter for ethernet_frame
<<<<<<< HEAD
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / DATA_WIDTH;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);
=======
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_WIDTH);
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  // Parameter for timestamp
  localparam TIMESTAMP_BYTES = (ENABLE_TIMESTAMP_FOOTER)? TIMESTAMP_WIDTH / 8: 0;
  // AXI4-Stream connection
  assign m_axis_tdata  = s_axis_tdata;
<<<<<<< HEAD
=======
  assign m_axis_tkeep  = s_axis_tkeep;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  assign m_axis_tvalid = (state == STATE_COUNT_FRAME_LENGTH)? s_axis_tvalid: 1'b0;
  assign s_axis_tready = (state == STATE_COUNT_FRAME_LENGTH)? m_axis_tready: 1'b0;
  assign m_axis_tlast  = s_axis_tlast;

  assign m_axis_frame_length_tdata  = ethernet_frame_counter;
  assign m_axis_frame_length_tvalid = (state == STATE_WRITE_FRAME_LENGTH);

<<<<<<< HEAD
=======
  reg [$clog2(C_AXIS_TKEEP_WIDTH):0]           num_bytes;
  integer                              i;
  always @ (*) begin
    num_bytes = 0;
    for (i = 0; i < C_AXIS_TKEEP_WIDTH; i = i + 1) begin
      if (s_axis_tkeep[i]) begin
        num_bytes = i + 1;
      end
    end
  end

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 1;
  localparam STATE_COUNT_FRAME_LENGTH = 0;
  localparam STATE_WRITE_FRAME_LENGTH = 1;
  // Important registers
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
<<<<<<< HEAD
      ethernet_frame_counter <= 'd0;
=======
      ethernet_frame_counter <= L1_LENGTH_OFFSET;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
      state <= STATE_COUNT_FRAME_LENGTH;
    end else begin
      case (state)
        STATE_COUNT_FRAME_LENGTH: begin
          if (s_axis_tvalid & s_axis_tready) begin
            if (s_axis_tlast) begin
<<<<<<< HEAD
              ethernet_frame_counter <= ethernet_frame_counter + 'd1 - TIMESTAMP_BYTES;
              state <= STATE_WRITE_FRAME_LENGTH;
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
=======
              ethernet_frame_counter <= ethernet_frame_counter + num_bytes - TIMESTAMP_BYTES;
              state <= STATE_WRITE_FRAME_LENGTH;
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + C_AXIS_TKEEP_WIDTH;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
              // Keep state
            end
          end else begin
            // Do nothing
          end
        end
        STATE_WRITE_FRAME_LENGTH: begin
          if (m_axis_frame_length_tvalid & m_axis_frame_length_tready) begin
<<<<<<< HEAD
            ethernet_frame_counter <= 'd0;
=======
            ethernet_frame_counter <= L1_LENGTH_OFFSET;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
            state <= STATE_COUNT_FRAME_LENGTH;
          end else begin
            // Do nothing
          end
        end
        default: begin
<<<<<<< HEAD
          ethernet_frame_counter <= 'd0;
=======
          ethernet_frame_counter <= L1_LENGTH_OFFSET;
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
          state <= STATE_COUNT_FRAME_LENGTH;
        end
      endcase
    end
  end

endmodule

`default_nettype wire
