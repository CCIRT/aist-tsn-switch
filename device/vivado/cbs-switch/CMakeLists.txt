# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

define_vivado(cbs-switch
  TOP         design_1_wrapper
  BOARD       *kc705*
  RTL         ${RTL_DIR}/src/channel_in_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_example_design_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_fifo_block_mod.v
              ${BUILD_DIR}/tri_mode_ethernet_mac_0_ex/imports/
              ${3RDPARTY_DIR}/eth_switch/hdl/
  CONSTRAINT  ${CONSTRAINT_DIR}
              ${RTL_DIR}/src/kc705_hpc.xdc
              ${RTL_DIR}/src/rgmii-0123.xdc
  IP          ${IP_DIR}
  DESIGN      design_1.tcl
)
