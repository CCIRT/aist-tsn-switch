// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`default_nettype none

module register_slice #(
  parameter DATA_WIDTH = 1
)(
  input  wire                  clk,
  input  wire [DATA_WIDTH-1:0] data_in,
  output reg  [DATA_WIDTH-1:0] data_out
);

  always @ (posedge clk) begin
    data_out <= data_in;
  end

endmodule

`default_nettype wire
