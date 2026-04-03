// Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
// All rights reserved.
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php

`ifndef FATAL_VH
`define FATAL_VH

`ifdef __ICARUS__
 `define FATAL #300; $display("FATAL: %s:%d:", `__FILE__, `__LINE__); $finish_and_return(1)
`else
 `define FATAL #300; $fatal()
`endif

`endif
