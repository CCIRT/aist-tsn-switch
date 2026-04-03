// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module compare_stream_with_pcap #(
  parameter PCAP_FILENAME = "",
  parameter integer REPEAT_NUM = 1,
  parameter integer ENABLE_RANDAMIZE = 1,
  parameter integer MAX_RAND_INTERVAL = 4,
  parameter integer S_AXIS_TREADY_OUT_CYCLE = 20,
  parameter integer DATA_WIDTH = 8,
  parameter integer ENABLE_FRAME_LENGTH_HEADER = 0,
  parameter integer ENABLE_TIMESTAMP_FOOTER = 0,
  parameter integer FRAME_LENGTH_WIDTH = 16,
  parameter integer ETHERNET_FRAME_WIDTH = 1600 * 8,
  parameter integer TIMESTAMP_WIDTH = 72,
  parameter integer COMPARE_WITH_FRAME_LENGTH = 0,
  parameter integer COMPARE_WITH_TIMESTAMP = 0,
  parameter [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 0
) (
  input wire                    clk,
  input wire                    rstn,
  input wire [DATA_WIDTH-1:0]   s_axis_tdata,
  input wire [DATA_WIDTH/8-1:0] s_axis_tkeep,
  input wire                    s_axis_tvalid,
  output reg                    s_axis_tready,
  input wire                    s_axis_tlast
);

  localparam BUF_DEPTH = (ETHERNET_FRAME_WIDTH + FRAME_LENGTH_WIDTH + TIMESTAMP_WIDTH) / 8;
  localparam BYTES_PER_CYCLE = DATA_WIDTH / 8;

  reg [7:0]                   data_buf;
  reg [7:0]                   data[BUF_DEPTH-1:0];

  integer fd, i, j, k, randval, num;
  integer frame_length = 0;

  initial begin
    // add header if exists
    if (ENABLE_FRAME_LENGTH_HEADER) begin
      // allocate region of frame length
      frame_length = FRAME_LENGTH_WIDTH / 8;
    end

    // Open pcap file
    fd = $fopen(PCAP_FILENAME, "rb");
    if (fd == 0) begin
      $display("Error: Cannot open pcap file '%s'", PCAP_FILENAME);
      `FATAL;
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

    // update header value
    if (ENABLE_FRAME_LENGTH_HEADER) begin
      // get true frame length
      frame_length -= FRAME_LENGTH_WIDTH / 8;
      for (i = 0; i < FRAME_LENGTH_WIDTH / 8; i++) begin
        data[i] = frame_length[i * 8 +: 8];
      end
      // restore frame length
      frame_length += FRAME_LENGTH_WIDTH / 8;
    end

    // add footer if exists
    if (ENABLE_TIMESTAMP_FOOTER) begin
      for (i = 0; i < TIMESTAMP_WIDTH / 8; i++) begin
        data[frame_length] = TIMESTAMP_VAL[i * 8 +: 8];
        frame_length++;
      end
    end

    // reset signals
    s_axis_tready = 0;

    // Wait until reset is done...
    @(posedge rstn);

    // Add delay
    for (j = 0; j < 10; j++) begin
      @(posedge clk);
    end

    // Start receive
    for (i = 0; i < REPEAT_NUM; i++) begin
      for (j = 0; j < frame_length; j += BYTES_PER_CYCLE) begin
        s_axis_tready <= 0;

        if (ENABLE_RANDAMIZE)  begin
          randval = $random % MAX_RAND_INTERVAL;
          for (k = 0; k < randval; k++) begin
            @(posedge clk);
          end
        end

        s_axis_tready <= 1;
        @(posedge clk);

        while (!s_axis_tvalid) begin
          @(posedge clk);
        end

        for (k = 0; k < BYTES_PER_CYCLE; k++) begin
          if (ENABLE_TIMESTAMP_FOOTER && COMPARE_WITH_TIMESTAMP == 0 && j + k >= frame_length - TIMESTAMP_WIDTH / 8) begin
            // do not compare
          end else if (ENABLE_FRAME_LENGTH_HEADER && COMPARE_WITH_FRAME_LENGTH == 0 && j + k < FRAME_LENGTH_WIDTH / 8) begin
            // do not compare
          end else if (j + k < frame_length) begin
            if (s_axis_tdata[k * 8 +: 8] !== data[j + k]) begin
              $display("Error: s_axis_tdata[%d +: 8] != data[%d]", k * 8, j + k);
              $display("  s_axis_tdata[%d +: 8] = 0x%h", k * 8, s_axis_tdata[k * 8 +: 8]);
              $display("  data[%d] = 0x%h", j + k, data[j + k]);
              `FATAL;
            end
            if (s_axis_tkeep[k] !== 1'b1) begin
              $display("Error: s_axis_tkeep[%d] is not asserted.", k);
              `FATAL;
            end
          end else begin // if (j + k < frame_length)
            if (s_axis_tkeep[k] !== 1'b0) begin
              $display("Error: s_axis_tkeep[%d] is assserted after frame length", s_axis_tkeep);
              `FATAL;
            end
          end
        end

        // Data received. do validation
        if (j >= frame_length - BYTES_PER_CYCLE) begin
          if (!s_axis_tlast) begin
            $display("Error: s_axis_tlast is not asserted at the last beat. j = %d, frame_length = %d", j, frame_length);
            `FATAL;
          end
        end else begin
          if (s_axis_tlast) begin
            $display("Error: s_axis_tlast is asserted even though it's not the last beat., j = %d, frame_length = %d", j, frame_length);
            `FATAL;
          end
        end

        s_axis_tready <= 0;
      end
    end

    $display("Test finished successfully.");
    for (int i = 0; i < 10; i++) begin
      @(posedge clk);
    end
    $finish();
  end

endmodule

`default_nettype wire
