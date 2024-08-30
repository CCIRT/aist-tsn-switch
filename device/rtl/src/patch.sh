# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php                                                            |

#! /bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <TEMAC_EXAMPLE_DIR>"
fi

CURRENT_DIR=$(cd $(dirname $0);pwd)
TEMAC_DIR=$1

patch -o $CURRENT_DIR/channel_in_mod.v \
         $CURRENT_DIR/../../../3rdparty/eth_switch/hdl/channel_in.v \
         $CURRENT_DIR/channel_in_mod.v.patch
patch -o $CURRENT_DIR/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v \
         $TEMAC_DIR/imports/tri_mode_ethernet_mac_0_axi_lite_sm.v \
         $CURRENT_DIR/tri_mode_ethernet_mac_0_axi_lite_sm_mod.v.patch
patch -o $CURRENT_DIR/tri_mode_ethernet_mac_0_example_design_mod.v \
         $TEMAC_DIR/imports/tri_mode_ethernet_mac_0_example_design.v \
         $CURRENT_DIR/tri_mode_ethernet_mac_0_example_design_mod.v.patch
patch -o $CURRENT_DIR/tri_mode_ethernet_mac_0_fifo_block_mod.v \
         $TEMAC_DIR/imports/tri_mode_ethernet_mac_0_fifo_block.v \
         $CURRENT_DIR/tri_mode_ethernet_mac_0_fifo_block_mod.v.patch
patch -o $CURRENT_DIR/kc705_hpc.xdc \
         $TEMAC_DIR/imports/tri_mode_ethernet_mac_0_example_design.xdc \
         $CURRENT_DIR/kc705_hpc.xdc.patch
patch -o $CURRENT_DIR/rgmii-0123.xdc \
         $TEMAC_DIR/imports/tri_mode_ethernet_mac_0_user_phytiming.xdc \
         $CURRENT_DIR/rgmii-0123.xdc.patch
