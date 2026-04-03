# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# reduce FDB table size from 256 (2^8) to 64 (2^6)
set_property -dict [list CONFIG.ADDR_WIDTH {6}] [get_bd_cells hier_fdb/mactable_mod_0]

# delete axi_gpio_parameters module
delete_bd_objs [get_bd_intf_nets smartconnect_0_M09_AXI] [get_bd_cells axi_gpio_parameters_0]
set_property -dict [list CONFIG.NUM_MI {9}] [get_bd_cells smartconnect_0]

# change axi_register_slice settings
set_property -dict [list CONFIG.REG_AW {1} CONFIG.REG_AR {1} CONFIG.REG_W {1} CONFIG.REG_R {1} CONFIG.REG_B {1}] [get_bd_cells axi_register_slice_0]

save_bd_design
