# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# Set processing_delay_max

if {$argc < 1} {
  puts "Usage: xsdb $argv0 <processing_delay_max (ps)>"
  exit
}
set processing_delay_max [lindex $argv 0]

# Connect to FPGA
conn
# Set target "JTAG2AXI"
target 3

# Set variables
set wval1 [expr $processing_delay_max % 0x100000000]
set wval2 [expr [expr $processing_delay_max / 0x100000000] % 0x100000000]
set wval3 [expr $processing_delay_max / 0x10000000000000000]
mwr 0x00020000 $wval1
mwr 0x00020004 $wval2
mwr 0x00020008 $wval3

# Get variables
set rstr1 [mrd 0x00020000 1]
set rstr2 [mrd 0x00020004 1]
set rstr3 [mrd 0x00020008 1]
set radr1 [string range $rstr1 3 7]
set radr2 [string range $rstr2 3 7]
set radr3 [string range $rstr3 3 7]
set rval1 [string range $rstr1 12 19]
set rval2 [string range $rstr2 12 19]
set rval3 [string range $rstr3 12 19]
set value [expr 0x$rval1 + 0x$rval2 * 0x100000000 + 0x$rval3 * 0x10000000000000000]

puts [format "mrd $radr1 %s (%u)" 0x$rval1 0x$rval1 ]
puts [format "mrd $radr2 %s (%u)" 0x$rval2 0x$rval2 ]
puts [format "mrd $radr3 %s (%u)" 0x$rval3 0x$rval3 ]
puts "processing_delay_max: $value ps"
