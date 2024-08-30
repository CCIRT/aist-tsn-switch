# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

open_project $env(ENV_PROJECT_NAME)
open_solution $env(ENV_SOLUTION_NAME)

set ldflags ""
if { [info exists ::env(ENV_COSIM_LDFLAGS)] } {
  set ldflags [string map {";" " "} "$env(ENV_COSIM_LDFLAGS)"]
}

set tlevel "none"
# default setting
if { [info exists ::env(ENV_COSIM_TRACE_LEVEL)] } {
  set tmp [string trim $env(ENV_COSIM_TRACE_LEVEL)]
  if { $tmp != "" } {
    set tlevel $tmp
  }
}

# user environment variable
# make TLEVEL=all cosim_foobar
if { [info exists ::env(TLEVEL)] } {
  set tmp [string trim $env(TLEVEL)]
  if { $tmp != "" } {
    set tlevel $tmp
  }
}

set argv ""
# make ARGV="-foo -bar" cosim_foobar
if { [info exists ::env(ARGV)] } {
  set tmp [string trim $env(ARGV)]
  if { $tmp != "" } {
    set argv $tmp
  }
}

cosim_design -O \
    -ldflags "$ldflags" \
    -rtl verilog \
    -tool xsim \
    -trace_level $tlevel \
    -argv "$argv"
exit
