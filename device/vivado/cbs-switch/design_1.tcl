
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
<<<<<<< HEAD
# channel_in_mod, channel_in_mod, channel_in_mod, channel_in_mod, mactable, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod
=======
# mactable_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod, tri_mode_ethernet_mac_0_example_design_mod
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
<<<<<<< HEAD
=======
user.org:user:axi_gpio_parameters:1.0\
xilinx.com:ip:axi_register_slice:2.1\
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:jtag_axi:1.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:util_vector_logic:2.0\
user.org:user:register_slice:1.0\
<<<<<<< HEAD
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:fifo_generator:13.2\
=======
xilinx.com:ip:axis_register_slice:1.1\
xilinx.com:ip:axis_switch:1.1\
user.org:user:channel_in_opt:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:fifo_generator:13.2\
user.org:user:ethernet_frame_dropper:1.0\
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
xilinx.com:ip:tri_mode_ethernet_mac:9.0\
user.org:user:add_tdest_from_vlan_tag:1.0\
user.org:user:dest_to_user:1.0\
user.org:user:user_to_dest:1.0\
user.org:user:ethernet_frame_arbiter:1.0\
user.org:user:extract_output_side_ready:1.0\
user.org:user:credit_based_shaper:1.0\
<<<<<<< HEAD
user.org:user:ethernet_frame_dropper:1.0\
=======
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
channel_in_mod\
channel_in_mod\
channel_in_mod\
channel_in_mod\
mactable\
=======
mactable_mod\
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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


# Hierarchical cell: registers_0
proc create_hier_cell_registers_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_registers_0_3() - Empty argument(s)!"}
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
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O -from 31 -to 0 cbs_6_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_6_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_send_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_send_slope

  # Create instance: axi_gpio_cbs_6_0, and set properties
  set axi_gpio_cbs_6_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_0

  # Create instance: axi_gpio_cbs_6_1, and set properties
  set axi_gpio_cbs_6_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_1

  # Create instance: axi_gpio_cbs_7_0, and set properties
  set axi_gpio_cbs_7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_0

  # Create instance: axi_gpio_cbs_7_1, and set properties
  set axi_gpio_cbs_7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_1

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_cbs_7_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins axi_gpio_cbs_7_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins axi_gpio_cbs_6_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_cbs_6_1/S_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins cbs_6_send_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins cbs_6_idle_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins cbs_6_min_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins cbs_6_max_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins cbs_7_send_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins cbs_7_idle_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins cbs_7_min_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins cbs_7_max_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio_io_o]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aclk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_7
proc create_hier_cell_packet_based_fifo_7_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_7_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_6
proc create_hier_cell_packet_based_fifo_6_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_6_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_5
proc create_hier_cell_packet_based_fifo_5_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_5_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_4
proc create_hier_cell_packet_based_fifo_4_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_4_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_3
proc create_hier_cell_packet_based_fifo_3_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_3_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_2
proc create_hier_cell_packet_based_fifo_2_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_2_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_1
proc create_hier_cell_packet_based_fifo_1_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_1_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_0
proc create_hier_cell_packet_based_fifo_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_0_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_7
proc create_hier_cell_credit_based_shaper_7_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_7_3() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_6
proc create_hier_cell_credit_based_shaper_6_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_6_3() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: arbiter_0
proc create_hier_cell_arbiter_0_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_arbiter_0_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S04_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S06_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S07_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O output_side_ready

<<<<<<< HEAD
  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
=======
  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.FRAME_GAP {24} \
 ] $ethernet_frame_arbit_0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
<<<<<<< HEAD
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
=======
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net extract_output_side_0_output_side_ready [get_bd_pins output_side_ready] [get_bd_pins extract_output_side_0/output_side_ready]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: registers_0
proc create_hier_cell_registers_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_registers_0_2() - Empty argument(s)!"}
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
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O -from 31 -to 0 cbs_6_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_6_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_send_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_send_slope

  # Create instance: axi_gpio_cbs_6_0, and set properties
  set axi_gpio_cbs_6_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_0

  # Create instance: axi_gpio_cbs_6_1, and set properties
  set axi_gpio_cbs_6_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_1

  # Create instance: axi_gpio_cbs_7_0, and set properties
  set axi_gpio_cbs_7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_0

  # Create instance: axi_gpio_cbs_7_1, and set properties
  set axi_gpio_cbs_7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_1

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_cbs_7_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins axi_gpio_cbs_7_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins axi_gpio_cbs_6_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_cbs_6_1/S_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins cbs_6_send_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins cbs_6_idle_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins cbs_6_min_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins cbs_6_max_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins cbs_7_send_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins cbs_7_idle_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins cbs_7_min_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins cbs_7_max_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio_io_o]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aclk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_7
proc create_hier_cell_packet_based_fifo_7_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_7_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_6
proc create_hier_cell_packet_based_fifo_6_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_6_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_5
proc create_hier_cell_packet_based_fifo_5_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_5_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_4
proc create_hier_cell_packet_based_fifo_4_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_4_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_3
proc create_hier_cell_packet_based_fifo_3_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_3_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_2
proc create_hier_cell_packet_based_fifo_2_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_2_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_1
proc create_hier_cell_packet_based_fifo_1_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_1_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_0
proc create_hier_cell_packet_based_fifo_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_0_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_7
proc create_hier_cell_credit_based_shaper_7_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_7_2() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_6
proc create_hier_cell_credit_based_shaper_6_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_6_2() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: arbiter_0
proc create_hier_cell_arbiter_0_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_arbiter_0_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S04_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S06_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S07_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O output_side_ready

<<<<<<< HEAD
  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
=======
  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.FRAME_GAP {24} \
 ] $ethernet_frame_arbit_0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
<<<<<<< HEAD
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
=======
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net extract_output_side_0_output_side_ready [get_bd_pins output_side_ready] [get_bd_pins extract_output_side_0/output_side_ready]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: registers_0
proc create_hier_cell_registers_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_registers_0_1() - Empty argument(s)!"}
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
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O -from 31 -to 0 cbs_6_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_6_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_send_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_send_slope

  # Create instance: axi_gpio_cbs_6_0, and set properties
  set axi_gpio_cbs_6_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_0

  # Create instance: axi_gpio_cbs_6_1, and set properties
  set axi_gpio_cbs_6_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_1

  # Create instance: axi_gpio_cbs_7_0, and set properties
  set axi_gpio_cbs_7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_0

  # Create instance: axi_gpio_cbs_7_1, and set properties
  set axi_gpio_cbs_7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_1

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_cbs_7_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins axi_gpio_cbs_7_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins axi_gpio_cbs_6_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_cbs_6_1/S_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins cbs_6_send_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins cbs_6_idle_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins cbs_6_min_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins cbs_6_max_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins cbs_7_send_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins cbs_7_idle_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins cbs_7_min_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins cbs_7_max_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio_io_o]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aclk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_7
proc create_hier_cell_packet_based_fifo_7_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_7_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_6
proc create_hier_cell_packet_based_fifo_6_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_6_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_5
proc create_hier_cell_packet_based_fifo_5_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_5_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_4
proc create_hier_cell_packet_based_fifo_4_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_4_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_3
proc create_hier_cell_packet_based_fifo_3_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_3_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_2
proc create_hier_cell_packet_based_fifo_2_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_2_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_1
proc create_hier_cell_packet_based_fifo_1_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_1_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_0
proc create_hier_cell_packet_based_fifo_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_0_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_7
proc create_hier_cell_credit_based_shaper_7_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_7_1() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_6
proc create_hier_cell_credit_based_shaper_6_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_6_1() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: arbiter_0
proc create_hier_cell_arbiter_0_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_arbiter_0_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S04_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S06_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S07_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O output_side_ready

<<<<<<< HEAD
  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
=======
  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.FRAME_GAP {24} \
 ] $ethernet_frame_arbit_0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
<<<<<<< HEAD
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
=======
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net extract_output_side_0_output_side_ready [get_bd_pins output_side_ready] [get_bd_pins extract_output_side_0/output_side_ready]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: registers_0
proc create_hier_cell_registers_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_registers_0() - Empty argument(s)!"}
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
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O -from 31 -to 0 cbs_6_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_6_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_6_send_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_idle_slope
  create_bd_pin -dir O -from 31 -to 0 cbs_7_max_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_min_credit
  create_bd_pin -dir O -from 31 -to 0 cbs_7_send_slope

  # Create instance: axi_gpio_cbs_6_0, and set properties
  set axi_gpio_cbs_6_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_0

  # Create instance: axi_gpio_cbs_6_1, and set properties
  set axi_gpio_cbs_6_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_6_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_6_1

  # Create instance: axi_gpio_cbs_7_0, and set properties
  set axi_gpio_cbs_7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_0 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x00000001} \
   CONFIG.C_DOUT_DEFAULT_2 {0xFFFFFFFF} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_0

  # Create instance: axi_gpio_cbs_7_1, and set properties
  set axi_gpio_cbs_7_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio_cbs_7_1 ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_ALL_OUTPUTS_2 {1} \
   CONFIG.C_DOUT_DEFAULT {0x7FFFFFFF} \
   CONFIG.C_DOUT_DEFAULT_2 {0x80000000} \
   CONFIG.C_IS_DUAL {1} \
 ] $axi_gpio_cbs_7_1

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins axi_gpio_cbs_7_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins axi_gpio_cbs_7_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins axi_gpio_cbs_6_0/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins axi_gpio_cbs_6_1/S_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins cbs_6_send_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins cbs_6_idle_slope] [get_bd_pins axi_gpio_cbs_6_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins cbs_6_min_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins cbs_6_max_credit] [get_bd_pins axi_gpio_cbs_6_1/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins cbs_7_send_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins cbs_7_idle_slope] [get_bd_pins axi_gpio_cbs_7_0/gpio_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins cbs_7_min_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio2_io_o]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins cbs_7_max_credit] [get_bd_pins axi_gpio_cbs_7_1/gpio_io_o]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aresetn] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aresetn] [get_bd_pins smartconnect_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axi_gpio_cbs_6_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_6_1/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_0/s_axi_aclk] [get_bd_pins axi_gpio_cbs_7_1/s_axi_aclk] [get_bd_pins smartconnect_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_7
proc create_hier_cell_packet_based_fifo_7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_7() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_6
proc create_hier_cell_packet_based_fifo_6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_6() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_5
proc create_hier_cell_packet_based_fifo_5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_5() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_4
proc create_hier_cell_packet_based_fifo_4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_4() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_3
proc create_hier_cell_packet_based_fifo_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_2
proc create_hier_cell_packet_based_fifo_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_1
proc create_hier_cell_packet_based_fifo_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: packet_based_fifo_0
proc create_hier_cell_packet_based_fifo_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_packet_based_fifo_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

<<<<<<< HEAD
  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16384} \
   CONFIG.FIFO_MEMORY_TYPE {block} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.PROG_FULL_THRESH {14861} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Empty_Threshold_Assert_Value_axis {16382} \
   CONFIG.Empty_Threshold_Assert_Value_rach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wach {14} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {14} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {14861} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {16384} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins fifo_generator_0/M_AXIS]

  # Create port connections
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_7
proc create_hier_cell_credit_based_shaper_7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_7() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: credit_based_shaper_6
proc create_hier_cell_credit_based_shaper_6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_credit_based_shaper_6() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I -from 31 -to 0 idle_slope
  create_bd_pin -dir I -from 31 -to 0 max_credit
  create_bd_pin -dir I -from 31 -to 0 min_credit
  create_bd_pin -dir I -from 31 -to 0 send_slope
  create_bd_pin -dir I transmission_gate_is_open

  # Create instance: credit_based_shaper_0, and set properties
  set credit_based_shaper_0 [ create_bd_cell -type ip -vlnv user.org:user:credit_based_shaper:1.0 credit_based_shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net credit_based_shaper_0_m_axis [get_bd_intf_pins m_axis] [get_bd_intf_pins credit_based_shaper_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins credit_based_shaper_0/s_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins credit_based_shaper_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins credit_based_shaper_0/rstn]
  connect_bd_net -net idle_slope_1 [get_bd_pins idle_slope] [get_bd_pins credit_based_shaper_0/idle_slope]
  connect_bd_net -net max_credit_1 [get_bd_pins max_credit] [get_bd_pins credit_based_shaper_0/max_credit]
  connect_bd_net -net min_credit_1 [get_bd_pins min_credit] [get_bd_pins credit_based_shaper_0/min_credit]
  connect_bd_net -net send_slope_1 [get_bd_pins send_slope] [get_bd_pins credit_based_shaper_0/send_slope]
  connect_bd_net -net transmission_gate_is_open_1 [get_bd_pins transmission_gate_is_open] [get_bd_pins credit_based_shaper_0/transmission_gate_is_open]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: arbiter_0
proc create_hier_cell_arbiter_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_arbiter_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S00_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S01_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S02_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S04_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S05_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S06_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S07_AXIS


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir O output_side_ready

<<<<<<< HEAD
  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
=======
  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.FRAME_GAP {24} \
 ] $ethernet_frame_arbit_0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
<<<<<<< HEAD
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
=======
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net extract_output_side_0_output_side_ready [get_bd_pins output_side_ready] [get_bd_pins extract_output_side_0/output_side_ready]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: switcher_3
proc create_hier_cell_switcher_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_switcher_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M04_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M05_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M06_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M07_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
   CONFIG.TDEST_WIDTH {3} \
 ] $axis_switch_0

  # Create instance: dest_to_user_0, and set properties
  set dest_to_user_0 [ create_bd_cell -type ip -vlnv user.org:user:dest_to_user:1.0 dest_to_user_0 ]

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins user_to_dest_0/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins axis_switch_0/M01_AXIS] [get_bd_intf_pins user_to_dest_1/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins axis_switch_0/M02_AXIS] [get_bd_intf_pins user_to_dest_2/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins axis_switch_0/M03_AXIS] [get_bd_intf_pins user_to_dest_3/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins axis_switch_0/M04_AXIS] [get_bd_intf_pins user_to_dest_4/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins axis_switch_0/M05_AXIS] [get_bd_intf_pins user_to_dest_5/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M06_AXIS [get_bd_intf_pins axis_switch_0/M06_AXIS] [get_bd_intf_pins user_to_dest_6/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M07_AXIS [get_bd_intf_pins axis_switch_0/M07_AXIS] [get_bd_intf_pins user_to_dest_7/s_axis]
  connect_bd_intf_net -intf_net dest_to_user_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/s_axis] [get_bd_intf_pins dest_to_user_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: switcher_2
proc create_hier_cell_switcher_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_switcher_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M04_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M05_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M06_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M07_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
   CONFIG.TDEST_WIDTH {3} \
 ] $axis_switch_0

  # Create instance: dest_to_user_0, and set properties
  set dest_to_user_0 [ create_bd_cell -type ip -vlnv user.org:user:dest_to_user:1.0 dest_to_user_0 ]

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins user_to_dest_0/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins axis_switch_0/M01_AXIS] [get_bd_intf_pins user_to_dest_1/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins axis_switch_0/M02_AXIS] [get_bd_intf_pins user_to_dest_2/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins axis_switch_0/M03_AXIS] [get_bd_intf_pins user_to_dest_3/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins axis_switch_0/M04_AXIS] [get_bd_intf_pins user_to_dest_4/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins axis_switch_0/M05_AXIS] [get_bd_intf_pins user_to_dest_5/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M06_AXIS [get_bd_intf_pins axis_switch_0/M06_AXIS] [get_bd_intf_pins user_to_dest_6/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M07_AXIS [get_bd_intf_pins axis_switch_0/M07_AXIS] [get_bd_intf_pins user_to_dest_7/s_axis]
  connect_bd_intf_net -intf_net dest_to_user_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/s_axis] [get_bd_intf_pins dest_to_user_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: switcher_1
proc create_hier_cell_switcher_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_switcher_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M04_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M05_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M06_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M07_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
   CONFIG.TDEST_WIDTH {3} \
 ] $axis_switch_0

  # Create instance: dest_to_user_0, and set properties
  set dest_to_user_0 [ create_bd_cell -type ip -vlnv user.org:user:dest_to_user:1.0 dest_to_user_0 ]

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins user_to_dest_0/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins axis_switch_0/M01_AXIS] [get_bd_intf_pins user_to_dest_1/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins axis_switch_0/M02_AXIS] [get_bd_intf_pins user_to_dest_2/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins axis_switch_0/M03_AXIS] [get_bd_intf_pins user_to_dest_3/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins axis_switch_0/M04_AXIS] [get_bd_intf_pins user_to_dest_4/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins axis_switch_0/M05_AXIS] [get_bd_intf_pins user_to_dest_5/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M06_AXIS [get_bd_intf_pins axis_switch_0/M06_AXIS] [get_bd_intf_pins user_to_dest_6/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M07_AXIS [get_bd_intf_pins axis_switch_0/M07_AXIS] [get_bd_intf_pins user_to_dest_7/s_axis]
  connect_bd_intf_net -intf_net dest_to_user_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/s_axis] [get_bd_intf_pins dest_to_user_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: switcher_0
proc create_hier_cell_switcher_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_switcher_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M04_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M05_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M06_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M07_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: add_tdest_from_vlan_0, and set properties
  set add_tdest_from_vlan_0 [ create_bd_cell -type ip -vlnv user.org:user:add_tdest_from_vlan_tag:1.0 add_tdest_from_vlan_0 ]

  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.DECODER_REG {1} \
   CONFIG.NUM_MI {8} \
   CONFIG.NUM_SI {1} \
   CONFIG.TDEST_WIDTH {3} \
 ] $axis_switch_0

  # Create instance: dest_to_user_0, and set properties
  set dest_to_user_0 [ create_bd_cell -type ip -vlnv user.org:user:dest_to_user:1.0 dest_to_user_0 ]

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
  connect_bd_intf_net -intf_net add_tdest_from_vlan_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/m_axis] [get_bd_intf_pins axis_switch_0/S00_AXIS]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins user_to_dest_0/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M01_AXIS [get_bd_intf_pins axis_switch_0/M01_AXIS] [get_bd_intf_pins user_to_dest_1/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M02_AXIS [get_bd_intf_pins axis_switch_0/M02_AXIS] [get_bd_intf_pins user_to_dest_2/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M03_AXIS [get_bd_intf_pins axis_switch_0/M03_AXIS] [get_bd_intf_pins user_to_dest_3/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M04_AXIS [get_bd_intf_pins axis_switch_0/M04_AXIS] [get_bd_intf_pins user_to_dest_4/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M05_AXIS [get_bd_intf_pins axis_switch_0/M05_AXIS] [get_bd_intf_pins user_to_dest_5/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M06_AXIS [get_bd_intf_pins axis_switch_0/M06_AXIS] [get_bd_intf_pins user_to_dest_6/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M07_AXIS [get_bd_intf_pins axis_switch_0/M07_AXIS] [get_bd_intf_pins user_to_dest_7/s_axis]
  connect_bd_intf_net -intf_net dest_to_user_0_m_axis [get_bd_intf_pins add_tdest_from_vlan_0/s_axis] [get_bd_intf_pins dest_to_user_0/m_axis]
  connect_bd_intf_net -intf_net s_axis_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]

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
  
<<<<<<< HEAD
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Type_AXI {Independent_Clock} \
   CONFIG.Empty_Threshold_Assert_Value_axis {4093} \
   CONFIG.Empty_Threshold_Assert_Value_rach {13} \
   CONFIG.Empty_Threshold_Assert_Value_rdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wach {13} \
   CONFIG.Empty_Threshold_Assert_Value_wdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {13} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_axis {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_rach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_rdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wrch {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {2496} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {4096} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  # Create instance: temac_3, and set properties
  set temac_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_3 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_3

<<<<<<< HEAD
  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_3_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_3/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_3_s_axi [get_bd_intf_pins eth_driver_3/s_axi] [get_bd_intf_pins temac_3/s_axi]
  connect_bd_intf_net -intf_net eth_driver_3_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_3/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_3_m_axis_rx [get_bd_intf_pins eth_driver_3/rx_axis_mac] [get_bd_intf_pins temac_3/m_axis_rx]
=======
  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_3_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_3/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_3_s_axi [get_bd_intf_pins eth_driver_3/s_axi] [get_bd_intf_pins temac_3/s_axi]
  connect_bd_intf_net -intf_net eth_driver_3_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins fifo_generator_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net temac_3_m_axis_rx [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins temac_3/m_axis_rx]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
=======
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_3/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_3/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_5 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_3/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_3/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_3/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_3/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_3/gtx_clk]
<<<<<<< HEAD
  connect_bd_net -net temac_3_rx_mac_aclk [get_bd_pins eth_driver_3/rx_axis_mac_aclk] [get_bd_pins temac_3/rx_mac_aclk]
  connect_bd_net -net temac_3_rx_reset [get_bd_pins eth_driver_3/rx_reset] [get_bd_pins temac_3/rx_reset]
  connect_bd_net -net temac_3_rx_statistics_valid [get_bd_pins eth_driver_3/rx_statistics_valid] [get_bd_pins temac_3/rx_statistics_valid]
  connect_bd_net -net temac_3_rx_statistics_vector [get_bd_pins eth_driver_3/rx_statistics_vector] [get_bd_pins temac_3/rx_statistics_vector]
  connect_bd_net -net temac_3_tx_mac_aclk [get_bd_pins tx_axis_mac_aclk] [get_bd_pins eth_driver_3/tx_axis_mac_aclk] [get_bd_pins temac_3/tx_mac_aclk]
=======
  connect_bd_net -net temac_3_rx_mac_aclk [get_bd_pins eth_driver_3/rx_axis_mac_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk] [get_bd_pins temac_3/rx_mac_aclk]
  connect_bd_net -net temac_3_rx_reset [get_bd_pins eth_driver_3/rx_reset] [get_bd_pins temac_3/rx_reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_3_rx_statistics_valid [get_bd_pins eth_driver_3/rx_statistics_valid] [get_bd_pins temac_3/rx_statistics_valid]
  connect_bd_net -net temac_3_rx_statistics_vector [get_bd_pins eth_driver_3/rx_statistics_vector] [get_bd_pins temac_3/rx_statistics_vector]
  connect_bd_net -net temac_3_tx_mac_aclk [get_bd_pins tx_axis_mac_aclk] [get_bd_pins eth_driver_3/tx_axis_mac_aclk] [get_bd_pins fifo_generator_0/m_aclk] [get_bd_pins temac_3/tx_mac_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net temac_3_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_3/tx_reset] [get_bd_pins temac_3/tx_reset]
  connect_bd_net -net temac_3_tx_statistics_valid [get_bd_pins eth_driver_3/tx_statistics_valid] [get_bd_pins temac_3/tx_statistics_valid]
  connect_bd_net -net temac_3_tx_statistics_vector [get_bd_pins eth_driver_3/tx_statistics_vector] [get_bd_pins temac_3/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_3/update_speed]
<<<<<<< HEAD
=======
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
  create_bd_pin -dir O -type clk tx_mac_aclk
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
  
<<<<<<< HEAD
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Type_AXI {Independent_Clock} \
   CONFIG.Empty_Threshold_Assert_Value_axis {4093} \
   CONFIG.Empty_Threshold_Assert_Value_rach {13} \
   CONFIG.Empty_Threshold_Assert_Value_rdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wach {13} \
   CONFIG.Empty_Threshold_Assert_Value_wdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {13} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_axis {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_rach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_rdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wrch {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {2496} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {4096} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  # Create instance: temac_2, and set properties
  set temac_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_2 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_2

<<<<<<< HEAD
  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_2_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_2/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_2_s_axi [get_bd_intf_pins eth_driver_2/s_axi] [get_bd_intf_pins temac_2/s_axi]
  connect_bd_intf_net -intf_net eth_driver_2_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_2/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_2_m_axis_rx [get_bd_intf_pins eth_driver_2/rx_axis_mac] [get_bd_intf_pins temac_2/m_axis_rx]
=======
  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_2_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_2/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_2_s_axi [get_bd_intf_pins eth_driver_2/s_axi] [get_bd_intf_pins temac_2/s_axi]
  connect_bd_intf_net -intf_net eth_driver_2_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins fifo_generator_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net temac_2_m_axis_rx [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins temac_2/m_axis_rx]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
=======
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_2/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_2/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_4 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_2/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_2/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_2/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_2/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_2/gtx_clk]
<<<<<<< HEAD
  connect_bd_net -net temac_2_rx_mac_aclk [get_bd_pins eth_driver_2/rx_axis_mac_aclk] [get_bd_pins temac_2/rx_mac_aclk]
  connect_bd_net -net temac_2_rx_reset [get_bd_pins eth_driver_2/rx_reset] [get_bd_pins temac_2/rx_reset]
  connect_bd_net -net temac_2_rx_statistics_valid [get_bd_pins eth_driver_2/rx_statistics_valid] [get_bd_pins temac_2/rx_statistics_valid]
  connect_bd_net -net temac_2_rx_statistics_vector [get_bd_pins eth_driver_2/rx_statistics_vector] [get_bd_pins temac_2/rx_statistics_vector]
  connect_bd_net -net temac_2_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_2/tx_axis_mac_aclk] [get_bd_pins temac_2/tx_mac_aclk]
=======
  connect_bd_net -net temac_2_rx_mac_aclk [get_bd_pins eth_driver_2/rx_axis_mac_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk] [get_bd_pins temac_2/rx_mac_aclk]
  connect_bd_net -net temac_2_rx_reset [get_bd_pins eth_driver_2/rx_reset] [get_bd_pins temac_2/rx_reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_2_rx_statistics_valid [get_bd_pins eth_driver_2/rx_statistics_valid] [get_bd_pins temac_2/rx_statistics_valid]
  connect_bd_net -net temac_2_rx_statistics_vector [get_bd_pins eth_driver_2/rx_statistics_vector] [get_bd_pins temac_2/rx_statistics_vector]
  connect_bd_net -net temac_2_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_2/tx_axis_mac_aclk] [get_bd_pins fifo_generator_0/m_aclk] [get_bd_pins temac_2/tx_mac_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net temac_2_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_2/tx_reset] [get_bd_pins temac_2/tx_reset]
  connect_bd_net -net temac_2_tx_statistics_valid [get_bd_pins eth_driver_2/tx_statistics_valid] [get_bd_pins temac_2/tx_statistics_valid]
  connect_bd_net -net temac_2_tx_statistics_vector [get_bd_pins eth_driver_2/tx_statistics_vector] [get_bd_pins temac_2/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_2/update_speed]
<<<<<<< HEAD
=======
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
  create_bd_pin -dir O -type clk tx_mac_aclk
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
  
<<<<<<< HEAD
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Type_AXI {Independent_Clock} \
   CONFIG.Empty_Threshold_Assert_Value_axis {4093} \
   CONFIG.Empty_Threshold_Assert_Value_rach {13} \
   CONFIG.Empty_Threshold_Assert_Value_rdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wach {13} \
   CONFIG.Empty_Threshold_Assert_Value_wdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {13} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_axis {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_rach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_rdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wrch {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {2496} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {4096} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  # Create instance: temac_1, and set properties
  set temac_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_1 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {0} \
 ] $temac_1

<<<<<<< HEAD
  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_1_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_1/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_1_s_axi [get_bd_intf_pins eth_driver_1/s_axi] [get_bd_intf_pins temac_1/s_axi]
  connect_bd_intf_net -intf_net eth_driver_1_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_1/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_1_m_axis_rx [get_bd_intf_pins eth_driver_1/rx_axis_mac] [get_bd_intf_pins temac_1/m_axis_rx]
=======
  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_1_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_1/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_1_s_axi [get_bd_intf_pins eth_driver_1/s_axi] [get_bd_intf_pins temac_1/s_axi]
  connect_bd_intf_net -intf_net eth_driver_1_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins fifo_generator_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net temac_1_m_axis_rx [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins temac_1/m_axis_rx]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
=======
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_1/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_1/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_3 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_1/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_1/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_1/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90] [get_bd_pins temac_1/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk] [get_bd_pins temac_1/gtx_clk]
<<<<<<< HEAD
  connect_bd_net -net temac_1_rx_mac_aclk [get_bd_pins eth_driver_1/rx_axis_mac_aclk] [get_bd_pins temac_1/rx_mac_aclk]
  connect_bd_net -net temac_1_rx_reset [get_bd_pins eth_driver_1/rx_reset] [get_bd_pins temac_1/rx_reset]
  connect_bd_net -net temac_1_rx_statistics_valid [get_bd_pins eth_driver_1/rx_statistics_valid] [get_bd_pins temac_1/rx_statistics_valid]
  connect_bd_net -net temac_1_rx_statistics_vector [get_bd_pins eth_driver_1/rx_statistics_vector] [get_bd_pins temac_1/rx_statistics_vector]
  connect_bd_net -net temac_1_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_1/tx_axis_mac_aclk] [get_bd_pins temac_1/tx_mac_aclk]
=======
  connect_bd_net -net temac_1_rx_mac_aclk [get_bd_pins eth_driver_1/rx_axis_mac_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk] [get_bd_pins temac_1/rx_mac_aclk]
  connect_bd_net -net temac_1_rx_reset [get_bd_pins eth_driver_1/rx_reset] [get_bd_pins temac_1/rx_reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_1_rx_statistics_valid [get_bd_pins eth_driver_1/rx_statistics_valid] [get_bd_pins temac_1/rx_statistics_valid]
  connect_bd_net -net temac_1_rx_statistics_vector [get_bd_pins eth_driver_1/rx_statistics_vector] [get_bd_pins temac_1/rx_statistics_vector]
  connect_bd_net -net temac_1_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_1/tx_axis_mac_aclk] [get_bd_pins fifo_generator_0/m_aclk] [get_bd_pins temac_1/tx_mac_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net temac_1_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_1/tx_reset] [get_bd_pins temac_1/tx_reset]
  connect_bd_net -net temac_1_tx_statistics_valid [get_bd_pins eth_driver_1/tx_statistics_valid] [get_bd_pins temac_1/tx_statistics_valid]
  connect_bd_net -net temac_1_tx_statistics_vector [get_bd_pins eth_driver_1/tx_statistics_vector] [get_bd_pins temac_1/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_1/update_speed]
<<<<<<< HEAD
=======
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
  
<<<<<<< HEAD
=======
  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]

  # Create instance: fifo_generator_0, and set properties
  set fifo_generator_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_0 ]
  set_property -dict [ list \
   CONFIG.Clock_Type_AXI {Independent_Clock} \
   CONFIG.Empty_Threshold_Assert_Value_axis {4093} \
   CONFIG.Empty_Threshold_Assert_Value_rach {13} \
   CONFIG.Empty_Threshold_Assert_Value_rdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wach {13} \
   CONFIG.Empty_Threshold_Assert_Value_wdch {1021} \
   CONFIG.Empty_Threshold_Assert_Value_wrch {13} \
   CONFIG.Enable_Safety_Circuit {true} \
   CONFIG.Enable_TLAST {true} \
   CONFIG.FIFO_Implementation_axis {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_rach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_rdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wach {Independent_Clocks_Distributed_RAM} \
   CONFIG.FIFO_Implementation_wdch {Independent_Clocks_Block_RAM} \
   CONFIG.FIFO_Implementation_wrch {Independent_Clocks_Distributed_RAM} \
   CONFIG.Full_Flags_Reset_Value {1} \
   CONFIG.Full_Threshold_Assert_Value_axis {2496} \
   CONFIG.Full_Threshold_Assert_Value_rach {15} \
   CONFIG.Full_Threshold_Assert_Value_wach {15} \
   CONFIG.Full_Threshold_Assert_Value_wrch {15} \
   CONFIG.INTERFACE_TYPE {AXI_STREAM} \
   CONFIG.Input_Depth_axis {4096} \
   CONFIG.Programmable_Full_Type_axis {Single_Programmable_Full_Threshold_Constant} \
   CONFIG.Reset_Type {Asynchronous_Reset} \
   CONFIG.TUSER_WIDTH {0} \
 ] $fifo_generator_0

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  # Create instance: temac_0, and set properties
  set temac_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:tri_mode_ethernet_mac:9.0 temac_0 ]
  set_property -dict [ list \
   CONFIG.Physical_Interface {RGMII} \
   CONFIG.SupportLevel {1} \
 ] $temac_0

<<<<<<< HEAD
  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_0_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_0/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_0_s_axi [get_bd_intf_pins eth_driver_0/s_axi] [get_bd_intf_pins temac_0/s_axi]
  connect_bd_intf_net -intf_net eth_driver_0_tx_axis_mac [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins eth_driver_0/tx_axis_mac]
  connect_bd_intf_net -intf_net temac_0_m_axis_rx [get_bd_intf_pins eth_driver_0/rx_axis_mac] [get_bd_intf_pins temac_0/m_axis_rx]
=======
  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axis_data_fifo_sw_0_M_AXIS [get_bd_intf_pins s_axis_tx] [get_bd_intf_pins temac_0/s_axis_tx]
  connect_bd_intf_net -intf_net eth_driver_0_s_axi [get_bd_intf_pins eth_driver_0/s_axi] [get_bd_intf_pins temac_0/s_axi]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins ethernet_frame_dropp_0/m_axis] [get_bd_intf_pins fifo_generator_0/S_AXIS]
  connect_bd_intf_net -intf_net fifo_generator_0_M_AXIS [get_bd_intf_pins tx_axis_mac] [get_bd_intf_pins fifo_generator_0/M_AXIS]
  connect_bd_intf_net -intf_net temac_0_m_axis_rx [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins temac_0/m_axis_rx]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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
<<<<<<< HEAD
=======
  connect_bd_net -net fifo_generator_0_axis_prog_full [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full] [get_bd_pins fifo_generator_0/axis_prog_full]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net gen_tx_data_1 [get_bd_pins gen_tx_data] [get_bd_pins eth_driver_0/gen_tx_data]
  connect_bd_net -net glbl_rst_1 [get_bd_pins glbl_rst] [get_bd_pins eth_driver_0/glbl_rst]
  connect_bd_net -net hier_flow_control_pause_req_2 [get_bd_pins pause_req_s] [get_bd_pins eth_driver_0/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_pins mac_speed] [get_bd_pins eth_driver_0/mac_speed]
  connect_bd_net -net reset_error_1 [get_bd_pins reset_error] [get_bd_pins eth_driver_0/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins gtx_clk90_out] [get_bd_pins temac_0/gtx_clk90_out]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins gtx_clk_out] [get_bd_pins temac_0/gtx_clk_out]
<<<<<<< HEAD
  connect_bd_net -net temac_0_rx_mac_aclk [get_bd_pins rx_mac_aclk] [get_bd_pins eth_driver_0/rx_axis_mac_aclk] [get_bd_pins temac_0/rx_mac_aclk]
  connect_bd_net -net temac_0_rx_reset [get_bd_pins rx_reset] [get_bd_pins eth_driver_0/rx_reset] [get_bd_pins temac_0/rx_reset]
  connect_bd_net -net temac_0_rx_statistics_valid [get_bd_pins eth_driver_0/rx_statistics_valid] [get_bd_pins temac_0/rx_statistics_valid]
  connect_bd_net -net temac_0_rx_statistics_vector [get_bd_pins eth_driver_0/rx_statistics_vector] [get_bd_pins temac_0/rx_statistics_vector]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_0/tx_axis_mac_aclk] [get_bd_pins temac_0/tx_mac_aclk]
=======
  connect_bd_net -net temac_0_rx_mac_aclk [get_bd_pins rx_mac_aclk] [get_bd_pins eth_driver_0/rx_axis_mac_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins fifo_generator_0/s_aclk] [get_bd_pins temac_0/rx_mac_aclk]
  connect_bd_net -net temac_0_rx_reset [get_bd_pins rx_reset] [get_bd_pins eth_driver_0/rx_reset] [get_bd_pins temac_0/rx_reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_0_rx_statistics_valid [get_bd_pins eth_driver_0/rx_statistics_valid] [get_bd_pins temac_0/rx_statistics_valid]
  connect_bd_net -net temac_0_rx_statistics_vector [get_bd_pins eth_driver_0/rx_statistics_vector] [get_bd_pins temac_0/rx_statistics_vector]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins tx_mac_aclk] [get_bd_pins eth_driver_0/tx_axis_mac_aclk] [get_bd_pins fifo_generator_0/m_aclk] [get_bd_pins temac_0/tx_mac_aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net temac_0_tx_reset [get_bd_pins tx_reset] [get_bd_pins eth_driver_0/tx_reset] [get_bd_pins temac_0/tx_reset]
  connect_bd_net -net temac_0_tx_statistics_valid [get_bd_pins eth_driver_0/tx_statistics_valid] [get_bd_pins temac_0/tx_statistics_valid]
  connect_bd_net -net temac_0_tx_statistics_vector [get_bd_pins eth_driver_0/tx_statistics_vector] [get_bd_pins temac_0/tx_statistics_vector]
  connect_bd_net -net update_speed_1 [get_bd_pins update_speed] [get_bd_pins eth_driver_0/update_speed]
<<<<<<< HEAD
=======
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins fifo_generator_0/s_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

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
  create_bd_pin -dir O -from 0 -to 0 drop_enable
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

  # Create instance: fifo_generator_4, and set properties
  set fifo_generator_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fifo_generator:13.2 fifo_generator_4 ]
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
 ] $fifo_generator_4

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

  # Create instance: util_vector_logic_not_0, and set properties
  set util_vector_logic_not_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_not_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_not_0

  # Create interface connections
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins S_AXI] [get_bd_intf_pins axi_gpio_flow_control/S_AXI]

  # Create port connections
  connect_bd_net -net axi_gpio_flow_control_gpio_io_o [get_bd_pins axi_gpio_flow_control/gpio_io_o] [get_bd_pins fifo_generator_4/din] [get_bd_pins util_vector_logic_and_0/Op2] [get_bd_pins util_vector_logic_and_1/Op2] [get_bd_pins util_vector_logic_and_2/Op2] [get_bd_pins util_vector_logic_and_3/Op2]
  connect_bd_net -net axis_data_fifo_swin_0_prog_full [get_bd_pins almost_full_0] [get_bd_pins fifo_generator_0/din]
  connect_bd_net -net axis_data_fifo_swin_1_prog_full [get_bd_pins almost_full_1] [get_bd_pins fifo_generator_1/din]
  connect_bd_net -net axis_data_fifo_swin_2_prog_full [get_bd_pins almost_full_2] [get_bd_pins fifo_generator_2/din]
  connect_bd_net -net axis_data_fifo_swin_3_prog_full [get_bd_pins almost_full_3] [get_bd_pins fifo_generator_3/din]
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins fifo_rd_clk] [get_bd_pins axi_gpio_flow_control/s_axi_aclk] [get_bd_pins fifo_generator_0/rd_clk] [get_bd_pins fifo_generator_1/rd_clk] [get_bd_pins fifo_generator_2/rd_clk] [get_bd_pins fifo_generator_3/rd_clk] [get_bd_pins fifo_generator_4/wr_clk]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins s_axi_aresetn] [get_bd_pins axi_gpio_flow_control/s_axi_aresetn]
  connect_bd_net -net fifo_generator_0_dout [get_bd_pins fifo_generator_0/dout] [get_bd_pins util_vector_logic_and_0/Op1]
  connect_bd_net -net fifo_generator_1_dout [get_bd_pins fifo_generator_1/dout] [get_bd_pins util_vector_logic_and_1/Op1]
  connect_bd_net -net fifo_generator_2_dout [get_bd_pins fifo_generator_2/dout] [get_bd_pins util_vector_logic_and_2/Op1]
  connect_bd_net -net fifo_generator_3_dout [get_bd_pins fifo_generator_3/dout] [get_bd_pins util_vector_logic_and_3/Op1]
  connect_bd_net -net fifo_generator_4_dout [get_bd_pins fifo_generator_4/dout] [get_bd_pins util_vector_logic_not_0/Op1]
  connect_bd_net -net ref_clk_oe_dout [get_bd_pins constant_1/dout] [get_bd_pins fifo_generator_0/rd_en] [get_bd_pins fifo_generator_0/wr_en] [get_bd_pins fifo_generator_1/rd_en] [get_bd_pins fifo_generator_1/wr_en] [get_bd_pins fifo_generator_2/rd_en] [get_bd_pins fifo_generator_2/wr_en] [get_bd_pins fifo_generator_3/rd_en] [get_bd_pins fifo_generator_3/wr_en] [get_bd_pins fifo_generator_4/rd_en] [get_bd_pins fifo_generator_4/wr_en]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins fifo_wr_clk] [get_bd_pins fifo_generator_0/wr_clk] [get_bd_pins fifo_generator_1/wr_clk] [get_bd_pins fifo_generator_2/wr_clk] [get_bd_pins fifo_generator_3/wr_clk] [get_bd_pins fifo_generator_4/rd_clk]
  connect_bd_net -net util_vector_logic_and_0_Res [get_bd_pins pause_req_0] [get_bd_pins util_vector_logic_and_0/Res]
  connect_bd_net -net util_vector_logic_and_1_Res [get_bd_pins pause_req_1] [get_bd_pins util_vector_logic_and_1/Res]
  connect_bd_net -net util_vector_logic_and_2_Res [get_bd_pins pause_req_2] [get_bd_pins util_vector_logic_and_2/Res]
  connect_bd_net -net util_vector_logic_and_3_Res [get_bd_pins pause_req_3] [get_bd_pins util_vector_logic_and_3/Res]
  connect_bd_net -net util_vector_logic_not_0_Res [get_bd_pins drop_enable] [get_bd_pins util_vector_logic_not_0/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_fdb
proc create_hier_cell_hier_fdb { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_fdb() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

<<<<<<< HEAD
=======
  # Create instance: axis_register_slice_in, and set properties
  set axis_register_slice_in [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_in ]

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  # Create instance: axis_switch_0, and set properties
  set axis_switch_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 axis_switch_0 ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {4} \
 ] $axis_switch_0

<<<<<<< HEAD
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
=======
  # Create instance: channel_in_opt_0, and set properties
  set channel_in_opt_0 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_0 ]

  # Create instance: channel_in_opt_1, and set properties
  set channel_in_opt_1 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_1 ]
  set_property -dict [ list \
   CONFIG.PORT_ADDR {1} \
 ] $channel_in_opt_1

  # Create instance: channel_in_opt_2, and set properties
  set channel_in_opt_2 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_2 ]
  set_property -dict [ list \
   CONFIG.PORT_ADDR {2} \
 ] $channel_in_opt_2

  # Create instance: channel_in_opt_3, and set properties
  set channel_in_opt_3 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_3 ]
  set_property -dict [ list \
   CONFIG.PORT_ADDR {3} \
 ] $channel_in_opt_3

  # Create instance: mactable_mod_0, and set properties
  set block_name mactable_mod
  set block_cell_name mactable_mod_0
  if { [catch {set mactable_mod_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mactable_mod_0 eq "" } {
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.MODE {dynamic} \
   CONFIG.PORT_WIDTH {2} \
<<<<<<< HEAD
 ] $mactable_0
=======
 ] $mactable_mod_0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Create instance: xlconstant_val_0, and set properties
  set xlconstant_val_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_val_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_val_0

  # Create interface connections
<<<<<<< HEAD
  connect_bd_intf_net -intf_net axis_data_fifo_swin_0_M_AXIS1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins channel_in_mod_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_1_M_AXIS [get_bd_intf_pins s_axis1] [get_bd_intf_pins channel_in_mod_1/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_2_M_AXIS [get_bd_intf_pins s_axis2] [get_bd_intf_pins channel_in_mod_2/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_3_M_AXIS [get_bd_intf_pins s_axis3] [get_bd_intf_pins channel_in_mod_3/s_axis]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_switch_0/M00_AXIS] [get_bd_intf_pins mactable_0/s_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins channel_in_mod_0/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_0_m_axis_table_request [get_bd_intf_pins axis_switch_0/S00_AXIS] [get_bd_intf_pins channel_in_mod_0/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins channel_in_mod_1/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_1_m_axis_table_request [get_bd_intf_pins axis_switch_0/S01_AXIS] [get_bd_intf_pins channel_in_mod_1/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins channel_in_mod_2/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_2_m_axis_table_request [get_bd_intf_pins axis_switch_0/S02_AXIS] [get_bd_intf_pins channel_in_mod_2/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_mod_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins channel_in_mod_3/m_axis]
  connect_bd_intf_net -intf_net channel_in_mod_3_m_axis_table_request [get_bd_intf_pins axis_switch_0/S03_AXIS] [get_bd_intf_pins channel_in_mod_3/m_axis_table_request]

  # Create port connections
  connect_bd_net -net mactable_0_m_axis_table_response_tdata [get_bd_pins channel_in_mod_0/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_1/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_2/s_axis_table_response_tdata] [get_bd_pins channel_in_mod_3/s_axis_table_response_tdata] [get_bd_pins mactable_0/m_axis_table_response_tdata]
  connect_bd_net -net mactable_0_m_axis_table_response_tuser [get_bd_pins channel_in_mod_0/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_1/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_2/s_axis_table_response_tuser] [get_bd_pins channel_in_mod_3/s_axis_table_response_tuser] [get_bd_pins mactable_0/m_axis_table_response_tuser]
  connect_bd_net -net mactable_0_m_axis_table_response_tvalid [get_bd_pins channel_in_mod_0/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_1/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_2/s_axis_table_response_tvalid] [get_bd_pins channel_in_mod_3/s_axis_table_response_tvalid] [get_bd_pins mactable_0/m_axis_table_response_tvalid]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins channel_in_mod_0/aresetn] [get_bd_pins channel_in_mod_1/aresetn] [get_bd_pins channel_in_mod_2/aresetn] [get_bd_pins channel_in_mod_3/aresetn] [get_bd_pins mactable_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins channel_in_mod_0/aclk] [get_bd_pins channel_in_mod_1/aclk] [get_bd_pins channel_in_mod_2/aclk] [get_bd_pins channel_in_mod_3/aclk] [get_bd_pins mactable_0/aclk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axis_switch_0/s_req_suppress] [get_bd_pins mactable_0/s_axis_table_config_tvalid] [get_bd_pins xlconstant_val_0/dout]
=======
  connect_bd_intf_net -intf_net axis_register_slice_in_M_AXIS [get_bd_intf_pins axis_register_slice_in/M_AXIS] [get_bd_intf_pins mactable_mod_0/s_axis_table_request]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_register_slice_in/S_AXIS] [get_bd_intf_pins axis_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins channel_in_opt_0/m_axis]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis_table_request [get_bd_intf_pins axis_switch_0/S00_AXIS] [get_bd_intf_pins channel_in_opt_0/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_opt_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins channel_in_opt_1/m_axis]
  connect_bd_intf_net -intf_net channel_in_opt_1_m_axis_table_request [get_bd_intf_pins axis_switch_0/S01_AXIS] [get_bd_intf_pins channel_in_opt_1/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_opt_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins channel_in_opt_2/m_axis]
  connect_bd_intf_net -intf_net channel_in_opt_2_m_axis_table_request [get_bd_intf_pins axis_switch_0/S02_AXIS] [get_bd_intf_pins channel_in_opt_2/m_axis_table_request]
  connect_bd_intf_net -intf_net channel_in_opt_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins channel_in_opt_3/m_axis]
  connect_bd_intf_net -intf_net channel_in_opt_3_m_axis_table_request [get_bd_intf_pins axis_switch_0/S03_AXIS] [get_bd_intf_pins channel_in_opt_3/m_axis_table_request]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins channel_in_opt_0/s_axis]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins channel_in_opt_1/s_axis]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins channel_in_opt_2/s_axis]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins channel_in_opt_3/s_axis]

  # Create port connections
  connect_bd_net -net mactable_0_m_axis_table_response_tdata [get_bd_pins channel_in_opt_0/s_axis_table_response_tdata] [get_bd_pins channel_in_opt_1/s_axis_table_response_tdata] [get_bd_pins channel_in_opt_2/s_axis_table_response_tdata] [get_bd_pins channel_in_opt_3/s_axis_table_response_tdata] [get_bd_pins mactable_mod_0/m_axis_table_response_tdata]
  connect_bd_net -net mactable_0_m_axis_table_response_tuser [get_bd_pins channel_in_opt_0/s_axis_table_response_tuser] [get_bd_pins channel_in_opt_1/s_axis_table_response_tuser] [get_bd_pins channel_in_opt_2/s_axis_table_response_tuser] [get_bd_pins channel_in_opt_3/s_axis_table_response_tuser] [get_bd_pins mactable_mod_0/m_axis_table_response_tuser]
  connect_bd_net -net mactable_0_m_axis_table_response_tvalid [get_bd_pins channel_in_opt_0/s_axis_table_response_tvalid] [get_bd_pins channel_in_opt_1/s_axis_table_response_tvalid] [get_bd_pins channel_in_opt_2/s_axis_table_response_tvalid] [get_bd_pins channel_in_opt_3/s_axis_table_response_tvalid] [get_bd_pins mactable_mod_0/m_axis_table_response_tvalid]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_register_slice_in/aresetn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins channel_in_opt_0/aresetn] [get_bd_pins channel_in_opt_1/aresetn] [get_bd_pins channel_in_opt_2/aresetn] [get_bd_pins channel_in_opt_3/aresetn] [get_bd_pins mactable_mod_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_register_slice_in/aclk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins channel_in_opt_0/aclk] [get_bd_pins channel_in_opt_1/aclk] [get_bd_pins channel_in_opt_2/aclk] [get_bd_pins channel_in_opt_3/aclk] [get_bd_pins mactable_mod_0/aclk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins axis_switch_0/s_req_suppress] [get_bd_pins mactable_mod_0/s_axis_table_config_tvalid] [get_bd_pins xlconstant_val_0/dout]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_7
proc create_hier_cell_hier_eth_switch_7 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_7() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_6
proc create_hier_cell_hier_eth_switch_6 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_6() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_5
proc create_hier_cell_hier_eth_switch_5 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_5() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_4
proc create_hier_cell_hier_eth_switch_4 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_4() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_3
proc create_hier_cell_hier_eth_switch_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_3() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_2
proc create_hier_cell_hier_eth_switch_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_2() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_1
proc create_hier_cell_hier_eth_switch_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_1() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_eth_switch_0
proc create_hier_cell_hier_eth_switch_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_eth_switch_0() - Empty argument(s)!"}
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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M00_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M01_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M02_AXIS

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M03_AXIS

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis3


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ALGORITHM {0} \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_NUM_CYCLES {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.HAS_ACLKEN {0} \
   CONFIG.M00_AXIS_BASETDEST {0x00000000} \
   CONFIG.M00_AXIS_HIGHTDEST {0x00000000} \
<<<<<<< HEAD
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
=======
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_AXIS_BASETDEST {0x00000001} \
   CONFIG.M01_AXIS_HIGHTDEST {0x00000001} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_AXIS_BASETDEST {0x00000002} \
   CONFIG.M02_AXIS_HIGHTDEST {0x00000002} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_AXIS_BASETDEST {0x00000003} \
   CONFIG.M03_AXIS_HIGHTDEST {0x00000003} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.ROUTING_MODE {0} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins s_axis2] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s_axis3_1 [get_bd_intf_pins s_axis3] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]
  connect_bd_intf_net -intf_net switch_4port_0_m_axis_1 [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_cbs_3
proc create_hier_cell_hier_cbs_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_cbs_3() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_7

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

  # Create instance: arbiter_0
  create_hier_cell_arbiter_0_3 $hier_obj arbiter_0

  # Create instance: credit_based_shaper_6
  create_hier_cell_credit_based_shaper_6_3 $hier_obj credit_based_shaper_6

  # Create instance: credit_based_shaper_7
  create_hier_cell_credit_based_shaper_7_3 $hier_obj credit_based_shaper_7

  # Create instance: packet_based_fifo_0
  create_hier_cell_packet_based_fifo_0_3 $hier_obj packet_based_fifo_0

  # Create instance: packet_based_fifo_1
  create_hier_cell_packet_based_fifo_1_3 $hier_obj packet_based_fifo_1

  # Create instance: packet_based_fifo_2
  create_hier_cell_packet_based_fifo_2_3 $hier_obj packet_based_fifo_2

  # Create instance: packet_based_fifo_3
  create_hier_cell_packet_based_fifo_3_3 $hier_obj packet_based_fifo_3

  # Create instance: packet_based_fifo_4
  create_hier_cell_packet_based_fifo_4_3 $hier_obj packet_based_fifo_4

  # Create instance: packet_based_fifo_5
  create_hier_cell_packet_based_fifo_5_3 $hier_obj packet_based_fifo_5

  # Create instance: packet_based_fifo_6
  create_hier_cell_packet_based_fifo_6_3 $hier_obj packet_based_fifo_6

  # Create instance: packet_based_fifo_7
  create_hier_cell_packet_based_fifo_7_3 $hier_obj packet_based_fifo_7

  # Create instance: register_slice_0, and set properties
  set register_slice_0 [ create_bd_cell -type ip -vlnv user.org:user:register_slice:1.0 register_slice_0 ]

  # Create instance: registers_0
  create_hier_cell_registers_0_3 $hier_obj registers_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_1_1 [get_bd_intf_pins S_AXIS_1] [get_bd_intf_pins packet_based_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_2_1 [get_bd_intf_pins S_AXIS_2] [get_bd_intf_pins packet_based_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_3_1 [get_bd_intf_pins S_AXIS_3] [get_bd_intf_pins packet_based_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_4_1 [get_bd_intf_pins S_AXIS_4] [get_bd_intf_pins packet_based_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_5_1 [get_bd_intf_pins S_AXIS_5] [get_bd_intf_pins packet_based_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_6_1 [get_bd_intf_pins S_AXIS_6] [get_bd_intf_pins packet_based_fifo_6/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_7_1 [get_bd_intf_pins S_AXIS_7] [get_bd_intf_pins packet_based_fifo_7/S_AXIS]
  connect_bd_intf_net -intf_net arbiter_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins arbiter_0/M00_AXIS]
  connect_bd_intf_net -intf_net credit_based_shaper_6_m_axis [get_bd_intf_pins arbiter_0/S06_AXIS] [get_bd_intf_pins credit_based_shaper_6/m_axis]
  connect_bd_intf_net -intf_net credit_based_shaper_7_m_axis [get_bd_intf_pins arbiter_0/S07_AXIS] [get_bd_intf_pins credit_based_shaper_7/m_axis]
  connect_bd_intf_net -intf_net packet_based_fifo_0_M_AXIS [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_1_M_AXIS [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_2_M_AXIS [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_3_M_AXIS [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_4_M_AXIS [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_5_M_AXIS [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_6_M_AXIS [get_bd_intf_pins credit_based_shaper_6/s_axis] [get_bd_intf_pins packet_based_fifo_6/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_7_M_AXIS [get_bd_intf_pins credit_based_shaper_7/s_axis] [get_bd_intf_pins packet_based_fifo_7/M_AXIS]

  # Create port connections
  connect_bd_net -net arbiter_0_output_side_ready [get_bd_pins arbiter_0/output_side_ready] [get_bd_pins credit_based_shaper_6/transmission_gate_is_open] [get_bd_pins credit_based_shaper_7/transmission_gate_is_open]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins credit_based_shaper_6/send_slope] [get_bd_pins registers_0/cbs_6_send_slope]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins credit_based_shaper_6/idle_slope] [get_bd_pins registers_0/cbs_6_idle_slope]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins credit_based_shaper_6/min_credit] [get_bd_pins registers_0/cbs_6_min_credit]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins credit_based_shaper_6/max_credit] [get_bd_pins registers_0/cbs_6_max_credit]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins credit_based_shaper_7/send_slope] [get_bd_pins registers_0/cbs_7_send_slope]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins credit_based_shaper_7/idle_slope] [get_bd_pins registers_0/cbs_7_idle_slope]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins credit_based_shaper_7/min_credit] [get_bd_pins registers_0/cbs_7_min_credit]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins credit_based_shaper_7/max_credit] [get_bd_pins registers_0/cbs_7_max_credit]
  connect_bd_net -net drop_enable_1 [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable] [get_bd_pins register_slice_0/data_out]
  connect_bd_net -net drop_enable_2 [get_bd_pins drop_enable] [get_bd_pins register_slice_0/data_in]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins register_slice_0/clk] [get_bd_pins registers_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_cbs_2
proc create_hier_cell_hier_cbs_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_cbs_2() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_7

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

  # Create instance: arbiter_0
  create_hier_cell_arbiter_0_2 $hier_obj arbiter_0

  # Create instance: credit_based_shaper_6
  create_hier_cell_credit_based_shaper_6_2 $hier_obj credit_based_shaper_6

  # Create instance: credit_based_shaper_7
  create_hier_cell_credit_based_shaper_7_2 $hier_obj credit_based_shaper_7

  # Create instance: packet_based_fifo_0
  create_hier_cell_packet_based_fifo_0_2 $hier_obj packet_based_fifo_0

  # Create instance: packet_based_fifo_1
  create_hier_cell_packet_based_fifo_1_2 $hier_obj packet_based_fifo_1

  # Create instance: packet_based_fifo_2
  create_hier_cell_packet_based_fifo_2_2 $hier_obj packet_based_fifo_2

  # Create instance: packet_based_fifo_3
  create_hier_cell_packet_based_fifo_3_2 $hier_obj packet_based_fifo_3

  # Create instance: packet_based_fifo_4
  create_hier_cell_packet_based_fifo_4_2 $hier_obj packet_based_fifo_4

  # Create instance: packet_based_fifo_5
  create_hier_cell_packet_based_fifo_5_2 $hier_obj packet_based_fifo_5

  # Create instance: packet_based_fifo_6
  create_hier_cell_packet_based_fifo_6_2 $hier_obj packet_based_fifo_6

  # Create instance: packet_based_fifo_7
  create_hier_cell_packet_based_fifo_7_2 $hier_obj packet_based_fifo_7

  # Create instance: register_slice_0, and set properties
  set register_slice_0 [ create_bd_cell -type ip -vlnv user.org:user:register_slice:1.0 register_slice_0 ]

  # Create instance: registers_0
  create_hier_cell_registers_0_2 $hier_obj registers_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_1_1 [get_bd_intf_pins S_AXIS_1] [get_bd_intf_pins packet_based_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_2_1 [get_bd_intf_pins S_AXIS_2] [get_bd_intf_pins packet_based_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_3_1 [get_bd_intf_pins S_AXIS_3] [get_bd_intf_pins packet_based_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_4_1 [get_bd_intf_pins S_AXIS_4] [get_bd_intf_pins packet_based_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_5_1 [get_bd_intf_pins S_AXIS_5] [get_bd_intf_pins packet_based_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_6_1 [get_bd_intf_pins S_AXIS_6] [get_bd_intf_pins packet_based_fifo_6/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_7_1 [get_bd_intf_pins S_AXIS_7] [get_bd_intf_pins packet_based_fifo_7/S_AXIS]
  connect_bd_intf_net -intf_net arbiter_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins arbiter_0/M00_AXIS]
  connect_bd_intf_net -intf_net credit_based_shaper_6_m_axis [get_bd_intf_pins arbiter_0/S06_AXIS] [get_bd_intf_pins credit_based_shaper_6/m_axis]
  connect_bd_intf_net -intf_net credit_based_shaper_7_m_axis [get_bd_intf_pins arbiter_0/S07_AXIS] [get_bd_intf_pins credit_based_shaper_7/m_axis]
  connect_bd_intf_net -intf_net packet_based_fifo_0_M_AXIS [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_1_M_AXIS [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_2_M_AXIS [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_3_M_AXIS [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_4_M_AXIS [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_5_M_AXIS [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_6_M_AXIS [get_bd_intf_pins credit_based_shaper_6/s_axis] [get_bd_intf_pins packet_based_fifo_6/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_7_M_AXIS [get_bd_intf_pins credit_based_shaper_7/s_axis] [get_bd_intf_pins packet_based_fifo_7/M_AXIS]

  # Create port connections
  connect_bd_net -net arbiter_0_output_side_ready [get_bd_pins arbiter_0/output_side_ready] [get_bd_pins credit_based_shaper_6/transmission_gate_is_open] [get_bd_pins credit_based_shaper_7/transmission_gate_is_open]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins credit_based_shaper_6/send_slope] [get_bd_pins registers_0/cbs_6_send_slope]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins credit_based_shaper_6/idle_slope] [get_bd_pins registers_0/cbs_6_idle_slope]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins credit_based_shaper_6/min_credit] [get_bd_pins registers_0/cbs_6_min_credit]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins credit_based_shaper_6/max_credit] [get_bd_pins registers_0/cbs_6_max_credit]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins credit_based_shaper_7/send_slope] [get_bd_pins registers_0/cbs_7_send_slope]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins credit_based_shaper_7/idle_slope] [get_bd_pins registers_0/cbs_7_idle_slope]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins credit_based_shaper_7/min_credit] [get_bd_pins registers_0/cbs_7_min_credit]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins credit_based_shaper_7/max_credit] [get_bd_pins registers_0/cbs_7_max_credit]
  connect_bd_net -net drop_enable_1 [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable] [get_bd_pins register_slice_0/data_out]
  connect_bd_net -net drop_enable_2 [get_bd_pins drop_enable] [get_bd_pins register_slice_0/data_in]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins register_slice_0/clk] [get_bd_pins registers_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_cbs_1
proc create_hier_cell_hier_cbs_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_cbs_1() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_7

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

  # Create instance: arbiter_0
  create_hier_cell_arbiter_0_1 $hier_obj arbiter_0

  # Create instance: credit_based_shaper_6
  create_hier_cell_credit_based_shaper_6_1 $hier_obj credit_based_shaper_6

  # Create instance: credit_based_shaper_7
  create_hier_cell_credit_based_shaper_7_1 $hier_obj credit_based_shaper_7

  # Create instance: packet_based_fifo_0
  create_hier_cell_packet_based_fifo_0_1 $hier_obj packet_based_fifo_0

  # Create instance: packet_based_fifo_1
  create_hier_cell_packet_based_fifo_1_1 $hier_obj packet_based_fifo_1

  # Create instance: packet_based_fifo_2
  create_hier_cell_packet_based_fifo_2_1 $hier_obj packet_based_fifo_2

  # Create instance: packet_based_fifo_3
  create_hier_cell_packet_based_fifo_3_1 $hier_obj packet_based_fifo_3

  # Create instance: packet_based_fifo_4
  create_hier_cell_packet_based_fifo_4_1 $hier_obj packet_based_fifo_4

  # Create instance: packet_based_fifo_5
  create_hier_cell_packet_based_fifo_5_1 $hier_obj packet_based_fifo_5

  # Create instance: packet_based_fifo_6
  create_hier_cell_packet_based_fifo_6_1 $hier_obj packet_based_fifo_6

  # Create instance: packet_based_fifo_7
  create_hier_cell_packet_based_fifo_7_1 $hier_obj packet_based_fifo_7

  # Create instance: register_slice_0, and set properties
  set register_slice_0 [ create_bd_cell -type ip -vlnv user.org:user:register_slice:1.0 register_slice_0 ]

  # Create instance: registers_0
  create_hier_cell_registers_0_1 $hier_obj registers_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_1_1 [get_bd_intf_pins S_AXIS_1] [get_bd_intf_pins packet_based_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_2_1 [get_bd_intf_pins S_AXIS_2] [get_bd_intf_pins packet_based_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_3_1 [get_bd_intf_pins S_AXIS_3] [get_bd_intf_pins packet_based_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_4_1 [get_bd_intf_pins S_AXIS_4] [get_bd_intf_pins packet_based_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_5_1 [get_bd_intf_pins S_AXIS_5] [get_bd_intf_pins packet_based_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_6_1 [get_bd_intf_pins S_AXIS_6] [get_bd_intf_pins packet_based_fifo_6/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_7_1 [get_bd_intf_pins S_AXIS_7] [get_bd_intf_pins packet_based_fifo_7/S_AXIS]
  connect_bd_intf_net -intf_net arbiter_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins arbiter_0/M00_AXIS]
  connect_bd_intf_net -intf_net credit_based_shaper_6_m_axis [get_bd_intf_pins arbiter_0/S06_AXIS] [get_bd_intf_pins credit_based_shaper_6/m_axis]
  connect_bd_intf_net -intf_net credit_based_shaper_7_m_axis [get_bd_intf_pins arbiter_0/S07_AXIS] [get_bd_intf_pins credit_based_shaper_7/m_axis]
  connect_bd_intf_net -intf_net packet_based_fifo_0_M_AXIS [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_1_M_AXIS [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_2_M_AXIS [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_3_M_AXIS [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_4_M_AXIS [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_5_M_AXIS [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_6_M_AXIS [get_bd_intf_pins credit_based_shaper_6/s_axis] [get_bd_intf_pins packet_based_fifo_6/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_7_M_AXIS [get_bd_intf_pins credit_based_shaper_7/s_axis] [get_bd_intf_pins packet_based_fifo_7/M_AXIS]

  # Create port connections
  connect_bd_net -net arbiter_0_output_side_ready [get_bd_pins arbiter_0/output_side_ready] [get_bd_pins credit_based_shaper_6/transmission_gate_is_open] [get_bd_pins credit_based_shaper_7/transmission_gate_is_open]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins credit_based_shaper_6/send_slope] [get_bd_pins registers_0/cbs_6_send_slope]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins credit_based_shaper_6/idle_slope] [get_bd_pins registers_0/cbs_6_idle_slope]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins credit_based_shaper_6/min_credit] [get_bd_pins registers_0/cbs_6_min_credit]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins credit_based_shaper_6/max_credit] [get_bd_pins registers_0/cbs_6_max_credit]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins credit_based_shaper_7/send_slope] [get_bd_pins registers_0/cbs_7_send_slope]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins credit_based_shaper_7/idle_slope] [get_bd_pins registers_0/cbs_7_idle_slope]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins credit_based_shaper_7/min_credit] [get_bd_pins registers_0/cbs_7_min_credit]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins credit_based_shaper_7/max_credit] [get_bd_pins registers_0/cbs_7_max_credit]
  connect_bd_net -net drop_enable_1 [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable] [get_bd_pins register_slice_0/data_out]
  connect_bd_net -net drop_enable_2 [get_bd_pins drop_enable] [get_bd_pins register_slice_0/data_in]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins register_slice_0/clk] [get_bd_pins registers_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_cbs_0
proc create_hier_cell_hier_cbs_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_cbs_0() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_0

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_1

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_2

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_3

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_4

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_5

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_6

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_7

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn
  create_bd_pin -dir I drop_enable

  # Create instance: arbiter_0
  create_hier_cell_arbiter_0 $hier_obj arbiter_0

  # Create instance: credit_based_shaper_6
  create_hier_cell_credit_based_shaper_6 $hier_obj credit_based_shaper_6

  # Create instance: credit_based_shaper_7
  create_hier_cell_credit_based_shaper_7 $hier_obj credit_based_shaper_7

  # Create instance: packet_based_fifo_0
  create_hier_cell_packet_based_fifo_0 $hier_obj packet_based_fifo_0

  # Create instance: packet_based_fifo_1
  create_hier_cell_packet_based_fifo_1 $hier_obj packet_based_fifo_1

  # Create instance: packet_based_fifo_2
  create_hier_cell_packet_based_fifo_2 $hier_obj packet_based_fifo_2

  # Create instance: packet_based_fifo_3
  create_hier_cell_packet_based_fifo_3 $hier_obj packet_based_fifo_3

  # Create instance: packet_based_fifo_4
  create_hier_cell_packet_based_fifo_4 $hier_obj packet_based_fifo_4

  # Create instance: packet_based_fifo_5
  create_hier_cell_packet_based_fifo_5 $hier_obj packet_based_fifo_5

  # Create instance: packet_based_fifo_6
  create_hier_cell_packet_based_fifo_6 $hier_obj packet_based_fifo_6

  # Create instance: packet_based_fifo_7
  create_hier_cell_packet_based_fifo_7 $hier_obj packet_based_fifo_7

  # Create instance: register_slice_0, and set properties
  set register_slice_0 [ create_bd_cell -type ip -vlnv user.org:user:register_slice:1.0 register_slice_0 ]

  # Create instance: registers_0
  create_hier_cell_registers_0 $hier_obj registers_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_1_1 [get_bd_intf_pins S_AXIS_1] [get_bd_intf_pins packet_based_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_2_1 [get_bd_intf_pins S_AXIS_2] [get_bd_intf_pins packet_based_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_3_1 [get_bd_intf_pins S_AXIS_3] [get_bd_intf_pins packet_based_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_4_1 [get_bd_intf_pins S_AXIS_4] [get_bd_intf_pins packet_based_fifo_4/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_5_1 [get_bd_intf_pins S_AXIS_5] [get_bd_intf_pins packet_based_fifo_5/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_6_1 [get_bd_intf_pins S_AXIS_6] [get_bd_intf_pins packet_based_fifo_6/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_7_1 [get_bd_intf_pins S_AXIS_7] [get_bd_intf_pins packet_based_fifo_7/S_AXIS]
  connect_bd_intf_net -intf_net arbiter_0_M00_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins arbiter_0/M00_AXIS]
  connect_bd_intf_net -intf_net credit_based_shaper_6_m_axis [get_bd_intf_pins arbiter_0/S06_AXIS] [get_bd_intf_pins credit_based_shaper_6/m_axis]
  connect_bd_intf_net -intf_net credit_based_shaper_7_m_axis [get_bd_intf_pins arbiter_0/S07_AXIS] [get_bd_intf_pins credit_based_shaper_7/m_axis]
  connect_bd_intf_net -intf_net packet_based_fifo_0_M_AXIS [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_1_M_AXIS [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_2_M_AXIS [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_3_M_AXIS [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_4_M_AXIS [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_5_M_AXIS [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_6_M_AXIS [get_bd_intf_pins credit_based_shaper_6/s_axis] [get_bd_intf_pins packet_based_fifo_6/M_AXIS]
  connect_bd_intf_net -intf_net packet_based_fifo_7_M_AXIS [get_bd_intf_pins credit_based_shaper_7/s_axis] [get_bd_intf_pins packet_based_fifo_7/M_AXIS]

  # Create port connections
  connect_bd_net -net arbiter_0_output_side_ready [get_bd_pins arbiter_0/output_side_ready] [get_bd_pins credit_based_shaper_6/transmission_gate_is_open] [get_bd_pins credit_based_shaper_7/transmission_gate_is_open]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio2_io_o [get_bd_pins credit_based_shaper_6/send_slope] [get_bd_pins registers_0/cbs_6_send_slope]
  connect_bd_net -net axi_gpio_cbs_6_0_gpio_io_o [get_bd_pins credit_based_shaper_6/idle_slope] [get_bd_pins registers_0/cbs_6_idle_slope]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio2_io_o [get_bd_pins credit_based_shaper_6/min_credit] [get_bd_pins registers_0/cbs_6_min_credit]
  connect_bd_net -net axi_gpio_cbs_6_1_gpio_io_o [get_bd_pins credit_based_shaper_6/max_credit] [get_bd_pins registers_0/cbs_6_max_credit]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio2_io_o [get_bd_pins credit_based_shaper_7/send_slope] [get_bd_pins registers_0/cbs_7_send_slope]
  connect_bd_net -net axi_gpio_cbs_7_0_gpio_io_o [get_bd_pins credit_based_shaper_7/idle_slope] [get_bd_pins registers_0/cbs_7_idle_slope]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio2_io_o [get_bd_pins credit_based_shaper_7/min_credit] [get_bd_pins registers_0/cbs_7_min_credit]
  connect_bd_net -net axi_gpio_cbs_7_1_gpio_io_o [get_bd_pins credit_based_shaper_7/max_credit] [get_bd_pins registers_0/cbs_7_max_credit]
  connect_bd_net -net drop_enable_1 [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable] [get_bd_pins register_slice_0/data_out]
  connect_bd_net -net drop_enable_2 [get_bd_pins drop_enable] [get_bd_pins register_slice_0/data_in]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins register_slice_0/clk] [get_bd_pins registers_0/aclk]

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

<<<<<<< HEAD
=======
  # Create instance: axi_gpio_parameters_0, and set properties
  set axi_gpio_parameters_0 [ create_bd_cell -type ip -vlnv user.org:user:axi_gpio_parameters:1.0 axi_gpio_parameters_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_PROCESSINGDELAYMAX_OUT {0} \
   CONFIG.ENABLE_COMMITHASH_READ {1} \
 ] $axi_gpio_parameters_0

  # Create instance: axi_register_slice_0, and set properties
  set axi_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_register_slice:2.1 axi_register_slice_0 ]
  set_property -dict [ list \
   CONFIG.REG_AR {1} \
   CONFIG.REG_AW {1} \
   CONFIG.REG_B {1} \
   CONFIG.REG_R {1} \
   CONFIG.REG_W {1} \
 ] $axi_register_slice_0

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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

  # Create instance: hier_cbs_0
  create_hier_cell_hier_cbs_0 [current_bd_instance .] hier_cbs_0

  # Create instance: hier_cbs_1
  create_hier_cell_hier_cbs_1 [current_bd_instance .] hier_cbs_1

  # Create instance: hier_cbs_2
  create_hier_cell_hier_cbs_2 [current_bd_instance .] hier_cbs_2

  # Create instance: hier_cbs_3
  create_hier_cell_hier_cbs_3 [current_bd_instance .] hier_cbs_3

  # Create instance: hier_eth_switch_0
  create_hier_cell_hier_eth_switch_0 [current_bd_instance .] hier_eth_switch_0

  # Create instance: hier_eth_switch_1
  create_hier_cell_hier_eth_switch_1 [current_bd_instance .] hier_eth_switch_1

  # Create instance: hier_eth_switch_2
  create_hier_cell_hier_eth_switch_2 [current_bd_instance .] hier_eth_switch_2

  # Create instance: hier_eth_switch_3
  create_hier_cell_hier_eth_switch_3 [current_bd_instance .] hier_eth_switch_3

  # Create instance: hier_eth_switch_4
  create_hier_cell_hier_eth_switch_4 [current_bd_instance .] hier_eth_switch_4

  # Create instance: hier_eth_switch_5
  create_hier_cell_hier_eth_switch_5 [current_bd_instance .] hier_eth_switch_5

  # Create instance: hier_eth_switch_6
  create_hier_cell_hier_eth_switch_6 [current_bd_instance .] hier_eth_switch_6

  # Create instance: hier_eth_switch_7
  create_hier_cell_hier_eth_switch_7 [current_bd_instance .] hier_eth_switch_7

  # Create instance: hier_fdb
  create_hier_cell_hier_fdb [current_bd_instance .] hier_fdb

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

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
<<<<<<< HEAD
   CONFIG.NUM_MI {9} \
=======
   CONFIG.NUM_MI {10} \
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
   CONFIG.NUM_SI {1} \
 ] $smartconnect_0

  # Create instance: switcher_0
  create_hier_cell_switcher_0 [current_bd_instance .] switcher_0

  # Create instance: switcher_1
  create_hier_cell_switcher_1 [current_bd_instance .] switcher_1

  # Create instance: switcher_2
  create_hier_cell_switcher_2 [current_bd_instance .] switcher_2

  # Create instance: switcher_3
  create_hier_cell_switcher_3 [current_bd_instance .] switcher_3

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
<<<<<<< HEAD
=======
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_0/M_AXIS] [get_bd_intf_pins hier_mac_0/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_1_M_AXIS [get_bd_intf_pins axis_clock_converter_1/M_AXIS] [get_bd_intf_pins hier_mac_1/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_2_M_AXIS [get_bd_intf_pins axis_clock_converter_2/M_AXIS] [get_bd_intf_pins hier_mac_2/s_axis_tx]
  connect_bd_intf_net -intf_net axis_clock_converter_3_M_AXIS [get_bd_intf_pins axis_clock_converter_3/M_AXIS] [get_bd_intf_pins hier_mac_3/s_axis_tx]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_2_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_2/M_AXIS] [get_bd_intf_pins hier_fdb/s_axis2]
  connect_bd_intf_net -intf_net axis_data_fifo_swin_3_M_AXIS [get_bd_intf_pins axis_data_fifo_swin_3/M_AXIS] [get_bd_intf_pins hier_fdb/s_axis3]
  connect_bd_intf_net -intf_net eth_driver_0_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_0/S_AXIS] [get_bd_intf_pins hier_mac_0/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_1_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_1/S_AXIS] [get_bd_intf_pins hier_mac_1/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_2_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_2/S_AXIS] [get_bd_intf_pins hier_mac_2/tx_axis_mac]
  connect_bd_intf_net -intf_net eth_driver_3_tx_axis_mac [get_bd_intf_pins axis_data_fifo_swin_3/S_AXIS] [get_bd_intf_pins hier_mac_3/tx_axis_mac]
  connect_bd_intf_net -intf_net hier_cbs_0_M04_AXI [get_bd_intf_pins smartconnect_0/M05_AXI] [get_bd_intf_pins switcher_0/S_AXI]
  connect_bd_intf_net -intf_net hier_cbs_0_M05_AXI [get_bd_intf_pins smartconnect_0/M06_AXI] [get_bd_intf_pins switcher_1/S_AXI]
  connect_bd_intf_net -intf_net hier_cbs_0_M06_AXI [get_bd_intf_pins smartconnect_0/M07_AXI] [get_bd_intf_pins switcher_2/S_AXI]
  connect_bd_intf_net -intf_net hier_cbs_0_M07_AXI [get_bd_intf_pins smartconnect_0/M08_AXI] [get_bd_intf_pins switcher_3/S_AXI]
  connect_bd_intf_net -intf_net hier_cbs_0_m_axis [get_bd_intf_pins axis_clock_converter_0/S_AXIS] [get_bd_intf_pins hier_cbs_0/m_axis]
  connect_bd_intf_net -intf_net hier_cbs_1_m_axis [get_bd_intf_pins axis_clock_converter_1/S_AXIS] [get_bd_intf_pins hier_cbs_1/m_axis]
  connect_bd_intf_net -intf_net hier_cbs_2_m_axis [get_bd_intf_pins axis_clock_converter_2/S_AXIS] [get_bd_intf_pins hier_cbs_2/m_axis]
  connect_bd_intf_net -intf_net hier_cbs_3_m_axis [get_bd_intf_pins axis_clock_converter_3/S_AXIS] [get_bd_intf_pins hier_cbs_3/m_axis]
  connect_bd_intf_net -intf_net hier_eth_switch_0_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_0] [get_bd_intf_pins hier_eth_switch_0/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_0_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_0] [get_bd_intf_pins hier_eth_switch_0/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_0_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_0] [get_bd_intf_pins hier_eth_switch_0/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_0_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_0] [get_bd_intf_pins hier_eth_switch_0/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_1_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_1] [get_bd_intf_pins hier_eth_switch_1/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_1_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_1] [get_bd_intf_pins hier_eth_switch_1/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_1_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_1] [get_bd_intf_pins hier_eth_switch_1/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_1_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_1] [get_bd_intf_pins hier_eth_switch_1/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_2_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_2] [get_bd_intf_pins hier_eth_switch_2/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_2_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_2] [get_bd_intf_pins hier_eth_switch_2/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_2_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_2] [get_bd_intf_pins hier_eth_switch_2/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_2_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_2] [get_bd_intf_pins hier_eth_switch_2/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_3_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_3] [get_bd_intf_pins hier_eth_switch_3/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_3_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_3] [get_bd_intf_pins hier_eth_switch_3/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_3_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_3] [get_bd_intf_pins hier_eth_switch_3/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_3_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_3] [get_bd_intf_pins hier_eth_switch_3/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_4_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_4] [get_bd_intf_pins hier_eth_switch_4/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_4_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_4] [get_bd_intf_pins hier_eth_switch_4/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_4_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_4] [get_bd_intf_pins hier_eth_switch_4/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_4_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_4] [get_bd_intf_pins hier_eth_switch_4/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_5_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_5] [get_bd_intf_pins hier_eth_switch_5/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_5_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_5] [get_bd_intf_pins hier_eth_switch_5/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_5_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_5] [get_bd_intf_pins hier_eth_switch_5/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_5_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_5] [get_bd_intf_pins hier_eth_switch_5/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_6_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_6] [get_bd_intf_pins hier_eth_switch_6/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_6_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_6] [get_bd_intf_pins hier_eth_switch_6/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_6_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_6] [get_bd_intf_pins hier_eth_switch_6/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_6_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_6] [get_bd_intf_pins hier_eth_switch_6/M03_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_7_M00_AXIS [get_bd_intf_pins hier_cbs_0/S_AXIS_7] [get_bd_intf_pins hier_eth_switch_7/M00_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_7_M01_AXIS [get_bd_intf_pins hier_cbs_1/S_AXIS_7] [get_bd_intf_pins hier_eth_switch_7/M01_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_7_M02_AXIS [get_bd_intf_pins hier_cbs_2/S_AXIS_7] [get_bd_intf_pins hier_eth_switch_7/M02_AXIS]
  connect_bd_intf_net -intf_net hier_eth_switch_7_M03_AXIS [get_bd_intf_pins hier_cbs_3/S_AXIS_7] [get_bd_intf_pins hier_eth_switch_7/M03_AXIS]
  connect_bd_intf_net -intf_net hier_fdb_M00_AXIS [get_bd_intf_pins hier_fdb/M00_AXIS] [get_bd_intf_pins switcher_0/s_axis]
  connect_bd_intf_net -intf_net hier_fdb_M01_AXIS [get_bd_intf_pins hier_fdb/M01_AXIS] [get_bd_intf_pins switcher_1/s_axis]
  connect_bd_intf_net -intf_net hier_fdb_M02_AXIS [get_bd_intf_pins hier_fdb/M02_AXIS] [get_bd_intf_pins switcher_2/s_axis]
  connect_bd_intf_net -intf_net hier_fdb_M03_AXIS [get_bd_intf_pins hier_fdb/M03_AXIS] [get_bd_intf_pins switcher_3/s_axis]
<<<<<<< HEAD
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins jtag_axi_0/M_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
=======
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins axi_register_slice_0/S_AXI] [get_bd_intf_pins jtag_axi_0/M_AXI]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_intf_net -intf_net ref_clk_1 [get_bd_intf_ports ref_clk] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins axis_data_fifo_swin_0/M_AXIS] [get_bd_intf_pins hier_fdb/s_axis0]
  connect_bd_intf_net -intf_net s_axis1_1 [get_bd_intf_pins axis_data_fifo_swin_1/M_AXIS] [get_bd_intf_pins hier_fdb/s_axis1]
  connect_bd_intf_net -intf_net s_axis1_2 [get_bd_intf_pins hier_eth_switch_0/s_axis1] [get_bd_intf_pins switcher_1/M00_AXIS]
  connect_bd_intf_net -intf_net s_axis2_1 [get_bd_intf_pins hier_eth_switch_0/s_axis2] [get_bd_intf_pins switcher_2/M00_AXIS]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins hier_cbs_0/S_AXI] [get_bd_intf_pins smartconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins hier_cbs_1/S_AXI] [get_bd_intf_pins smartconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins hier_cbs_2/S_AXI] [get_bd_intf_pins smartconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins hier_cbs_3/S_AXI] [get_bd_intf_pins smartconnect_0/M03_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins hier_flow_control/S_AXI] [get_bd_intf_pins smartconnect_0/M04_AXI]
<<<<<<< HEAD
=======
  connect_bd_intf_net -intf_net smartconnect_0_M09_AXI [get_bd_intf_pins axi_gpio_parameters_0/S_AXI] [get_bd_intf_pins smartconnect_0/M09_AXI]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_intf_net -intf_net switcher_0_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s_axis0] [get_bd_intf_pins switcher_0/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s_axis0] [get_bd_intf_pins switcher_0/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s_axis0] [get_bd_intf_pins switcher_0/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s_axis0] [get_bd_intf_pins switcher_0/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s_axis0] [get_bd_intf_pins switcher_0/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s_axis0] [get_bd_intf_pins switcher_0/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s_axis0] [get_bd_intf_pins switcher_0/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s_axis0] [get_bd_intf_pins switcher_0/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s_axis1] [get_bd_intf_pins switcher_1/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s_axis1] [get_bd_intf_pins switcher_1/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s_axis1] [get_bd_intf_pins switcher_1/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s_axis1] [get_bd_intf_pins switcher_1/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s_axis1] [get_bd_intf_pins switcher_1/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s_axis1] [get_bd_intf_pins switcher_1/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s_axis1] [get_bd_intf_pins switcher_1/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s_axis2] [get_bd_intf_pins switcher_2/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s_axis2] [get_bd_intf_pins switcher_2/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s_axis2] [get_bd_intf_pins switcher_2/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s_axis2] [get_bd_intf_pins switcher_2/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s_axis2] [get_bd_intf_pins switcher_2/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s_axis2] [get_bd_intf_pins switcher_2/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s_axis2] [get_bd_intf_pins switcher_2/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s_axis3] [get_bd_intf_pins switcher_3/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s_axis3] [get_bd_intf_pins switcher_3/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s_axis3] [get_bd_intf_pins switcher_3/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s_axis3] [get_bd_intf_pins switcher_3/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s_axis3] [get_bd_intf_pins switcher_3/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s_axis3] [get_bd_intf_pins switcher_3/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s_axis3] [get_bd_intf_pins switcher_3/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s_axis3] [get_bd_intf_pins switcher_3/M07_AXIS]
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
  connect_bd_net -net drop_enable_1 [get_bd_pins hier_cbs_0/drop_enable] [get_bd_pins hier_cbs_1/drop_enable] [get_bd_pins hier_cbs_2/drop_enable] [get_bd_pins hier_cbs_3/drop_enable] [get_bd_pins hier_flow_control/drop_enable]
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
  connect_bd_net -net hier_flow_control_pause_req_2 [get_bd_pins hier_flow_control/pause_req_0] [get_bd_pins hier_mac_0/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_3 [get_bd_pins hier_flow_control/pause_req_1] [get_bd_pins hier_mac_1/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_4 [get_bd_pins hier_flow_control/pause_req_2] [get_bd_pins hier_mac_2/pause_req_s]
  connect_bd_net -net hier_flow_control_pause_req_5 [get_bd_pins hier_flow_control/pause_req_3] [get_bd_pins hier_mac_3/pause_req_s]
  connect_bd_net -net mac_speed_1 [get_bd_ports mac_speed] [get_bd_pins hier_mac_0/mac_speed] [get_bd_pins hier_mac_1/mac_speed] [get_bd_pins hier_mac_2/mac_speed] [get_bd_pins hier_mac_3/mac_speed]
<<<<<<< HEAD
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins axis_data_fifo_swin_0/s_axis_aresetn] [get_bd_pins hier_cbs_0/aresetn] [get_bd_pins hier_cbs_1/aresetn] [get_bd_pins hier_cbs_2/aresetn] [get_bd_pins hier_cbs_3/aresetn] [get_bd_pins hier_eth_switch_0/aresetn] [get_bd_pins hier_eth_switch_1/aresetn] [get_bd_pins hier_eth_switch_2/aresetn] [get_bd_pins hier_eth_switch_3/aresetn] [get_bd_pins hier_eth_switch_4/aresetn] [get_bd_pins hier_eth_switch_5/aresetn] [get_bd_pins hier_eth_switch_6/aresetn] [get_bd_pins hier_eth_switch_7/aresetn] [get_bd_pins hier_fdb/aresetn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins proc_sys_reset_sw/peripheral_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins switcher_0/aresetn] [get_bd_pins switcher_1/aresetn] [get_bd_pins switcher_2/aresetn] [get_bd_pins switcher_3/aresetn]
=======
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins axi_gpio_parameters_0/rstn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins axis_data_fifo_swin_0/s_axis_aresetn] [get_bd_pins hier_cbs_0/aresetn] [get_bd_pins hier_cbs_1/aresetn] [get_bd_pins hier_cbs_2/aresetn] [get_bd_pins hier_cbs_3/aresetn] [get_bd_pins hier_eth_switch_0/aresetn] [get_bd_pins hier_eth_switch_1/aresetn] [get_bd_pins hier_eth_switch_2/aresetn] [get_bd_pins hier_eth_switch_3/aresetn] [get_bd_pins hier_eth_switch_4/aresetn] [get_bd_pins hier_eth_switch_5/aresetn] [get_bd_pins hier_eth_switch_6/aresetn] [get_bd_pins hier_eth_switch_7/aresetn] [get_bd_pins hier_fdb/aresetn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins proc_sys_reset_sw/peripheral_aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins switcher_0/aresetn] [get_bd_pins switcher_1/aresetn] [get_bd_pins switcher_2/aresetn] [get_bd_pins switcher_3/aresetn]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net ref_clk_fsel_dout [get_bd_ports ref_clk_fsel] [get_bd_pins ref_clk_fsel/dout]
  connect_bd_net -net ref_clk_oe_dout [get_bd_ports ref_clk_oe] [get_bd_pins ref_clk_oe/dout]
  connect_bd_net -net reset_error_1 [get_bd_ports reset_error] [get_bd_pins hier_mac_0/reset_error] [get_bd_pins hier_mac_1/reset_error] [get_bd_pins hier_mac_2/reset_error] [get_bd_pins hier_mac_3/reset_error]
  connect_bd_net -net temac_0_gtx_clk90_out [get_bd_pins hier_mac_0/gtx_clk90_out] [get_bd_pins hier_mac_1/gtx_clk90] [get_bd_pins hier_mac_2/gtx_clk90] [get_bd_pins hier_mac_3/gtx_clk90]
  connect_bd_net -net temac_0_gtx_clk_out [get_bd_pins hier_mac_0/gtx_clk_out] [get_bd_pins hier_mac_1/gtx_clk] [get_bd_pins hier_mac_2/gtx_clk] [get_bd_pins hier_mac_3/gtx_clk]
<<<<<<< HEAD
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_clock_converter_2/s_axis_aclk] [get_bd_pins axis_clock_converter_3/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_1/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_2/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_3/m_axis_aclk] [get_bd_pins hier_cbs_0/aclk] [get_bd_pins hier_cbs_1/aclk] [get_bd_pins hier_cbs_2/aclk] [get_bd_pins hier_cbs_3/aclk] [get_bd_pins hier_eth_switch_0/aclk] [get_bd_pins hier_eth_switch_1/aclk] [get_bd_pins hier_eth_switch_2/aclk] [get_bd_pins hier_eth_switch_3/aclk] [get_bd_pins hier_eth_switch_4/aclk] [get_bd_pins hier_eth_switch_5/aclk] [get_bd_pins hier_eth_switch_6/aclk] [get_bd_pins hier_eth_switch_7/aclk] [get_bd_pins hier_fdb/aclk] [get_bd_pins hier_flow_control/fifo_wr_clk] [get_bd_pins hier_mac_0/tx_mac_aclk] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins proc_sys_reset_sw/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins switcher_0/aclk] [get_bd_pins switcher_1/aclk] [get_bd_pins switcher_2/aclk] [get_bd_pins switcher_3/aclk]
=======
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins axi_gpio_parameters_0/clk] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins axis_clock_converter_0/m_axis_aclk] [get_bd_pins axis_clock_converter_0/s_axis_aclk] [get_bd_pins axis_clock_converter_1/s_axis_aclk] [get_bd_pins axis_clock_converter_2/s_axis_aclk] [get_bd_pins axis_clock_converter_3/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_0/s_axis_aclk] [get_bd_pins axis_data_fifo_swin_1/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_2/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_3/m_axis_aclk] [get_bd_pins hier_cbs_0/aclk] [get_bd_pins hier_cbs_1/aclk] [get_bd_pins hier_cbs_2/aclk] [get_bd_pins hier_cbs_3/aclk] [get_bd_pins hier_eth_switch_0/aclk] [get_bd_pins hier_eth_switch_1/aclk] [get_bd_pins hier_eth_switch_2/aclk] [get_bd_pins hier_eth_switch_3/aclk] [get_bd_pins hier_eth_switch_4/aclk] [get_bd_pins hier_eth_switch_5/aclk] [get_bd_pins hier_eth_switch_6/aclk] [get_bd_pins hier_eth_switch_7/aclk] [get_bd_pins hier_fdb/aclk] [get_bd_pins hier_flow_control/fifo_wr_clk] [get_bd_pins hier_mac_0/tx_mac_aclk] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins proc_sys_reset_sw/slowest_sync_clk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins switcher_0/aclk] [get_bd_pins switcher_1/aclk] [get_bd_pins switcher_2/aclk] [get_bd_pins switcher_3/aclk]
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  connect_bd_net -net temac_0_tx_reset [get_bd_pins hier_mac_0/tx_reset] [get_bd_pins proc_sys_reset_sw/ext_reset_in] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net temac_1_tx_mac_aclk [get_bd_pins axis_clock_converter_1/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_1/s_axis_aclk] [get_bd_pins hier_mac_1/tx_mac_aclk]
  connect_bd_net -net temac_1_tx_reset [get_bd_pins hier_mac_1/tx_reset] [get_bd_pins util_vector_logic_1/Op1]
  connect_bd_net -net temac_2_tx_mac_aclk [get_bd_pins axis_clock_converter_2/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_2/s_axis_aclk] [get_bd_pins hier_mac_2/tx_mac_aclk]
  connect_bd_net -net temac_2_tx_reset [get_bd_pins hier_mac_2/tx_reset] [get_bd_pins util_vector_logic_2/Op1]
  connect_bd_net -net temac_3_tx_mac_aclk [get_bd_pins axis_clock_converter_3/m_axis_aclk] [get_bd_pins axis_data_fifo_swin_3/s_axis_aclk] [get_bd_pins hier_mac_3/tx_axis_mac_aclk]
  connect_bd_net -net temac_3_tx_reset [get_bd_pins hier_mac_3/tx_reset] [get_bd_pins util_vector_logic_3/Op1]
  connect_bd_net -net update_speed_1 [get_bd_ports update_speed] [get_bd_pins hier_mac_0/update_speed] [get_bd_pins hier_mac_1/update_speed] [get_bd_pins hier_mac_2/update_speed] [get_bd_pins hier_mac_3/update_speed]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins axis_clock_converter_0/m_axis_aresetn] [get_bd_pins axis_clock_converter_0/s_axis_aresetn] [get_bd_pins axis_clock_converter_1/s_axis_aresetn] [get_bd_pins axis_clock_converter_2/s_axis_aresetn] [get_bd_pins axis_clock_converter_3/s_axis_aresetn] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net util_vector_logic_1_Res [get_bd_pins axis_clock_converter_1/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_1/s_axis_aresetn] [get_bd_pins util_vector_logic_1/Res]
  connect_bd_net -net util_vector_logic_2_Res [get_bd_pins axis_clock_converter_2/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_2/s_axis_aresetn] [get_bd_pins util_vector_logic_2/Res]
  connect_bd_net -net util_vector_logic_3_Res [get_bd_pins axis_clock_converter_3/m_axis_aresetn] [get_bd_pins axis_data_fifo_swin_3/s_axis_aresetn] [get_bd_pins util_vector_logic_3/Res]

  # Create address segments
  assign_bd_address -offset 0x50000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs switcher_0/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50010000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs switcher_1/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50020000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs switcher_2/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x50030000 -range 0x00001000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs switcher_3/add_tdest_from_vlan_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x40000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_0/registers_0/axi_gpio_cbs_6_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40040000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_1/registers_0/axi_gpio_cbs_6_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40080000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_2/registers_0/axi_gpio_cbs_6_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x400C0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_3/registers_0/axi_gpio_cbs_6_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40010000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_0/registers_0/axi_gpio_cbs_6_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x40050000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_1/registers_0/axi_gpio_cbs_6_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x40090000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_2/registers_0/axi_gpio_cbs_6_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x400D0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_3/registers_0/axi_gpio_cbs_6_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x40020000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_0/registers_0/axi_gpio_cbs_7_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40060000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_1/registers_0/axi_gpio_cbs_7_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x400A0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_2/registers_0/axi_gpio_cbs_7_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x400E0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_3/registers_0/axi_gpio_cbs_7_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40030000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_0/registers_0/axi_gpio_cbs_7_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x40070000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_1/registers_0/axi_gpio_cbs_7_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x400B0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_2/registers_0/axi_gpio_cbs_7_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x400F0000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_cbs_3/registers_0/axi_gpio_cbs_7_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x40100000 -range 0x00010000 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs hier_flow_control/axi_gpio_flow_control/S_AXI/Reg] -force
<<<<<<< HEAD
=======
  assign_bd_address -offset 0x00100000 -range 0x00000080 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs axi_gpio_parameters_0/S_AXI/reg0] -force
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
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


