
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# channel_in_mod, channel_in_mod, channel_in_mod, channel_in_mod, mactable, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k325tffg900-2
   set_property BOARD_PART xilinx.com:kc705:part0:1.6 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:clk_wiz:6.0\
user.org:user:gpio_processing_delay_max:1.0\
xilinx.com:ip:jtag_axi:1.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
user.org:user:reference_timer:1.0\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:fifo_generator:13.2\
xilinx.com:ip:util_ff:1.0\
xilinx.com:ip:tri_mode_ethernet_mac:9.0\
user.org:user:set_timestamp:1.0\
user.org:user:et_gate:1.0\
user.org:user:add_tdest_from_vlan_tag:1.0\
user.org:user:get_frame_length:1.0\
user.org:user:separate_timestamp:1.0\
user.org:user:ethernet_frame_arbiter:1.0\
xilinx.com:ip:axis_broadcaster:1.1\
user.org:user:connect_timestamp:1.0\
user.org:user:detect_flow:1.0\
user.org:user:process_frame:1.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
channel_in_mod\
channel_in_mod\
channel_in_mod\
channel_in_mod\
mactable\
tri_mode_ethernet_mac_0_example_design_mod\
tri_mode_ethernet_mac_0_example_design_mod\
tri_mode_ethernet_mac_0_example_design_mod\
tri_mode_ethernet_mac_0_example_design_mod\
"

   set list_mods_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2020 -severity "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2021 -severity "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_gid_msg -ssname BD::TCL -id 2022 -severity "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_7() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net s_axis_3_1 [get_bd_intf_pins s_axis_3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net s_axis_4_1 [get_bd_intf_pins s_axis_4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net s_axis_5_1 [get_bd_intf_pins s_axis_5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_7() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P01
proc create_hier_cell_hier_calc_et_P01_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P01_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P00
proc create_hier_cell_hier_calc_et_P00_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P00_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_6() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net s_axis_3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net s_axis_4_1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net s_axis_5_1 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_6() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P01
proc create_hier_cell_hier_calc_et_P01_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P01_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P00
proc create_hier_cell_hier_calc_et_P00_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P00_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_5() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net s_axis_3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net s_axis_4_1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net s_axis_5_1 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_5() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P01
proc create_hier_cell_hier_calc_et_P01_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P01_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P00
proc create_hier_cell_hier_calc_et_P00_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P00_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_4() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net s_axis_3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net s_axis_4_1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net s_axis_5_1 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_4() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P01
proc create_hier_cell_hier_calc_et_P01 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P01() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_calc_et_P00
proc create_hier_cell_hier_calc_et_P00 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_calc_et_P00() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_broadcaster_0, and set properties
  set axis_broadcaster_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_broadcaster:1.1 axis_broadcaster_0 ]

  # Create instance: axis_data_fifo_frame_0, and set properties
  set axis_data_fifo_frame_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_0

  # Create instance: axis_data_fifo_frame_1, and set properties
  set axis_data_fifo_frame_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_frame_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_frame_1

  # Create instance: axis_data_fifo_length_0, and set properties
  set axis_data_fifo_length_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_length_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_length_0

  # Create instance: axis_data_fifo_timestamp_0, and set properties
  set axis_data_fifo_timestamp_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_timestamp_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
 ] $axis_data_fifo_timestamp_0

  # Create instance: connect_timestamp_0, and set properties
  set connect_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:connect_timestamp:1.0 connect_timestamp_0 ]

  # Create instance: detect_flow_0, and set properties
  set detect_flow_0 [ create_bd_cell -type ip -vlnv user.org:user:detect_flow:1.0 detect_flow_0 ]

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: process_frame_0, and set properties
  set process_frame_0 [ create_bd_cell -type ip -vlnv user.org:user:process_frame:1.0 process_frame_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M00_AXIS [get_bd_intf_pins axis_broadcaster_0/M00_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_broadcaster_0_M01_AXIS [get_bd_intf_pins axis_broadcaster_0/M01_AXIS] [get_bd_intf_pins axis_data_fifo_length_0/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_frame_1_M_AXIS [get_bd_intf_pins axis_data_fifo_frame_1/M_AXIS] [get_bd_intf_pins connect_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_length_0_M_AXIS [get_bd_intf_pins axis_data_fifo_length_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net axis_data_fifo_timestamp_0_M_AXIS [get_bd_intf_pins axis_data_fifo_timestamp_0/M_AXIS] [get_bd_intf_pins process_frame_0/s_axis_arrival_timestamp]
  connect_bd_intf_net -intf_net connect_timestamp_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins connect_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_1/S_AXIS] [get_bd_intf_pins detect_flow_0/m_axis]
  connect_bd_intf_net -intf_net detect_flow_0_m_axis_flow [get_bd_intf_pins detect_flow_0/m_axis_flow] [get_bd_intf_pins process_frame_0/s_axis_flow]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_frame_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins axis_broadcaster_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis_frame_length]
  connect_bd_intf_net -intf_net process_frame_0_m_axis_eligibility_timestamp [get_bd_intf_pins connect_timestamp_0/s_axis_timestamp] [get_bd_intf_pins process_frame_0/m_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins detect_flow_0/s_axis] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins axis_data_fifo_timestamp_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins detect_flow_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins process_frame_0/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_broadcaster_0/aresetn] [get_bd_pins axis_data_fifo_frame_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_frame_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_length_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aresetn] [get_bd_pins connect_timestamp_0/rstn] [get_bd_pins detect_flow_0/rstn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins process_frame_0/rstn] [get_bd_pins separate_timestamp_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_broadcaster_0/aclk] [get_bd_pins axis_data_fifo_frame_0/s_axis_aclk] [get_bd_pins axis_data_fifo_frame_1/s_axis_aclk] [get_bd_pins axis_data_fifo_length_0/s_axis_aclk] [get_bd_pins axis_data_fifo_timestamp_0/s_axis_aclk] [get_bd_pins connect_timestamp_0/clk] [get_bd_pins detect_flow_0/clk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins process_frame_0/clk] [get_bd_pins separate_timestamp_0/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC5
proc create_hier_cell_hier_round_robin_TC5_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC5_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC4
proc create_hier_cell_hier_round_robin_TC4_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC4_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC3
proc create_hier_cell_hier_round_robin_TC3_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC3_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC2
proc create_hier_cell_hier_round_robin_TC2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC2_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC1
proc create_hier_cell_hier_round_robin_TC1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC1_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC0
proc create_hier_cell_hier_round_robin_TC0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P01
proc create_hier_cell_hier_round_robin_P01_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P01_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {525} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P00
proc create_hier_cell_hier_round_robin_P00_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P00_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {2573} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_2
proc create_hier_cell_hier_queue_FIFO_2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_2_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_1
proc create_hier_cell_hier_queue_FIFO_1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_1_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_0
proc create_hier_cell_hier_queue_FIFO_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_2
proc create_hier_cell_hier_queue_ATS_P01_2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_2_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_1
proc create_hier_cell_hier_queue_ATS_P01_1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_1_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_0
proc create_hier_cell_hier_queue_ATS_P01_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_2
proc create_hier_cell_hier_queue_ATS_P00_2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_2_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_1
proc create_hier_cell_hier_queue_ATS_P00_1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_1_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_0
proc create_hier_cell_hier_queue_ATS_P00_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_2
proc create_hier_cell_hier_priority_switch_2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_2_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_1
proc create_hier_cell_hier_priority_switch_1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_1_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P01
proc create_hier_cell_hier_et_gate_P01_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P01_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P00
proc create_hier_cell_hier_et_gate_P00_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P00_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC5
proc create_hier_cell_hier_round_robin_TC5_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC5_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC4
proc create_hier_cell_hier_round_robin_TC4_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC4_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC3
proc create_hier_cell_hier_round_robin_TC3_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC3_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC2
proc create_hier_cell_hier_round_robin_TC2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC2_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC1
proc create_hier_cell_hier_round_robin_TC1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC1_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC0
proc create_hier_cell_hier_round_robin_TC0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P01
proc create_hier_cell_hier_round_robin_P01_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P01_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {525} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P00
proc create_hier_cell_hier_round_robin_P00_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P00_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {2573} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_2
proc create_hier_cell_hier_queue_FIFO_2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_2_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_1
proc create_hier_cell_hier_queue_FIFO_1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_1_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_0
proc create_hier_cell_hier_queue_FIFO_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_2
proc create_hier_cell_hier_queue_ATS_P01_2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_2_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_1
proc create_hier_cell_hier_queue_ATS_P01_1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_1_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_0
proc create_hier_cell_hier_queue_ATS_P01_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_2
proc create_hier_cell_hier_queue_ATS_P00_2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_2_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_1
proc create_hier_cell_hier_queue_ATS_P00_1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_1_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_0
proc create_hier_cell_hier_queue_ATS_P00_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_2
proc create_hier_cell_hier_priority_switch_2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_2_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_1
proc create_hier_cell_hier_priority_switch_1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_1_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P01
proc create_hier_cell_hier_et_gate_P01_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P01_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P00
proc create_hier_cell_hier_et_gate_P00_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P00_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC5
proc create_hier_cell_hier_round_robin_TC5_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC5_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC4
proc create_hier_cell_hier_round_robin_TC4_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC4_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC3
proc create_hier_cell_hier_round_robin_TC3_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC3_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC2
proc create_hier_cell_hier_round_robin_TC2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC2_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC1
proc create_hier_cell_hier_round_robin_TC1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC1_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC0
proc create_hier_cell_hier_round_robin_TC0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P01
proc create_hier_cell_hier_round_robin_P01_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P01_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {525} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P00
proc create_hier_cell_hier_round_robin_P00_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P00_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {2573} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_2
proc create_hier_cell_hier_queue_FIFO_2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_2_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_1
proc create_hier_cell_hier_queue_FIFO_1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_1_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_0
proc create_hier_cell_hier_queue_FIFO_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_2
proc create_hier_cell_hier_queue_ATS_P01_2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_2_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_1
proc create_hier_cell_hier_queue_ATS_P01_1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_1_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_0
proc create_hier_cell_hier_queue_ATS_P01_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_2
proc create_hier_cell_hier_queue_ATS_P00_2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_2_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_1
proc create_hier_cell_hier_queue_ATS_P00_1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_1_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_0
proc create_hier_cell_hier_queue_ATS_P00_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_2
proc create_hier_cell_hier_priority_switch_2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_2_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_1
proc create_hier_cell_hier_priority_switch_1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_1_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P01
proc create_hier_cell_hier_et_gate_P01_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P01_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P00
proc create_hier_cell_hier_et_gate_P00_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P00_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_strict_priority_0
proc create_hier_cell_hier_strict_priority_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_strict_priority_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_P01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins ethernet_frame_arbit_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_P00_1 [get_bd_intf_pins s_axis_P00] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net s_axis_P01_1 [get_bd_intf_pins s_axis_P01] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC5
proc create_hier_cell_hier_round_robin_TC5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC5() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC4
proc create_hier_cell_hier_round_robin_TC4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC4() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC3
proc create_hier_cell_hier_round_robin_TC3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {6669} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC2
proc create_hier_cell_hier_round_robin_TC2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC1
proc create_hier_cell_hier_round_robin_TC1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_TC0
proc create_hier_cell_hier_round_robin_TC0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_TC0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P01
proc create_hier_cell_hier_round_robin_P01 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P01() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {525} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_round_robin_P00
proc create_hier_cell_hier_round_robin_P00 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_round_robin_P00() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {2573} \
 ] $axis_data_fifo_0

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_TLAST {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {3} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net et_gate_0_m_axis [get_bd_intf_pins s_axis_0] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net et_gate_1_m_axis [get_bd_intf_pins s_axis_1] [get_bd_intf_pins axis_switch_0/S01_AXIS]
  connect_bd_intf_net -intf_net et_gate_2_m_axis [get_bd_intf_pins s_axis_2] [get_bd_intf_pins axis_switch_0/S02_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_2
proc create_hier_cell_hier_queue_FIFO_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_1
proc create_hier_cell_hier_queue_FIFO_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_FIFO_0
proc create_hier_cell_hier_queue_FIFO_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_FIFO_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_TC5


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_3

  # Create instance: axis_data_fifo_4, and set properties
  set axis_data_fifo_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_4 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_4

  # Create instance: axis_data_fifo_5, and set properties
  set axis_data_fifo_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_5 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {8192} \
 ] $axis_data_fifo_5

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins s_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_2_M_AXIS [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_4_M_AXIS [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_data_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_5_M_AXIS [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_data_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis_TC0] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC1_1 [get_bd_intf_pins s_axis_TC1] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC2_1 [get_bd_intf_pins s_axis_TC2] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins s_axis_TC3] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins axis_data_fifo_4/s_axis_aresetn] [get_bd_pins axis_data_fifo_5/s_axis_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins axis_data_fifo_4/s_axis_aclk] [get_bd_pins axis_data_fifo_5/s_axis_aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_2
proc create_hier_cell_hier_queue_ATS_P01_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_1
proc create_hier_cell_hier_queue_ATS_P01_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P01_0
proc create_hier_cell_hier_queue_ATS_P01_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P01_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_2
proc create_hier_cell_hier_queue_ATS_P00_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_1
proc create_hier_cell_hier_queue_ATS_P00_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_queue_ATS_P00_0
proc create_hier_cell_hier_queue_ATS_P00_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_queue_ATS_P00_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_et

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
 ] $axis_data_fifo_0

  # Create instance: et_queue_0, and set properties
  set et_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 et_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {1} \
 ] $et_queue_0

  # Create instance: frame_queue_0, and set properties
  set frame_queue_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 frame_queue_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
 ] $frame_queue_0

  # Create instance: get_frame_length_0, and set properties
  set get_frame_length_0 [ create_bd_cell -type ip -vlnv user.org:user:get_frame_length:1.0 get_frame_length_0 ]

  # Create instance: separate_timestamp_0, and set properties
  set separate_timestamp_0 [ create_bd_cell -type ip -vlnv user.org:user:separate_timestamp:1.0 separate_timestamp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis] [get_bd_intf_pins frame_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_et] [get_bd_intf_pins et_queue_0/M_AXIS]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins separate_timestamp_0/s_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins get_frame_length_0/m_axis]
  connect_bd_intf_net -intf_net get_frame_length_0_m_axis_frame_length [get_bd_intf_pins get_frame_length_0/m_axis_frame_length] [get_bd_intf_pins separate_timestamp_0/s_axis_frame_length]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins get_frame_length_0/s_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis [get_bd_intf_pins frame_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis]
  connect_bd_intf_net -intf_net separate_timestamp_0_m_axis_timestamp [get_bd_intf_pins et_queue_0/S_AXIS] [get_bd_intf_pins separate_timestamp_0/m_axis_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins et_queue_0/s_axis_aresetn] [get_bd_pins frame_queue_0/s_axis_aresetn] [get_bd_pins get_frame_length_0/rstn] [get_bd_pins separate_timestamp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins et_queue_0/s_axis_aclk] [get_bd_pins frame_queue_0/s_axis_aclk] [get_bd_pins get_frame_length_0/clk] [get_bd_pins separate_timestamp_0/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_2
proc create_hier_cell_hier_priority_switch_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_1
proc create_hier_cell_hier_priority_switch_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_priority_switch_0
proc create_hier_cell_hier_priority_switch_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_priority_switch_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_P01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC4

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_TC5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
 ] $axis_switch_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_P01] [get_bd_intf_pins axis_switch_0/M07_AXIS]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_P00] [get_bd_intf_pins axis_switch_0/M06_AXIS]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins m_axis_TC2] [get_bd_intf_pins axis_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net Conn5 [get_bd_intf_pins m_axis_TC3] [get_bd_intf_pins axis_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins m_axis_TC4] [get_bd_intf_pins axis_switch_0/M04_AXIS]
  connect_bd_intf_net -intf_net Conn7 [get_bd_intf_pins m_axis_TC5] [get_bd_intf_pins axis_switch_0/M05_AXIS]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis_TC0] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins m_axis_TC1] [get_bd_intf_pins axis_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins add_tdest_from_vlan_0/s_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P01
proc create_hier_cell_hier_et_gate_P01 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P01() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_et_gate_P00
proc create_hier_cell_hier_et_gate_P00 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_et_gate_P00() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1_eligibility_timestamp

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2_eligibility_timestamp


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: et_gate_0, and set properties
  set et_gate_0 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_0 ]

  # Create instance: et_gate_1, and set properties
  set et_gate_1 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_1 ]

  # Create instance: et_gate_2, and set properties
  set et_gate_2 [ create_bd_cell -type ip -vlnv user.org:user:et_gate:1.0 et_gate_2 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins m_axis_0] [get_bd_intf_pins et_gate_0/m_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_1] [get_bd_intf_pins et_gate_1/m_axis]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_2] [get_bd_intf_pins et_gate_2/m_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_0_M_AXIS [get_bd_intf_pins s_axis_0] [get_bd_intf_pins et_gate_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P00_2_M_AXIS [get_bd_intf_pins s_axis_2] [get_bd_intf_pins et_gate_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_P01_1_M_AXIS [get_bd_intf_pins s_axis_1] [get_bd_intf_pins et_gate_1/s_axis]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_0_m_axis_et [get_bd_intf_pins s_axis_0_eligibility_timestamp] [get_bd_intf_pins et_gate_0/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_1_m_axis_et [get_bd_intf_pins s_axis_1_eligibility_timestamp] [get_bd_intf_pins et_gate_1/s_axis_eligibility_timestamp]
  connect_bd_intf_net -intf_net hier_clalc_et_P00_2_m_axis_et [get_bd_intf_pins s_axis_2_eligibility_timestamp] [get_bd_intf_pins et_gate_2/s_axis_eligibility_timestamp]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins et_gate_0/rstn] [get_bd_pins et_gate_1/rstn] [get_bd_pins et_gate_2/rstn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins et_gate_0/processing_delay_max] [get_bd_pins et_gate_1/processing_delay_max] [get_bd_pins et_gate_2/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins et_gate_0/clk] [get_bd_pins et_gate_1/clk] [get_bd_pins et_gate_2/clk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins et_gate_0/transmission_selection_timer] [get_bd_pins et_gate_1/transmission_selection_timer] [get_bd_pins et_gate_2/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_scheduler_3
proc create_hier_cell_hier_scheduler_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_scheduler_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -from 71 -to 0 ats_scheduler_timer
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: hier_calc_et_P00
  create_hier_cell_hier_calc_et_P00_3 $hier_obj hier_calc_et_P00

  # Create instance: hier_calc_et_P01
  create_hier_cell_hier_calc_et_P01_3 $hier_obj hier_calc_et_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_7 $hier_obj hier_priority_switch_0

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_7 $hier_obj hier_strict_priority_0

  # Create instance: set_timestamp_P00, and set properties
  set set_timestamp_P00 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P00 ]

  # Create instance: set_timestamp_P01, and set properties
  set set_timestamp_P01 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P01 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net hier_calc_et_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_calc_et_P0_m_axis [get_bd_intf_pins hier_calc_et_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M00_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_strict_priority_0/s_axis_0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M01_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_strict_priority_0/s_axis_1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M02_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_strict_priority_0/s_axis_2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M03_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_strict_priority_0/s_axis_3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M04_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_strict_priority_0/s_axis_4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M05_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_strict_priority_0/s_axis_5]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins set_timestamp_P00/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins set_timestamp_P01/s_axis]
  connect_bd_intf_net -intf_net hier_strict_priority_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net set_timestamp_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/s_axis] [get_bd_intf_pins set_timestamp_P00/m_axis]
  connect_bd_intf_net -intf_net set_timestamp_P01_m_axis [get_bd_intf_pins hier_calc_et_P01/s_axis] [get_bd_intf_pins set_timestamp_P01/m_axis]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_calc_et_P00/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_calc_et_P01/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins ats_scheduler_timer] [get_bd_pins set_timestamp_P00/ats_scheduler_timer] [get_bd_pins set_timestamp_P01/ats_scheduler_timer]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins hier_calc_et_P00/rstn] [get_bd_pins hier_calc_et_P01/rstn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins set_timestamp_P00/rstn] [get_bd_pins set_timestamp_P01/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins hier_calc_et_P00/clk] [get_bd_pins hier_calc_et_P01/clk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins set_timestamp_P00/clk] [get_bd_pins set_timestamp_P01/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_scheduler_2
proc create_hier_cell_hier_scheduler_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_scheduler_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -from 71 -to 0 ats_scheduler_timer
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: hier_calc_et_P00
  create_hier_cell_hier_calc_et_P00_2 $hier_obj hier_calc_et_P00

  # Create instance: hier_calc_et_P01
  create_hier_cell_hier_calc_et_P01_2 $hier_obj hier_calc_et_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_6 $hier_obj hier_priority_switch_0

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_6 $hier_obj hier_strict_priority_0

  # Create instance: set_timestamp_P00, and set properties
  set set_timestamp_P00 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P00 ]

  # Create instance: set_timestamp_P01, and set properties
  set set_timestamp_P01 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P01 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net hier_calc_et_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_calc_et_P0_m_axis [get_bd_intf_pins hier_calc_et_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M00_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M01_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M02_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M03_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M04_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M05_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins set_timestamp_P00/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins set_timestamp_P01/s_axis]
  connect_bd_intf_net -intf_net hier_strict_priority_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net set_timestamp_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/s_axis] [get_bd_intf_pins set_timestamp_P00/m_axis]
  connect_bd_intf_net -intf_net set_timestamp_P01_m_axis [get_bd_intf_pins hier_calc_et_P01/s_axis] [get_bd_intf_pins set_timestamp_P01/m_axis]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_calc_et_P00/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_calc_et_P01/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins ats_scheduler_timer] [get_bd_pins set_timestamp_P00/ats_scheduler_timer] [get_bd_pins set_timestamp_P01/ats_scheduler_timer]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins hier_calc_et_P00/rstn] [get_bd_pins hier_calc_et_P01/rstn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins set_timestamp_P00/rstn] [get_bd_pins set_timestamp_P01/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins hier_calc_et_P00/clk] [get_bd_pins hier_calc_et_P01/clk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins set_timestamp_P00/clk] [get_bd_pins set_timestamp_P01/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_scheduler_1
proc create_hier_cell_hier_scheduler_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_scheduler_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -from 71 -to 0 ats_scheduler_timer
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: hier_calc_et_P00
  create_hier_cell_hier_calc_et_P00_1 $hier_obj hier_calc_et_P00

  # Create instance: hier_calc_et_P01
  create_hier_cell_hier_calc_et_P01_1 $hier_obj hier_calc_et_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_5 $hier_obj hier_priority_switch_0

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_5 $hier_obj hier_strict_priority_0

  # Create instance: set_timestamp_P00, and set properties
  set set_timestamp_P00 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P00 ]

  # Create instance: set_timestamp_P01, and set properties
  set set_timestamp_P01 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P01 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net hier_calc_et_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_calc_et_P0_m_axis [get_bd_intf_pins hier_calc_et_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M00_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M01_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M02_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M03_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M04_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M05_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins set_timestamp_P00/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins set_timestamp_P01/s_axis]
  connect_bd_intf_net -intf_net hier_strict_priority_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net set_timestamp_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/s_axis] [get_bd_intf_pins set_timestamp_P00/m_axis]
  connect_bd_intf_net -intf_net set_timestamp_P01_m_axis [get_bd_intf_pins hier_calc_et_P01/s_axis] [get_bd_intf_pins set_timestamp_P01/m_axis]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_calc_et_P00/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_calc_et_P01/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net Net [get_bd_pins ats_scheduler_timer] [get_bd_pins set_timestamp_P00/ats_scheduler_timer] [get_bd_pins set_timestamp_P01/ats_scheduler_timer]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins hier_calc_et_P00/rstn] [get_bd_pins hier_calc_et_P01/rstn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins set_timestamp_P00/rstn] [get_bd_pins set_timestamp_P01/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins hier_calc_et_P00/clk] [get_bd_pins hier_calc_et_P01/clk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins set_timestamp_P00/clk] [get_bd_pins set_timestamp_P01/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_scheduler_0
proc create_hier_cell_hier_scheduler_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_scheduler_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -from 71 -to 0 ats_scheduler_timer
  create_bd_pin -dir I -type clk clk
  create_bd_pin -dir I -type rst rstn

  # Create instance: hier_calc_et_P00
  create_hier_cell_hier_calc_et_P00 $hier_obj hier_calc_et_P00

  # Create instance: hier_calc_et_P01
  create_hier_cell_hier_calc_et_P01 $hier_obj hier_calc_et_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_4 $hier_obj hier_priority_switch_0

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_4 $hier_obj hier_strict_priority_0

  # Create instance: set_timestamp_P00, and set properties
  set set_timestamp_P00 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P00 ]

  # Create instance: set_timestamp_P01, and set properties
  set set_timestamp_P01 [ create_bd_cell -type ip -vlnv user.org:user:set_timestamp:1.0 set_timestamp_P01 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net hier_calc_et_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_calc_et_P0_m_axis [get_bd_intf_pins hier_calc_et_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M00_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M01_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M02_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M03_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M04_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_M05_AXIS [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins set_timestamp_P00/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins set_timestamp_P01/s_axis]
  connect_bd_intf_net -intf_net hier_strict_priority_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net s_axi_1 [get_bd_intf_pins s_axi] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net set_timestamp_P00_m_axis [get_bd_intf_pins hier_calc_et_P00/s_axis] [get_bd_intf_pins set_timestamp_P00/m_axis]
  connect_bd_intf_net -intf_net set_timestamp_P01_m_axis [get_bd_intf_pins hier_calc_et_P01/s_axis] [get_bd_intf_pins set_timestamp_P01/m_axis]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_calc_et_P00/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_calc_et_P01/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net ats_scheduler_timer_1 [get_bd_pins ats_scheduler_timer] [get_bd_pins set_timestamp_P00/ats_scheduler_timer] [get_bd_pins set_timestamp_P01/ats_scheduler_timer]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins rstn] [get_bd_pins hier_calc_et_P00/rstn] [get_bd_pins hier_calc_et_P01/rstn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins set_timestamp_P00/rstn] [get_bd_pins set_timestamp_P01/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins clk] [get_bd_pins hier_calc_et_P00/clk] [get_bd_pins hier_calc_et_P01/clk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins set_timestamp_P00/clk] [get_bd_pins set_timestamp_P01/clk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_mac_3
proc create_hier_cell_hier_mac_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_mac_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_3

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 tx_axis_mac


  # Create pins
  create_bd_pin -dir O activity_flash_3
  create_bd_pin -dir I chk_tx_data
  create_bd_pin -dir I config_board
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir O frame_error_3
  create_bd_pin -dir I gen_tx_data
  create_bd_pin -dir I -type rst glbl_rst
  create_bd_pin -dir I -type clk gtx_clk
  create_bd_pin -dir I -type clk gtx_clk90
  create_bd_pin -dir I gtx_clk_bufg
  create_bd_pin -dir I -from 1 -to 0 mac_speed
  create_bd_pin -dir I pause_req_s
  create_bd_pin -dir I -type rst reset_error
  create_bd_pin -dir O -type rst reset_port_3
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir O -type clk tx_axis_mac_aclk
  create_bd_pin -dir O -type rst tx_reset
  create_bd_pin -dir I update_speed

  # Create instance: eth_driver_3, and set properties
  set block_name tri_mode_ethernet_mac_0_example_design_mod
  set block_cell_name eth_driver_3
  if { [catch {set eth_driver_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_driver_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: temac_3, and set properties
  set temac_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_3 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_3

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_3_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_3/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_3_s_axi [get_bd_intf_pins eth_driver_3/s_axi] [get_bd_intf_pins temac_3/s_axi]
  connect_bd_intf_net -intf_net eth_driver_3_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_3/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_3_m_axis_rx [get_bd_intf_pins eth_driver_3/rx_axis_mac] [get_bd_intf_pins temac_3/m_axis_rx]
  connect_bd_intf_net -intf_net temac_3_mdio_external [get_bd_intf_pins mdio_io_port_3] [get_bd_intf_pins temac_3/mdio_external]
  connect_bd_intf_net -intf_net temac_3_rgmii [get_bd_intf_pins rgmii_port_3] [get_bd_intf_pins temac_3/rgmii]

  # Create port connections
  connect_bd_net -net chk_tx_data_1 [get_bd_pins chk_tx_data] [get_bd_pins eth_driver_3/chk_tx_data]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins gtx_clk_bufg] [get_bd_pins eth_driver_3/gtx_clk_bufg]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins s_axi_aclk] [get_bd_pins eth_driver_3/s_axi_aclk] [get_bd_pins temac_3/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins dcm_locked] [get_bd_pins eth_driver_3/dcm_locked]
  connect_bd_net -net config_board_1 [get_bd_pins config_board] [get_bd_pins eth_driver_3/config_board]
  connect_bd_net -net eth_driver_3_activity_flash [get_bd_pins activity_flash_3] [get_bd_pins eth_driver_3/activity_flash]
  connect_bd_net -net eth_driver_3_frame_error [get_bd_pins frame_error_3] [get_bd_pins eth_driver_3/frame_error]
  connect_bd_net -net eth_driver_3_glbl_rstn [get_bd_pins eth_driver_3/glbl_rstn] [get_bd_pins temac_3/glbl_rstn]
  connect_bd_net -net eth_driver_3_pause_req [get_bd_pins eth_driver_3/pause_req] [get_bd_pins temac_3/pause_req]
  connect_bd_net -net eth_driver_3_pause_val [get_bd_pins eth_driver_3/pause_val] [get_bd_pins temac_3/pause_val]
  connect_bd_net -net eth_driver_3_phy_resetn [get_bd_pins reset_port_3] [get_bd_pins eth_driver_3/phy_resetn]
  connect_bd_net -net eth_driver_3_rx_axi_rstn [get_bd_pins eth_driver_3/rx_axi_rstn] [get_bd_pins temac_3/rx_axi_rstn]
  connect_bd_net -net eth_driver_3_s_axi_resetn [get_bd_pins eth_driver_3/s_axi_resetn] [get_bd_pins temac_3/s_axi_resetn]
  connect_bd_net -net eth_driver_3_tx_axi_rstn [get_bd_pins eth_driver_3/tx_axi_rstn] [get_bd_pins temac_3/tx_axi_rstn]
  connect_bd_net -net eth_driver_3_tx_ifg_delay [get_bd_pins eth_driver_3/tx_ifg_delay] [get_bd_pins temac_3/tx_ifg_delay]
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_3/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_3/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_5 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_3/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_3/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_3/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_3/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_3/gtx_clk]
  connect_bd_net -net temac_3_rx_mac_aclk [get_bd_pins eth_driver_3/rx_axis_mac_aclk] [get_bd_pins temac_3/rx_mac_aclk]
  connect_bd_net -net temac_3_rx_reset [get_bd_pins eth_driver_3/rx_reset] [get_bd_pins temac_3/rx_reset]
  connect_bd_net -net temac_3_rx_statistics_valid [get_bd_pins eth_driver_3/rx_statistics_valid] [get_bd_pins temac_3/rx_statistics_valid]
  connect_bd_net -net temac_3_rx_statistics_vector [get_bd_pins eth_driver_3/rx_statistics_vector] [get_bd_pins temac_3/rx_statistics_vector]
  connect_bd_net -net temac_3_tx_mac_aclk [get_bd_pins tx_axis_mac_aclk] [get_bd_pins eth_driver_3/tx_axis_mac_aclk] [get_bd_pins temac_3/tx_mac_aclk]
  connect_bd_net -net temac_3_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_3/tx_reset] [get_bd_pins temac_3/tx_reset]
  connect_bd_net -net temac_3_tx_statistics_valid [get_bd_pins eth_driver_3/tx_statistics_valid] [get_bd_pins temac_3/tx_statistics_valid]
  connect_bd_net -net temac_3_tx_statistics_vector [get_bd_pins eth_driver_3/tx_statistics_vector] [get_bd_pins temac_3/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_3/update_speed]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_mac_2
proc create_hier_cell_hier_mac_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_mac_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_2

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 tx_axis_mac


  # Create pins
  create_bd_pin -dir O activity_flash_2
  create_bd_pin -dir I chk_tx_data
  create_bd_pin -dir I config_board
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir O frame_error_2
  create_bd_pin -dir I gen_tx_data
  create_bd_pin -dir I -type rst glbl_rst
  create_bd_pin -dir I -type clk gtx_clk
  create_bd_pin -dir I -type clk gtx_clk90
  create_bd_pin -dir I gtx_clk_bufg
  create_bd_pin -dir I -from 1 -to 0 mac_speed
  create_bd_pin -dir I pause_req_s
  create_bd_pin -dir I -type rst reset_error
  create_bd_pin -dir O -type rst reset_port_2
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir O -type clk tx_axis_mac_aclk
  create_bd_pin -dir O -type rst tx_reset
  create_bd_pin -dir I update_speed

  # Create instance: eth_driver_2, and set properties
  set block_name tri_mode_ethernet_mac_0_example_design_mod
  set block_cell_name eth_driver_2
  if { [catch {set eth_driver_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_driver_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: temac_2, and set properties
  set temac_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_2 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_2

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_2_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_2/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_2_s_axi [get_bd_intf_pins eth_driver_2/s_axi] [get_bd_intf_pins temac_2/s_axi]
  connect_bd_intf_net -intf_net eth_driver_2_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_2/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_2_m_axis_rx [get_bd_intf_pins eth_driver_2/rx_axis_mac] [get_bd_intf_pins temac_2/m_axis_rx]
  connect_bd_intf_net -intf_net temac_2_mdio_external [get_bd_intf_pins mdio_io_port_2] [get_bd_intf_pins temac_2/mdio_external]
  connect_bd_intf_net -intf_net temac_2_rgmii [get_bd_intf_pins rgmii_port_2] [get_bd_intf_pins temac_2/rgmii]

  # Create port connections
  connect_bd_net -net chk_tx_data_1 [get_bd_pins chk_tx_data] [get_bd_pins eth_driver_2/chk_tx_data]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins gtx_clk_bufg] [get_bd_pins eth_driver_2/gtx_clk_bufg]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins s_axi_aclk] [get_bd_pins eth_driver_2/s_axi_aclk] [get_bd_pins temac_2/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins dcm_locked] [get_bd_pins eth_driver_2/dcm_locked]
  connect_bd_net -net config_board_1 [get_bd_pins config_board] [get_bd_pins eth_driver_2/config_board]
  connect_bd_net -net eth_driver_2_activity_flash [get_bd_pins activity_flash_2] [get_bd_pins eth_driver_2/activity_flash]
  connect_bd_net -net eth_driver_2_frame_error [get_bd_pins frame_error_2] [get_bd_pins eth_driver_2/frame_error]
  connect_bd_net -net eth_driver_2_glbl_rstn [get_bd_pins eth_driver_2/glbl_rstn] [get_bd_pins temac_2/glbl_rstn]
  connect_bd_net -net eth_driver_2_pause_req [get_bd_pins eth_driver_2/pause_req] [get_bd_pins temac_2/pause_req]
  connect_bd_net -net eth_driver_2_pause_val [get_bd_pins eth_driver_2/pause_val] [get_bd_pins temac_2/pause_val]
  connect_bd_net -net eth_driver_2_phy_resetn [get_bd_pins reset_port_2] [get_bd_pins eth_driver_2/phy_resetn]
  connect_bd_net -net eth_driver_2_rx_axi_rstn [get_bd_pins eth_driver_2/rx_axi_rstn] [get_bd_pins temac_2/rx_axi_rstn]
  connect_bd_net -net eth_driver_2_s_axi_resetn [get_bd_pins eth_driver_2/s_axi_resetn] [get_bd_pins temac_2/s_axi_resetn]
  connect_bd_net -net eth_driver_2_tx_axi_rstn [get_bd_pins eth_driver_2/tx_axi_rstn] [get_bd_pins temac_2/tx_axi_rstn]
  connect_bd_net -net eth_driver_2_tx_ifg_delay [get_bd_pins eth_driver_2/tx_ifg_delay] [get_bd_pins temac_2/tx_ifg_delay]
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_2/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_2/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_4 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_2/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_2/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_2/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_2/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_2/gtx_clk]
  connect_bd_net -net temac_2_rx_mac_aclk [get_bd_pins eth_driver_2/rx_axis_mac_aclk] [get_bd_pins temac_2/rx_mac_aclk]
  connect_bd_net -net temac_2_rx_reset [get_bd_pins eth_driver_2/rx_reset] [get_bd_pins temac_2/rx_reset]
  connect_bd_net -net temac_2_rx_statistics_valid [get_bd_pins eth_driver_2/rx_statistics_valid] [get_bd_pins temac_2/rx_statistics_valid]
  connect_bd_net -net temac_2_rx_statistics_vector [get_bd_pins eth_driver_2/rx_statistics_vector] [get_bd_pins temac_2/rx_statistics_vector]
  connect_bd_net -net temac_2_tx_mac_aclk [get_bd_pins tx_axis_mac_aclk] [get_bd_pins eth_driver_2/tx_axis_mac_aclk] [get_bd_pins temac_2/tx_mac_aclk]
  connect_bd_net -net temac_2_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_2/tx_reset] [get_bd_pins temac_2/tx_reset]
  connect_bd_net -net temac_2_tx_statistics_valid [get_bd_pins eth_driver_2/tx_statistics_valid] [get_bd_pins temac_2/tx_statistics_valid]
  connect_bd_net -net temac_2_tx_statistics_vector [get_bd_pins eth_driver_2/tx_statistics_vector] [get_bd_pins temac_2/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_2/update_speed]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_mac_1
proc create_hier_cell_hier_mac_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_mac_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_1

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 tx_axis_mac


  # Create pins
  create_bd_pin -dir O activity_flash_1
  create_bd_pin -dir I chk_tx_data
  create_bd_pin -dir I config_board
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir O frame_error_1
  create_bd_pin -dir I gen_tx_data
  create_bd_pin -dir I -type rst glbl_rst
  create_bd_pin -dir I -type clk gtx_clk
  create_bd_pin -dir I -type clk gtx_clk90
  create_bd_pin -dir I gtx_clk_bufg
  create_bd_pin -dir I -from 1 -to 0 mac_speed
  create_bd_pin -dir I pause_req_s
  create_bd_pin -dir I -type rst reset_error
  create_bd_pin -dir O -type rst reset_port_1
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir O -type clk tx_axis_mac_aclk
  create_bd_pin -dir O -type rst tx_reset
  create_bd_pin -dir I update_speed

  # Create instance: eth_driver_1, and set properties
  set block_name tri_mode_ethernet_mac_0_example_design_mod
  set block_cell_name eth_driver_1
  if { [catch {set eth_driver_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_driver_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: temac_1, and set properties
  set temac_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_1 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_1

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_1_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_1/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_1_s_axi [get_bd_intf_pins eth_driver_1/s_axi] [get_bd_intf_pins temac_1/s_axi]
  connect_bd_intf_net -intf_net eth_driver_1_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_1/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_1_m_axis_rx [get_bd_intf_pins eth_driver_1/rx_axis_mac] [get_bd_intf_pins temac_1/m_axis_rx]
  connect_bd_intf_net -intf_net temac_1_mdio_external [get_bd_intf_pins mdio_io_port_1] [get_bd_intf_pins temac_1/mdio_external]
  connect_bd_intf_net -intf_net temac_1_rgmii [get_bd_intf_pins rgmii_port_1] [get_bd_intf_pins temac_1/rgmii]

  # Create port connections
  connect_bd_net -net chk_tx_data_1 [get_bd_pins chk_tx_data] [get_bd_pins eth_driver_1/chk_tx_data]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins gtx_clk_bufg] [get_bd_pins eth_driver_1/gtx_clk_bufg]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins s_axi_aclk] [get_bd_pins eth_driver_1/s_axi_aclk] [get_bd_pins temac_1/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins dcm_locked] [get_bd_pins eth_driver_1/dcm_locked]
  connect_bd_net -net config_board_1 [get_bd_pins config_board] [get_bd_pins eth_driver_1/config_board]
  connect_bd_net -net eth_driver_1_activity_flash [get_bd_pins activity_flash_1] [get_bd_pins eth_driver_1/activity_flash]
  connect_bd_net -net eth_driver_1_frame_error [get_bd_pins frame_error_1] [get_bd_pins eth_driver_1/frame_error]
  connect_bd_net -net eth_driver_1_glbl_rstn [get_bd_pins eth_driver_1/glbl_rstn] [get_bd_pins temac_1/glbl_rstn]
  connect_bd_net -net eth_driver_1_pause_req [get_bd_pins eth_driver_1/pause_req] [get_bd_pins temac_1/pause_req]
  connect_bd_net -net eth_driver_1_pause_val [get_bd_pins eth_driver_1/pause_val] [get_bd_pins temac_1/pause_val]
  connect_bd_net -net eth_driver_1_phy_resetn [get_bd_pins reset_port_1] [get_bd_pins eth_driver_1/phy_resetn]
  connect_bd_net -net eth_driver_1_rx_axi_rstn [get_bd_pins eth_driver_1/rx_axi_rstn] [get_bd_pins temac_1/rx_axi_rstn]
  connect_bd_net -net eth_driver_1_s_axi_resetn [get_bd_pins eth_driver_1/s_axi_resetn] [get_bd_pins temac_1/s_axi_resetn]
  connect_bd_net -net eth_driver_1_tx_axi_rstn [get_bd_pins eth_driver_1/tx_axi_rstn] [get_bd_pins temac_1/tx_axi_rstn]
  connect_bd_net -net eth_driver_1_tx_ifg_delay [get_bd_pins eth_driver_1/tx_ifg_delay] [get_bd_pins temac_1/tx_ifg_delay]
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_1/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_1/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_3 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_1/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_1/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_1/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_1/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_1/gtx_clk]
  connect_bd_net -net temac_1_rx_mac_aclk [get_bd_pins eth_driver_1/rx_axis_mac_aclk] [get_bd_pins temac_1/rx_mac_aclk]
  connect_bd_net -net temac_1_rx_reset [get_bd_pins eth_driver_1/rx_reset] [get_bd_pins temac_1/rx_reset]
  connect_bd_net -net temac_1_rx_statistics_valid [get_bd_pins eth_driver_1/rx_statistics_valid] [get_bd_pins temac_1/rx_statistics_valid]
  connect_bd_net -net temac_1_rx_statistics_vector [get_bd_pins eth_driver_1/rx_statistics_vector] [get_bd_pins temac_1/rx_statistics_vector]
  connect_bd_net -net temac_1_tx_mac_aclk [get_bd_pins tx_axis_mac_aclk] [get_bd_pins eth_driver_1/tx_axis_mac_aclk] [get_bd_pins temac_1/tx_mac_aclk]
  connect_bd_net -net temac_1_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_1/tx_reset] [get_bd_pins temac_1/tx_reset]
  connect_bd_net -net temac_1_tx_statistics_valid [get_bd_pins eth_driver_1/tx_statistics_valid] [get_bd_pins temac_1/tx_statistics_valid]
  connect_bd_net -net temac_1_tx_statistics_vector [get_bd_pins eth_driver_1/tx_statistics_vector] [get_bd_pins temac_1/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_1/update_speed]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_mac_0
proc create_hier_cell_hier_mac_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_mac_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_0

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_tx

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 tx_axis_mac


  # Create pins
  create_bd_pin -dir O activity_flash_0
  create_bd_pin -dir I chk_tx_data
  create_bd_pin -dir I config_board
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir O frame_error_0
  create_bd_pin -dir I gen_tx_data
  create_bd_pin -dir I -type rst glbl_rst
  create_bd_pin -dir I -type clk gtx_clk
  create_bd_pin -dir O -type clk gtx_clk90_out
  create_bd_pin -dir O -type clk gtx_clk_out
  create_bd_pin -dir I -from 1 -to 0 mac_speed
  create_bd_pin -dir I pause_req_s
  create_bd_pin -dir I -type clk refclk
  create_bd_pin -dir I -type rst reset_error
  create_bd_pin -dir O -type rst reset_port_0
  create_bd_pin -dir O -type clk rx_mac_aclk
  create_bd_pin -dir O -type rst rx_reset
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir O -type clk tx_mac_aclk
  create_bd_pin -dir O -type rst tx_reset
  create_bd_pin -dir I update_speed

  # Create instance: eth_driver_0, and set properties
  set block_name tri_mode_ethernet_mac_0_example_design_mod
  set block_cell_name eth_driver_0
  if { [catch {set eth_driver_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $eth_driver_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: temac_0, and set properties
  set temac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_0 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {1} \
 ] $temac_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_0_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_0/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_0_s_axi [get_bd_intf_pins eth_driver_0/s_axi] [get_bd_intf_pins temac_0/s_axi]
  connect_bd_intf_net -intf_net eth_driver_0_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_0/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_0_m_axis_rx [get_bd_intf_pins eth_driver_0/rx_axis_mac] [get_bd_intf_pins temac_0/m_axis_rx]
  connect_bd_intf_net -intf_net temac_0_mdio_external [get_bd_intf_pins mdio_io_port_0] [get_bd_intf_pins temac_0/mdio_external]
  connect_bd_intf_net -intf_net temac_0_rgmii [get_bd_intf_pins rgmii_port_0] [get_bd_intf_pins temac_0/rgmii]

  # Create port connections
  connect_bd_net -net chk_tx_data_1 [get_bd_pins chk_tx_data] [get_bd_pins eth_driver_0/chk_tx_data]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins gtx_clk] [get_bd_pins eth_driver_0/gtx_clk_bufg] [get_bd_pins temac_0/gtx_clk]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins s_axi_aclk] [get_bd_pins eth_driver_0/s_axi_aclk] [get_bd_pins temac_0/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins refclk] [get_bd_pins temac_0/refclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins dcm_locked] [get_bd_pins eth_driver_0/dcm_locked]
  connect_bd_net -net config_board_1 [get_bd_pins config_board] [get_bd_pins eth_driver_0/config_board]
  connect_bd_net -net eth_driver_0_activity_flash [get_bd_pins activity_flash_0] [get_bd_pins eth_driver_0/activity_flash]
  connect_bd_net -net eth_driver_0_frame_error [get_bd_pins frame_error_0] [get_bd_pins eth_driver_0/frame_error]
  connect_bd_net -net eth_driver_0_glbl_rstn [get_bd_pins eth_driver_0/glbl_rstn] [get_bd_pins temac_0/glbl_rstn]
  connect_bd_net -net eth_driver_0_pause_req [get_bd_pins eth_driver_0/pause_req] [get_bd_pins temac_0/pause_req]
  connect_bd_net -net eth_driver_0_pause_val [get_bd_pins eth_driver_0/pause_val] [get_bd_pins temac_0/pause_val]
  connect_bd_net -net eth_driver_0_phy_resetn [get_bd_pins reset_port_0] [get_bd_pins eth_driver_0/phy_resetn]
  connect_bd_net -net eth_driver_0_rx_axi_rstn [get_bd_pins eth_driver_0/rx_axi_rstn] [get_bd_pins temac_0/rx_axi_rstn]
  connect_bd_net -net eth_driver_0_s_axi_resetn [get_bd_pins eth_driver_0/s_axi_resetn] [get_bd_pins temac_0/s_axi_resetn]
  connect_bd_net -net eth_driver_0_tx_axi_rstn [get_bd_pins eth_driver_0/tx_axi_rstn] [get_bd_pins temac_0/tx_axi_rstn]
  connect_bd_net -net eth_driver_0_tx_ifg_delay [get_bd_pins eth_driver_0/tx_ifg_delay] [get_bd_pins temac_0/tx_ifg_delay]
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_0/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_0/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_2 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_0/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_0/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_0/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90_out] [get_bd_pins temac_0/gtx_clk90_out]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk_out] [get_bd_pins temac_0/gtx_clk_out]
  connect_bd_net -net temac_0_rx_mac_aclk [get_bd_pins rx_mac_aclk] [get_bd_pins eth_driver_0/rx_axis_mac_aclk] [get_bd_pins temac_0/rx_mac_aclk]
  connect_bd_net -net temac_0_rx_reset [get_bd_pins rx_reset] [get_bd_pins eth_driver_0/rx_reset] [get_bd_pins temac_0/rx_reset]
  connect_bd_net -net temac_0_rx_statistics_valid [get_bd_pins eth_driver_0/rx_statistics_valid] [get_bd_pins temac_0/rx_statistics_valid]
  connect_bd_net -net temac_0_rx_statistics_vector [get_bd_pins eth_driver_0/rx_statistics_vector] [get_bd_pins temac_0/rx_statistics_vector]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_0/tx_axis_mac_aclk] [get_bd_pins temac_0/tx_mac_aclk]
  connect_bd_net -net temac_0_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_0/tx_reset] [get_bd_pins temac_0/tx_reset]
  connect_bd_net -net temac_0_tx_statistics_valid [get_bd_pins eth_driver_0/tx_statistics_valid] [get_bd_pins temac_0/tx_statistics_valid]
  connect_bd_net -net temac_0_tx_statistics_vector [get_bd_pins eth_driver_0/tx_statistics_vector] [get_bd_pins temac_0/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_0/update_speed]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_flow_control
proc create_hier_cell_hier_flow_control { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_flow_control() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI


  # Create pins
  create_bd_pin -dir I -from 0 -to 0 almost_full_0
  create_bd_pin -dir I -from 0 -to 0 almost_full_1
  create_bd_pin -dir I -from 0 -to 0 almost_full_2
  create_bd_pin -dir I -from 0 -to 0 almost_full_3
  create_bd_pin -dir I -type clk fifo_rd_clk
  create_bd_pin -dir I -type clk fifo_wr_clk
  create_bd_pin -dir O -from 0 -to 0 pause_req_0
  create_bd_pin -dir O -from 0 -to 0 pause_req_1
  create_bd_pin -dir O -from 0 -to 0 pause_req_2
  create_bd_pin -dir O -from 0 -to 0 pause_req_3
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_gpio_flow_control, and set properties
  set axi_gpio_flow_control [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_flow_control ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {0} \
   CONFIG.C_DOUT_DEFAULT {0x00000000} \
   CONFIG.C_DOUT_DEFAULT_2 {0x00000000} \
   CONFIG.C_GPIO_WIDTH {1} \
   CONFIG.C_IS_DUAL {0} \
 ] $axi_gpio_flow_control

  # Create instance: constant_0, and set properties
  set constant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $constant_0

  # Create instance: constant_1, and set properties
  set constant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 constant_1 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Data_Count_Width {4} \
   CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {0} \
   CONFIG.Full_Threshold_Assert_Value {13} \
   CONFIG.Full_Threshold_Negate_Value {12} \
   CONFIG.Input_Data_Width {1} \
   CONFIG.Input_Depth {16} \
   CONFIG.Output_Data_Width {1} \
   CONFIG.Output_Depth {16} \
   CONFIG.Read_Data_Count_Width {4} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Write_Data_Count_Width {4} \
 ] $fifo_generator_0

  # Create instance: fifo_generator_1, and set properties
  set fifo_generator_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_1 ]
  set_property -dict [ list \
   CONFIG.Data_Count_Width {4} \
   CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {0} \
   CONFIG.Full_Threshold_Assert_Value {13} \
   CONFIG.Full_Threshold_Negate_Value {12} \
   CONFIG.Input_Data_Width {1} \
   CONFIG.Input_Depth {16} \
   CONFIG.Output_Data_Width {1} \
   CONFIG.Output_Depth {16} \
   CONFIG.Read_Data_Count_Width {4} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Write_Data_Count_Width {4} \
 ] $fifo_generator_1

  # Create instance: fifo_generator_2, and set properties
  set fifo_generator_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_2 ]
  set_property -dict [ list \
   CONFIG.Data_Count_Width {4} \
   CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {0} \
   CONFIG.Full_Threshold_Assert_Value {13} \
   CONFIG.Full_Threshold_Negate_Value {12} \
   CONFIG.Input_Data_Width {1} \
   CONFIG.Input_Depth {16} \
   CONFIG.Output_Data_Width {1} \
   CONFIG.Output_Depth {16} \
   CONFIG.Read_Data_Count_Width {4} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Write_Data_Count_Width {4} \
 ] $fifo_generator_2

  # Create instance: fifo_generator_3, and set properties
  set fifo_generator_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_3 ]
  set_property -dict [ list \
   CONFIG.Data_Count_Width {4} \
   CONFIG.Fifo_Implementation {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {0} \
   CONFIG.Full_Threshold_Assert_Value {13} \
   CONFIG.Full_Threshold_Negate_Value {12} \
   CONFIG.Input_Data_Width {1} \
   CONFIG.Input_Depth {16} \
   CONFIG.Output_Data_Width {1} \
   CONFIG.Output_Depth {16} \
   CONFIG.Read_Data_Count_Width {4} \
   CONFIG.Reset_Pin {false} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.Use_Dout_Reset {false} \
   CONFIG.Write_Data_Count_Width {4} \
 ] $fifo_generator_3

  # Create instance: util_ff_0, and set properties
  set util_ff_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ff:1.0 util_ff_0 ]

  # Create instance: util_vector_logic_and_0, and set properties
  set util_vector_logic_and_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_and_0 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_and_0

  # Create instance: util_vector_logic_and_1, and set properties
  set util_vector_logic_and_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_and_1 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_and_1

  # Create instance: util_vector_logic_and_2, and set properties
  set util_vector_logic_and_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_and_2 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_and_2

  # Create instance: util_vector_logic_and_3, and set properties
  set util_vector_logic_and_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_and_3 ]
  set_property -dict [ list \
   CONFIG.C_SIZE {1} \
 ] $util_vector_logic_and_3

  # Create interface connections
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_flow_control/S_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_flow_control_gpio_io_o [get_bd_pins util_ff_0/Q] [get_bd_pins util_vector_logic_and_0/Op2] [get_bd_pins util_vector_logic_and_1/Op2] [get_bd_pins util_vector_logic_and_2/Op2] [get_bd_pins util_vector_logic_and_3/Op2]
  connect_bd_net -net axi_gpio_flow_control_gpio_io_o1 [get_bd_pins axi_gpio_flow_control/gpio_io_o] [get_bd_pins util_ff_0/D]
  connect_bd_net -net axis_data_fifo_swin_0_prog_full [get_bd_pins almost_full_0] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net axis_data_fifo_swin_1_prog_full [get_bd_pins almost_full_1] [get_bd_pins fifo_generator_1/din]
  connect_bd_net -net axis_data_fifo_swin_2_prog_full [get_bd_pins almost_full_2] [get_bd_pins fifo_generator_2/din]
  connect_bd_net -net axis_data_fifo_swin_3_prog_full [get_bd_pins almost_full_3] [get_bd_pins fifo_generator_3/din]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins fifo_rd_clk] [get_bd_pins axi_gpio_flow_control/s_axi_aclk] [get_bd_pins fifo_generator_0/rd_clk] [get_bd_pins fifo_generator_1/rd_clk] [get_bd_pins fifo_generator_2/rd_clk] [get_bd_pins fifo_generator_3/rd_clk] [get_bd_pins util_ff_0/clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_flow_control/s_axi_aresetn]
  connect_bd_net -net constant_0_dout [get_bd_pins constant_0/dout] [get_bd_pins util_ff_0/reset]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins fifo_generator_0/dout] [get_bd_pins util_vector_logic_and_0/Op1]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins fifo_generator_1/dout] [get_bd_pins util_vector_logic_and_1/Op1]
  connect_bd_net -net fifo_generator_2_dout [get_bd_pins fifo_generator_2/dout] [get_bd_pins util_vector_logic_and_2/Op1]
  connect_bd_net -net fifo_generator_3_dout [get_bd_pins fifo_generator_3/dout] [get_bd_pins util_vector_logic_and_3/Op1]
  connect_bd_net -net ref_clk_oe_dout [get_bd_pins constant_1/dout] [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins fifo_generator_1/wr_en] [get_bd_pins fifo_generator_2/rd_en] [get_bd_pins fifo_generator_2/wr_en] [get_bd_pins fifo_generator_3/rd_en] [get_bd_pins fifo_generator_3/wr_en] [get_bd_pins util_ff_0/clk_enable]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins fifo_wr_clk] [get_bd_pins fifo_generator_0/wr_clk] [get_bd_pins fifo_generator_1/wr_clk] [get_bd_pins fifo_generator_2/wr_clk] [get_bd_pins fifo_generator_3/wr_clk]
  connect_bd_net -net util_vector_logic_and_0_Res [get_bd_pins pause_req_0] [get_bd_pins util_vector_logic_and_0/Res]
  connect_bd_net -net util_vector_logic_and_1_Res [get_bd_pins pause_req_1] [get_bd_pins util_vector_logic_and_1/Res]
  connect_bd_net -net util_vector_logic_and_2_Res [get_bd_pins pause_req_2] [get_bd_pins util_vector_logic_and_2/Res]
  connect_bd_net -net util_vector_logic_and_3_Res [get_bd_pins pause_req_3] [get_bd_pins util_vector_logic_and_3/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch
proc create_hier_cell_hier_eth_switch { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_S01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_S02

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_S03

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_S00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_S02

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_S03

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_S00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_S01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_S03

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_S00

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_S01

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_S02

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_s00, and set properties
  set axis_interconnect_s00 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_s00 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_BASETDEST {0x00000001} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_AXIS_BASETDEST {0x00000002} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_AXIS_BASETDEST {0x00000003} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {3} \
 ] $axis_interconnect_s00

  # Create instance: axis_interconnect_s01, and set properties
  set axis_interconnect_s01 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_s01 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000002} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_AXIS_BASETDEST {0x00000003} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {3} \
 ] $axis_interconnect_s01

  # Create instance: axis_interconnect_s02, and set properties
  set axis_interconnect_s02 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_s02 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000003} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {3} \
 ] $axis_interconnect_s02

  # Create instance: axis_interconnect_s03, and set properties
  set axis_interconnect_s03 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_s03 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.NUM_MI {3} \
 ] $axis_interconnect_s03

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {4} \
 ] $axis_switch_0

  # Create instance: channel_in_mod_0, and set properties
  set block_name channel_in_mod
  set block_cell_name channel_in_mod_0
  if { [catch {set channel_in_mod_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $channel_in_mod_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.FLOODING_ENABLE {0} \
 ] $channel_in_mod_0

  # Create instance: channel_in_mod_1, and set properties
  set block_name channel_in_mod
  set block_cell_name channel_in_mod_1
  if { [catch {set channel_in_mod_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $channel_in_mod_1 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.FLOODING_ENABLE {0} \
   CONFIG.PORT_ADDR {1} \
 ] $channel_in_mod_1

  # Create instance: channel_in_mod_2, and set properties
  set block_name channel_in_mod
  set block_cell_name channel_in_mod_2
  if { [catch {set channel_in_mod_2 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $channel_in_mod_2 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.FLOODING_ENABLE {0} \
   CONFIG.PORT_ADDR {2} \
 ] $channel_in_mod_2

  # Create instance: channel_in_mod_3, and set properties
  set block_name channel_in_mod
  set block_cell_name channel_in_mod_3
  if { [catch {set channel_in_mod_3 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $channel_in_mod_3 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.FLOODING_ENABLE {0} \
   CONFIG.PORT_ADDR {3} \
 ] $channel_in_mod_3

  # Create instance: mactable_0, and set properties
  set block_name mactable
  set block_cell_name mactable_0
  if { [catch {set mactable_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mactable_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.MODE {dynamic} \
   CONFIG.PORT_WIDTH {2} \
 ] $mactable_0

  # Create instance: xlconstant_val_0, and set properties
  set xlconstant_val_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_val_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_val_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_1 [get_bd_intf_pins S00] [get_bd_intf_pins channel_in_mod_0/s_axis]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins axis_interconnect_s01/S00_AXIS] [get_bd_intf_pins channel_in_mod_1/m_axis]
  connect_bd_intf_net -intf_net S01_1 [get_bd_intf_pins S01] [get_bd_intf_pins channel_in_mod_1/s_axis]
  connect_bd_intf_net -intf_net S02_1 [get_bd_intf_pins S02] [get_bd_intf_pins channel_in_mod_2/s_axis]
  connect_bd_intf_net -intf_net S03_1 [get_bd_intf_pins S03] [get_bd_intf_pins channel_in_mod_3/s_axis]
  connect_bd_intf_net -intf_net axis_interconnect_s00_M00_AXIS [get_bd_intf_pins M01_S00] [get_bd_intf_pins axis_interconnect_s00/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s00_M01_AXIS [get_bd_intf_pins M02_S00] [get_bd_intf_pins axis_interconnect_s00/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s00_M02_AXIS [get_bd_intf_pins M03_S00] [get_bd_intf_pins axis_interconnect_s00/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s01_M00_AXIS [get_bd_intf_pins M00_S01] [get_bd_intf_pins axis_interconnect_s01/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s01_M01_AXIS [get_bd_intf_pins M02_S01] [get_bd_intf_pins axis_interconnect_s01/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s01_M02_AXIS [get_bd_intf_pins M03_S01] [get_bd_intf_pins axis_interconnect_s01/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s02_M00_AXIS [get_bd_intf_pins M00_S02] [get_bd_intf_pins axis_interconnect_s02/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s02_M01_AXIS [get_bd_intf_pins M01_S02] [get_bd_intf_pins axis_interconnect_s02/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s02_M02_AXIS [get_bd_intf_pins M03_S02] [get_bd_intf_pins axis_interconnect_s02/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s03_M00_AXIS [get_bd_intf_pins M00_S03] [get_bd_intf_pins axis_interconnect_s03/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s03_M01_AXIS [get_bd_intf_pins M01_S03] [get_bd_intf_pins axis_interconnect_s03/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_s03_M02_AXIS [get_bd_intf_pins M02_S03] [get_bd_intf_pins axis_interconnect_s03/M02_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins mactable_0/s_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_0_m_axis [get_bd_intf_pins axis_interconnect_s00/S00_AXIS] [get_bd_intf_pins channel_in_mod_0/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_0_m_axis_table_request [get_bd_intf_pins axis_switch_0/S00_AXIS] [get_bd_intf_pins channel_in_mod_0/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_1_m_axis_table_request [get_bd_intf_pins axis_switch_0/S01_AXIS] [get_bd_intf_pins channel_in_mod_1/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_2_m_axis [get_bd_intf_pins axis_interconnect_s02/S00_AXIS] [get_bd_intf_pins channel_in_mod_2/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_2_m_axis_table_request [get_bd_intf_pins axis_switch_0/S02_AXIS] [get_bd_intf_pins channel_in_mod_2/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_3_m_axis [get_bd_intf_pins axis_interconnect_s03/S00_AXIS] [get_bd_intf_pins channel_in_mod_3/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_3_m_axis_table_request [get_bd_intf_pins axis_switch_0/S03_AXIS] [get_bd_intf_pins channel_in_mod_3/m_axis_table_request]

  # Create port connections
  connect_bd_net -net mactable_0_m_axis_table_response_tdata [get_bd_pins channel_in_mod_0/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_1/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_2/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_3/s_axis_table_response_tdata] [get_bd_pins mactable_0/m_axis_table_response_tdata]
  connect_bd_net -net mactable_0_m_axis_table_response_tuser [get_bd_pins channel_in_mod_0/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_1/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_2/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_3/s_axis_table_response_tuser] [get_bd_pins mactable_0/m_axis_table_response_tuser]
  connect_bd_net -net mactable_0_m_axis_table_response_tvalid [get_bd_pins channel_in_mod_0/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_1/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_2/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_3/s_axis_table_response_tvalid] [get_bd_pins mactable_0/m_axis_table_response_tvalid]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_s00/ARESETN] [get_bd_pins axis_interconnect_s00/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s00/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_s00/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_s00/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s01/ARESETN] [get_bd_pins axis_interconnect_s01/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s01/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_s01/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_s01/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s02/ARESETN] [get_bd_pins axis_interconnect_s02/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s02/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_s02/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_s02/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s03/ARESETN] [get_bd_pins axis_interconnect_s03/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_s03/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_s03/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_s03/S00_AXIS_ARESETN] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins channel_in_mod_0/aresetn] [get_bd_pins channel_in_mod_1/aresetn] [get_bd_pins channel_in_mod_2/aresetn] [get_bd_pins channel_in_mod_3/aresetn] [get_bd_pins mactable_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_s00/ACLK] [get_bd_pins axis_interconnect_s00/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_s00/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_s00/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_s00/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_s01/ACLK] [get_bd_pins axis_interconnect_s01/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_s01/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_s01/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_s01/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_s02/ACLK] [get_bd_pins axis_interconnect_s02/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_s02/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_s02/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_s02/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_s03/ACLK] [get_bd_pins axis_interconnect_s03/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_s03/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_s03/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_s03/S00_AXIS_ACLK] [get_bd_pins axis_switch_0/aclk] [get_bd_pins channel_in_mod_0/aclk] [get_bd_pins channel_in_mod_1/aclk] [get_bd_pins channel_in_mod_2/aclk] [get_bd_pins channel_in_mod_3/aclk] [get_bd_pins mactable_0/aclk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axis_switch_0/s_req_suppress] [get_bd_pins mactable_0/s_axis_table_config_tvalid] [get_bd_pins xlconstant_val_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_ats_3
proc create_hier_cell_hier_ats_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_ats_3() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: hier_et_gate_P00
  create_hier_cell_hier_et_gate_P00_3 $hier_obj hier_et_gate_P00

  # Create instance: hier_et_gate_P01
  create_hier_cell_hier_et_gate_P01_3 $hier_obj hier_et_gate_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_3 $hier_obj hier_priority_switch_0

  # Create instance: hier_priority_switch_1
  create_hier_cell_hier_priority_switch_1_3 $hier_obj hier_priority_switch_1

  # Create instance: hier_priority_switch_2
  create_hier_cell_hier_priority_switch_2_3 $hier_obj hier_priority_switch_2

  # Create instance: hier_queue_ATS_P00_0
  create_hier_cell_hier_queue_ATS_P00_0_3 $hier_obj hier_queue_ATS_P00_0

  # Create instance: hier_queue_ATS_P00_1
  create_hier_cell_hier_queue_ATS_P00_1_3 $hier_obj hier_queue_ATS_P00_1

  # Create instance: hier_queue_ATS_P00_2
  create_hier_cell_hier_queue_ATS_P00_2_3 $hier_obj hier_queue_ATS_P00_2

  # Create instance: hier_queue_ATS_P01_0
  create_hier_cell_hier_queue_ATS_P01_0_3 $hier_obj hier_queue_ATS_P01_0

  # Create instance: hier_queue_ATS_P01_1
  create_hier_cell_hier_queue_ATS_P01_1_3 $hier_obj hier_queue_ATS_P01_1

  # Create instance: hier_queue_ATS_P01_2
  create_hier_cell_hier_queue_ATS_P01_2_3 $hier_obj hier_queue_ATS_P01_2

  # Create instance: hier_queue_FIFO_0
  create_hier_cell_hier_queue_FIFO_0_3 $hier_obj hier_queue_FIFO_0

  # Create instance: hier_queue_FIFO_1
  create_hier_cell_hier_queue_FIFO_1_3 $hier_obj hier_queue_FIFO_1

  # Create instance: hier_queue_FIFO_2
  create_hier_cell_hier_queue_FIFO_2_3 $hier_obj hier_queue_FIFO_2

  # Create instance: hier_round_robin_P00
  create_hier_cell_hier_round_robin_P00_3 $hier_obj hier_round_robin_P00

  # Create instance: hier_round_robin_P01
  create_hier_cell_hier_round_robin_P01_3 $hier_obj hier_round_robin_P01

  # Create instance: hier_round_robin_TC0
  create_hier_cell_hier_round_robin_TC0_3 $hier_obj hier_round_robin_TC0

  # Create instance: hier_round_robin_TC1
  create_hier_cell_hier_round_robin_TC1_3 $hier_obj hier_round_robin_TC1

  # Create instance: hier_round_robin_TC2
  create_hier_cell_hier_round_robin_TC2_3 $hier_obj hier_round_robin_TC2

  # Create instance: hier_round_robin_TC3
  create_hier_cell_hier_round_robin_TC3_3 $hier_obj hier_round_robin_TC3

  # Create instance: hier_round_robin_TC4
  create_hier_cell_hier_round_robin_TC4_3 $hier_obj hier_round_robin_TC4

  # Create instance: hier_round_robin_TC5
  create_hier_cell_hier_round_robin_TC5_3 $hier_obj hier_round_robin_TC5

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_3 $hier_obj hier_strict_priority_0

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_0 [get_bd_intf_pins hier_et_gate_P00/m_axis_0] [get_bd_intf_pins hier_round_robin_P00/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_1 [get_bd_intf_pins hier_et_gate_P00/m_axis_1] [get_bd_intf_pins hier_round_robin_P00/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_2 [get_bd_intf_pins hier_et_gate_P00/m_axis_2] [get_bd_intf_pins hier_round_robin_P00/s_axis_2]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_0 [get_bd_intf_pins hier_et_gate_P01/m_axis_0] [get_bd_intf_pins hier_round_robin_P01/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_1 [get_bd_intf_pins hier_et_gate_P01/m_axis_1] [get_bd_intf_pins hier_round_robin_P01/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_2 [get_bd_intf_pins hier_et_gate_P01/m_axis_2] [get_bd_intf_pins hier_round_robin_P01/s_axis_2]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S01 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P00 [get_bd_intf_pins hier_priority_switch_1/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P01 [get_bd_intf_pins hier_priority_switch_1/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P00 [get_bd_intf_pins hier_priority_switch_2/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P01 [get_bd_intf_pins hier_priority_switch_2/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_round_robin_P00_m_axis [get_bd_intf_pins hier_round_robin_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_round_robin_P01_m_axis [get_bd_intf_pins hier_round_robin_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_round_robin_TC0_m_axis [get_bd_intf_pins hier_round_robin_TC0/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_round_robin_TC1_m_axis [get_bd_intf_pins hier_round_robin_TC1/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_round_robin_TC2_m_axis [get_bd_intf_pins hier_round_robin_TC2/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_round_robin_TC3_m_axis [get_bd_intf_pins hier_round_robin_TC3/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_round_robin_TC4_m_axis [get_bd_intf_pins hier_round_robin_TC4/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_round_robin_TC5_m_axis [get_bd_intf_pins hier_round_robin_TC5/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_eligibility_timestamp_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis_et]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins hier_priority_switch_1/s_axis]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins hier_priority_switch_2/s_axis]
  connect_bd_intf_net -intf_net s_axis_TC2_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC2]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC3]
  connect_bd_intf_net -intf_net s_axis_TC4_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC4]
  connect_bd_intf_net -intf_net s_axis_TC5_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC5]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_priority_switch_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_2/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins hier_et_gate_P00/aresetn] [get_bd_pins hier_et_gate_P01/aresetn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_priority_switch_1/rstn] [get_bd_pins hier_priority_switch_2/rstn] [get_bd_pins hier_queue_ATS_P00_0/rstn] [get_bd_pins hier_queue_ATS_P00_1/rstn] [get_bd_pins hier_queue_ATS_P00_2/rstn] [get_bd_pins hier_queue_ATS_P01_0/rstn] [get_bd_pins hier_queue_ATS_P01_1/rstn] [get_bd_pins hier_queue_ATS_P01_2/rstn] [get_bd_pins hier_queue_FIFO_0/rstn] [get_bd_pins hier_queue_FIFO_1/rstn] [get_bd_pins hier_queue_FIFO_2/rstn] [get_bd_pins hier_round_robin_P00/aresetn] [get_bd_pins hier_round_robin_P01/aresetn] [get_bd_pins hier_round_robin_TC0/aresetn] [get_bd_pins hier_round_robin_TC1/aresetn] [get_bd_pins hier_round_robin_TC2/aresetn] [get_bd_pins hier_round_robin_TC3/aresetn] [get_bd_pins hier_round_robin_TC4/aresetn] [get_bd_pins hier_round_robin_TC5/aresetn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins hier_et_gate_P00/processing_delay_max] [get_bd_pins hier_et_gate_P01/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins hier_et_gate_P00/aclk] [get_bd_pins hier_et_gate_P01/aclk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_priority_switch_1/clk] [get_bd_pins hier_priority_switch_2/clk] [get_bd_pins hier_queue_ATS_P00_0/clk] [get_bd_pins hier_queue_ATS_P00_1/clk] [get_bd_pins hier_queue_ATS_P00_2/clk] [get_bd_pins hier_queue_ATS_P01_0/clk] [get_bd_pins hier_queue_ATS_P01_1/clk] [get_bd_pins hier_queue_ATS_P01_2/clk] [get_bd_pins hier_queue_FIFO_0/clk] [get_bd_pins hier_queue_FIFO_1/clk] [get_bd_pins hier_queue_FIFO_2/clk] [get_bd_pins hier_round_robin_P00/aclk] [get_bd_pins hier_round_robin_P01/aclk] [get_bd_pins hier_round_robin_TC0/aclk] [get_bd_pins hier_round_robin_TC1/aclk] [get_bd_pins hier_round_robin_TC2/aclk] [get_bd_pins hier_round_robin_TC3/aclk] [get_bd_pins hier_round_robin_TC4/aclk] [get_bd_pins hier_round_robin_TC5/aclk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins hier_et_gate_P00/transmission_selection_timer] [get_bd_pins hier_et_gate_P01/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_ats_2
proc create_hier_cell_hier_ats_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_ats_2() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: hier_et_gate_P00
  create_hier_cell_hier_et_gate_P00_2 $hier_obj hier_et_gate_P00

  # Create instance: hier_et_gate_P01
  create_hier_cell_hier_et_gate_P01_2 $hier_obj hier_et_gate_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_2 $hier_obj hier_priority_switch_0

  # Create instance: hier_priority_switch_1
  create_hier_cell_hier_priority_switch_1_2 $hier_obj hier_priority_switch_1

  # Create instance: hier_priority_switch_2
  create_hier_cell_hier_priority_switch_2_2 $hier_obj hier_priority_switch_2

  # Create instance: hier_queue_ATS_P00_0
  create_hier_cell_hier_queue_ATS_P00_0_2 $hier_obj hier_queue_ATS_P00_0

  # Create instance: hier_queue_ATS_P00_1
  create_hier_cell_hier_queue_ATS_P00_1_2 $hier_obj hier_queue_ATS_P00_1

  # Create instance: hier_queue_ATS_P00_2
  create_hier_cell_hier_queue_ATS_P00_2_2 $hier_obj hier_queue_ATS_P00_2

  # Create instance: hier_queue_ATS_P01_0
  create_hier_cell_hier_queue_ATS_P01_0_2 $hier_obj hier_queue_ATS_P01_0

  # Create instance: hier_queue_ATS_P01_1
  create_hier_cell_hier_queue_ATS_P01_1_2 $hier_obj hier_queue_ATS_P01_1

  # Create instance: hier_queue_ATS_P01_2
  create_hier_cell_hier_queue_ATS_P01_2_2 $hier_obj hier_queue_ATS_P01_2

  # Create instance: hier_queue_FIFO_0
  create_hier_cell_hier_queue_FIFO_0_2 $hier_obj hier_queue_FIFO_0

  # Create instance: hier_queue_FIFO_1
  create_hier_cell_hier_queue_FIFO_1_2 $hier_obj hier_queue_FIFO_1

  # Create instance: hier_queue_FIFO_2
  create_hier_cell_hier_queue_FIFO_2_2 $hier_obj hier_queue_FIFO_2

  # Create instance: hier_round_robin_P00
  create_hier_cell_hier_round_robin_P00_2 $hier_obj hier_round_robin_P00

  # Create instance: hier_round_robin_P01
  create_hier_cell_hier_round_robin_P01_2 $hier_obj hier_round_robin_P01

  # Create instance: hier_round_robin_TC0
  create_hier_cell_hier_round_robin_TC0_2 $hier_obj hier_round_robin_TC0

  # Create instance: hier_round_robin_TC1
  create_hier_cell_hier_round_robin_TC1_2 $hier_obj hier_round_robin_TC1

  # Create instance: hier_round_robin_TC2
  create_hier_cell_hier_round_robin_TC2_2 $hier_obj hier_round_robin_TC2

  # Create instance: hier_round_robin_TC3
  create_hier_cell_hier_round_robin_TC3_2 $hier_obj hier_round_robin_TC3

  # Create instance: hier_round_robin_TC4
  create_hier_cell_hier_round_robin_TC4_2 $hier_obj hier_round_robin_TC4

  # Create instance: hier_round_robin_TC5
  create_hier_cell_hier_round_robin_TC5_2 $hier_obj hier_round_robin_TC5

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_2 $hier_obj hier_strict_priority_0

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_0 [get_bd_intf_pins hier_et_gate_P00/m_axis_0] [get_bd_intf_pins hier_round_robin_P00/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_1 [get_bd_intf_pins hier_et_gate_P00/m_axis_1] [get_bd_intf_pins hier_round_robin_P00/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_2 [get_bd_intf_pins hier_et_gate_P00/m_axis_2] [get_bd_intf_pins hier_round_robin_P00/s_axis_2]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_0 [get_bd_intf_pins hier_et_gate_P01/m_axis_0] [get_bd_intf_pins hier_round_robin_P01/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_1 [get_bd_intf_pins hier_et_gate_P01/m_axis_1] [get_bd_intf_pins hier_round_robin_P01/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_2 [get_bd_intf_pins hier_et_gate_P01/m_axis_2] [get_bd_intf_pins hier_round_robin_P01/s_axis_2]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S01 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P00 [get_bd_intf_pins hier_priority_switch_1/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P01 [get_bd_intf_pins hier_priority_switch_1/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P00 [get_bd_intf_pins hier_priority_switch_2/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P01 [get_bd_intf_pins hier_priority_switch_2/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_round_robin_P00_m_axis [get_bd_intf_pins hier_round_robin_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_round_robin_P01_m_axis [get_bd_intf_pins hier_round_robin_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_round_robin_TC0_m_axis [get_bd_intf_pins hier_round_robin_TC0/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_round_robin_TC1_m_axis [get_bd_intf_pins hier_round_robin_TC1/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_round_robin_TC2_m_axis [get_bd_intf_pins hier_round_robin_TC2/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_round_robin_TC3_m_axis [get_bd_intf_pins hier_round_robin_TC3/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_round_robin_TC4_m_axis [get_bd_intf_pins hier_round_robin_TC4/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_round_robin_TC5_m_axis [get_bd_intf_pins hier_round_robin_TC5/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_eligibility_timestamp_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis_et]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins hier_priority_switch_1/s_axis]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins hier_priority_switch_2/s_axis]
  connect_bd_intf_net -intf_net s_axis_TC2_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC2]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC3]
  connect_bd_intf_net -intf_net s_axis_TC4_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC4]
  connect_bd_intf_net -intf_net s_axis_TC5_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC5]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_priority_switch_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_2/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins hier_et_gate_P00/aresetn] [get_bd_pins hier_et_gate_P01/aresetn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_priority_switch_1/rstn] [get_bd_pins hier_priority_switch_2/rstn] [get_bd_pins hier_queue_ATS_P00_0/rstn] [get_bd_pins hier_queue_ATS_P00_1/rstn] [get_bd_pins hier_queue_ATS_P00_2/rstn] [get_bd_pins hier_queue_ATS_P01_0/rstn] [get_bd_pins hier_queue_ATS_P01_1/rstn] [get_bd_pins hier_queue_ATS_P01_2/rstn] [get_bd_pins hier_queue_FIFO_0/rstn] [get_bd_pins hier_queue_FIFO_1/rstn] [get_bd_pins hier_queue_FIFO_2/rstn] [get_bd_pins hier_round_robin_P00/aresetn] [get_bd_pins hier_round_robin_P01/aresetn] [get_bd_pins hier_round_robin_TC0/aresetn] [get_bd_pins hier_round_robin_TC1/aresetn] [get_bd_pins hier_round_robin_TC2/aresetn] [get_bd_pins hier_round_robin_TC3/aresetn] [get_bd_pins hier_round_robin_TC4/aresetn] [get_bd_pins hier_round_robin_TC5/aresetn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins hier_et_gate_P00/processing_delay_max] [get_bd_pins hier_et_gate_P01/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins hier_et_gate_P00/aclk] [get_bd_pins hier_et_gate_P01/aclk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_priority_switch_1/clk] [get_bd_pins hier_priority_switch_2/clk] [get_bd_pins hier_queue_ATS_P00_0/clk] [get_bd_pins hier_queue_ATS_P00_1/clk] [get_bd_pins hier_queue_ATS_P00_2/clk] [get_bd_pins hier_queue_ATS_P01_0/clk] [get_bd_pins hier_queue_ATS_P01_1/clk] [get_bd_pins hier_queue_ATS_P01_2/clk] [get_bd_pins hier_queue_FIFO_0/clk] [get_bd_pins hier_queue_FIFO_1/clk] [get_bd_pins hier_queue_FIFO_2/clk] [get_bd_pins hier_round_robin_P00/aclk] [get_bd_pins hier_round_robin_P01/aclk] [get_bd_pins hier_round_robin_TC0/aclk] [get_bd_pins hier_round_robin_TC1/aclk] [get_bd_pins hier_round_robin_TC2/aclk] [get_bd_pins hier_round_robin_TC3/aclk] [get_bd_pins hier_round_robin_TC4/aclk] [get_bd_pins hier_round_robin_TC5/aclk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins hier_et_gate_P00/transmission_selection_timer] [get_bd_pins hier_et_gate_P01/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_ats_1
proc create_hier_cell_hier_ats_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_ats_1() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: hier_et_gate_P00
  create_hier_cell_hier_et_gate_P00_1 $hier_obj hier_et_gate_P00

  # Create instance: hier_et_gate_P01
  create_hier_cell_hier_et_gate_P01_1 $hier_obj hier_et_gate_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0_1 $hier_obj hier_priority_switch_0

  # Create instance: hier_priority_switch_1
  create_hier_cell_hier_priority_switch_1_1 $hier_obj hier_priority_switch_1

  # Create instance: hier_priority_switch_2
  create_hier_cell_hier_priority_switch_2_1 $hier_obj hier_priority_switch_2

  # Create instance: hier_queue_ATS_P00_0
  create_hier_cell_hier_queue_ATS_P00_0_1 $hier_obj hier_queue_ATS_P00_0

  # Create instance: hier_queue_ATS_P00_1
  create_hier_cell_hier_queue_ATS_P00_1_1 $hier_obj hier_queue_ATS_P00_1

  # Create instance: hier_queue_ATS_P00_2
  create_hier_cell_hier_queue_ATS_P00_2_1 $hier_obj hier_queue_ATS_P00_2

  # Create instance: hier_queue_ATS_P01_0
  create_hier_cell_hier_queue_ATS_P01_0_1 $hier_obj hier_queue_ATS_P01_0

  # Create instance: hier_queue_ATS_P01_1
  create_hier_cell_hier_queue_ATS_P01_1_1 $hier_obj hier_queue_ATS_P01_1

  # Create instance: hier_queue_ATS_P01_2
  create_hier_cell_hier_queue_ATS_P01_2_1 $hier_obj hier_queue_ATS_P01_2

  # Create instance: hier_queue_FIFO_0
  create_hier_cell_hier_queue_FIFO_0_1 $hier_obj hier_queue_FIFO_0

  # Create instance: hier_queue_FIFO_1
  create_hier_cell_hier_queue_FIFO_1_1 $hier_obj hier_queue_FIFO_1

  # Create instance: hier_queue_FIFO_2
  create_hier_cell_hier_queue_FIFO_2_1 $hier_obj hier_queue_FIFO_2

  # Create instance: hier_round_robin_P00
  create_hier_cell_hier_round_robin_P00_1 $hier_obj hier_round_robin_P00

  # Create instance: hier_round_robin_P01
  create_hier_cell_hier_round_robin_P01_1 $hier_obj hier_round_robin_P01

  # Create instance: hier_round_robin_TC0
  create_hier_cell_hier_round_robin_TC0_1 $hier_obj hier_round_robin_TC0

  # Create instance: hier_round_robin_TC1
  create_hier_cell_hier_round_robin_TC1_1 $hier_obj hier_round_robin_TC1

  # Create instance: hier_round_robin_TC2
  create_hier_cell_hier_round_robin_TC2_1 $hier_obj hier_round_robin_TC2

  # Create instance: hier_round_robin_TC3
  create_hier_cell_hier_round_robin_TC3_1 $hier_obj hier_round_robin_TC3

  # Create instance: hier_round_robin_TC4
  create_hier_cell_hier_round_robin_TC4_1 $hier_obj hier_round_robin_TC4

  # Create instance: hier_round_robin_TC5
  create_hier_cell_hier_round_robin_TC5_1 $hier_obj hier_round_robin_TC5

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0_1 $hier_obj hier_strict_priority_0

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_0 [get_bd_intf_pins hier_et_gate_P00/m_axis_0] [get_bd_intf_pins hier_round_robin_P00/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_1 [get_bd_intf_pins hier_et_gate_P00/m_axis_1] [get_bd_intf_pins hier_round_robin_P00/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_2 [get_bd_intf_pins hier_et_gate_P00/m_axis_2] [get_bd_intf_pins hier_round_robin_P00/s_axis_2]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_0 [get_bd_intf_pins hier_et_gate_P01/m_axis_0] [get_bd_intf_pins hier_round_robin_P01/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_1 [get_bd_intf_pins hier_et_gate_P01/m_axis_1] [get_bd_intf_pins hier_round_robin_P01/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_2 [get_bd_intf_pins hier_et_gate_P01/m_axis_2] [get_bd_intf_pins hier_round_robin_P01/s_axis_2]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S01 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P00 [get_bd_intf_pins hier_priority_switch_1/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P01 [get_bd_intf_pins hier_priority_switch_1/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P00 [get_bd_intf_pins hier_priority_switch_2/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P01 [get_bd_intf_pins hier_priority_switch_2/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_round_robin_P00_m_axis [get_bd_intf_pins hier_round_robin_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_round_robin_P01_m_axis [get_bd_intf_pins hier_round_robin_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_round_robin_TC0_m_axis [get_bd_intf_pins hier_round_robin_TC0/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_round_robin_TC1_m_axis [get_bd_intf_pins hier_round_robin_TC1/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_round_robin_TC2_m_axis [get_bd_intf_pins hier_round_robin_TC2/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_round_robin_TC3_m_axis [get_bd_intf_pins hier_round_robin_TC3/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_round_robin_TC4_m_axis [get_bd_intf_pins hier_round_robin_TC4/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_round_robin_TC5_m_axis [get_bd_intf_pins hier_round_robin_TC5/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_eligibility_timestamp_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis_et]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins hier_priority_switch_1/s_axis]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins hier_priority_switch_2/s_axis]
  connect_bd_intf_net -intf_net s_axis_TC2_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC2]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC3]
  connect_bd_intf_net -intf_net s_axis_TC4_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC4]
  connect_bd_intf_net -intf_net s_axis_TC5_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC5]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_priority_switch_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_2/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins hier_et_gate_P00/aresetn] [get_bd_pins hier_et_gate_P01/aresetn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_priority_switch_1/rstn] [get_bd_pins hier_priority_switch_2/rstn] [get_bd_pins hier_queue_ATS_P00_0/rstn] [get_bd_pins hier_queue_ATS_P00_1/rstn] [get_bd_pins hier_queue_ATS_P00_2/rstn] [get_bd_pins hier_queue_ATS_P01_0/rstn] [get_bd_pins hier_queue_ATS_P01_1/rstn] [get_bd_pins hier_queue_ATS_P01_2/rstn] [get_bd_pins hier_queue_FIFO_0/rstn] [get_bd_pins hier_queue_FIFO_1/rstn] [get_bd_pins hier_queue_FIFO_2/rstn] [get_bd_pins hier_round_robin_P00/aresetn] [get_bd_pins hier_round_robin_P01/aresetn] [get_bd_pins hier_round_robin_TC0/aresetn] [get_bd_pins hier_round_robin_TC1/aresetn] [get_bd_pins hier_round_robin_TC2/aresetn] [get_bd_pins hier_round_robin_TC3/aresetn] [get_bd_pins hier_round_robin_TC4/aresetn] [get_bd_pins hier_round_robin_TC5/aresetn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins hier_et_gate_P00/processing_delay_max] [get_bd_pins hier_et_gate_P01/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins hier_et_gate_P00/aclk] [get_bd_pins hier_et_gate_P01/aclk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_priority_switch_1/clk] [get_bd_pins hier_priority_switch_2/clk] [get_bd_pins hier_queue_ATS_P00_0/clk] [get_bd_pins hier_queue_ATS_P00_1/clk] [get_bd_pins hier_queue_ATS_P00_2/clk] [get_bd_pins hier_queue_ATS_P01_0/clk] [get_bd_pins hier_queue_ATS_P01_1/clk] [get_bd_pins hier_queue_ATS_P01_2/clk] [get_bd_pins hier_queue_FIFO_0/clk] [get_bd_pins hier_queue_FIFO_1/clk] [get_bd_pins hier_queue_FIFO_2/clk] [get_bd_pins hier_round_robin_P00/aclk] [get_bd_pins hier_round_robin_P01/aclk] [get_bd_pins hier_round_robin_TC0/aclk] [get_bd_pins hier_round_robin_TC1/aclk] [get_bd_pins hier_round_robin_TC2/aclk] [get_bd_pins hier_round_robin_TC3/aclk] [get_bd_pins hier_round_robin_TC4/aclk] [get_bd_pins hier_round_robin_TC5/aclk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins hier_et_gate_P00/transmission_selection_timer] [get_bd_pins hier_et_gate_P01/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_ats_0
proc create_hier_cell_hier_ats_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_ats_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_2


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 71 -to 0 processing_delay_max
  create_bd_pin -dir I -from 71 -to 0 transmission_selection_timer

  # Create instance: hier_et_gate_P00
  create_hier_cell_hier_et_gate_P00 $hier_obj hier_et_gate_P00

  # Create instance: hier_et_gate_P01
  create_hier_cell_hier_et_gate_P01 $hier_obj hier_et_gate_P01

  # Create instance: hier_priority_switch_0
  create_hier_cell_hier_priority_switch_0 $hier_obj hier_priority_switch_0

  # Create instance: hier_priority_switch_1
  create_hier_cell_hier_priority_switch_1 $hier_obj hier_priority_switch_1

  # Create instance: hier_priority_switch_2
  create_hier_cell_hier_priority_switch_2 $hier_obj hier_priority_switch_2

  # Create instance: hier_queue_ATS_P00_0
  create_hier_cell_hier_queue_ATS_P00_0 $hier_obj hier_queue_ATS_P00_0

  # Create instance: hier_queue_ATS_P00_1
  create_hier_cell_hier_queue_ATS_P00_1 $hier_obj hier_queue_ATS_P00_1

  # Create instance: hier_queue_ATS_P00_2
  create_hier_cell_hier_queue_ATS_P00_2 $hier_obj hier_queue_ATS_P00_2

  # Create instance: hier_queue_ATS_P01_0
  create_hier_cell_hier_queue_ATS_P01_0 $hier_obj hier_queue_ATS_P01_0

  # Create instance: hier_queue_ATS_P01_1
  create_hier_cell_hier_queue_ATS_P01_1 $hier_obj hier_queue_ATS_P01_1

  # Create instance: hier_queue_ATS_P01_2
  create_hier_cell_hier_queue_ATS_P01_2 $hier_obj hier_queue_ATS_P01_2

  # Create instance: hier_queue_FIFO_0
  create_hier_cell_hier_queue_FIFO_0 $hier_obj hier_queue_FIFO_0

  # Create instance: hier_queue_FIFO_1
  create_hier_cell_hier_queue_FIFO_1 $hier_obj hier_queue_FIFO_1

  # Create instance: hier_queue_FIFO_2
  create_hier_cell_hier_queue_FIFO_2 $hier_obj hier_queue_FIFO_2

  # Create instance: hier_round_robin_P00
  create_hier_cell_hier_round_robin_P00 $hier_obj hier_round_robin_P00

  # Create instance: hier_round_robin_P01
  create_hier_cell_hier_round_robin_P01 $hier_obj hier_round_robin_P01

  # Create instance: hier_round_robin_TC0
  create_hier_cell_hier_round_robin_TC0 $hier_obj hier_round_robin_TC0

  # Create instance: hier_round_robin_TC1
  create_hier_cell_hier_round_robin_TC1 $hier_obj hier_round_robin_TC1

  # Create instance: hier_round_robin_TC2
  create_hier_cell_hier_round_robin_TC2 $hier_obj hier_round_robin_TC2

  # Create instance: hier_round_robin_TC3
  create_hier_cell_hier_round_robin_TC3 $hier_obj hier_round_robin_TC3

  # Create instance: hier_round_robin_TC4
  create_hier_cell_hier_round_robin_TC4 $hier_obj hier_round_robin_TC4

  # Create instance: hier_round_robin_TC5
  create_hier_cell_hier_round_robin_TC5 $hier_obj hier_round_robin_TC5

  # Create instance: hier_strict_priority_0
  create_hier_cell_hier_strict_priority_0 $hier_obj hier_strict_priority_0

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins hier_strict_priority_0/m_axis]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_0 [get_bd_intf_pins hier_et_gate_P00/m_axis_0] [get_bd_intf_pins hier_round_robin_P00/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_1 [get_bd_intf_pins hier_et_gate_P00/m_axis_1] [get_bd_intf_pins hier_round_robin_P00/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P00_m_axis_2 [get_bd_intf_pins hier_et_gate_P00/m_axis_2] [get_bd_intf_pins hier_round_robin_P00/s_axis_2]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_0 [get_bd_intf_pins hier_et_gate_P01/m_axis_0] [get_bd_intf_pins hier_round_robin_P01/s_axis_0]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_1 [get_bd_intf_pins hier_et_gate_P01/m_axis_1] [get_bd_intf_pins hier_round_robin_P01/s_axis_1]
  connect_bd_intf_net -intf_net hier_et_gate_P01_m_axis_2 [get_bd_intf_pins hier_et_gate_P01/m_axis_2] [get_bd_intf_pins hier_round_robin_P01/s_axis_2]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S01 [get_bd_intf_pins s_axis_0] [get_bd_intf_pins hier_priority_switch_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P00 [get_bd_intf_pins hier_priority_switch_0/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_P01 [get_bd_intf_pins hier_priority_switch_0/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_0/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_0_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_0/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_0/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P00 [get_bd_intf_pins hier_priority_switch_1/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_P01 [get_bd_intf_pins hier_priority_switch_1/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_1/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC2 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC3 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC4 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_priority_switch_1_m_axis_TC5 [get_bd_intf_pins hier_priority_switch_1/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_1/s_axis_TC5]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P00 [get_bd_intf_pins hier_priority_switch_2/m_axis_P00] [get_bd_intf_pins hier_queue_ATS_P00_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_P01 [get_bd_intf_pins hier_priority_switch_2/m_axis_P01] [get_bd_intf_pins hier_queue_ATS_P01_2/s_axis]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC0 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC0] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_priority_switch_2_m_axis_TC1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC1] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_0_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_0/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_0]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_1_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_1/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_1]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC0 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC0] [get_bd_intf_pins hier_round_robin_TC0/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC1 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC1] [get_bd_intf_pins hier_round_robin_TC1/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC2 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC2] [get_bd_intf_pins hier_round_robin_TC2/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC3 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC3] [get_bd_intf_pins hier_round_robin_TC3/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC4 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC4] [get_bd_intf_pins hier_round_robin_TC4/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_FIFO_2_m_axis_TC5 [get_bd_intf_pins hier_queue_FIFO_2/m_axis_TC5] [get_bd_intf_pins hier_round_robin_TC5/s_axis_2]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_1_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis [get_bd_intf_pins hier_et_gate_P00/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P00_2_m_axis_et [get_bd_intf_pins hier_et_gate_P00/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_0_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_0/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_1] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_1_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_1_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_1/m_axis_et]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis [get_bd_intf_pins hier_et_gate_P01/s_axis_2] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis]
  connect_bd_intf_net -intf_net hier_queue_P01_2_m_axis_et [get_bd_intf_pins hier_et_gate_P01/s_axis_2_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P01_2/m_axis_et]
  connect_bd_intf_net -intf_net hier_round_robin_P00_m_axis [get_bd_intf_pins hier_round_robin_P00/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P00]
  connect_bd_intf_net -intf_net hier_round_robin_P01_m_axis [get_bd_intf_pins hier_round_robin_P01/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_P01]
  connect_bd_intf_net -intf_net hier_round_robin_TC0_m_axis [get_bd_intf_pins hier_round_robin_TC0/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC0]
  connect_bd_intf_net -intf_net hier_round_robin_TC1_m_axis [get_bd_intf_pins hier_round_robin_TC1/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC1]
  connect_bd_intf_net -intf_net hier_round_robin_TC2_m_axis [get_bd_intf_pins hier_round_robin_TC2/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC2]
  connect_bd_intf_net -intf_net hier_round_robin_TC3_m_axis [get_bd_intf_pins hier_round_robin_TC3/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC3]
  connect_bd_intf_net -intf_net hier_round_robin_TC4_m_axis [get_bd_intf_pins hier_round_robin_TC4/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC4]
  connect_bd_intf_net -intf_net hier_round_robin_TC5_m_axis [get_bd_intf_pins hier_round_robin_TC5/m_axis] [get_bd_intf_pins hier_strict_priority_0/s_axis_TC5]
  connect_bd_intf_net -intf_net s_axis_0_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_0_eligibility_timestamp_1 [get_bd_intf_pins hier_et_gate_P00/s_axis_0_eligibility_timestamp] [get_bd_intf_pins hier_queue_ATS_P00_0/m_axis_et]
  connect_bd_intf_net -intf_net s_axis_1_1 [get_bd_intf_pins s_axis_1] [get_bd_intf_pins hier_priority_switch_1/s_axis]
  connect_bd_intf_net -intf_net s_axis_2_1 [get_bd_intf_pins s_axis_2] [get_bd_intf_pins hier_priority_switch_2/s_axis]
  connect_bd_intf_net -intf_net s_axis_TC2_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC2] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC2]
  connect_bd_intf_net -intf_net s_axis_TC3_1 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC3] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC3]
  connect_bd_intf_net -intf_net s_axis_TC4_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC4] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC4]
  connect_bd_intf_net -intf_net s_axis_TC5_2 [get_bd_intf_pins hier_priority_switch_2/m_axis_TC5] [get_bd_intf_pins hier_queue_FIFO_2/s_axis_TC5]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_priority_switch_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_priority_switch_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_priority_switch_2/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins hier_et_gate_P00/aresetn] [get_bd_pins hier_et_gate_P01/aresetn] [get_bd_pins hier_priority_switch_0/rstn] [get_bd_pins hier_priority_switch_1/rstn] [get_bd_pins hier_priority_switch_2/rstn] [get_bd_pins hier_queue_ATS_P00_0/rstn] [get_bd_pins hier_queue_ATS_P00_1/rstn] [get_bd_pins hier_queue_ATS_P00_2/rstn] [get_bd_pins hier_queue_ATS_P01_0/rstn] [get_bd_pins hier_queue_ATS_P01_1/rstn] [get_bd_pins hier_queue_ATS_P01_2/rstn] [get_bd_pins hier_queue_FIFO_0/rstn] [get_bd_pins hier_queue_FIFO_1/rstn] [get_bd_pins hier_queue_FIFO_2/rstn] [get_bd_pins hier_round_robin_P00/aresetn] [get_bd_pins hier_round_robin_P01/aresetn] [get_bd_pins hier_round_robin_TC0/aresetn] [get_bd_pins hier_round_robin_TC1/aresetn] [get_bd_pins hier_round_robin_TC2/aresetn] [get_bd_pins hier_round_robin_TC3/aresetn] [get_bd_pins hier_round_robin_TC4/aresetn] [get_bd_pins hier_round_robin_TC5/aresetn] [get_bd_pins hier_strict_priority_0/aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net processing_delay_max_1 [get_bd_pins processing_delay_max] [get_bd_pins hier_et_gate_P00/processing_delay_max] [get_bd_pins hier_et_gate_P01/processing_delay_max]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins hier_et_gate_P00/aclk] [get_bd_pins hier_et_gate_P01/aclk] [get_bd_pins hier_priority_switch_0/clk] [get_bd_pins hier_priority_switch_1/clk] [get_bd_pins hier_priority_switch_2/clk] [get_bd_pins hier_queue_ATS_P00_0/clk] [get_bd_pins hier_queue_ATS_P00_1/clk] [get_bd_pins hier_queue_ATS_P00_2/clk] [get_bd_pins hier_queue_ATS_P01_0/clk] [get_bd_pins hier_queue_ATS_P01_1/clk] [get_bd_pins hier_queue_ATS_P01_2/clk] [get_bd_pins hier_queue_FIFO_0/clk] [get_bd_pins hier_queue_FIFO_1/clk] [get_bd_pins hier_queue_FIFO_2/clk] [get_bd_pins hier_round_robin_P00/aclk] [get_bd_pins hier_round_robin_P01/aclk] [get_bd_pins hier_round_robin_TC0/aclk] [get_bd_pins hier_round_robin_TC1/aclk] [get_bd_pins hier_round_robin_TC2/aclk] [get_bd_pins hier_round_robin_TC3/aclk] [get_bd_pins hier_round_robin_TC4/aclk] [get_bd_pins hier_round_robin_TC5/aclk] [get_bd_pins hier_strict_priority_0/aclk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net transmission_selection_timer_1 [get_bd_pins transmission_selection_timer] [get_bd_pins hier_et_gate_P00/transmission_selection_timer] [get_bd_pins hier_et_gate_P01/transmission_selection_timer]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set mdio_io_port_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_0 ]

  set mdio_io_port_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_1 ]

  set mdio_io_port_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_2 ]

  set mdio_io_port_3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:mdio_io:1.0 mdio_io_port_3 ]

  set ref_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 ref_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {125000000} \
   ] $ref_clk

  set rgmii_port_0 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_0 ]

  set rgmii_port_1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_1 ]

  set rgmii_port_2 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_2 ]

  set rgmii_port_3 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:rgmii_rtl:1.0 rgmii_port_3 ]


  # Create ports
  set activity_flash_0 [ create_bd_port -dir O activity_flash_0 ]
  set activity_flash_1 [ create_bd_port -dir O activity_flash_1 ]
  set activity_flash_2 [ create_bd_port -dir O activity_flash_2 ]
  set activity_flash_3 [ create_bd_port -dir O activity_flash_3 ]
  set chk_tx_data [ create_bd_port -dir I chk_tx_data ]
  set config_board [ create_bd_port -dir I config_board ]
  set frame_error_0 [ create_bd_port -dir O frame_error_0 ]
  set frame_error_1 [ create_bd_port -dir O frame_error_1 ]
  set frame_error_2 [ create_bd_port -dir O frame_error_2 ]
  set frame_error_3 [ create_bd_port -dir O frame_error_3 ]
  set gen_tx_data [ create_bd_port -dir I gen_tx_data ]
  set glbl_rst [ create_bd_port -dir I -type rst glbl_rst ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $glbl_rst
  set mac_speed [ create_bd_port -dir I -from 1 -to 0 mac_speed ]
  set ref_clk_fsel [ create_bd_port -dir O -from 0 -to 0 ref_clk_fsel ]
  set ref_clk_oe [ create_bd_port -dir O -from 0 -to 0 ref_clk_oe ]
  set reset_error [ create_bd_port -dir I -type rst reset_error ]
  set reset_port_0 [ create_bd_port -dir O -type rst reset_port_0 ]
  set reset_port_1 [ create_bd_port -dir O -type rst reset_port_1 ]
  set reset_port_2 [ create_bd_port -dir O -type rst reset_port_2 ]
  set reset_port_3 [ create_bd_port -dir O -type rst reset_port_3 ]
  set update_speed [ create_bd_port -dir I update_speed ]

  # Create instance: axis_clock_converter_0, and set properties
  set axis_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_0 ]

  # Create instance: axis_clock_converter_1, and set properties
  set axis_clock_converter_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_1 ]

  # Create instance: axis_clock_converter_2, and set properties
  set axis_clock_converter_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_2 ]

  # Create instance: axis_clock_converter_3, and set properties
  set axis_clock_converter_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_3 ]

  # Create instance: axis_data_fifo_swin_0, and set properties
  set axis_data_fifo_swin_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_swin_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_EMPTY {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {4091} \
 ] $axis_data_fifo_swin_0

  # Create instance: axis_data_fifo_swin_1, and set properties
  set axis_data_fifo_swin_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_swin_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_EMPTY {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {0} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {4091} \
 ] $axis_data_fifo_swin_1

  # Create instance: axis_data_fifo_swin_2, and set properties
  set axis_data_fifo_swin_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_swin_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_EMPTY {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {4091} \
 ] $axis_data_fifo_swin_2

  # Create instance: axis_data_fifo_swin_3, and set properties
  set axis_data_fifo_swin_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_swin_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {4096} \
   CONFIG.FIFO_MEMORY_TYPE {distributed} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_EMPTY {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {4091} \
 ] $axis_data_fifo_swin_3

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {80.0} \
   CONFIG.CLKOUT1_JITTER {119.348} \
   CONFIG.CLKOUT1_PHASE_ERROR {96.948} \
   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {125} \
   CONFIG.CLKOUT2_JITTER {124.615} \
   CONFIG.CLKOUT2_PHASE_ERROR {96.948} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.CLKOUT3_JITTER {109.241} \
   CONFIG.CLKOUT3_PHASE_ERROR {96.948} \
   CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {200} \
   CONFIG.CLKOUT3_USED {true} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {8.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {8.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {8.000} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {10} \
   CONFIG.MMCM_CLKOUT2_DIVIDE {5} \
   CONFIG.NUM_OUT_CLKS {3} \
   CONFIG.PRIM_IN_FREQ {125} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
 ] $clk_wiz_0

  # Create instance: gpio_processing_dela_0, and set properties
  set gpio_processing_dela_0 [ create_bd_cell -type ip -vlnv user.org:user:gpio_processing_delay_max:1.0 gpio_processing_dela_0 ]

  # Create instance: hier_ats_0
  create_hier_cell_hier_ats_0 [current_bd_instance .] hier_ats_0

  # Create instance: hier_ats_1
  create_hier_cell_hier_ats_1 [current_bd_instance .] hier_ats_1

  # Create instance: hier_ats_2
  create_hier_cell_hier_ats_2 [current_bd_instance .] hier_ats_2

  # Create instance: hier_ats_3
  create_hier_cell_hier_ats_3 [current_bd_instance .] hier_ats_3

  # Create instance: hier_eth_switch
  create_hier_cell_hier_eth_switch [current_bd_instance .] hier_eth_switch

  # Create instance: hier_flow_control
  create_hier_cell_hier_flow_control [current_bd_instance .] hier_flow_control

  # Create instance: hier_mac_0
  create_hier_cell_hier_mac_0 [current_bd_instance .] hier_mac_0

  # Create instance: hier_mac_1
  create_hier_cell_hier_mac_1 [current_bd_instance .] hier_mac_1

  # Create instance: hier_mac_2
  create_hier_cell_hier_mac_2 [current_bd_instance .] hier_mac_2

  # Create instance: hier_mac_3
  create_hier_cell_hier_mac_3 [current_bd_instance .] hier_mac_3

  # Create instance: hier_scheduler_0
  create_hier_cell_hier_scheduler_0 [current_bd_instance .] hier_scheduler_0

  # Create instance: hier_scheduler_1
  create_hier_cell_hier_scheduler_1 [current_bd_instance .] hier_scheduler_1

  # Create instance: hier_scheduler_2
  create_hier_cell_hier_scheduler_2 [current_bd_instance .] hier_scheduler_2

  # Create instance: hier_scheduler_3
  create_hier_cell_hier_scheduler_3 [current_bd_instance .] hier_scheduler_3

  # Create instance: jtag_axi_0, and set properties
  set jtag_axi_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi_0 ]
  set_property -dict [ list \
   CONFIG.PROTOCOL {2} \
 ] $jtag_axi_0

  # Create instance: proc_sys_reset_sw, and set properties
  set proc_sys_reset_sw [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_sw ]

  # Create instance: ref_clk_fsel, and set properties
  set ref_clk_fsel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ref_clk_fsel ]

  # Create instance: ref_clk_oe, and set properties
  set ref_clk_oe [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 ref_clk_oe ]

  # Create instance: reference_timer_0, and set properties
  set reference_timer_0 [ create_bd_cell -type ip -vlnv user.org:user:reference_timer:1.0 reference_timer_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {10} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: util_vector_logic_1, and set properties
  set util_vector_logic_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_1 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_1

  # Create instance: util_vector_logic_2, and set properties
  set util_vector_logic_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_2 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_2

  # Create instance: util_vector_logic_3, and set properties
  set util_vector_logic_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_3 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_3

  # Create interface connections
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_0/M_AXIS] [get_bd_intf_pins hier_mac_0/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_1_M_AXIS [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins hier_mac_1/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_2_M_AXIS [get_bd_intf_pins axis_clock_converter_2/M_AXIS] [get_bd_intf_pins hier_mac_2/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_3_M_AXIS [get_bd_intf_pins axis_clock_converter_3/M_AXIS] [get_bd_intf_pins hier_mac_3/s_axis_tx]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_0_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_0/M_AXIS] [get_bd_intf_pins hier_scheduler_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_1_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_1/M_AXIS] [get_bd_intf_pins hier_scheduler_1/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_2_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_2/M_AXIS] [get_bd_intf_pins hier_scheduler_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_3_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_3/M_AXIS] [get_bd_intf_pins hier_scheduler_3/s_axis]
  connect_bd_intf_net -intf_net eth_driver_0_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_0/S_AXIS] [get_bd_intf_pins hier_mac_0/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_1_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_1/S_AXIS] [get_bd_intf_pins hier_mac_1/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_2_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_2/S_AXIS] [get_bd_intf_pins hier_mac_2/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_3_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_3/S_AXIS] [get_bd_intf_pins hier_mac_3/tx_axis_mac]
  connect_bd_intf_net -intf_net hier_ats_0_m_axis [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins hier_ats_0/m_axis]
  connect_bd_intf_net -intf_net hier_ats_1_m_axis [get_bd_intf_pins axis_clock_converter_1/S_AXIS] [get_bd_intf_pins hier_ats_1/m_axis]
  connect_bd_intf_net -intf_net hier_ats_2_m_axis [get_bd_intf_pins axis_clock_converter_2/S_AXIS] [get_bd_intf_pins hier_ats_2/m_axis]
  connect_bd_intf_net -intf_net hier_ats_3_m_axis [get_bd_intf_pins axis_clock_converter_3/S_AXIS] [get_bd_intf_pins hier_ats_3/m_axis]
  connect_bd_intf_net -intf_net hier_calc_et_0_m_axis [get_bd_intf_pins hier_eth_switch/S00] [get_bd_intf_pins hier_scheduler_0/m_axis]
  connect_bd_intf_net -intf_net hier_calc_et_1_m_axis [get_bd_intf_pins hier_eth_switch/S01] [get_bd_intf_pins hier_scheduler_1/m_axis]
  connect_bd_intf_net -intf_net hier_calc_et_2_m_axis [get_bd_intf_pins hier_eth_switch/S02] [get_bd_intf_pins hier_scheduler_2/m_axis]
  connect_bd_intf_net -intf_net hier_calc_et_3_m_axis [get_bd_intf_pins hier_eth_switch/S03] [get_bd_intf_pins hier_scheduler_3/m_axis]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S01 [get_bd_intf_pins hier_ats_0/s_axis_0] [get_bd_intf_pins hier_eth_switch/M00_S01]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S02 [get_bd_intf_pins hier_ats_0/s_axis_1] [get_bd_intf_pins hier_eth_switch/M00_S02]
  connect_bd_intf_net -intf_net hier_eth_switch_M00_S03 [get_bd_intf_pins hier_ats_0/s_axis_2] [get_bd_intf_pins hier_eth_switch/M00_S03]
  connect_bd_intf_net -intf_net hier_eth_switch_M01_S00 [get_bd_intf_pins hier_ats_1/s_axis_0] [get_bd_intf_pins hier_eth_switch/M01_S00]
  connect_bd_intf_net -intf_net hier_eth_switch_M01_S02 [get_bd_intf_pins hier_ats_1/s_axis_1] [get_bd_intf_pins hier_eth_switch/M01_S02]
  connect_bd_intf_net -intf_net hier_eth_switch_M01_S03 [get_bd_intf_pins hier_ats_1/s_axis_2] [get_bd_intf_pins hier_eth_switch/M01_S03]
  connect_bd_intf_net -intf_net hier_eth_switch_M02_S00 [get_bd_intf_pins hier_ats_2/s_axis_0] [get_bd_intf_pins hier_eth_switch/M02_S00]
  connect_bd_intf_net -intf_net hier_eth_switch_M02_S01 [get_bd_intf_pins hier_ats_2/s_axis_1] [get_bd_intf_pins hier_eth_switch/M02_S01]
  connect_bd_intf_net -intf_net hier_eth_switch_M02_S03 [get_bd_intf_pins hier_ats_2/s_axis_2] [get_bd_intf_pins hier_eth_switch/M02_S03]
  connect_bd_intf_net -intf_net hier_eth_switch_M03_S00 [get_bd_intf_pins hier_ats_3/s_axis_0] [get_bd_intf_pins hier_eth_switch/M03_S00]
  connect_bd_intf_net -intf_net hier_eth_switch_M03_S01 [get_bd_intf_pins hier_ats_3/s_axis_1] [get_bd_intf_pins hier_eth_switch/M03_S01]
  connect_bd_intf_net -intf_net hier_eth_switch_M03_S02 [get_bd_intf_pins hier_ats_3/s_axis_2] [get_bd_intf_pins hier_eth_switch/M03_S02]
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins jtag_axi_0/M_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net ref_clk_1 [get_bd_intf_ports ref_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_scheduler_0/s_axi] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_scheduler_1/s_axi] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_scheduler_2/s_axi] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins hier_scheduler_3/s_axi] [get_bd_intf_pins smartconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins hier_flow_control/S_AXI] [get_bd_intf_pins smartconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M05_AXI [get_bd_intf_pins hier_ats_0/S00_AXI] [get_bd_intf_pins smartconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M06_AXI [get_bd_intf_pins hier_ats_1/S00_AXI] [get_bd_intf_pins smartconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M07_AXI [get_bd_intf_pins hier_ats_2/S00_AXI] [get_bd_intf_pins smartconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M08_AXI [get_bd_intf_pins hier_ats_3/S00_AXI] [get_bd_intf_pins smartconnect_0/M08_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M09_AXI [get_bd_intf_pins gpio_processing_dela_0/S_AXI] [get_bd_intf_pins smartconnect_0/M09_AXI]
  connect_bd_intf_net -intf_net temac_0_mdio_external [get_bd_intf_ports mdio_io_port_0] [get_bd_intf_pins hier_mac_0/mdio_io_port_0]
  connect_bd_intf_net -intf_net temac_0_rgmii [get_bd_intf_ports rgmii_port_0] [get_bd_intf_pins hier_mac_0/rgmii_port_0]
  connect_bd_intf_net -intf_net temac_1_mdio_external [get_bd_intf_ports mdio_io_port_1] [get_bd_intf_pins hier_mac_1/mdio_io_port_1]
  connect_bd_intf_net -intf_net temac_1_rgmii [get_bd_intf_ports rgmii_port_1] [get_bd_intf_pins hier_mac_1/rgmii_port_1]
  connect_bd_intf_net -intf_net temac_2_mdio_external [get_bd_intf_ports mdio_io_port_2] [get_bd_intf_pins hier_mac_2/mdio_io_port_2]
  connect_bd_intf_net -intf_net temac_2_rgmii [get_bd_intf_ports rgmii_port_2] [get_bd_intf_pins hier_mac_2/rgmii_port_2]
  connect_bd_intf_net -intf_net temac_3_mdio_external [get_bd_intf_ports mdio_io_port_3] [get_bd_intf_pins hier_mac_3/mdio_io_port_3]
  connect_bd_intf_net -intf_net temac_3_rgmii [get_bd_intf_ports rgmii_port_3] [get_bd_intf_pins hier_mac_3/rgmii_port_3]

  # Create port connections
  connect_bd_net -net axis_data_fifo_swin_0_prog_full [get_bd_pins axis_data_fifo_swin_0/prog_full] [get_bd_pins hier_flow_control/almost_full_0]
  connect_bd_net -net axis_data_fifo_swin_1_prog_full [get_bd_pins axis_data_fifo_swin_1/prog_full] [get_bd_pins hier_flow_control/almost_full_1]
  connect_bd_net -net axis_data_fifo_swin_2_prog_full [get_bd_pins axis_data_fifo_swin_2/prog_full] [get_bd_pins hier_flow_control/almost_full_2]
  connect_bd_net -net axis_data_fifo_swin_3_prog_full [get_bd_pins axis_data_fifo_swin_3/prog_full] [get_bd_pins hier_flow_control/almost_full_3]
  connect_bd_net -net chk_tx_data_1 [get_bd_ports chk_tx_data] [get_bd_pins hier_mac_0/chk_tx_data] [get_bd_pins hier_mac_1/chk_tx_data] [get_bd_pins hier_mac_2/chk_tx_data] [get_bd_pins hier_mac_3/chk_tx_data]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins hier_flow_control/fifo_rd_clk] [get_bd_pins hier_mac_0/gtx_clk] [get_bd_pins hier_mac_1/gtx_clk_bufg] [get_bd_pins hier_mac_2/gtx_clk_bufg] [get_bd_pins hier_mac_3/gtx_clk_bufg]
  connect_bd_net -net clk_wiz_0_clk_out2 [get_bd_pins clk_wiz_0/clk_out2] [get_bd_pins hier_mac_0/s_axi_aclk] [get_bd_pins hier_mac_1/s_axi_aclk] [get_bd_pins hier_mac_2/s_axi_aclk] [get_bd_pins hier_mac_3/s_axi_aclk]
  connect_bd_net -net clk_wiz_0_clk_out3 [get_bd_pins clk_wiz_0/clk_out3] [get_bd_pins hier_mac_0/refclk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins hier_flow_control/s_axi_aresetn] [get_bd_pins hier_mac_0/dcm_locked] [get_bd_pins hier_mac_1/dcm_locked] [get_bd_pins hier_mac_2/dcm_locked] [get_bd_pins hier_mac_3/dcm_locked]
  connect_bd_net -net config_board_1 [get_bd_ports config_board] [get_bd_pins hier_mac_0/config_board] [get_bd_pins hier_mac_1/config_board] [get_bd_pins hier_mac_2/config_board] [get_bd_pins hier_mac_3/config_board]
  connect_bd_net -net eth_driver_0_activity_flash [get_bd_ports activity_flash_0] [get_bd_pins hier_mac_0/activity_flash_0]
  connect_bd_net -net eth_driver_0_frame_error [get_bd_ports frame_error_0] [get_bd_pins hier_mac_0/frame_error_0]
  connect_bd_net -net eth_driver_0_phy_resetn [get_bd_ports reset_port_0] [get_bd_pins hier_mac_0/reset_port_0]
  connect_bd_net -net eth_driver_1_activity_flash [get_bd_ports activity_flash_1] [get_bd_pins hier_mac_1/activity_flash_1]
  connect_bd_net -net eth_driver_1_frame_error [get_bd_ports frame_error_1] [get_bd_pins hier_mac_1/frame_error_1]
  connect_bd_net -net eth_driver_1_phy_resetn [get_bd_ports reset_port_1] [get_bd_pins hier_mac_1/reset_port_1]
  connect_bd_net -net eth_driver_2_activity_flash [get_bd_ports activity_flash_2] [get_bd_pins hier_mac_2/activity_flash_2]
  connect_bd_net -net eth_driver_2_frame_error [get_bd_ports frame_error_2] [get_bd_pins hier_mac_2/frame_error_2]
  connect_bd_net -net eth_driver_2_phy_resetn [get_bd_ports reset_port_2] [get_bd_pins hier_mac_2/reset_port_2]
  connect_bd_net -net eth_driver_3_activity_flash [get_bd_ports activity_flash_3] [get_bd_pins hier_mac_3/activity_flash_3]
  connect_bd_net -net eth_driver_3_frame_error [get_bd_ports frame_error_3] [get_bd_pins hier_mac_3/frame_error_3]
  connect_bd_net -net eth_driver_3_phy_resetn [get_bd_ports reset_port_3] [get_bd_pins hier_mac_3/reset_port_3]
  connect_bd_net -net gen_tx_data_1 [get_bd_ports gen_tx_data] [get_bd_pins hier_mac_0/gen_tx_data] [get_bd_pins hier_mac_1/gen_tx_data] [get_bd_pins hier_mac_2/gen_tx_data] [get_bd_pins hier_mac_3/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_ports glbl_rst] [get_bd_pins clk_wiz_0/reset] [get_bd_pins hier_mac_0/glbl_rst] [get_bd_pins hier_mac_1/glbl_rst] [get_bd_pins hier_mac_2/glbl_rst] [get_bd_pins hier_mac_3/glbl_rst]
  connect_bd_net -net gpio_processing_dela_0_processing_delay_max [get_bd_pins gpio_processing_dela_0/processing_delay_max] [get_bd_pins hier_ats_0/processing_delay_max] [get_bd_pins hier_ats_1/processing_delay_max] [get_bd_pins hier_ats_2/processing_delay_max] [get_bd_pins hier_ats_3/processing_delay_max]
  connect_bd_net -net hier_flow_control_pause_req_2 [get_bd_pins hier_flow_control/pause_req_0] [get_bd_pins hier_mac_0/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_3 [get_bd_pins hier_flow_control/pause_req_1] [get_bd_pins hier_mac_1/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_4 [get_bd_pins hier_flow_control/pause_req_2] [get_bd_pins hier_mac_2/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_5 [get_bd_pins hier_flow_control/pause_req_3] [get_bd_pins hier_mac_3/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_ports mac_speed] [get_bd_pins hier_mac_0/mac_speed] [get_bd_pins hier_mac_1/mac_speed] [get_bd_pins hier_mac_2/mac_speed] [get_bd_pins hier_mac_3/mac_speed]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins axis_data_fifo_swin_0/s_axis_aresetn] [get_bd_pins gpio_processing_dela_0/rstn] [get_bd_pins hier_ats_0/aresetn] [get_bd_pins hier_ats_1/aresetn] [get_bd_pins hier_ats_2/aresetn] [get_bd_pins hier_ats_3/aresetn] [get_bd_pins hier_eth_switch/aresetn] [get_bd_pins hier_scheduler_0/rstn] [get_bd_pins hier_scheduler_1/rstn] [get_bd_pins hier_scheduler_2/rstn] [get_bd_pins hier_scheduler_3/rstn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins proc_sys_reset_sw/peripheral_aresetn] [get_bd_pins reference_timer_0/rstn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net ref_clk_fsel_dout [get_bd_ports ref_clk_fsel] [get_bd_pins ref_clk_fsel/dout]
  connect_bd_net -net ref_clk_oe_dout [get_bd_ports ref_clk_oe] [get_bd_pins ref_clk_oe/dout]
  connect_bd_net -net reference_timer_0_reference_timer_output [get_bd_pins hier_ats_0/transmission_selection_timer] [get_bd_pins hier_ats_1/transmission_selection_timer] [get_bd_pins hier_ats_2/transmission_selection_timer] [get_bd_pins hier_ats_3/transmission_selection_timer] [get_bd_pins hier_scheduler_0/ats_scheduler_timer] [get_bd_pins hier_scheduler_1/ats_scheduler_timer] [get_bd_pins hier_scheduler_2/ats_scheduler_timer] [get_bd_pins hier_scheduler_3/ats_scheduler_timer] [get_bd_pins reference_timer_0/reference_timer_output]
  connect_bd_net -net reset_error_1 [get_bd_ports reset_error] [get_bd_pins hier_mac_0/reset_error] [get_bd_pins hier_mac_1/reset_error] [get_bd_pins hier_mac_2/reset_error] [get_bd_pins hier_mac_3/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins hier_mac_0/gtx_clk90_out] [get_bd_pins hier_mac_1/gtx_clk90] [get_bd_pins hier_mac_2/gtx_clk90] [get_bd_pins hier_mac_3/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins hier_mac_0/gtx_clk_out] [get_bd_pins hier_mac_1/gtx_clk] [get_bd_pins hier_mac_2/gtx_clk] [get_bd_pins hier_mac_3/gtx_clk]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_clock_converter_2/s_axis_aclk] [get_bd_pins axis_clock_converter_3/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_1/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_2/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_3/m_axis_aclk] [get_bd_pins gpio_processing_dela_0/clk] [get_bd_pins hier_ats_0/aclk] [get_bd_pins hier_ats_1/aclk] [get_bd_pins hier_ats_2/aclk] [get_bd_pins hier_ats_3/aclk] [get_bd_pins hier_eth_switch/aclk] [get_bd_pins hier_flow_control/fifo_wr_clk] [get_bd_pins hier_mac_0/tx_mac_aclk] [get_bd_pins hier_scheduler_0/clk] [get_bd_pins hier_scheduler_1/clk] [get_bd_pins hier_scheduler_2/clk] [get_bd_pins hier_scheduler_3/clk] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins proc_sys_reset_sw/slowest_sync_clk] [get_bd_pins reference_timer_0/clk] [get_bd_pins smartconnect_0/aclk]
  connect_bd_net -net temac_0_tx_reset [get_bd_pins hier_mac_0/tx_reset] [get_bd_pins proc_sys_reset_sw/ext_reset_in] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_1_tx_mac_aclk [get_bd_pins axis_clock_converter_1/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_1/s_axis_aclk] [get_bd_pins hier_mac_1/tx_axis_mac_aclk]
  connect_bd_net -net temac_1_tx_reset [get_bd_pins hier_mac_1/tx_reset] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net temac_2_tx_mac_aclk [get_bd_pins axis_clock_converter_2/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_2/s_axis_aclk] [get_bd_pins hier_mac_2/tx_axis_mac_aclk]
  connect_bd_net -net temac_2_tx_reset [get_bd_pins hier_mac_2/tx_reset] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net temac_3_tx_mac_aclk [get_bd_pins axis_clock_converter_3/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_3/s_axis_aclk] [get_bd_pins hier_mac_3/tx_axis_mac_aclk]
  connect_bd_net -net temac_3_tx_reset [get_bd_pins hier_mac_3/tx_reset] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net update_speed_1 [get_bd_ports update_speed] [get_bd_pins hier_mac_0/update_speed] [get_bd_pins hier_mac_1/update_speed] [get_bd_pins hier_mac_2/update_speed] [get_bd_pins hier_mac_3/update_speed]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins axis_clock_converter_2/s_axis_aresetn] [get_bd_pins axis_clock_converter_3/s_axis_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_1/s_axis_aresetn] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins axis_clock_converter_2/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_2/s_axis_aresetn] [get_bd_pins util_vector_logic_2/Res]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins axis_clock_converter_3/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_3/s_axis_aresetn] [get_bd_pins util_vector_logic_3/Res]

  # Create address segments
  assign_bd_address -offset 0x50000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_0/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50010000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_0/hier_priority_switch_1/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50020000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_0/hier_priority_switch_2/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50030000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_1/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50040000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_1/hier_priority_switch_1/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50050000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_1/hier_priority_switch_2/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50060000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_2/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50070000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_2/hier_priority_switch_1/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50080000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_2/hier_priority_switch_2/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50090000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_3/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500A0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_3/hier_priority_switch_1/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500B0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_ats_3/hier_priority_switch_2/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500C0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_0/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500D0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_1/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500E0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_2/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x500F0000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_3/hier_priority_switch_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00010000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_flow_control/axi_gpio_flow_control/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_0/hier_calc_et_P00/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00002000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_0/hier_calc_et_P01/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00004000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_1/hier_calc_et_P00/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00006000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_1/hier_calc_et_P01/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00008000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_2/hier_calc_et_P00/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000A000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_2/hier_calc_et_P01/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000C000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_3/hier_calc_et_P00/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000E000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_3/hier_calc_et_P01/detect_flow_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00020000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs gpio_processing_dela_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00001000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_0/hier_calc_et_P00/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00003000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_0/hier_calc_et_P01/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00005000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_1/hier_calc_et_P00/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00007000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_1/hier_calc_et_P01/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00009000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_2/hier_calc_et_P00/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000B000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_2/hier_calc_et_P01/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000D000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_3/hier_calc_et_P00/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x0000F000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_scheduler_3/hier_calc_et_P01/process_frame_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces hier_mac_0/eth_driver_0/s_axi] [get_bd_addr_segs hier_mac_0/temac_0/s_axi/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces hier_mac_1/eth_driver_1/s_axi] [get_bd_addr_segs hier_mac_1/temac_1/s_axi/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces hier_mac_2/eth_driver_2/s_axi] [get_bd_addr_segs hier_mac_2/temac_2/s_axi/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces hier_mac_3/eth_driver_3/s_axi] [get_bd_addr_segs hier_mac_3/temac_3/s_axi/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


