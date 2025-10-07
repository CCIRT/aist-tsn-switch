# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

#-------------------------------------------------------
# patches to export network information to PMOD JA port
#-------------------------------------------------------
set port_list [list 0 1 2 3]

# get tlast signal of TC1, TC5, TC6, TC7 (RX)
foreach i ${port_list} {
    create_bd_cell -type ip -vlnv user.org:user:axis_stream_detector:1.0 switcher_${i}/axis_stream_detector_0
    delete_bd_objs [get_bd_intf_nets switcher_${i}/axis_switch_0_M01_AXIS]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_0/s_axis] [get_bd_intf_pins switcher_${i}/axis_switch_0/M01_AXIS]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_0/m_axis] [get_bd_intf_pins switcher_${i}/user_to_dest_1/s_axis]
    connect_bd_net [get_bd_pins switcher_${i}/aclk] [get_bd_pins switcher_${i}/axis_stream_detector_0/aclk]
    connect_bd_net [get_bd_pins switcher_${i}/aresetn] [get_bd_pins switcher_${i}/axis_stream_detector_0/aresetn]
    regenerate_bd_layout -hierarchy [get_bd_cells switcher_${i}]
    delete_bd_objs [get_bd_intf_nets switcher_${i}/axis_switch_0_M07_AXIS] [get_bd_intf_nets switcher_${i}/axis_switch_0_M06_AXIS] [get_bd_intf_nets switcher_${i}/axis_switch_0_M05_AXIS]
    copy_bd_objs switcher_${i}  [get_bd_cells switcher_${i}/axis_stream_detector_0]
    copy_bd_objs switcher_${i}  [get_bd_cells switcher_${i}/axis_stream_detector_0]
    copy_bd_objs switcher_${i}  [get_bd_cells switcher_${i}/axis_stream_detector_0]

    # clock
    connect_bd_net [get_bd_pins switcher_${i}/aclk] [get_bd_pins switcher_${i}/axis_stream_detector_1/aclk]
    connect_bd_net [get_bd_pins switcher_${i}/aresetn] [get_bd_pins switcher_${i}/axis_stream_detector_1/aresetn]
    connect_bd_net [get_bd_pins switcher_${i}/aclk] [get_bd_pins switcher_${i}/axis_stream_detector_2/aclk]
    connect_bd_net [get_bd_pins switcher_${i}/aresetn] [get_bd_pins switcher_${i}/axis_stream_detector_2/aresetn]
    connect_bd_net [get_bd_pins switcher_${i}/aclk] [get_bd_pins switcher_${i}/axis_stream_detector_3/aclk]
    connect_bd_net [get_bd_pins switcher_${i}/aresetn] [get_bd_pins switcher_${i}/axis_stream_detector_3/aresetn]

    # intf
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_1/s_axis] [get_bd_intf_pins switcher_${i}/axis_switch_0/M05_AXIS]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_1/m_axis] [get_bd_intf_pins switcher_${i}/user_to_dest_5/s_axis]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_2/s_axis] [get_bd_intf_pins switcher_${i}/axis_switch_0/M06_AXIS]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_2/m_axis] [get_bd_intf_pins switcher_${i}/user_to_dest_6/s_axis]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_3/s_axis] [get_bd_intf_pins switcher_${i}/axis_switch_0/M07_AXIS]
    connect_bd_intf_net [get_bd_intf_pins switcher_${i}/axis_stream_detector_3/m_axis] [get_bd_intf_pins switcher_${i}/user_to_dest_7/s_axis]

    create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 switcher_${i}/xlconcat_0
    set_property -dict [list CONFIG.NUM_PORTS {4}] [get_bd_cells switcher_${i}/xlconcat_0]
    connect_bd_net [get_bd_pins switcher_${i}/axis_stream_detector_0/streaming_with_last] [get_bd_pins switcher_${i}/xlconcat_0/In0]
    connect_bd_net [get_bd_pins switcher_${i}/axis_stream_detector_1/streaming_with_last] [get_bd_pins switcher_${i}/xlconcat_0/In1]
    connect_bd_net [get_bd_pins switcher_${i}/axis_stream_detector_2/streaming_with_last] [get_bd_pins switcher_${i}/xlconcat_0/In2]
    connect_bd_net [get_bd_pins switcher_${i}/axis_stream_detector_3/streaming_with_last] [get_bd_pins switcher_${i}/xlconcat_0/In3]
}

# get tlast signal of TC1, TC5, TC6, TC7 (TX)
foreach i ${port_list} {
    create_bd_cell -type ip -vlnv user.org:user:axis_stream_detector:1.0 hier_cbs_${i}/arbiter_0/axis_stream_detector_0
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aclk] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_0/aclk]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aresetn] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_0/aresetn]
    delete_bd_objs [get_bd_intf_nets hier_cbs_${i}/arbiter_0/S06_AXIS_1] [get_bd_intf_nets hier_cbs_${i}/arbiter_0/S07_AXIS_1] [get_bd_intf_nets hier_cbs_${i}/arbiter_0/S05_AXIS_1] [get_bd_intf_nets hier_cbs_${i}/arbiter_0/S01_AXIS_1]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/S01_AXIS] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_0/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_0/m_axis] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/ethernet_frame_arbit_0/s_axis_1]
    create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 hier_cbs_${i}/arbiter_0/xlconcat_0
    set_property -dict [list CONFIG.NUM_PORTS {4}] [get_bd_cells hier_cbs_${i}/arbiter_0/xlconcat_0]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_0/streaming_with_last] [get_bd_pins hier_cbs_${i}/arbiter_0/xlconcat_0/In0]
    copy_bd_objs hier_cbs_${i}/arbiter_0  [get_bd_cells hier_cbs_${i}/arbiter_0/axis_stream_detector_0]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/S05_AXIS] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_1/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_1/m_axis] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/ethernet_frame_arbit_0/s_axis_5]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aclk] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_1/aclk]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aresetn] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_1/aresetn]
    copy_bd_objs hier_cbs_${i}/arbiter_0  [get_bd_cells hier_cbs_${i}/arbiter_0/axis_stream_detector_1]
    copy_bd_objs hier_cbs_${i}/arbiter_0  [get_bd_cells hier_cbs_${i}/arbiter_0/axis_stream_detector_1]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/S06_AXIS] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_2/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_2/m_axis] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/ethernet_frame_arbit_0/s_axis_6]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/S07_AXIS] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_3/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_3/m_axis] [get_bd_intf_pins hier_cbs_${i}/arbiter_0/ethernet_frame_arbit_0/s_axis_7]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aclk] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_3/aclk]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aresetn] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_3/aresetn]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aclk] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_2/aclk]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/aresetn] [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_2/aresetn]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_1/streaming_with_last] [get_bd_pins hier_cbs_${i}/arbiter_0/xlconcat_0/In1]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_2/streaming_with_last] [get_bd_pins hier_cbs_${i}/arbiter_0/xlconcat_0/In2]
    connect_bd_net [get_bd_pins hier_cbs_${i}/arbiter_0/axis_stream_detector_3/streaming_with_last] [get_bd_pins hier_cbs_${i}/arbiter_0/xlconcat_0/In3]
    regenerate_bd_layout -hierarchy [get_bd_cells hier_cbs_${i}/arbiter_0]
}

# get tlast signal of temac RX/TX
foreach i ${port_list} {
    create_bd_cell -type ip -vlnv user.org:user:axis_stream_detector:1.0 hier_mac_${i}/axis_stream_detector_0
    set_property name axis_stream_detector_rx [get_bd_cells hier_mac_${i}/axis_stream_detector_0]
    copy_bd_objs hier_mac_${i}  [get_bd_cells hier_mac_${i}/axis_stream_detector_rx]
    set_property name axis_stream_detector_tx [get_bd_cells hier_mac_${i}/axis_stream_detector_rx1]
    delete_bd_objs [get_bd_intf_nets hier_mac_${i}/axis_data_fifo_sw_${i}_M_AXIS]
    connect_bd_intf_net [get_bd_intf_pins hier_mac_${i}/s_axis_tx] [get_bd_intf_pins hier_mac_${i}/axis_stream_detector_tx/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_mac_${i}/axis_stream_detector_tx/m_axis] [get_bd_intf_pins hier_mac_${i}/temac_${i}/s_axis_tx]
    connect_bd_net [get_bd_pins hier_mac_${i}/axis_stream_detector_tx/aclk] [get_bd_pins hier_mac_${i}/temac_${i}/tx_mac_aclk]
    connect_bd_net [get_bd_pins hier_mac_${i}/xlconstant_0/dout] [get_bd_pins hier_mac_${i}/axis_stream_detector_tx/aresetn]
    delete_bd_objs [get_bd_intf_nets hier_mac_${i}/temac_${i}_m_axis_rx]
    connect_bd_intf_net [get_bd_intf_pins hier_mac_${i}/axis_stream_detector_rx/m_axis] [get_bd_intf_pins hier_mac_${i}/ethernet_frame_dropp_0/s_axis]
    connect_bd_intf_net [get_bd_intf_pins hier_mac_${i}/axis_stream_detector_rx/s_axis] [get_bd_intf_pins hier_mac_${i}/temac_${i}/m_axis_rx]
    connect_bd_net [get_bd_pins hier_mac_${i}/axis_stream_detector_rx/aclk] [get_bd_pins hier_mac_${i}/temac_${i}/rx_mac_aclk]
    connect_bd_net [get_bd_pins hier_mac_${i}/axis_stream_detector_rx/aresetn] [get_bd_pins hier_mac_${i}/util_vector_logic_0/Res]
    create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 hier_mac_${i}/xlconcat_0
    connect_bd_net [get_bd_pins hier_mac_${i}/axis_stream_detector_rx/streaming_with_last] [get_bd_pins hier_mac_${i}/xlconcat_0/In0]
    connect_bd_net [get_bd_pins hier_mac_${i}/xlconcat_0/In1] [get_bd_pins hier_mac_${i}/axis_stream_detector_tx/streaming_with_last]
    regenerate_bd_layout -hierarchy [get_bd_cells hier_mac_${i}]
}


# connect tlast signal to pulse generator (4x4=16 port)
create_bd_cell -type ip -vlnv user.org:user:pulse_generator:1.0 pulse_generator_0
set_property -dict [list CONFIG.NUM_INPUTS {40} CONFIG.NUM_OUTPUTS {4}] [get_bd_cells pulse_generator_0]
make_bd_pins_external  [get_bd_pins pulse_generator_0/pulse_out]
set_property -dict [list CONFIG.NUM_MI {10}] [get_bd_cells smartconnect_0]
connect_bd_net [get_bd_pins pulse_generator_0/clk] [get_bd_pins hier_mac_0/tx_mac_aclk]
connect_bd_net [get_bd_pins pulse_generator_0/rstn] [get_bd_pins proc_sys_reset_sw/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins pulse_generator_0/S_AXI] [get_bd_intf_pins smartconnect_0/M09_AXI]
create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0
set_property -dict [list CONFIG.NUM_PORTS {12}] [get_bd_cells xlconcat_0]
connect_bd_net [get_bd_pins xlconcat_0/dout] [get_bd_pins pulse_generator_0/data_in]
connect_bd_net [get_bd_pins switcher_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In0]
connect_bd_net [get_bd_pins switcher_1/xlconcat_0/dout] [get_bd_pins xlconcat_0/In1]
connect_bd_net [get_bd_pins switcher_2/xlconcat_0/dout] [get_bd_pins xlconcat_0/In2]
connect_bd_net [get_bd_pins switcher_3/xlconcat_0/dout] [get_bd_pins xlconcat_0/In3]
connect_bd_net [get_bd_pins hier_cbs_0/arbiter_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In4]
connect_bd_net [get_bd_pins hier_cbs_1/arbiter_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In5]
connect_bd_net [get_bd_pins hier_cbs_2/arbiter_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In6]
connect_bd_net [get_bd_pins hier_cbs_3/arbiter_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In7]
connect_bd_net [get_bd_pins hier_mac_0/xlconcat_0/dout] [get_bd_pins xlconcat_0/In8]
connect_bd_net [get_bd_pins hier_mac_1/xlconcat_0/dout] [get_bd_pins xlconcat_0/In9]
connect_bd_net [get_bd_pins hier_mac_2/xlconcat_0/dout] [get_bd_pins xlconcat_0/In10]
connect_bd_net [get_bd_pins hier_mac_3/xlconcat_0/dout] [get_bd_pins xlconcat_0/In11]

# assign IP address of pulse generator to 0x40110000
assign_bd_address -target_address_space /jtag_axi_0/Data [get_bd_addr_segs pulse_generator_0/S_AXI/reg0] -force
set_property offset 0x40110000 [get_bd_addr_segs {jtag_axi_0/Data/SEG_pulse_generator_0_reg0}]

# change axi_register_slice settings
set_property -dict [list CONFIG.REG_AW {1} CONFIG.REG_AR {1} CONFIG.REG_W {1} CONFIG.REG_R {1} CONFIG.REG_B {1}] [get_bd_cells axi_register_slice_0]

save_bd_design

# override wrapper to output pulse_out_0 signal.
generate_target all $bd_files
make_wrapper -files $bd_files -top -import -force
