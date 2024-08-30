# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

if {$argc < 1} {
  puts "Usage: xsdb $argv0 <flow_control_enable> (<drop_enable>)"
  exit
}

# Connect to FPGA
conn
# Set target "JTAG2AXI"
target 3

mwr 0x40100000 [lindex $argv 0]
if {$argc == 2} {
  mwr 0x40100008 [lindex $argv 1]
}
