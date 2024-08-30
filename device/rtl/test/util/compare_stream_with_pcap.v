// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module compare_stream_with_pcap #(
  parameter PCAP_FILENAME = "",
  parameter integer REPEAT_NUM = 1,
  parameter integer ENABLE_RANDAMIZE = 1,
  parameter integer S_AXIS_TREADY_OUT_CYCLE = 20,
  parameter integer DATA_WIDTH = 8,
  parameter integer ENABLE_FRAME_LENGTH_HEADER = 0,
  parameter integer ENABLE_TIMESTAMP_FOOTER = 0,
  parameter integer FRAME_LENGTH_WIDTH = 16,                  // Must be aligned to DATA_WIDTH
  parameter integer ETHERNET_FRAME_WIDTH = 1600 * DATA_WIDTH, // Must be aligned to DATA_WIDTH
  parameter integer TIMESTAMP_WIDTH = 72,                     // Must be aligned to DATA_WIDTH
  parameter integer COMPARE_WITH_FRAME_LENGTH = 0,
  parameter integer COMPARE_WITH_TIMESTAMP = 0,
  parameter [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 0
) (
  input  wire clk,
  input  wire rstn,
  input  wire [DATA_WIDTH-1:0] s_axis_tdata,
  input  wire                  s_axis_tvalid,
  output wire                  s_axis_tready,
  input  wire                  s_axis_tlast
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
  reg                  s_axis_tready_reg = 0;
  reg                  output_enable_reg = 0;

  integer fd, i, j, num;
  integer frame_length_ref = 0;
  integer repeat_counter = 0;

  assign s_axis_tready = (ENABLE_RANDAMIZE == 0)? s_axis_tready_reg: s_axis_tready_reg & output_enable_reg;

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
      data[frame_length_ref] = data_buf;
      frame_length_ref++;
    end
    frame_length_ref--;

    // Close pcap file
    $fclose(fd);

    // Control s_axis_tready_reg
    for (i = 0; 1; i++) begin
      @(posedge clk);
      if (i == S_AXIS_TREADY_OUT_CYCLE) begin
        s_axis_tready_reg = 1'b1;
      end else if (repeat_counter == REPEAT_NUM) begin
        s_axis_tready_reg = 1'b0;
      end
    end
  end

  // Control output_enable_reg
  initial begin
    while (1) begin
      for (j = 0; j < 20; j++) begin
        @(posedge clk);
      end
      output_enable_reg = ~output_enable_reg;
    end
  end

  // Utility wires
  wire stream_incoming = s_axis_tvalid & s_axis_tready;

  // Watch s_axis_tlast
  always @ (posedge clk) begin
    if (stream_incoming) begin
      if ((ENABLE_TIMESTAMP_FOOTER == 0 && state == STATE_READ_ETHERNET_FRAME && ethernet_frame_counter == frame_length_ref - 1) |
          (state == STATE_READ_TIMESTAMP && timestamp_counter == TIMESTAMP_BEAT_NUM - 1)) begin
        if (!s_axis_tlast) begin
          $display("Error: s_axis_tlast is not asserted at the last beat.");
          $fatal();
        end else begin
          // Continue testing
        end
      end else begin
        if (s_axis_tlast) begin
          $display("Error: s_axis_tlast is asserted even though it's not the last beat.");
          $fatal();
        end else begin
          // Continue testing
        end
      end
    end else begin
      // Do nothing
    end
  end

  // Main state
  reg [STATE_WIDTH-1:0] state = 'd0;
  localparam STATE_WIDTH = 2;
  localparam STATE_READ_FRAME_LENGTH = 0;
  localparam STATE_READ_ETHERNET_FRAME = 1;
  localparam STATE_READ_TIMESTAMP = 2;
  // Important registers
  reg [FRAME_LENGTH_WIDTH-1:0] frame_length = 'd0;
  reg [FRAME_LENGTH_COUNTER_WIDTH-1:0] frame_length_counter = 'd0;
  reg [ETHERNET_FRAME_COUNTER_WIDTH-1:0] ethernet_frame_counter = 'd0;
  reg [TIMESTAMP_WIDTH-1:0] timestamp = 'd0;
  reg [TIMESTAMP_COUNTER_WIDTH-1:0] timestamp_counter = 'd0;
  // State machine
  always @ (posedge clk) begin
    if (!rstn) begin
      repeat_counter <= 'd0;
      frame_length_counter <='d0;
      ethernet_frame_counter <='d0;
      timestamp_counter <= 'd0;
      if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
        state <= STATE_READ_FRAME_LENGTH;
      end else begin
        state <= STATE_READ_ETHERNET_FRAME;
      end
    end else begin
      case (state)
        STATE_READ_FRAME_LENGTH: begin
          if (stream_incoming) begin
            if (frame_length_counter == 'd0) begin
              frame_length <= s_axis_tdata;
            end else begin
              frame_length <= s_axis_tdata << (DATA_WIDTH * frame_length_counter) | frame_length;
            end
            #1
            if (frame_length_counter == FRAME_LENGTH_BEAT_NUM - 1) begin
              if (COMPARE_WITH_FRAME_LENGTH != 0) begin
                // Check frame_length is same as reference
                if (frame_length != frame_length_ref) begin
                  $display("Error: frame_length != frame_length_ref");
                  $display("  frame_length = %d", frame_length);
                  $display("  frame_length_ref = %d", frame_length_ref);
                  $fatal();
                end else begin
                  // Continue testing
                end
              end
              frame_length_counter <= 'd0;
              state <= STATE_READ_ETHERNET_FRAME;
            end else begin
              frame_length_counter <= frame_length_counter + 'd1;
            end
          end
        end
        STATE_READ_ETHERNET_FRAME: begin
          if (stream_incoming) begin
            // Check input data is same as reference
            if (s_axis_tdata !== data[ethernet_frame_counter]) begin
              $display("Error: s_axis_tdata != data[%d]", ethernet_frame_counter);
              $display("  s_axis_tdata = 0x%h", s_axis_tdata);
              $display("  data[%d] = 0x%h", ethernet_frame_counter, data[ethernet_frame_counter]);
              $fatal();
            end else begin
              // Continue testing
            end
            if (ethernet_frame_counter == frame_length_ref - 1) begin
              ethernet_frame_counter <= 'd0;
              if (ENABLE_TIMESTAMP_FOOTER != 0) begin
                state <= STATE_READ_TIMESTAMP;
              end else begin
                if (repeat_counter == REPEAT_NUM - 1) begin
                  $display("Test finished successfully.");
                  #100
                  $finish();
                end else begin
                  repeat_counter++;
                end
                if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
                  state <= STATE_READ_FRAME_LENGTH;
                end else begin
                  state <= STATE_READ_ETHERNET_FRAME;
                end
              end
            end else begin
              ethernet_frame_counter <= ethernet_frame_counter + 'd1;
            end
          end
        end
        STATE_READ_TIMESTAMP: begin
          if (stream_incoming) begin
            if (timestamp_counter == 'd0) begin
              timestamp <= s_axis_tdata;
            end else begin
              timestamp <= s_axis_tdata << (DATA_WIDTH * timestamp_counter) | timestamp;
            end
            #1
            if (timestamp_counter == TIMESTAMP_BEAT_NUM - 1) begin
              if (COMPARE_WITH_TIMESTAMP != 0) begin
                // Check timestamp is same as reference
                if (timestamp != TIMESTAMP_VAL) begin
                  $display("Error: timestamp != TIMESTAMP_VAL");
                  $display("  timestamp = 0x%h", timestamp);
                  $display("  timestamp_ref = 0x%h", TIMESTAMP_VAL);
                  $fatal();
                end else begin
                  // Continue testing
                end
              end
              timestamp_counter <= 'd0;
              if (repeat_counter == REPEAT_NUM - 1) begin
                $display("Test finished successfully.");
                #100
                $finish();
              end else begin
                repeat_counter++;
              end
              if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
                state <= STATE_READ_FRAME_LENGTH;
              end else begin
                state <= STATE_READ_ETHERNET_FRAME;
              end
            end else begin
              timestamp_counter <= timestamp_counter + 'd1;
            end
          end
        end
        default: begin
          frame_length_counter <='d0;
          ethernet_frame_counter <='d0;
          timestamp_counter <= 'd0;
          if (ENABLE_FRAME_LENGTH_HEADER != 0) begin
            state <= STATE_READ_FRAME_LENGTH;
          end else begin
            state <= STATE_READ_ETHERNET_FRAME;
          end
        end
      endcase
    end
  end

endmodule

`default_nettype wire
