# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

define_vivado(cbs-switch
  TOP         design_1_wrapper
  BOARD       *kc705*
  RTL         ${RTL_DIR}/src/channel_in_mod.v
<<<<<<< HEAD
=======
              ${RTL_DIR}/src/mactable_mod.v
              ${RTL_DIR}/src/mactable_dpcam_mod.v
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_example_design_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_fifo_block_mod.v
              ${BUILD_DIR}/tri_mode_ethernet_mac_0_ex/imports/
              ${3RDPARTY_DIR}/eth_switch/hdl/
<<<<<<< HEAD
  CONSTRAINT  ${CONSTRAINT_DIR}
              ${RTL_DIR}/src/kc705_hpc.xdc
=======
  CONSTRAINT  ${RTL_DIR}/src/kc705_hpc.xdc
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
              ${RTL_DIR}/src/rgmii-0123.xdc
  IP          ${IP_DIR}
  DESIGN      design_1.tcl
)
<<<<<<< HEAD
=======

define_vivado(cbs-switch-zedboard
  TOP         design_1_wrapper
  BOARD       *digilent*zedboard*
  RTL         ${RTL_DIR}/src/channel_in_mod.v
              ${RTL_DIR}/src/mactable_mod.v
              ${RTL_DIR}/src/mactable_dpcam_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_example_design_mod.v
              ${BUILD_DIR}/tri_mode_ethernet_mac_0_ex/imports/
              ${3RDPARTY_DIR}/eth_switch/hdl/
  CONSTRAINT  ${RTL_DIR}/src/rgmii-0123.xdc
              ${RTL_DIR}/../constraints/zedboard.xdc
  IP          ${IP_DIR}
  TCL0        ${CMAKE_CURRENT_SOURCE_DIR}/../common/install_zedboard_board_file.tcl
  TCL1        ${CMAKE_CURRENT_SOURCE_DIR}/../ats-switch/impl_strategy_zedboard.tcl
  TCL2        ${CMAKE_CURRENT_SOURCE_DIR}/patch_for_zedboard.tcl
  DESIGN      design_1.tcl
)

define_vivado(cbs-switch-zedboard-with-probes
  TOP         design_1_wrapper
  BOARD       *digilent*zedboard*
  RTL         ${RTL_DIR}/src/channel_in_mod.v
              ${RTL_DIR}/src/mactable_mod.v
              ${RTL_DIR}/src/mactable_dpcam_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v
              ${RTL_DIR}/src/tri_mode_ethernet_mac_0_example_design_mod.v
              ${BUILD_DIR}/tri_mode_ethernet_mac_0_ex/imports/
              ${3RDPARTY_DIR}/eth_switch/hdl/
  CONSTRAINT  ${RTL_DIR}/src/rgmii-0123.xdc
              ${RTL_DIR}/../constraints/zedboard.xdc
  IP          ${IP_DIR}
  TCL0        ${CMAKE_CURRENT_SOURCE_DIR}/../common/install_zedboard_board_file.tcl
  TCL1        ${CMAKE_CURRENT_SOURCE_DIR}/../ats-switch/impl_strategy_zedboard.tcl
  TCL2        ${CMAKE_CURRENT_SOURCE_DIR}/patch_for_zedboard.tcl
              ${CMAKE_CURRENT_SOURCE_DIR}/patch_for_with_probes.tcl
  DESIGN      design_1.tcl
)

define_vivado(cbs-switch-10g
  TOP         design_1_wrapper
  BOARD       xcu26-vsva1365-2LV-e
  RTL         ${RTL_DIR}/src/mactable_mod.v
              ${RTL_DIR}/src/mactable_dpcam_mod.v
              ${3RDPARTY_DIR}/eth_switch/hdl/
  CONSTRAINT  ${CONSTRAINT_DIR}/u45n.xdc
              ${CONSTRAINT_DIR}/u45n_bitstream_config.xdc
              ${CONSTRAINT_DIR}/u45n_timing.xdc
  IP          ${IP_DIR}
              ${3RDPARTY_DIR}/xg_mac/xg_mac
  DESIGN      design_1_10g.tcl
)
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
