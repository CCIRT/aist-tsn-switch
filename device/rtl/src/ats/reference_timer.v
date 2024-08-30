// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module reference_timer #(
  parameter TIMESTAMP_WIDTH = 72,
  parameter CLOCK_PERIOD_PS = 8000
) (
  // clock, negative-reset
  input  wire clk,
  input  wire rstn,
  // Reference timer output
  output reg  [TIMESTAMP_WIDTH-1:0] reference_timer_output
);

  always @ (posedge clk) begin
    if (!rstn) begin
      reference_timer_output <= 'd0;
    end else begin
      reference_timer_output <= reference_timer_output + CLOCK_PERIOD_PS;
    end
  end

endmodule

`default_nettype wire
