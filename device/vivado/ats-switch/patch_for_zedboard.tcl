# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set ats_list [list 0 1 2 3]
set delete_tc_list [list 0 1 2 3 4]
set dst_list [list 0 1 2]

# reduce FDB table size from 256 (2^8) to 32 (2^6)
set_property -dict [list CONFIG.ADDR_WIDTH {6}] [get_bd_cells hier_eth_switch/mactable_mod_0]

foreach i ${ats_list} {
    # remove TC0-TC4
    foreach tc ${delete_tc_list} {
        delete_bd_objs [get_bd_cells hier_ats_${i}/hier_round_robin_TC${tc}]
        delete_bd_objs [get_bd_intf_nets hier_ats_${i}/hier_queue_FIFO_0/s_axis_TC${tc}_1] [get_bd_nets hier_ats_${i}/hier_queue_FIFO_0/fifo_generator_${tc}_axis_prog_full] [get_bd_cells hier_ats_${i}/hier_queue_FIFO_0/ethernet_frame_dropp_${tc}]

        foreach dst ${dst_list} {
            delete_bd_objs [get_bd_cells hier_ats_${i}/hier_queue_FIFO_${dst}/fifo_generator_${tc}]
        }
    }

    # forward TC0-TC4 frame to TC5 flow. (hier_ats)
    foreach dst ${dst_list} {
        set_property -dict [list CONFIG.NUM_MI {3} CONFIG.M01_AXIS_BASETDEST {0x00000006} CONFIG.M02_AXIS_BASETDEST {0x00000007} CONFIG.M00_AXIS_HIGHTDEST {0x00000005} CONFIG.M01_AXIS_HIGHTDEST {0x00000006} CONFIG.M02_AXIS_HIGHTDEST {0x00000007}] [get_bd_cells hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0]
        delete_bd_objs [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M03_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M04_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M05_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M06_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M07_AXIS]
        delete_bd_objs [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M01_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M00_AXIS] [get_bd_intf_nets hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0_M02_AXIS]
        connect_bd_intf_net [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0/M00_AXIS] [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_subset_converter_5/S_AXIS]
        connect_bd_intf_net [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0/M01_AXIS] [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_subset_converter_6/S_AXIS]
        connect_bd_intf_net [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_switch_0/M02_AXIS] [get_bd_intf_pins hier_ats_${i}/hier_priority_switch_${dst}/axis_subset_converter_7/S_AXIS]
        set_property -dict [list CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_0 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_1 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_4 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_5 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_6 {5}] [get_bd_cells hier_ats_${i}/hier_priority_switch_${dst}/add_tdest_from_vlan_0]
    }

    # forward TC0-TC4 frame to TC5 flow. (hier_scheduler)
    set_property -dict [list CONFIG.NUM_MI {3} CONFIG.M01_AXIS_BASETDEST {0x00000006} CONFIG.M02_AXIS_BASETDEST {0x00000007} CONFIG.M00_AXIS_HIGHTDEST {0x00000005} CONFIG.M01_AXIS_HIGHTDEST {0x00000006} CONFIG.M02_AXIS_HIGHTDEST {0x00000007}] [get_bd_cells hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0]
    delete_bd_objs [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M03_AXIS] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M04_AXIS] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M05_AXIS] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/Conn3] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/Conn2]
    delete_bd_objs [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M01_AXIS] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M00_AXIS] [get_bd_intf_nets hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0_M02_AXIS]
    connect_bd_intf_net [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0/M00_AXIS]
    connect_bd_intf_net [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0/M01_AXIS]
    connect_bd_intf_net [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins hier_scheduler_${i}/hier_priority_switch_0/axis_switch_0/M02_AXIS]
    set_property -dict [list CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_0 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_1 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_4 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_5 {5} CONFIG.INIT_VAL_OF_PRIORITY_MAPPER_6 {5}] [get_bd_cells hier_scheduler_${i}/hier_priority_switch_0/add_tdest_from_vlan_0]

    # Reduce FIFOs
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P00_0/fifo_generator_0]
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P00_1/fifo_generator_0]
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P00_2/fifo_generator_0]
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P01_0/fifo_generator_0]
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P01_1/fifo_generator_0]
    set_property -dict [list CONFIG.Input_Depth_axis {2048} CONFIG.Full_Threshold_Assert_Value_axis {2047} CONFIG.Empty_Threshold_Assert_Value_axis {2046}] [get_bd_cells hier_ats_${i}/hier_queue_ATS_P01_2/fifo_generator_0]

    # Modify Optimization Level of add_tdest_from_vlan_tag and detect_flow
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_ats_${i}/hier_priority_switch_0/add_tdest_from_vlan_0]
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_ats_${i}/hier_priority_switch_1/add_tdest_from_vlan_0]
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_ats_${i}/hier_priority_switch_2/add_tdest_from_vlan_0]
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_scheduler_${i}/hier_priority_switch_0/add_tdest_from_vlan_0]
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_scheduler_${i}/hier_calc_et_P00/detect_flow_0]
    set_property -dict [list CONFIG.OPT_LEVEL {0}] [get_bd_cells hier_scheduler_${i}/hier_calc_et_P01/detect_flow_0]
}

# Disable reading USR_ACCESS
set_property -dict [list CONFIG.ENABLE_COMMITHASH_READ {0}] [get_bd_cells axi_gpio_parameters_0]

save_bd_design
