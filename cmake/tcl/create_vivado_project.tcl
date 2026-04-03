# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set project_name      [lindex $argv 0]
set project_directory [lindex $argv 1]
set board_part        [lindex $argv 2]
set full_path         [lindex $argv 3]
set top_module_name   [lindex $argv 4]
# source_directory: CMakeLists.txt directory
set source_directory  [lindex $argv 5]
# repository top directory
set root              [lindex $argv 6]
set design_bd_name    [lindex $argv 7]

# load user script (TCL0)
set tcl0 [split [string map {";" " "} $env(ENV_TCL0)] " "]
set tcl1 [split [string map {";" " "} $env(ENV_TCL1)] " "]
set tcl2 [split [string map {";" " "} $env(ENV_TCL2)] " "]

foreach file $tcl0 {
  if { [file exists ${file}] } {
    source ${file}
  } else {
    puts "ERROR!! Source file ${file} not found"
    exit 1
  }
}

# if board part contains `*`, search board part.
if { [string first "*" $board_part] != -1 } {
  set find_board_part [get_board_parts -quiet -latest_file_version $board_part]
  if { $find_board_part eq "" } {
    puts "ERROR: `$board_part` board part is not found"
    exit 1
  }
  puts "INFO: Board parts: `$board_part` -> `$find_board_part`"
  set board_part $find_board_part

  create_project -force $project_name $project_directory
  set_property board $board_part [current_project]
} else {
  create_project -force $project_name $project_directory
  set_property part $board_part [current_project]
}

set ipdir [string trim [string map {";" " "} $env(ENV_IP)] ]
if { "$ipdir" != "" } {
  set_property IP_REPO_PATHS $ipdir [current_fileset]
}
update_ip_catalog

set rtl [string trim [string map {";" " "} $env(ENV_RTL)] ]
if { $rtl != "" } {
  add_files $rtl
}

set cst [string trim [string map {";" " "} $env(ENV_CONSTRAINT)] ]
if { $cst != "" } {
  add_files -fileset constrs_1 $cst
}

# load user script (TCL1)
foreach file $tcl1 {
  if { [file exists ${file}] } {
    source ${file}
  } else {
    puts "ERROR!! Source file ${file} not found"
    exit 1
  }
}

# load design file
set design [string trim $env(ENV_DESIGN)]
if { "$design" != "" } {
  if { [file exists $design ] == 1 } {
    source $design
    regenerate_bd_layout
    save_bd_design
    set bd_files [get_files $design_bd_name.bd]
    puts $bd_files
    generate_target all $bd_files
    if { "$top_module_name" == "${design_bd_name}_wrapper" } {
      make_wrapper -files $bd_files -top -import
    }
  } else {
    puts "Skip load design: $design"
  }
}

if { "$top_module_name" != "" } {
  set_property top ${top_module_name} [current_fileset]
}

# load user script (TCL2)
foreach file $tcl2 {
  if { [file exists ${file}] } {
    source ${file}
  } else {
    puts "ERROR!! Source file ${file} not found"
    exit 1
  }
}

close_project

puts "Create Project: ${full_path}"
