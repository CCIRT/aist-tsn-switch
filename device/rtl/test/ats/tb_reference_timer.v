// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`timescale 1ns / 1ns

`default_nettype none

module tb_reference_timer;
  parameter VCD_FILENAME = "";
  parameter integer TIMESTAMP_WIDTH = 72;               // Must be aligned to DATA_WIDTH
  parameter integer CLOCK_PERIOD_PS = 8000;

  localparam integer TIMEOUT_CYCLE = 20000;
  localparam integer RESET_CYCLE = 10;

  localparam TIMESTAMP_WIDTH = 72;
  localparam CLOCK_PERIOD_PS = 8000;

  //-------------------------
  // Port definition
  //-------------------------
  // clock, negative-reset
  reg  clk;
  reg  rstn;
  // Reference clock output
  wire [TIMESTAMP_WIDTH-1:0] reference_timer_output;

  //-------------------------
  // Timer
  //-------------------------
  integer i = 0;
  initial begin
    clk = 0;
    rstn = 0;

    for (i = 0; i < TIMEOUT_CYCLE; i++) begin
      @(posedge clk);
      if (i == RESET_CYCLE) begin
        rstn = 1;
      end
    end

    $display("Test finished successfully.");
    #100
    $finish();
  end

  //-------------------------
  // Generate clock
  //-------------------------
  always clk = #10 ~clk;

  //-------------------------
  // Test module
  //-------------------------
  reference_timer #(
    .TIMESTAMP_WIDTH(TIMESTAMP_WIDTH),
    .CLOCK_PERIOD_PS(CLOCK_PERIOD_PS)
  ) reference_timer_i (
    clk,
    rstn,
    reference_timer_output
  );

  //-------------------------
  // Dump waveform
  //-------------------------
  initial
  begin
    $dumpfile(VCD_FILENAME);
    $dumpvars(0, reference_timer_i);
  end

endmodule

`default_nettype wire
