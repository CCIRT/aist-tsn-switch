# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set project_name      [lindex $argv 0]
set project_directory [lindex $argv 1]
set jobs              [lindex $argv 2]

proc runImpl {run jobsize} {
  set name [get_property NAME $run]
  set isImpl [get_property IS_IMPLEMENTATION  $run]
  set isIncArchive [get_property INCLUDE_IN_ARCHIVE $run]
  set stat [get_property STATUS $run]
  if { $isImpl == 1 && $isIncArchive == 1 && $stat != "write_bitstream Complete!" } {
      puts "INFO: Run $name"
      launch_runs $run -jobs $jobsize -to_step write_bitstream
      wait_on_run $run
      set stat [get_property STATUS $run]
      if {$stat != "write_bitstream Complete!"} {
        puts "------------- Fail implements:$name: $stat --------------"
        exit 1
      }
      puts "Result:$name: $stat"
  } else {
    puts "INFO: Skip $name"
  }
}


open_project ${project_directory}/${project_name}.xpr
set impls [split [string map {";" " "} $env(ENV_IMPLEMENTS)] " "]

if { "$impls" == "" } {
  foreach r [get_runs] {
    runImpl $r $jobs
  }
} else {
  foreach rname $impls {
    set r [get_runs $rname]
    runImpl $r $jobs
  }
}
