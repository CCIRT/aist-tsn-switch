# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

proc set_priority_mapper {priority traffic_class} {
    if {$priority <= 8} {
      for {set base_address 0x50000000} {$base_address <= 0x500F0000} {set base_address [expr $base_address + 0x10000]} {
        set address [expr $base_address + [expr $priority * 0x00004]]
        set value [mwr $address $traffic_class]
      }
    }
}

proc get_priority_mapper {} {
  for {set base_address 0x50000000} {$base_address <= 0x50030000} {set base_address [expr $base_address + 0x10000]} {
    # PCP0
    set address [expr $base_address + 0x00000]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP1
    set address [expr $base_address + 0x00004]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP2
    set address [expr $base_address + 0x00008]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP3
    set address [expr $base_address + 0x0000C]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP4
    set address [expr $base_address + 0x00010]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP5
    set address [expr $base_address + 0x00014]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP6
    set address [expr $base_address + 0x00018]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # PCP7
    set address [expr $base_address + 0x0001C]
    set value [mrd $address 1]
    puts -nonewline "mrd $value"
    # no VLAN TAG
    set address [expr $base_address + 0x00020]
    set value [mrd $address 1]
    puts "mrd $value"
  }
}

# Set priority_mapper_default for all ATS modules

if {$argc < 1} {
  puts "Usage: xsdb $argv0 <priority_mapper_default> (<priority_mapper_pcp3>) (<priority_mapper_pcp2>)"
  exit
}
set priority_mapper_default [lindex $argv 0]
if {$argc >= 2} {
  set priority_mapper_pcp3 [lindex $argv 1]
}
if {$argc >= 3} {
  set priority_mapper_pcp2 [lindex $argv 2]
}

# Connect to FPGA
conn
# Set target "JTAG2AXI"
target 3

# Set variables to all CBS modules
set_priority_mapper 8 $priority_mapper_default

if {$argc >= 2} {
  set_priority_mapper 3 $priority_mapper_pcp3
}

if {$argc >= 3} {
  set_priority_mapper 2 $priority_mapper_pcp2
}

# Get variables
get_priority_mapper
