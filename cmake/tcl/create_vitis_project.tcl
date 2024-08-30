# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set ws        [lindex $argv 0]
set project   [lindex $argv 1]
set platform  [lindex $argv 2]
set domain    [lindex $argv 3]
set os        [lindex $argv 4]
set proc      [lindex $argv 5]
set xsa_file  [lindex $argv 6]
set build_mode  [lindex $argv 7]
set linker_script [lindex $argv 8]


set src [split [string map {";" " "} $env(ENV_SRC)] " "]
set incdir [split [string map {";" " "} $env(ENV_INC)] " "]
set defs [split [string map {";" " "} $env(ENV_DEFS)] " "]
set tcl0 [split [string map {";" " "} $env(ENV_TCL0)] " "]
set tcl1 [split [string map {";" " "} $env(ENV_TCL1)] " "]
set tcl2 [split [string map {";" " "} $env(ENV_TCL2)] " "]

# set workspace
setws ${ws}

# TCL0 user script
foreach f $tcl0 {
  puts "Source TCL0 $f"
  source $f
}

# Define platform
platform create \
  -name ${platform} \
  -hw ${xsa_file}

domain create \
  -name ${domain} \
  -display-name ${domain} \
  -os ${os} \
  -proc ${proc} \
  -runtime {cpp}

platform active ${platform}
platform generate

# project
app create \
  -name $project \
  -platform ${platform} \
  -domain ${domain} \
  -template {Empty Application (C++)} \
  -lang {c++}

foreach f $src {
  importsources -name $project -path $f -soft-link
}

foreach bc {Debug Release} {
  app config -name $project -set build-config $bc
  foreach d $incdir {
    app config -name $project -add include-path $d
  }

  foreach d $defs {
    app config -name $project -add define-compiler-symbols $d
  }
}

# TCL1 user script
foreach f $tcl1 {
  puts "Source TCL1 $f"
  source $f
}

app config -name $project -set build-config ${build_mode}

if { "$linker_script" != "" } {
  app config -name $project -set linker-script ${linker_script}
}

# TCL2 user script
foreach f $tcl2 {
  puts "Source TCL3 $f"
  source $f
}
