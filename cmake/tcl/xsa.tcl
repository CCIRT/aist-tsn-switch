# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set project_name      [lindex $argv 0]
set project_directory [lindex $argv 1]
set xsafile           [lindex $argv 2]

open_project ${project_directory}/${project_name}.xpr
write_hw_platform \
  -fixed \
  -include_bit \
  -force \
  -file $xsafile

close_project
