# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

puts "momo"
set do_exit 1
if { [info exists not_exit] } {
  set do_exit 0
}

open_project $env(ENV_PROJECT_NAME)

set src [string trim [string map {";" " "} $env(ENV_SOURCES)]]
set cflags [string map {";" " "} $env(ENV_CFLAGS)]
set tbsrc [string trim [string map {";" " "} $env(ENV_TB_SOURCES)]]
set tbcflags [string map {";" " "} $env(ENV_TB_CFLAGS)]

if { "$src" != "" } {
  add_files -cflags "$cflags" $src
}

if { "$tbsrc" != "" } {
  add_files -tb -cflags "$tbcflags" $tbsrc
}

set_top $env(ENV_TOP)
open_solution $env(ENV_SOLUTION_NAME) -flow_target vivado
set_part $env(ENV_PART)
create_clock -period $env(ENV_PERIOD) -name default

if { $do_exit == 1 } {
  exit
}
