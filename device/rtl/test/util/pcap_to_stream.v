// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none
`include "fatal.vh"

module pcap_to_stream #(
  parameter PCAP_FILENAME = "",
  parameter integer REPEAT_NUM = 1,
  parameter integer ENABLE_RANDAMIZE = 1,
  parameter integer MAX_RAND_INTERVAL = 4,
  parameter integer M_AXIS_TVALID_OUT_CYCLE = 20,
  parameter integer DATA_WIDTH = 8,
  parameter integer ENABLE_FRAME_LENGTH_HEADER = 0,
  parameter integer ENABLE_TIMESTAMP_FOOTER = 0,
  parameter integer FRAME_LENGTH_WIDTH = 16,
  parameter integer ETHERNET_FRAME_WIDTH = 1600 * 8,
  parameter integer TIMESTAMP_WIDTH = 72,
  parameter [TIMESTAMP_WIDTH-1:0] TIMESTAMP_VAL = 0
) (
  input wire                    clk,
  input wire                    rstn,
  output reg [DATA_WIDTH-1:0]   m_axis_tdata,
  output reg [DATA_WIDTH/8-1:0] m_axis_tkeep,
  output reg                    m_axis_tvalid,
  input wire                    m_axis_tready,
  output reg                    m_axis_tlast
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
    m_axis_tdata = 0;
    m_axis_tlast = 0;
    m_axis_tvalid = 0;

    // Wait until reset is done...
    @(posedge rstn);

    // Add delay
    for (j = 0; j < 10; j++) begin
      @(posedge clk);
    end

    // Start transfer
    for (i = 0; i < REPEAT_NUM; i++) begin
      for (j = 0; j < frame_length; j += BYTES_PER_CYCLE) begin
        m_axis_tdata <= 0;
        m_axis_tlast <= 0;
        m_axis_tvalid <= 0;

        if (ENABLE_RANDAMIZE)  begin
          randval = $random % MAX_RAND_INTERVAL;
          for (k = 0; k < randval; k++) begin
            @(posedge clk);
          end
        end

        for (int k = 0; k < BYTES_PER_CYCLE; k++) begin
          if (j + k < frame_length) begin
            m_axis_tdata[k * 8 +: 8] <= data[j + k];
            m_axis_tkeep[k] <= 1'b1;
          end else begin
            m_axis_tdata[k * 8 +: 8] <= 8'h0;
            m_axis_tkeep[k] <= 1'b0;
          end
        end
        m_axis_tlast <= (j >= frame_length - BYTES_PER_CYCLE) ? 1 : 0;
        m_axis_tvalid <= 1;
        @(posedge clk);

        while (!m_axis_tready) begin
          @(posedge clk);
        end

        m_axis_tdata <= 0;
        m_axis_tlast <= 0;
        m_axis_tvalid <= 0;
      end
    end
  end
endmodule

`default_nettype wire
