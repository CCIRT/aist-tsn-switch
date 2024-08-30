# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

create_project tmp_proj -part xc7k325tffg900-2 -in_memory
set_property board_part xilinx.com:kc705:part0:1.6 [current_project]
create_bd_design "design_1"
create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 tri_mode_ethernet_mac_0
save_bd_design
open_example_project -force -dir [lindex $argv 0] [get_ips design_1_tri_mode_ethernet_mac_0_0]
close_project
