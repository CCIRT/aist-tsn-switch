// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module pcap_to_stream #(
  parameter PCAP_FILENAME = "",
  parameter integer REPEAT_NUM = 1,
  parameter integer ENABLE_RANDAMIZE = 1,
  parameter integer M_AXIS_TVALID_OUT_CYCLE = 20,
  parameter integer DATA_WIDTH = 8,
  parameter integer ENABLE_FRAME_LENGTH_HEADER = 0,
  parameter integer ENABLE_TIMESTAMP_FOOTER = 0,
  parameter integer FRAME_LENGTH_WIDTH = 16,                  // Must be aligned to DATA_WIDTH
  parameter integer ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH, // Must be aligned to DATA_WIDTH
  parameter integer TIMESTAMP_WIDTH = 72,                     // Must be aligned to DATA_WIDTH
  parameter [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 0
) (
  input  wire clk,
  input  wire rstn,
  output wire [DATA_WIDTH-1:0] m_axis_tdata,
  output wire                  m_axis_tvalid,
  input  wire                  m_axis_tready,
  output wire                  m_axis_tlast
);

  // Parameter for frame_length
  localparam FRAME_LENGTH_BEAT_NUM = FRAME_LENGTH_WIDTH / DATA_WIDTH;
  localparam FRAME_LENGTH_COUNTER_WIDTH = $clog2(FRAME_LENGTH_BEAT_NUM);
  // Parameter for ethernet_frame
  localparam ETHERNET_FRAME_BEAT_NUM = ETHERNET_FRAME_WIDTH / DATA_WIDTH;
  localparam ETHERNET_FRAME_COUNTER_WIDTH = $clog2(ETHERNET_FRAME_BEAT_NUM);
  // Parameter for timestamp
  localparam TIMESTAMP_BEAT_NUM = TIMESTAMP_WIDTH / DATA_WIDTH;
  localparam TIMESTAMP_COUNTER_WIDTH = $clog2(TIMESTAMP_BEAT_NUM);

  reg [DATA_WIDTH-1:0] data_buf;
  reg [DATA_WIDTH-1:0] data[ETHERNET_FRAME_BEAT_NUM-1:0];
  reg                  m_axis_tvalid_reg = 0;
  reg                  output_enable_reg = 0;

  integer fd, i, j, num;
  integer frame_length = 0;
  integer repeat_counter = 0;

  assign #1 m_axis_tdata  = (state == STATE_WRITE_FRAME_LENGTH)?   frame_length >> (DATA_WIDTH * frame_length_counter) :
                            (state == STATE_WRITE_ETHERNET_FRAME)? data[ethernet_frame_counter]:
                            (state == STATE_WRITE_TIMESTAMP)?      TIMESTAMP_VAL >> (DATA_WIDTH * timestamp_counter): 'd0;
  assign #1 m_axis_tvalid = (ENABLE_RANDAMIZE == 0)? m_axis_tvalid_reg: m_axis_tvalid_reg & output_enable_reg;
  assign #1 m_axis_tlast  = (ENABLE_TIMESTAMP_FOOTER != 0)? (state == STATE_WRITE_TIMESTAMP & timestamp_counter == TIMESTAMP_BEAT_NUM - 1):
                                                            (state == STATE_WRITE_ETHERNET_FRAME & ethernet_frame_counter == frame_length - 1);

  initial begin
    // Open pcap file
    fd = $fopen(PCAP_FILENAME, "rb");
    if (fd == 0) begin
      $display("Error: Cannot open pcap file '%s'", PCAP_FILENAME);
      $finish;
    end

    // Drop initial 40 Bytes
    for (i = 0; i < 40; i++) begin
      num = $fread(data_buf, fd);
    end

    // Store data until end of file
    while($feof(fd) == 0) begin
      num = $fread(data_buf, fd);
      data[frame_length] = data_buf;
      frame_length++;
    end
    frame_length--;

    // Close pcap file
    $fclose(fd);

    // Control m_axis_tvalid_reg
    for (i = 0; 1; i++) begin
      @(posedge clk);
      if (i == M_AXIS_TVALID_OUT_CYCLE) begin
        m_axis_tvalid_reg = 1'b1;
      end else if ((m_axis_tvalid & m_axis_tready & m_axis_tlast) &&
                   (repeat_counter == REPEAT_NUM - 1)) begin
        m_axis_tvalid_reg = 1'b0;
      end
    end
  end

  // Control output_enable_reg
  initial begin
    while (1) begin
      for (j = 0; j < 10; j++) begin
        @(posedge clk);
      end
      output_enable_reg = ~output_enable_reg;
    end
  end

  // Utility wires
  wire stream_outgoing = m_axis_tvalid & m_axis_tready;

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_WRITE_FRAME_LENGTH = 0;
  localparam STATE_WRITE_ETHERNET_FRAME = 1;
  localparam STATE_WRITE_TIMESTAMP = 2;
  // Important registers
  reg [FRAME_LENGTH_COUNTER_WIDTH-1:0] frame_length_counter = 'd0;
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      repeat_counter <= 'd0;
      frame_length_counter <='d0;
      ethernet_frame_counter <='d0;
      timestamp_counter <= 'd0;
      if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
        state <= STATE_WRITE_FRAME_LENGTH;
      end else begin
        state <= STATE_WRITE_ETHERNET_FRAME;
      end
    end else begin
      case (state)
        STATE_WRITE_FRAME_LENGTH: begin
          if (stream_outgoing) begin
            if (frame_length_counter == FRAME_LENGTH_BEAT_NUM - 1) begin
              #1 frame_length_counter <= 'd0;
              #1 state <= STATE_WRITE_ETHERNET_FRAME;
            end else begin
              #1 frame_length_counter <= frame_length_counter + 'd1;
            end
          end
        end
        STATE_WRITE_ETHERNET_FRAME: begin
          if (stream_outgoing) begin
            if (ethernet_frame_counter == frame_length - 1) begin
              #1 ethernet_frame_counter <= 'd0;
              if (ENABLE_TIMESTAMP_FOOTER != 0) begin
                #1 state <= STATE_WRITE_TIMESTAMP;
              end else begin
                repeat_counter++;
                if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
                  #1 state <= STATE_WRITE_FRAME_LENGTH;
                end else begin
                  #1 state <= STATE_WRITE_ETHERNET_FRAME;
                end
              end
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
            end
          end
        end
        STATE_WRITE_TIMESTAMP: begin
          if (stream_outgoing) begin
            if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
              #1 timestamp_counter <= 'd0;
              #1 repeat_counter++;
              if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
                #1 state <= STATE_WRITE_FRAME_LENGTH;
              end else begin
                #1 state <= STATE_WRITE_ETHERNET_FRAME;
              end
            end else begin
              #1 timestamp_counter <= timestamp_counter + 'd1;
            end
          end
        end
        default: begin
          frame_length_counter <='d0;
          ethernet_frame_counter <='d0;
          timestamp_counter <= 'd0;
          if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
            state <= STATE_WRITE_FRAME_LENGTH;
          end else begin
            state <= STATE_WRITE_ETHERNET_FRAME;
          end
        end
      endcase
    end
  end

endmodule

`default_nettype wire
