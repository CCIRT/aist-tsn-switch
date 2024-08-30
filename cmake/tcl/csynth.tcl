# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set not_exit 1

source $env(ENV_TCL_DIR)/create_hls_project.tcl

csynth_design
export_design \
  -display_name $env(ENV_NAME) \
  -description $env(ENV_DESCRIPTION) \
  -ipname $env(ENV_IPNAME) \
  -taxonomy $env(ENV_IP_TAXONOMY) \
  -vendor $env(ENV_IP_VENDOR) \
  -version $env(ENV_IP_VERSION)
exit
