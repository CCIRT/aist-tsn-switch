# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

if {$argc < 2} {
  puts "Usage: xsdb $argv0 <idle_slope TC7> <send_slope TC7> (<idle_slope TC6> <send_slope TC6>) (<hi_credit> <lo_credit>)"
  exit
}
set idle_slope [lindex $argv 0]
set send_slope [lindex $argv 1]

if {$argc >= 4} {
  set idle_slope2 [lindex $argv 2]
  set send_slope2 [lindex $argv 3]
} else {
  set idle_slope2 [lindex $argv 0]
  set send_slope2 [lindex $argv 1]
}

if {$argc == 6} {
  set hi_credit [lindex $argv 4]
  set lo_credit [lindex $argv 5]
} else {
  set hi_credit 0x7FFFFFFF
  set lo_credit 0x80000000
}

# Connect to FPGA
conn
# Set target "JTAG2AXI"
target 3

# Set variables to all CBS modules
for {set base_address 0x40000000} {$base_address <= 0x400C0000} {set base_address [expr $base_address + 0x40000]} {
  # Slopes of Traffic class 6 
  mwr [expr $base_address + 0x00000] $idle_slope2
  mwr [expr $base_address + 0x00008] $send_slope2
  # Slopes of Traffic class 7
  mwr [expr $base_address + 0x20000] $idle_slope
  mwr [expr $base_address + 0x20008] $send_slope
}

if {$argc >= 4} {
  # Set variables to all CBS modules
  for {set base_address 0x40000000} {$base_address <= 0x400C0000} {set base_address [expr $base_address + 0x40000]} {
    # Credits of Traffic class 6 
    mwr [expr $base_address + 0x10000] $hi_credit
    mwr [expr $base_address + 0x10008] $lo_credit
    # Credits of Traffic class 7
    mwr [expr $base_address + 0x30000] $hi_credit
    mwr [expr $base_address + 0x30008] $lo_credit
  }
}

for {set base_address 0x40000000} {$base_address <= 0x400C0000} {set base_address [expr $base_address + 0x40000]} {
  # Traffic class 6 
  set address [expr $base_address + 0x00000]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x00008]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x10000]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x10008]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  # Traffic class 7
  set address [expr $base_address + 0x20000]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x20008]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x30000]
  set value [mrd $address 1]
  puts -nonewline "mrd $value"
  set address [expr $base_address + 0x30008]
  set value [mrd $address 1]
  puts "mrd $value"
}
