
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
# mactable_mod

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcu26-vsva1365-2LV-e
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
user.org:user:axi_gpio_parameters:1.0\
xilinx.com:ip:axi_register_slice:2.1\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:clk_wiz:6.0\
xilinx.com:ip:jtag_axi:1.2\
xilinx.com:ip:smartconnect:1.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xxv_ethernet:4.1\
xilinx.com:ip:vio:3.0\
xilinx.com:ip:axis_register_slice:1.1\
xilinx.com:ip:axis_switch:1.1\
xilinx.com:ip:axis_clock_converter:1.1\
xilinx.com:ip:axis_data_fifo:2.0\
user.org:user:ethernet_frame_dropper:1.0\
fixstars:fixstars:xg_mac:1.0\
user.org:user:add_tdest_from_vlan_tag:1.0\
user.org:user:dest_to_user:1.0\
user.org:user:user_to_dest:1.0\
user.org:user:ethernet_frame_arbiter:1.0\
user.org:user:extract_output_side_ready:1.0\
user.org:user:credit_based_shaper:1.0\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:axis_dwidth_converter:1.1\
user.org:user:channel_in_opt:1.0\
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
mactable_mod\
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


# Hierarchical cell: hier_channel_in_opt_3
proc create_hier_cell_hier_channel_in_opt_3 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_channel_in_opt_3() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_status

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_table_request

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_table_response


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
 ] $axis_data_fifo_0

  # Create instance: axis_dwidth_converter_128to64, and set properties
  set axis_dwidth_converter_128to64 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_128to64 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_128to64

  # Create instance: axis_dwidth_converter_64to128, and set properties
  set axis_dwidth_converter_64to128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_64to128 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {16} \
 ] $axis_dwidth_converter_64to128

  # Create instance: channel_in_opt_3, and set properties
  set channel_in_opt_3 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_3 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {128} \
   CONFIG.C_AXIS_TKEEP_WIDTH {16} \
   CONFIG.PORT_ADDR {3} \
   CONFIG.PORT_WIDTH {2} \
 ] $channel_in_opt_3

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_table_response] [get_bd_intf_pins channel_in_opt_3/s_axis_table_response]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_status] [get_bd_intf_pins channel_in_opt_3/m_axis_status]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_table_request] [get_bd_intf_pins channel_in_opt_3/m_axis_table_request]
  connect_bd_intf_net -intf_net axis_dwidth_converter_128to64_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_dwidth_converter_128to64/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_64to128_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_64to128/M_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis [get_bd_intf_pins axis_dwidth_converter_128to64/S_AXIS] [get_bd_intf_pins channel_in_opt_3/m_axis]
  connect_bd_intf_net -intf_net s_axis0 [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins channel_in_opt_3/s_axis]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins axis_dwidth_converter_64to128/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_128to64/aresetn] [get_bd_pins axis_dwidth_converter_64to128/aresetn] [get_bd_pins channel_in_opt_3/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_dwidth_converter_128to64/aclk] [get_bd_pins axis_dwidth_converter_64to128/aclk] [get_bd_pins channel_in_opt_3/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_channel_in_opt_2
proc create_hier_cell_hier_channel_in_opt_2 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_channel_in_opt_2() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_status

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_table_request

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_table_response


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
 ] $axis_data_fifo_0

  # Create instance: axis_dwidth_converter_128to64, and set properties
  set axis_dwidth_converter_128to64 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_128to64 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_128to64

  # Create instance: axis_dwidth_converter_64to128, and set properties
  set axis_dwidth_converter_64to128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_64to128 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {16} \
 ] $axis_dwidth_converter_64to128

  # Create instance: channel_in_opt_2, and set properties
  set channel_in_opt_2 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_2 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {128} \
   CONFIG.C_AXIS_TKEEP_WIDTH {16} \
   CONFIG.PORT_ADDR {2} \
   CONFIG.PORT_WIDTH {2} \
 ] $channel_in_opt_2

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_table_response] [get_bd_intf_pins channel_in_opt_2/s_axis_table_response]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_status] [get_bd_intf_pins channel_in_opt_2/m_axis_status]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_table_request] [get_bd_intf_pins channel_in_opt_2/m_axis_table_request]
  connect_bd_intf_net -intf_net axis_dwidth_converter_128to64_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_dwidth_converter_128to64/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_64to128_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_64to128/M_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis [get_bd_intf_pins axis_dwidth_converter_128to64/S_AXIS] [get_bd_intf_pins channel_in_opt_2/m_axis]
  connect_bd_intf_net -intf_net s_axis0 [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins channel_in_opt_2/s_axis]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins axis_dwidth_converter_64to128/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_128to64/aresetn] [get_bd_pins axis_dwidth_converter_64to128/aresetn] [get_bd_pins channel_in_opt_2/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_dwidth_converter_128to64/aclk] [get_bd_pins axis_dwidth_converter_64to128/aclk] [get_bd_pins channel_in_opt_2/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_channel_in_opt_1
proc create_hier_cell_hier_channel_in_opt_1 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_channel_in_opt_1() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_status

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_table_request

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_table_response


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
 ] $axis_data_fifo_0

  # Create instance: axis_dwidth_converter_128to64, and set properties
  set axis_dwidth_converter_128to64 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_128to64 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_128to64

  # Create instance: axis_dwidth_converter_64to128, and set properties
  set axis_dwidth_converter_64to128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_64to128 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {16} \
 ] $axis_dwidth_converter_64to128

  # Create instance: channel_in_opt_1, and set properties
  set channel_in_opt_1 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_1 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {128} \
   CONFIG.C_AXIS_TKEEP_WIDTH {16} \
   CONFIG.PORT_ADDR {1} \
   CONFIG.PORT_WIDTH {2} \
 ] $channel_in_opt_1

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_table_response] [get_bd_intf_pins channel_in_opt_1/s_axis_table_response]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_status] [get_bd_intf_pins channel_in_opt_1/m_axis_status]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_table_request] [get_bd_intf_pins channel_in_opt_1/m_axis_table_request]
  connect_bd_intf_net -intf_net axis_dwidth_converter_128to64_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_dwidth_converter_128to64/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_64to128_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_64to128/M_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis [get_bd_intf_pins axis_dwidth_converter_128to64/S_AXIS] [get_bd_intf_pins channel_in_opt_1/m_axis]
  connect_bd_intf_net -intf_net s_axis0 [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins channel_in_opt_1/s_axis]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins axis_dwidth_converter_64to128/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_128to64/aresetn] [get_bd_pins axis_dwidth_converter_64to128/aresetn] [get_bd_pins channel_in_opt_1/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_dwidth_converter_128to64/aclk] [get_bd_pins axis_dwidth_converter_64to128/aclk] [get_bd_pins channel_in_opt_1/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: hier_channel_in_opt_0
proc create_hier_cell_hier_channel_in_opt_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_hier_channel_in_opt_0() - Empty argument(s)!"}
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

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_status

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_table_request

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_table_response


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
 ] $axis_data_fifo_0

  # Create instance: axis_dwidth_converter_128to64, and set properties
  set axis_dwidth_converter_128to64 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_128to64 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {8} \
 ] $axis_dwidth_converter_128to64

  # Create instance: axis_dwidth_converter_64to128, and set properties
  set axis_dwidth_converter_64to128 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_dwidth_converter:1.1 axis_dwidth_converter_64to128 ]
  set_property -dict [ list \
   CONFIG.M_TDATA_NUM_BYTES {16} \
 ] $axis_dwidth_converter_64to128

  # Create instance: channel_in_opt_0, and set properties
  set channel_in_opt_0 [ create_bd_cell -type ip -vlnv user.org:user:channel_in_opt:1.0 channel_in_opt_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {128} \
   CONFIG.C_AXIS_TKEEP_WIDTH {16} \
   CONFIG.PORT_WIDTH {2} \
 ] $channel_in_opt_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis_table_response] [get_bd_intf_pins channel_in_opt_0/s_axis_table_response]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins m_axis_status] [get_bd_intf_pins channel_in_opt_0/m_axis_status]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins m_axis_table_request] [get_bd_intf_pins channel_in_opt_0/m_axis_table_request]
  connect_bd_intf_net -intf_net axis_dwidth_converter_128to64_0_M_AXIS [get_bd_intf_pins m_axis] [get_bd_intf_pins axis_dwidth_converter_128to64/M_AXIS]
  connect_bd_intf_net -intf_net axis_dwidth_converter_64to128_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins axis_dwidth_converter_64to128/M_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis [get_bd_intf_pins axis_dwidth_converter_128to64/S_AXIS] [get_bd_intf_pins channel_in_opt_0/m_axis]
  connect_bd_intf_net -intf_net s_axis0 [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins channel_in_opt_0/s_axis]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis] [get_bd_intf_pins axis_dwidth_converter_64to128/S_AXIS]

  # Create port connections
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_dwidth_converter_128to64/aresetn] [get_bd_pins axis_dwidth_converter_64to128/aresetn] [get_bd_pins channel_in_opt_0/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_dwidth_converter_128to64/aclk] [get_bd_pins axis_dwidth_converter_64to128/aclk] [get_bd_pins channel_in_opt_0/aclk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.FRAME_GAP {3} \
 ] $ethernet_frame_arbit_0

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $extract_output_side_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.FRAME_GAP {3} \
 ] $ethernet_frame_arbit_0

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $extract_output_side_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.FRAME_GAP {3} \
 ] $ethernet_frame_arbit_0

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $extract_output_side_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  create_bd_pin -dir O -from 31 -to 0 axis_wr_data_count
  create_bd_pin -dir I drop_enable

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {2048} \
   CONFIG.FIFO_MEMORY_TYPE {ultra} \
   CONFIG.FIFO_MODE {2} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.PROG_FULL_THRESH {1857} \
 ] $axis_data_fifo_0

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/s_axis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins M_AXIS] [get_bd_intf_pins axis_data_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_0/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_axis_wr_data_count [get_bd_pins axis_wr_data_count] [get_bd_pins axis_data_fifo_0/axis_wr_data_count]
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_0/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk]
  connect_bd_net -net drop_enable_1 [get_bd_pins drop_enable] [get_bd_pins ethernet_frame_dropp_0/drop_enable]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $credit_based_shaper_0

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

  # Create instance: axis_register_slice_0, and set properties
  set axis_register_slice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_0 ]

  # Create instance: ethernet_frame_arbit_0, and set properties
  set ethernet_frame_arbit_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_arbiter:1.0 ethernet_frame_arbit_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.FRAME_GAP {3} \
 ] $ethernet_frame_arbit_0

  # Create instance: extract_output_side_0, and set properties
  set extract_output_side_0 [ create_bd_cell -type ip -vlnv user.org:user:extract_output_side_ready:1.0 extract_output_side_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $extract_output_side_0

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins S00_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_0]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins S01_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_1]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins S02_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_2]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins S03_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_3]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins S04_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_4]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins S05_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_5]
  connect_bd_intf_net -intf_net S06_AXIS_1 [get_bd_intf_pins S06_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_6]
  connect_bd_intf_net -intf_net S07_AXIS_1 [get_bd_intf_pins S07_AXIS] [get_bd_intf_pins ethernet_frame_arbit_0/s_axis_7]
  connect_bd_intf_net -intf_net axis_register_slice_0_M_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_register_slice_0/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_arbit_0_m_axis [get_bd_intf_pins ethernet_frame_arbit_0/m_axis] [get_bd_intf_pins extract_output_side_0/s_axis]
  connect_bd_intf_net -intf_net extract_output_side_0_m_axis [get_bd_intf_pins axis_register_slice_0/S_AXIS] [get_bd_intf_pins extract_output_side_0/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins axis_register_slice_0/aclk] [get_bd_pins ethernet_frame_arbit_0/clk] [get_bd_pins extract_output_side_0/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins axis_register_slice_0/aresetn] [get_bd_pins ethernet_frame_arbit_0/rstn] [get_bd_pins extract_output_side_0/rstn]
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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $add_tdest_from_vlan_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $dest_to_user_0

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_0

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_1

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_2

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_3

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_4

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_5

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_6

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_7

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
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
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $add_tdest_from_vlan_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $dest_to_user_0

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_0

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_1

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_2

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_3

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_4

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_5

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_6

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_7

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
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
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $add_tdest_from_vlan_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $dest_to_user_0

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_0

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_1

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_2

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_3

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_4

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_5

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_6

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_7

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
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
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $add_tdest_from_vlan_0

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
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $dest_to_user_0

  # Create instance: user_to_dest_0, and set properties
  set user_to_dest_0 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_0

  # Create instance: user_to_dest_1, and set properties
  set user_to_dest_1 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_1 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_1

  # Create instance: user_to_dest_2, and set properties
  set user_to_dest_2 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_2 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_2

  # Create instance: user_to_dest_3, and set properties
  set user_to_dest_3 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_3 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_3

  # Create instance: user_to_dest_4, and set properties
  set user_to_dest_4 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_4 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_4

  # Create instance: user_to_dest_5, and set properties
  set user_to_dest_5 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_5 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_5

  # Create instance: user_to_dest_6, and set properties
  set user_to_dest_6 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_6 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_6

  # Create instance: user_to_dest_7, and set properties
  set user_to_dest_7 [ create_bd_cell -type ip -vlnv user.org:user:user_to_dest:1.0 user_to_dest_7 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
   CONFIG.C_AXIS_TUSER_WIDTH {3} \
 ] $user_to_dest_7

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins s_axis] [get_bd_intf_pins dest_to_user_0/s_axis]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S_AXI] [get_bd_intf_pins add_tdest_from_vlan_0/S_AXI]
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
  connect_bd_intf_net -intf_net user_to_dest_0_m_axis [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins user_to_dest_0/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_1_m_axis [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins user_to_dest_1/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_2_m_axis [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins user_to_dest_2/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_3_m_axis [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins user_to_dest_3/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_4_m_axis [get_bd_intf_pins M04_AXIS] [get_bd_intf_pins user_to_dest_4/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_5_m_axis [get_bd_intf_pins M05_AXIS] [get_bd_intf_pins user_to_dest_5/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_6_m_axis [get_bd_intf_pins M06_AXIS] [get_bd_intf_pins user_to_dest_6/m_axis]
  connect_bd_intf_net -intf_net user_to_dest_7_m_axis [get_bd_intf_pins M07_AXIS] [get_bd_intf_pins user_to_dest_7/m_axis]

  # Create port connections
  connect_bd_net -net aclk_1 [get_bd_pins aclk] [get_bd_pins add_tdest_from_vlan_0/clk] [get_bd_pins axis_switch_0/aclk] [get_bd_pins dest_to_user_0/clk] [get_bd_pins user_to_dest_0/clk] [get_bd_pins user_to_dest_1/clk] [get_bd_pins user_to_dest_2/clk] [get_bd_pins user_to_dest_3/clk] [get_bd_pins user_to_dest_4/clk] [get_bd_pins user_to_dest_5/clk] [get_bd_pins user_to_dest_6/clk] [get_bd_pins user_to_dest_7/clk]
  connect_bd_net -net aresetn_1 [get_bd_pins aresetn] [get_bd_pins add_tdest_from_vlan_0/rstn] [get_bd_pins axis_switch_0/aresetn] [get_bd_pins dest_to_user_0/rstn] [get_bd_pins user_to_dest_0/rstn] [get_bd_pins user_to_dest_1/rstn] [get_bd_pins user_to_dest_2/rstn] [get_bd_pins user_to_dest_3/rstn] [get_bd_pins user_to_dest_4/rstn] [get_bd_pins user_to_dest_5/rstn] [get_bd_pins user_to_dest_6/rstn] [get_bd_pins user_to_dest_7/rstn]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 rx_maxis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 tx_saxis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type clk axis_common_aclk
  create_bd_pin -dir I -type rst axis_common_aresetn
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst rx_aresetn
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst tx_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axis_clock_converter_tx, and set properties
  set axis_clock_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_tx ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {512} \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {322} \
 ] $axis_data_fifo_rx

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create instance: rst_xxv_ethernet_0_156M_rx, and set properties
  set rst_xxv_ethernet_0_156M_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_rx ]

  # Create instance: rst_xxv_ethernet_0_156M_tx, and set properties
  set rst_xxv_ethernet_0_156M_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_tx ]

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create instance: xg_mac_0, and set properties
  set xg_mac_0 [ create_bd_cell -type ip -vlnv fixstars:fixstars:xg_mac:1.0 xg_mac_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xg_mac_0/rx_xgmii]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_tx/M_AXIS] [get_bd_intf_pins xg_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]
  connect_bd_intf_net -intf_net tx_saxis_1 [get_bd_intf_pins tx_saxis] [get_bd_intf_pins axis_clock_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins xg_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net xg_mac_0_tx_xgmii [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xg_mac_0/tx_xgmii]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_rx/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net axis_data_fifo_rx_axis_wr_data_count [get_bd_pins axis_data_fifo_rx/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M_tx/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_reset] [get_bd_pins xg_mac_0/rx_reset]
  connect_bd_net -net rst_xxv_ethernet_0_156M_rx_peripheral_aresetn [get_bd_pins rx_aresetn] [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_aresetn [get_bd_pins tx_aresetn] [get_bd_pins axis_clock_converter_tx/m_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_reset] [get_bd_pins xg_mac_0/tx_reset]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins rst_xxv_ethernet_0_156M_rx/slowest_sync_clk] [get_bd_pins xg_mac_0/rx_clock]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_rx/ext_reset_in]
  connect_bd_net -net s_axis_aclk_1 [get_bd_pins axis_common_aclk] [get_bd_pins axis_clock_converter_tx/s_axis_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net s_axis_aresetn_1 [get_bd_pins axis_common_aresetn] [get_bd_pins axis_clock_converter_tx/s_axis_aresetn]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_clock_converter_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_tx/slowest_sync_clk] [get_bd_pins xg_mac_0/tx_clock]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_tx/ext_reset_in]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 rx_maxis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 tx_saxis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type clk axis_common_aclk
  create_bd_pin -dir I -type rst axis_common_aresetn
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst rx_aresetn
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst tx_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axis_clock_converter_tx, and set properties
  set axis_clock_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_tx ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {512} \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {322} \
 ] $axis_data_fifo_rx

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create instance: rst_xxv_ethernet_0_156M_rx, and set properties
  set rst_xxv_ethernet_0_156M_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_rx ]

  # Create instance: rst_xxv_ethernet_0_156M_tx, and set properties
  set rst_xxv_ethernet_0_156M_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_tx ]

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create instance: xg_mac_0, and set properties
  set xg_mac_0 [ create_bd_cell -type ip -vlnv fixstars:fixstars:xg_mac:1.0 xg_mac_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xg_mac_0/rx_xgmii]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_tx/M_AXIS] [get_bd_intf_pins xg_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]
  connect_bd_intf_net -intf_net tx_saxis_1 [get_bd_intf_pins tx_saxis] [get_bd_intf_pins axis_clock_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins xg_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net xg_mac_0_tx_xgmii [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xg_mac_0/tx_xgmii]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_rx/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net axis_data_fifo_rx_axis_wr_data_count [get_bd_pins axis_data_fifo_rx/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M_tx/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_reset] [get_bd_pins xg_mac_0/rx_reset]
  connect_bd_net -net rst_xxv_ethernet_0_156M_rx_peripheral_aresetn [get_bd_pins rx_aresetn] [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_aresetn [get_bd_pins tx_aresetn] [get_bd_pins axis_clock_converter_tx/m_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_reset] [get_bd_pins xg_mac_0/tx_reset]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins rst_xxv_ethernet_0_156M_rx/slowest_sync_clk] [get_bd_pins xg_mac_0/rx_clock]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_rx/ext_reset_in]
  connect_bd_net -net s_axis_aclk_1 [get_bd_pins axis_common_aclk] [get_bd_pins axis_clock_converter_tx/s_axis_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net s_axis_aresetn_1 [get_bd_pins axis_common_aresetn] [get_bd_pins axis_clock_converter_tx/s_axis_aresetn]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_clock_converter_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_tx/slowest_sync_clk] [get_bd_pins xg_mac_0/tx_clock]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_tx/ext_reset_in]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 rx_maxis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 tx_saxis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type clk axis_common_aclk
  create_bd_pin -dir I -type rst axis_common_aresetn
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst rx_aresetn
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst tx_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axis_clock_converter_tx, and set properties
  set axis_clock_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_tx ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {512} \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {322} \
 ] $axis_data_fifo_rx

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create instance: rst_xxv_ethernet_0_156M_rx, and set properties
  set rst_xxv_ethernet_0_156M_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_rx ]

  # Create instance: rst_xxv_ethernet_0_156M_tx, and set properties
  set rst_xxv_ethernet_0_156M_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_tx ]

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create instance: xg_mac_0, and set properties
  set xg_mac_0 [ create_bd_cell -type ip -vlnv fixstars:fixstars:xg_mac:1.0 xg_mac_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xg_mac_0/rx_xgmii]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_tx/M_AXIS] [get_bd_intf_pins xg_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]
  connect_bd_intf_net -intf_net tx_saxis_1 [get_bd_intf_pins tx_saxis] [get_bd_intf_pins axis_clock_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins xg_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net xg_mac_0_tx_xgmii [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xg_mac_0/tx_xgmii]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_rx/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net axis_data_fifo_rx_axis_wr_data_count [get_bd_pins axis_data_fifo_rx/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M_tx/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_reset] [get_bd_pins xg_mac_0/rx_reset]
  connect_bd_net -net rst_xxv_ethernet_0_156M_rx_peripheral_aresetn [get_bd_pins rx_aresetn] [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_aresetn [get_bd_pins tx_aresetn] [get_bd_pins axis_clock_converter_tx/m_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_reset] [get_bd_pins xg_mac_0/tx_reset]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins rst_xxv_ethernet_0_156M_rx/slowest_sync_clk] [get_bd_pins xg_mac_0/rx_clock]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_rx/ext_reset_in]
  connect_bd_net -net s_axis_aclk_1 [get_bd_pins axis_common_aclk] [get_bd_pins axis_clock_converter_tx/s_axis_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net s_axis_aresetn_1 [get_bd_pins axis_common_aresetn] [get_bd_pins axis_clock_converter_tx/s_axis_aresetn]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_clock_converter_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_tx/slowest_sync_clk] [get_bd_pins xg_mac_0/tx_clock]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_tx/ext_reset_in]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]

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
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 rx_maxis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 rx_xgmii

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 tx_saxis

  create_bd_intf_pin -mode Master -vlnv xilinx.com:display_xxv_ethernet:user_int_ports:2.0 tx_xgmii


  # Create pins
  create_bd_pin -dir I -type clk axis_common_aclk
  create_bd_pin -dir I -type rst axis_common_aresetn
  create_bd_pin -dir I -type rst mb_debug_sys_rst
  create_bd_pin -dir O -from 0 -to 0 -type rst rx_aresetn
  create_bd_pin -dir I -type clk rx_clock
  create_bd_pin -dir I -type rst rx_reset
  create_bd_pin -dir O -from 0 -to 0 -type rst tx_aresetn
  create_bd_pin -dir I -type clk tx_clock
  create_bd_pin -dir I -type rst tx_reset

  # Create instance: axis_clock_converter_tx, and set properties
  set axis_clock_converter_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_clock_converter:1.1 axis_clock_converter_tx ]

  # Create instance: axis_data_fifo_rx, and set properties
  set axis_data_fifo_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:2.0 axis_data_fifo_rx ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {512} \
   CONFIG.FIFO_MEMORY_TYPE {auto} \
   CONFIG.FIFO_MODE {1} \
   CONFIG.HAS_PROG_FULL {1} \
   CONFIG.HAS_WR_DATA_COUNT {1} \
   CONFIG.IS_ACLK_ASYNC {1} \
   CONFIG.PROG_FULL_THRESH {322} \
 ] $axis_data_fifo_rx

  # Create instance: ethernet_frame_dropp_0, and set properties
  set ethernet_frame_dropp_0 [ create_bd_cell -type ip -vlnv user.org:user:ethernet_frame_dropper:1.0 ethernet_frame_dropp_0 ]
  set_property -dict [ list \
   CONFIG.C_AXIS_TDATA_WIDTH {64} \
   CONFIG.C_AXIS_TKEEP_WIDTH {8} \
 ] $ethernet_frame_dropp_0

  # Create instance: rst_xxv_ethernet_0_156M_rx, and set properties
  set rst_xxv_ethernet_0_156M_rx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_rx ]

  # Create instance: rst_xxv_ethernet_0_156M_tx, and set properties
  set rst_xxv_ethernet_0_156M_tx [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_xxv_ethernet_0_156M_tx ]

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create instance: xg_mac_0, and set properties
  set xg_mac_0 [ create_bd_cell -type ip -vlnv fixstars:fixstars:xg_mac:1.0 xg_mac_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $xlconstant_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins rx_xgmii] [get_bd_intf_pins xg_mac_0/rx_xgmii]
  connect_bd_intf_net -intf_net axis_clock_converter_0_M_AXIS [get_bd_intf_pins axis_clock_converter_tx/M_AXIS] [get_bd_intf_pins xg_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins rx_maxis] [get_bd_intf_pins axis_data_fifo_rx/M_AXIS]
  connect_bd_intf_net -intf_net ethernet_frame_dropp_0_m_axis [get_bd_intf_pins axis_data_fifo_rx/S_AXIS] [get_bd_intf_pins ethernet_frame_dropp_0/m_axis]
  connect_bd_intf_net -intf_net tx_saxis_1 [get_bd_intf_pins tx_saxis] [get_bd_intf_pins axis_clock_converter_tx/S_AXIS]
  connect_bd_intf_net -intf_net xg_mac_0_rx_maxis [get_bd_intf_pins ethernet_frame_dropp_0/s_axis] [get_bd_intf_pins xg_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net xg_mac_0_tx_xgmii [get_bd_intf_pins tx_xgmii] [get_bd_intf_pins xg_mac_0/tx_xgmii]

  # Create port connections
  connect_bd_net -net axis_data_fifo_0_prog_full [get_bd_pins axis_data_fifo_rx/prog_full] [get_bd_pins ethernet_frame_dropp_0/fifo_is_almost_full]
  connect_bd_net -net axis_data_fifo_rx_axis_wr_data_count [get_bd_pins axis_data_fifo_rx/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net mb_debug_sys_rst_1 [get_bd_pins mb_debug_sys_rst] [get_bd_pins rst_xxv_ethernet_0_156M_tx/mb_debug_sys_rst]
  connect_bd_net -net rst_xxv_ethernet_0_156M_2_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_reset] [get_bd_pins xg_mac_0/rx_reset]
  connect_bd_net -net rst_xxv_ethernet_0_156M_rx_peripheral_aresetn [get_bd_pins rx_aresetn] [get_bd_pins axis_data_fifo_rx/s_axis_aresetn] [get_bd_pins ethernet_frame_dropp_0/rstn] [get_bd_pins rst_xxv_ethernet_0_156M_rx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_aresetn [get_bd_pins tx_aresetn] [get_bd_pins axis_clock_converter_tx/m_axis_aresetn] [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_aresetn]
  connect_bd_net -net rst_xxv_ethernet_0_156M_tx_peripheral_reset [get_bd_pins rst_xxv_ethernet_0_156M_tx/peripheral_reset] [get_bd_pins xg_mac_0/tx_reset]
  connect_bd_net -net rx_clock [get_bd_pins rx_clock] [get_bd_pins axis_data_fifo_rx/s_axis_aclk] [get_bd_pins ethernet_frame_dropp_0/clk] [get_bd_pins rst_xxv_ethernet_0_156M_rx/slowest_sync_clk] [get_bd_pins xg_mac_0/rx_clock]
  connect_bd_net -net rx_reset [get_bd_pins rx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_rx/ext_reset_in]
  connect_bd_net -net s_axis_aclk_1 [get_bd_pins axis_common_aclk] [get_bd_pins axis_clock_converter_tx/s_axis_aclk] [get_bd_pins axis_data_fifo_rx/m_axis_aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net s_axis_aresetn_1 [get_bd_pins axis_common_aresetn] [get_bd_pins axis_clock_converter_tx/s_axis_aresetn]
  connect_bd_net -net tx_clock [get_bd_pins tx_clock] [get_bd_pins axis_clock_converter_tx/m_axis_aclk] [get_bd_pins rst_xxv_ethernet_0_156M_tx/slowest_sync_clk] [get_bd_pins xg_mac_0/tx_clock]
  connect_bd_net -net tx_reset [get_bd_pins tx_reset] [get_bd_pins rst_xxv_ethernet_0_156M_tx/ext_reset_in]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins ethernet_frame_dropp_0/drop_enable] [get_bd_pins xlconstant_0/dout]

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

  # Create instance: axis_register_slice_in, and set properties
  set axis_register_slice_in [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 axis_register_slice_in ]

  # Create instance: hier_channel_in_opt_0
  create_hier_cell_hier_channel_in_opt_0 $hier_obj hier_channel_in_opt_0

  # Create instance: hier_channel_in_opt_1
  create_hier_cell_hier_channel_in_opt_1 $hier_obj hier_channel_in_opt_1

  # Create instance: hier_channel_in_opt_2
  create_hier_cell_hier_channel_in_opt_2 $hier_obj hier_channel_in_opt_2

  # Create instance: hier_channel_in_opt_3
  create_hier_cell_hier_channel_in_opt_3 $hier_obj hier_channel_in_opt_3

  # Create instance: mactable_mod_0, and set properties
  set block_name mactable_mod
  set block_cell_name mactable_mod_0
  if { [catch {set mactable_mod_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2095 -severity "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $mactable_mod_0 eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2096 -severity "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
    set_property -dict [ list \
   CONFIG.ADDR_WIDTH {8} \
   CONFIG.MODE {dynamic} \
   CONFIG.PORT_WIDTH {2} \
 ] $mactable_mod_0

  # Create instance: request_switch, and set properties
  set request_switch [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_switch:1.1 request_switch ]
  set_property -dict [ list \
   CONFIG.M00_AXIS_HIGHTDEST {0xFFFFFFFF} \
   CONFIG.NUM_SI {4} \
 ] $request_switch

  # Create instance: xlconstant_val_0, and set properties
  set xlconstant_val_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_val_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
   CONFIG.CONST_WIDTH {8} \
 ] $xlconstant_val_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_register_slice_in_M_AXIS [get_bd_intf_pins axis_register_slice_in/M_AXIS] [get_bd_intf_pins mactable_mod_0/s_axis_table_request]
  connect_bd_intf_net -intf_net axis_switch_0_M00_AXIS [get_bd_intf_pins axis_register_slice_in/S_AXIS] [get_bd_intf_pins request_switch/M00_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_0_m_axis_table_request [get_bd_intf_pins hier_channel_in_opt_0/m_axis_table_request] [get_bd_intf_pins request_switch/S00_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_1_m_axis_table_request [get_bd_intf_pins hier_channel_in_opt_1/m_axis_table_request] [get_bd_intf_pins request_switch/S01_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_2_m_axis_table_request [get_bd_intf_pins hier_channel_in_opt_2/m_axis_table_request] [get_bd_intf_pins request_switch/S02_AXIS]
  connect_bd_intf_net -intf_net channel_in_opt_3_m_axis_table_request [get_bd_intf_pins hier_channel_in_opt_3/m_axis_table_request] [get_bd_intf_pins request_switch/S03_AXIS]
  connect_bd_intf_net -intf_net l2_switch_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins hier_channel_in_opt_0/m_axis]
  connect_bd_intf_net -intf_net l2_switch_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins hier_channel_in_opt_1/m_axis]
  connect_bd_intf_net -intf_net l2_switch_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins hier_channel_in_opt_2/m_axis]
  connect_bd_intf_net -intf_net l2_switch_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins hier_channel_in_opt_3/m_axis]
  connect_bd_intf_net -intf_net s_axis0_1 [get_bd_intf_pins s_axis0] [get_bd_intf_pins hier_channel_in_opt_0/s_axis]
  connect_bd_intf_net -intf_net s_axis1 [get_bd_intf_pins s_axis1] [get_bd_intf_pins hier_channel_in_opt_1/s_axis]
  connect_bd_intf_net -intf_net s_axis2 [get_bd_intf_pins s_axis2] [get_bd_intf_pins hier_channel_in_opt_2/s_axis]
  connect_bd_intf_net -intf_net s_axis3 [get_bd_intf_pins s_axis3] [get_bd_intf_pins hier_channel_in_opt_3/s_axis]

  # Create port connections
  connect_bd_net -net mactable_0_m_axis_table_response_tdata [get_bd_pins hier_channel_in_opt_0/s_axis_table_response_tdata] [get_bd_pins hier_channel_in_opt_1/s_axis_table_response_tdata] [get_bd_pins hier_channel_in_opt_2/s_axis_table_response_tdata] [get_bd_pins hier_channel_in_opt_3/s_axis_table_response_tdata] [get_bd_pins mactable_mod_0/m_axis_table_response_tdata]
  connect_bd_net -net mactable_0_m_axis_table_response_tuser [get_bd_pins hier_channel_in_opt_0/s_axis_table_response_tuser] [get_bd_pins hier_channel_in_opt_1/s_axis_table_response_tuser] [get_bd_pins hier_channel_in_opt_2/s_axis_table_response_tuser] [get_bd_pins hier_channel_in_opt_3/s_axis_table_response_tuser] [get_bd_pins mactable_mod_0/m_axis_table_response_tuser]
  connect_bd_net -net mactable_0_m_axis_table_response_tvalid [get_bd_pins hier_channel_in_opt_0/s_axis_table_response_tvalid] [get_bd_pins hier_channel_in_opt_1/s_axis_table_response_tvalid] [get_bd_pins hier_channel_in_opt_2/s_axis_table_response_tvalid] [get_bd_pins hier_channel_in_opt_3/s_axis_table_response_tvalid] [get_bd_pins mactable_mod_0/m_axis_table_response_tvalid]
  connect_bd_net -net proc_sys_reset_sw_peripheral_aresetn [get_bd_pins aresetn] [get_bd_pins axis_register_slice_in/aresetn] [get_bd_pins hier_channel_in_opt_0/aresetn] [get_bd_pins hier_channel_in_opt_1/aresetn] [get_bd_pins hier_channel_in_opt_2/aresetn] [get_bd_pins hier_channel_in_opt_3/aresetn] [get_bd_pins mactable_mod_0/aresetn] [get_bd_pins request_switch/aresetn]
  connect_bd_net -net temac_0_tx_mac_aclk [get_bd_pins aclk] [get_bd_pins axis_register_slice_in/aclk] [get_bd_pins hier_channel_in_opt_0/aclk] [get_bd_pins hier_channel_in_opt_1/aclk] [get_bd_pins hier_channel_in_opt_2/aclk] [get_bd_pins hier_channel_in_opt_3/aclk] [get_bd_pins mactable_mod_0/aclk] [get_bd_pins request_switch/aclk]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins mactable_mod_0/s_axis_table_config_tvalid] [get_bd_pins request_switch/s_req_suppress] [get_bd_pins xlconstant_val_0/dout]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s0_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s1_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s2_axis

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s3_axis


  # Create pins
  create_bd_pin -dir I -type clk aclk
  create_bd_pin -dir I -type rst aresetn

  # Create instance: axis_interconnect_0, and set properties
  set axis_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_interconnect:2.1 axis_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.ARB_ON_MAX_XFERS {0} \
   CONFIG.ARB_ON_TLAST {1} \
   CONFIG.M00_HAS_REGSLICE {1} \
   CONFIG.M01_HAS_REGSLICE {1} \
   CONFIG.M02_HAS_REGSLICE {1} \
   CONFIG.M03_HAS_REGSLICE {1} \
   CONFIG.M04_HAS_REGSLICE {1} \
   CONFIG.M05_HAS_REGSLICE {1} \
   CONFIG.M06_HAS_REGSLICE {1} \
   CONFIG.M07_HAS_REGSLICE {1} \
   CONFIG.NUM_MI {4} \
   CONFIG.NUM_SI {4} \
   CONFIG.S00_HAS_REGSLICE {1} \
   CONFIG.S01_HAS_REGSLICE {1} \
   CONFIG.S02_HAS_REGSLICE {1} \
   CONFIG.S03_HAS_REGSLICE {1} \
   CONFIG.S04_HAS_REGSLICE {1} \
   CONFIG.S05_HAS_REGSLICE {1} \
   CONFIG.S06_HAS_REGSLICE {1} \
   CONFIG.S07_HAS_REGSLICE {1} \
 ] $axis_interconnect_0

  # Create interface connections
  connect_bd_intf_net -intf_net axis_interconnect_0_M00_AXIS [get_bd_intf_pins M00_AXIS] [get_bd_intf_pins axis_interconnect_0/M00_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M01_AXIS [get_bd_intf_pins M01_AXIS] [get_bd_intf_pins axis_interconnect_0/M01_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M02_AXIS [get_bd_intf_pins M02_AXIS] [get_bd_intf_pins axis_interconnect_0/M02_AXIS]
  connect_bd_intf_net -intf_net axis_interconnect_0_M03_AXIS [get_bd_intf_pins M03_AXIS] [get_bd_intf_pins axis_interconnect_0/M03_AXIS]
  connect_bd_intf_net -intf_net s0_axis_1 [get_bd_intf_pins s0_axis] [get_bd_intf_pins axis_interconnect_0/S00_AXIS]
  connect_bd_intf_net -intf_net s1_axis_1 [get_bd_intf_pins s1_axis] [get_bd_intf_pins axis_interconnect_0/S01_AXIS]
  connect_bd_intf_net -intf_net s2_axis_1 [get_bd_intf_pins s2_axis] [get_bd_intf_pins axis_interconnect_0/S02_AXIS]
  connect_bd_intf_net -intf_net s3_axis_1 [get_bd_intf_pins s3_axis] [get_bd_intf_pins axis_interconnect_0/S03_AXIS]

  # Create port connections
  connect_bd_net -net ACLK_1 [get_bd_pins aclk] [get_bd_pins axis_interconnect_0/ACLK] [get_bd_pins axis_interconnect_0/M00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/M03_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S00_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S01_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S02_AXIS_ACLK] [get_bd_pins axis_interconnect_0/S03_AXIS_ACLK]
  connect_bd_net -net ARESETN_1 [get_bd_pins aresetn] [get_bd_pins axis_interconnect_0/ARESETN] [get_bd_pins axis_interconnect_0/M00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/M03_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S00_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S01_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S02_AXIS_ARESETN] [get_bd_pins axis_interconnect_0/S03_AXIS_ARESETN]

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

  # Create instance: registers_0
  create_hier_cell_registers_0_3 $hier_obj registers_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {8} \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
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
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins registers_0/aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net packet_based_fifo_0_axis_wr_data_count [get_bd_pins packet_based_fifo_0/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net packet_based_fifo_1_axis_wr_data_count [get_bd_pins packet_based_fifo_1/axis_wr_data_count] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net packet_based_fifo_2_axis_wr_data_count [get_bd_pins packet_based_fifo_2/axis_wr_data_count] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net packet_based_fifo_3_axis_wr_data_count [get_bd_pins packet_based_fifo_3/axis_wr_data_count] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net packet_based_fifo_4_axis_wr_data_count [get_bd_pins packet_based_fifo_4/axis_wr_data_count] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net packet_based_fifo_5_axis_wr_data_count [get_bd_pins packet_based_fifo_5/axis_wr_data_count] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net packet_based_fifo_6_axis_wr_data_count [get_bd_pins packet_based_fifo_6/axis_wr_data_count] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net packet_based_fifo_7_axis_wr_data_count [get_bd_pins packet_based_fifo_7/axis_wr_data_count] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins drop_enable] [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable]

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

  # Create instance: registers_0
  create_hier_cell_registers_0_2 $hier_obj registers_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {8} \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
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
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins registers_0/aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net packet_based_fifo_0_axis_wr_data_count [get_bd_pins packet_based_fifo_0/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net packet_based_fifo_1_axis_wr_data_count [get_bd_pins packet_based_fifo_1/axis_wr_data_count] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net packet_based_fifo_2_axis_wr_data_count [get_bd_pins packet_based_fifo_2/axis_wr_data_count] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net packet_based_fifo_3_axis_wr_data_count [get_bd_pins packet_based_fifo_3/axis_wr_data_count] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net packet_based_fifo_4_axis_wr_data_count [get_bd_pins packet_based_fifo_4/axis_wr_data_count] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net packet_based_fifo_5_axis_wr_data_count [get_bd_pins packet_based_fifo_5/axis_wr_data_count] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net packet_based_fifo_6_axis_wr_data_count [get_bd_pins packet_based_fifo_6/axis_wr_data_count] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net packet_based_fifo_7_axis_wr_data_count [get_bd_pins packet_based_fifo_7/axis_wr_data_count] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins drop_enable] [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable]

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

  # Create instance: registers_0
  create_hier_cell_registers_0_1 $hier_obj registers_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {8} \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
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
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins registers_0/aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net packet_based_fifo_0_axis_wr_data_count [get_bd_pins packet_based_fifo_0/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net packet_based_fifo_1_axis_wr_data_count [get_bd_pins packet_based_fifo_1/axis_wr_data_count] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net packet_based_fifo_2_axis_wr_data_count [get_bd_pins packet_based_fifo_2/axis_wr_data_count] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net packet_based_fifo_3_axis_wr_data_count [get_bd_pins packet_based_fifo_3/axis_wr_data_count] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net packet_based_fifo_4_axis_wr_data_count [get_bd_pins packet_based_fifo_4/axis_wr_data_count] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net packet_based_fifo_5_axis_wr_data_count [get_bd_pins packet_based_fifo_5/axis_wr_data_count] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net packet_based_fifo_6_axis_wr_data_count [get_bd_pins packet_based_fifo_6/axis_wr_data_count] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net packet_based_fifo_7_axis_wr_data_count [get_bd_pins packet_based_fifo_7/axis_wr_data_count] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins drop_enable] [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable]

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

  # Create instance: registers_0
  create_hier_cell_registers_0 $hier_obj registers_0

  # Create instance: vio_0, and set properties
  set vio_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:vio:3.0 vio_0 ]
  set_property -dict [ list \
   CONFIG.C_NUM_PROBE_IN {8} \
   CONFIG.C_NUM_PROBE_OUT {0} \
 ] $vio_0

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S_AXI] [get_bd_intf_pins registers_0/S_AXI]
  connect_bd_intf_net -intf_net S00_AXIS_1 [get_bd_intf_pins arbiter_0/S00_AXIS] [get_bd_intf_pins packet_based_fifo_0/M_AXIS]
  connect_bd_intf_net -intf_net S01_AXIS_1 [get_bd_intf_pins arbiter_0/S01_AXIS] [get_bd_intf_pins packet_based_fifo_1/M_AXIS]
  connect_bd_intf_net -intf_net S02_AXIS_1 [get_bd_intf_pins arbiter_0/S02_AXIS] [get_bd_intf_pins packet_based_fifo_2/M_AXIS]
  connect_bd_intf_net -intf_net S03_AXIS_1 [get_bd_intf_pins arbiter_0/S03_AXIS] [get_bd_intf_pins packet_based_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net S04_AXIS_1 [get_bd_intf_pins arbiter_0/S04_AXIS] [get_bd_intf_pins packet_based_fifo_4/M_AXIS]
  connect_bd_intf_net -intf_net S05_AXIS_1 [get_bd_intf_pins arbiter_0/S05_AXIS] [get_bd_intf_pins packet_based_fifo_5/M_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_pins S_AXIS_0] [get_bd_intf_pins packet_based_fifo_0/S_AXIS]
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
  connect_bd_net -net clk_1 [get_bd_pins aclk] [get_bd_pins arbiter_0/aclk] [get_bd_pins credit_based_shaper_6/aclk] [get_bd_pins credit_based_shaper_7/aclk] [get_bd_pins packet_based_fifo_0/aclk] [get_bd_pins packet_based_fifo_1/aclk] [get_bd_pins packet_based_fifo_2/aclk] [get_bd_pins packet_based_fifo_3/aclk] [get_bd_pins packet_based_fifo_4/aclk] [get_bd_pins packet_based_fifo_5/aclk] [get_bd_pins packet_based_fifo_6/aclk] [get_bd_pins packet_based_fifo_7/aclk] [get_bd_pins registers_0/aclk] [get_bd_pins vio_0/clk]
  connect_bd_net -net packet_based_fifo_0_axis_wr_data_count [get_bd_pins packet_based_fifo_0/axis_wr_data_count] [get_bd_pins vio_0/probe_in0]
  connect_bd_net -net packet_based_fifo_1_axis_wr_data_count [get_bd_pins packet_based_fifo_1/axis_wr_data_count] [get_bd_pins vio_0/probe_in1]
  connect_bd_net -net packet_based_fifo_2_axis_wr_data_count [get_bd_pins packet_based_fifo_2/axis_wr_data_count] [get_bd_pins vio_0/probe_in2]
  connect_bd_net -net packet_based_fifo_3_axis_wr_data_count [get_bd_pins packet_based_fifo_3/axis_wr_data_count] [get_bd_pins vio_0/probe_in3]
  connect_bd_net -net packet_based_fifo_4_axis_wr_data_count [get_bd_pins packet_based_fifo_4/axis_wr_data_count] [get_bd_pins vio_0/probe_in4]
  connect_bd_net -net packet_based_fifo_5_axis_wr_data_count [get_bd_pins packet_based_fifo_5/axis_wr_data_count] [get_bd_pins vio_0/probe_in5]
  connect_bd_net -net packet_based_fifo_6_axis_wr_data_count [get_bd_pins packet_based_fifo_6/axis_wr_data_count] [get_bd_pins vio_0/probe_in6]
  connect_bd_net -net packet_based_fifo_7_axis_wr_data_count [get_bd_pins packet_based_fifo_7/axis_wr_data_count] [get_bd_pins vio_0/probe_in7]
  connect_bd_net -net rstn_1 [get_bd_pins aresetn] [get_bd_pins arbiter_0/aresetn] [get_bd_pins credit_based_shaper_6/aresetn] [get_bd_pins credit_based_shaper_7/aresetn] [get_bd_pins packet_based_fifo_0/aresetn] [get_bd_pins packet_based_fifo_1/aresetn] [get_bd_pins packet_based_fifo_2/aresetn] [get_bd_pins packet_based_fifo_3/aresetn] [get_bd_pins packet_based_fifo_4/aresetn] [get_bd_pins packet_based_fifo_5/aresetn] [get_bd_pins packet_based_fifo_6/aresetn] [get_bd_pins packet_based_fifo_7/aresetn] [get_bd_pins registers_0/aresetn]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins drop_enable] [get_bd_pins packet_based_fifo_0/drop_enable] [get_bd_pins packet_based_fifo_1/drop_enable] [get_bd_pins packet_based_fifo_2/drop_enable] [get_bd_pins packet_based_fifo_3/drop_enable] [get_bd_pins packet_based_fifo_4/drop_enable] [get_bd_pins packet_based_fifo_5/drop_enable] [get_bd_pins packet_based_fifo_6/drop_enable] [get_bd_pins packet_based_fifo_7/drop_enable]

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
  set gty_refclk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 gty_refclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {161132812} \
   ] $gty_refclk

  set gty_rx_in [ create_bd_intf_port -mode Slave -vlnv xilinx.com:display_xxv_ethernet:gt_ports:2.0 gty_rx_in ]

  set gty_tx_out [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_xxv_ethernet:gt_ports:2.0 gty_tx_out ]

  set sysclk_300 [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sysclk_300 ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {300000000} \
   ] $sysclk_300


  # Create ports

  # Create instance: axi_gpio_parameters_0, and set properties
  set axi_gpio_parameters_0 [ create_bd_cell -type ip -vlnv user.org:user:axi_gpio_parameters:1.0 axi_gpio_parameters_0 ]
  set_property -dict [ list \
   CONFIG.ENABLE_COMMITHASH_READ {true} \
   CONFIG.ENABLE_PROCESSINGDELAYMAX_OUT {false} \
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

  # Create instance: blk_mem_gen_mb, and set properties
  set blk_mem_gen_mb [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_mb ]
  set_property -dict [ list \
   CONFIG.EN_SAFETY_CKT {false} \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
 ] $blk_mem_gen_mb

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [ list \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
   CONFIG.USE_RESET {false} \
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

  # Create instance: jtag_axi_0_periph, and set properties
  set jtag_axi_0_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 jtag_axi_0_periph ]
  set_property -dict [ list \
   CONFIG.NUM_MI {2} \
   CONFIG.NUM_SI {1} \
 ] $jtag_axi_0_periph

  # Create instance: lmb_bram_if_cntlr_mb_data, and set properties
  set lmb_bram_if_cntlr_mb_data [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_bram_if_cntlr_mb_data ]

  # Create instance: lmb_bram_if_cntlr_mb_inst, and set properties
  set lmb_bram_if_cntlr_mb_inst [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 lmb_bram_if_cntlr_mb_inst ]

  # Create instance: mdm_0, and set properties
  set mdm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_SIZE {32} \
   CONFIG.C_M_AXI_ADDR_WIDTH {32} \
   CONFIG.C_USE_UART {1} \
 ] $mdm_0

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [ list \
   CONFIG.C_ADDR_TAG_BITS {0} \
   CONFIG.C_DATA_SIZE {32} \
   CONFIG.C_DCACHE_ADDR_TAG {0} \
   CONFIG.C_D_AXI {1} \
 ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list \
   CONFIG.M00_HAS_REGSLICE {4} \
   CONFIG.M01_HAS_REGSLICE {4} \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.M03_HAS_REGSLICE {4} \
   CONFIG.M04_HAS_REGSLICE {4} \
   CONFIG.M05_HAS_REGSLICE {4} \
   CONFIG.M06_HAS_REGSLICE {4} \
   CONFIG.M07_HAS_REGSLICE {4} \
   CONFIG.M08_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {5} \
   CONFIG.S00_HAS_REGSLICE {4} \
 ] $microblaze_0_axi_periph

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: smartconnect_0, and set properties
  set smartconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 smartconnect_0 ]
  set_property -dict [ list \
   CONFIG.NUM_MI {8} \
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

  # Create instance: xlconstant_clksel, and set properties
  set xlconstant_clksel [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_clksel ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0b101} \
   CONFIG.CONST_WIDTH {3} \
 ] $xlconstant_clksel

  # Create instance: xlconstant_drop_enable, and set properties
  set xlconstant_drop_enable [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_drop_enable ]

  # Create instance: xlconstant_no_reset, and set properties
  set xlconstant_no_reset [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_no_reset ]

  # Create instance: xxv_ethernet_0, and set properties
  set xxv_ethernet_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xxv_ethernet:4.1 xxv_ethernet_0 ]
  set_property -dict [ list \
   CONFIG.BASE_R_KR {BASE-R} \
   CONFIG.CORE {Ethernet PCS/PMA 64-bit} \
   CONFIG.DATA_PATH_INTERFACE {MII} \
   CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
   CONFIG.ENABLE_PIPELINE_REG {0} \
   CONFIG.ETHERNET_BOARD_INTERFACE {Custom} \
   CONFIG.GT_GROUP_SELECT {Quad_X0Y7} \
   CONFIG.GT_REF_CLK_FREQ {161.1328125} \
   CONFIG.GT_TYPE {GTY} \
   CONFIG.INCLUDE_AXI4_INTERFACE {1} \
   CONFIG.INCLUDE_STATISTICS_COUNTERS {1} \
   CONFIG.LANE1_GT_LOC {X0Y28} \
   CONFIG.LANE2_GT_LOC {X0Y29} \
   CONFIG.LANE3_GT_LOC {X0Y30} \
   CONFIG.LANE4_GT_LOC {X0Y31} \
   CONFIG.LINE_RATE {10} \
   CONFIG.NUM_OF_CORES {4} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $xxv_ethernet_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_register_slice_0_M_AXI [get_bd_intf_pins axi_register_slice_0/M_AXI] [get_bd_intf_pins jtag_axi_0_periph/S00_AXI]
  connect_bd_intf_net -intf_net gt_rx_0_1 [get_bd_intf_ports gty_rx_in] [get_bd_intf_pins xxv_ethernet_0/gt_rx]
  connect_bd_intf_net -intf_net hier_cbs_0_m_axis [get_bd_intf_pins hier_cbs_0/m_axis] [get_bd_intf_pins hier_mac_0/tx_saxis]
  connect_bd_intf_net -intf_net hier_cbs_1_m_axis [get_bd_intf_pins hier_cbs_1/m_axis] [get_bd_intf_pins hier_mac_1/tx_saxis]
  connect_bd_intf_net -intf_net hier_cbs_2_m_axis [get_bd_intf_pins hier_cbs_2/m_axis] [get_bd_intf_pins hier_mac_2/tx_saxis]
  connect_bd_intf_net -intf_net hier_cbs_3_m_axis [get_bd_intf_pins hier_cbs_3/m_axis] [get_bd_intf_pins hier_mac_3/tx_saxis]
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
  connect_bd_intf_net -intf_net hier_mac_0_rx_maxis [get_bd_intf_pins hier_fdb/s_axis0] [get_bd_intf_pins hier_mac_0/rx_maxis]
  connect_bd_intf_net -intf_net hier_mac_0_tx_xgmii [get_bd_intf_pins hier_mac_0/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_0]
  connect_bd_intf_net -intf_net hier_mac_1_rx_maxis [get_bd_intf_pins hier_fdb/s_axis1] [get_bd_intf_pins hier_mac_1/rx_maxis]
  connect_bd_intf_net -intf_net hier_mac_1_tx_xgmii [get_bd_intf_pins hier_mac_1/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_1]
  connect_bd_intf_net -intf_net hier_mac_2_rx_maxis [get_bd_intf_pins hier_fdb/s_axis2] [get_bd_intf_pins hier_mac_2/rx_maxis]
  connect_bd_intf_net -intf_net hier_mac_2_tx_xgmii [get_bd_intf_pins hier_mac_2/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_2]
  connect_bd_intf_net -intf_net hier_mac_3_rx_maxis [get_bd_intf_pins hier_fdb/s_axis3] [get_bd_intf_pins hier_mac_3/rx_maxis]
  connect_bd_intf_net -intf_net hier_mac_3_tx_xgmii [get_bd_intf_pins hier_mac_3/tx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_tx_3]
  connect_bd_intf_net -intf_net jtag_axi_0_M_AXI [get_bd_intf_pins axi_register_slice_0/S_AXI] [get_bd_intf_pins jtag_axi_0/M_AXI]
  connect_bd_intf_net -intf_net jtag_axi_0_periph_M00_AXI [get_bd_intf_pins jtag_axi_0_periph/M00_AXI] [get_bd_intf_pins smartconnect_0/S00_AXI]
  connect_bd_intf_net -intf_net jtag_axi_0_periph_M01_AXI [get_bd_intf_pins axi_gpio_parameters_0/S_AXI] [get_bd_intf_pins jtag_axi_0_periph/M01_AXI]
  connect_bd_intf_net -intf_net lmb_bram_if_cntlr_mb_data_BRAM_PORT [get_bd_intf_pins blk_mem_gen_mb/BRAM_PORTA] [get_bd_intf_pins lmb_bram_if_cntlr_mb_data/BRAM_PORT]
  connect_bd_intf_net -intf_net lmb_bram_if_cntlr_mb_inst_BRAM_PORT [get_bd_intf_pins blk_mem_gen_mb/BRAM_PORTB] [get_bd_intf_pins lmb_bram_if_cntlr_mb_inst/BRAM_PORT]
  connect_bd_intf_net -intf_net mdm_0_MBDEBUG_0 [get_bd_intf_pins mdm_0/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_DLMB [get_bd_intf_pins lmb_bram_if_cntlr_mb_data/SLMB] [get_bd_intf_pins microblaze_0/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ILMB [get_bd_intf_pins lmb_bram_if_cntlr_mb_inst/SLMB] [get_bd_intf_pins microblaze_0/ILMB]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins mdm_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_0]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_1]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_2]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI] [get_bd_intf_pins xxv_ethernet_0/s_axi_3]
  connect_bd_intf_net -intf_net sfpdd_refclk0_1 [get_bd_intf_ports gty_refclk] [get_bd_intf_pins xxv_ethernet_0/gt_ref_clk]
  connect_bd_intf_net -intf_net smartconnect_0_M00_AXI [get_bd_intf_pins smartconnect_0/M00_AXI] [get_bd_intf_pins switcher_0/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M01_AXI [get_bd_intf_pins smartconnect_0/M01_AXI] [get_bd_intf_pins switcher_1/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M02_AXI [get_bd_intf_pins smartconnect_0/M02_AXI] [get_bd_intf_pins switcher_2/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M03_AXI [get_bd_intf_pins smartconnect_0/M03_AXI] [get_bd_intf_pins switcher_3/S_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M04_AXI [get_bd_intf_pins hier_cbs_0/S_AXI] [get_bd_intf_pins smartconnect_0/M04_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M05_AXI [get_bd_intf_pins hier_cbs_1/S_AXI] [get_bd_intf_pins smartconnect_0/M05_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M06_AXI [get_bd_intf_pins hier_cbs_2/S_AXI] [get_bd_intf_pins smartconnect_0/M06_AXI]
  connect_bd_intf_net -intf_net smartconnect_0_M07_AXI [get_bd_intf_pins hier_cbs_3/S_AXI] [get_bd_intf_pins smartconnect_0/M07_AXI]
  connect_bd_intf_net -intf_net switcher_0_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s0_axis] [get_bd_intf_pins switcher_0/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s0_axis] [get_bd_intf_pins switcher_0/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s0_axis] [get_bd_intf_pins switcher_0/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s0_axis] [get_bd_intf_pins switcher_0/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s0_axis] [get_bd_intf_pins switcher_0/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s0_axis] [get_bd_intf_pins switcher_0/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s0_axis] [get_bd_intf_pins switcher_0/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_0_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s0_axis] [get_bd_intf_pins switcher_0/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s1_axis] [get_bd_intf_pins switcher_1/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s1_axis] [get_bd_intf_pins switcher_1/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s1_axis] [get_bd_intf_pins switcher_1/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s1_axis] [get_bd_intf_pins switcher_1/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s1_axis] [get_bd_intf_pins switcher_1/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s1_axis] [get_bd_intf_pins switcher_1/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s1_axis] [get_bd_intf_pins switcher_1/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_1_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s1_axis] [get_bd_intf_pins switcher_1/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s2_axis] [get_bd_intf_pins switcher_2/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s2_axis] [get_bd_intf_pins switcher_2/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s2_axis] [get_bd_intf_pins switcher_2/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s2_axis] [get_bd_intf_pins switcher_2/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s2_axis] [get_bd_intf_pins switcher_2/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s2_axis] [get_bd_intf_pins switcher_2/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s2_axis] [get_bd_intf_pins switcher_2/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_2_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s2_axis] [get_bd_intf_pins switcher_2/M07_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M00_AXIS [get_bd_intf_pins hier_eth_switch_0/s3_axis] [get_bd_intf_pins switcher_3/M00_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M01_AXIS [get_bd_intf_pins hier_eth_switch_1/s3_axis] [get_bd_intf_pins switcher_3/M01_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M02_AXIS [get_bd_intf_pins hier_eth_switch_2/s3_axis] [get_bd_intf_pins switcher_3/M02_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M03_AXIS [get_bd_intf_pins hier_eth_switch_3/s3_axis] [get_bd_intf_pins switcher_3/M03_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M04_AXIS [get_bd_intf_pins hier_eth_switch_4/s3_axis] [get_bd_intf_pins switcher_3/M04_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M05_AXIS [get_bd_intf_pins hier_eth_switch_5/s3_axis] [get_bd_intf_pins switcher_3/M05_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M06_AXIS [get_bd_intf_pins hier_eth_switch_6/s3_axis] [get_bd_intf_pins switcher_3/M06_AXIS]
  connect_bd_intf_net -intf_net switcher_3_M07_AXIS [get_bd_intf_pins hier_eth_switch_7/s3_axis] [get_bd_intf_pins switcher_3/M07_AXIS]
  connect_bd_intf_net -intf_net sysclk_300_1 [get_bd_intf_ports sysclk_300] [get_bd_intf_pins clk_wiz_0/CLK_IN1_D]
  connect_bd_intf_net -intf_net xxv_ethernet_0_gt_tx [get_bd_intf_ports gty_tx_out] [get_bd_intf_pins xxv_ethernet_0/gt_tx]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_0 [get_bd_intf_pins hier_mac_0/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_0]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_1 [get_bd_intf_pins hier_mac_1/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_1]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_2 [get_bd_intf_pins hier_mac_2/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_2]
  connect_bd_intf_net -intf_net xxv_ethernet_0_mii_rx_3 [get_bd_intf_pins hier_mac_3/rx_xgmii] [get_bd_intf_pins xxv_ethernet_0/mii_rx_3]

  # Create port connections
  connect_bd_net -net clk_wiz_0_clk_out1 [get_bd_pins clk_wiz_0/clk_out1] [get_bd_pins lmb_bram_if_cntlr_mb_data/LMB_Clk] [get_bd_pins lmb_bram_if_cntlr_mb_inst/LMB_Clk] [get_bd_pins mdm_0/S_AXI_ACLK] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins xxv_ethernet_0/dclk] [get_bd_pins xxv_ethernet_0/s_axi_aclk_0] [get_bd_pins xxv_ethernet_0/s_axi_aclk_1] [get_bd_pins xxv_ethernet_0/s_axi_aclk_2] [get_bd_pins xxv_ethernet_0/s_axi_aclk_3]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins proc_sys_reset_0/dcm_locked]
  create_bd_net hier_mac_0_peripheral_aresetn1
  connect_bd_net -net [get_bd_nets hier_mac_0_peripheral_aresetn1] [get_bd_pins axi_gpio_parameters_0/rstn] [get_bd_pins axi_register_slice_0/aresetn] [get_bd_pins hier_cbs_0/aresetn] [get_bd_pins hier_cbs_1/aresetn] [get_bd_pins hier_cbs_2/aresetn] [get_bd_pins hier_cbs_3/aresetn] [get_bd_pins hier_eth_switch_0/aresetn] [get_bd_pins hier_eth_switch_1/aresetn] [get_bd_pins hier_eth_switch_2/aresetn] [get_bd_pins hier_eth_switch_3/aresetn] [get_bd_pins hier_eth_switch_4/aresetn] [get_bd_pins hier_eth_switch_5/aresetn] [get_bd_pins hier_eth_switch_6/aresetn] [get_bd_pins hier_eth_switch_7/aresetn] [get_bd_pins hier_fdb/aresetn] [get_bd_pins hier_mac_0/axis_common_aresetn] [get_bd_pins hier_mac_0/tx_aresetn] [get_bd_pins hier_mac_1/axis_common_aresetn] [get_bd_pins hier_mac_2/axis_common_aresetn] [get_bd_pins hier_mac_3/axis_common_aresetn] [get_bd_pins jtag_axi_0/aresetn] [get_bd_pins jtag_axi_0_periph/aresetn] [get_bd_pins smartconnect_0/aresetn] [get_bd_pins switcher_0/aresetn] [get_bd_pins switcher_1/aresetn] [get_bd_pins switcher_2/aresetn] [get_bd_pins switcher_3/aresetn]
  connect_bd_net -net mdm_0_Debug_SYS_Rst [get_bd_pins hier_mac_0/mb_debug_sys_rst] [get_bd_pins hier_mac_1/mb_debug_sys_rst] [get_bd_pins hier_mac_2/mb_debug_sys_rst] [get_bd_pins hier_mac_3/mb_debug_sys_rst] [get_bd_pins mdm_0/Debug_SYS_Rst] [get_bd_pins proc_sys_reset_0/mb_debug_sys_rst]
  connect_bd_net -net proc_sys_reset_0_mb_reset [get_bd_pins lmb_bram_if_cntlr_mb_data/LMB_Rst] [get_bd_pins lmb_bram_if_cntlr_mb_inst/LMB_Rst] [get_bd_pins microblaze_0/Reset] [get_bd_pins proc_sys_reset_0/mb_reset]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins mdm_0/S_AXI_ARESETN] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_0] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_1] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_2] [get_bd_pins xxv_ethernet_0/s_axi_aresetn_3]
  connect_bd_net -net proc_sys_reset_0_peripheral_reset [get_bd_pins proc_sys_reset_0/peripheral_reset] [get_bd_pins xxv_ethernet_0/sys_reset]
  connect_bd_net -net rx_clock_1 [get_bd_pins hier_mac_2/tx_clock] [get_bd_pins xxv_ethernet_0/tx_mii_clk_2]
  connect_bd_net -net rx_clock_2 [get_bd_pins hier_mac_3/tx_clock] [get_bd_pins xxv_ethernet_0/tx_mii_clk_3]
  connect_bd_net -net rx_reset_1 [get_bd_pins hier_mac_1/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_1]
  connect_bd_net -net rx_reset_2 [get_bd_pins hier_mac_2/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_2]
  connect_bd_net -net rx_reset_3 [get_bd_pins hier_mac_3/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_3]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconstant_clksel/dout] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_0] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_1] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_2] [get_bd_pins xxv_ethernet_0/rxoutclksel_in_3] [get_bd_pins xxv_ethernet_0/txoutclksel_in_0] [get_bd_pins xxv_ethernet_0/txoutclksel_in_1] [get_bd_pins xxv_ethernet_0/txoutclksel_in_2] [get_bd_pins xxv_ethernet_0/txoutclksel_in_3]
  connect_bd_net -net xlconstant_0_dout1 [get_bd_pins hier_cbs_0/drop_enable] [get_bd_pins hier_cbs_1/drop_enable] [get_bd_pins hier_cbs_2/drop_enable] [get_bd_pins hier_cbs_3/drop_enable] [get_bd_pins xlconstant_drop_enable/dout]
  connect_bd_net -net xlconstant_no_reset_dout [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins xlconstant_no_reset/dout]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_0 [get_bd_pins hier_mac_0/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_0] [get_bd_pins xxv_ethernet_0/rx_core_clk_0]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_1 [get_bd_pins hier_mac_1/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_1] [get_bd_pins xxv_ethernet_0/rx_core_clk_1]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_2 [get_bd_pins hier_mac_2/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_2] [get_bd_pins xxv_ethernet_0/rx_core_clk_2]
  connect_bd_net -net xxv_ethernet_0_rx_clk_out_3 [get_bd_pins hier_mac_3/rx_clock] [get_bd_pins xxv_ethernet_0/rx_clk_out_3] [get_bd_pins xxv_ethernet_0/rx_core_clk_3]
  connect_bd_net -net xxv_ethernet_0_tx_mii_clk_0 [get_bd_pins axi_gpio_parameters_0/clk] [get_bd_pins axi_register_slice_0/aclk] [get_bd_pins hier_cbs_0/aclk] [get_bd_pins hier_cbs_1/aclk] [get_bd_pins hier_cbs_2/aclk] [get_bd_pins hier_cbs_3/aclk] [get_bd_pins hier_eth_switch_0/aclk] [get_bd_pins hier_eth_switch_1/aclk] [get_bd_pins hier_eth_switch_2/aclk] [get_bd_pins hier_eth_switch_3/aclk] [get_bd_pins hier_eth_switch_4/aclk] [get_bd_pins hier_eth_switch_5/aclk] [get_bd_pins hier_eth_switch_6/aclk] [get_bd_pins hier_eth_switch_7/aclk] [get_bd_pins hier_fdb/aclk] [get_bd_pins hier_mac_0/axis_common_aclk] [get_bd_pins hier_mac_0/tx_clock] [get_bd_pins hier_mac_1/axis_common_aclk] [get_bd_pins hier_mac_2/axis_common_aclk] [get_bd_pins hier_mac_3/axis_common_aclk] [get_bd_pins jtag_axi_0/aclk] [get_bd_pins jtag_axi_0_periph/aclk] [get_bd_pins smartconnect_0/aclk] [get_bd_pins switcher_0/aclk] [get_bd_pins switcher_1/aclk] [get_bd_pins switcher_2/aclk] [get_bd_pins switcher_3/aclk] [get_bd_pins xxv_ethernet_0/tx_mii_clk_0]
  connect_bd_net -net xxv_ethernet_0_tx_mii_clk_1 [get_bd_pins hier_mac_1/tx_clock] [get_bd_pins xxv_ethernet_0/tx_mii_clk_1]
  connect_bd_net -net xxv_ethernet_0_user_rx_reset_0 [get_bd_pins hier_mac_0/rx_reset] [get_bd_pins xxv_ethernet_0/user_rx_reset_0]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_0 [get_bd_pins hier_mac_0/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_0] [get_bd_pins xxv_ethernet_0/user_tx_reset_0]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_1 [get_bd_pins hier_mac_1/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_1] [get_bd_pins xxv_ethernet_0/user_tx_reset_1]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_2 [get_bd_pins hier_mac_2/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_2] [get_bd_pins xxv_ethernet_0/user_tx_reset_2]
  connect_bd_net -net xxv_ethernet_0_user_tx_reset_3 [get_bd_pins hier_mac_3/tx_reset] [get_bd_pins xxv_ethernet_0/rx_reset_3] [get_bd_pins xxv_ethernet_0/user_tx_reset_3]

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
  assign_bd_address -offset 0x00100000 -range 0x00000080 -target_address_space [get_bd_addr_spaces jtag_axi_0/Data] [get_bd_addr_segs axi_gpio_parameters_0/S_AXI/reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs lmb_bram_if_cntlr_mb_data/SLMB/Mem] -force
  assign_bd_address -offset 0x41400000 -range 0x00000080 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs mdm_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x44A40000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_0/Reg] -force
  assign_bd_address -offset 0x44A80000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_1/Reg] -force
  assign_bd_address -offset 0x44AC0000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_2/Reg] -force
  assign_bd_address -offset 0x44B00000 -range 0x00040000 -target_address_space [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs xxv_ethernet_0/s_axi_3/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs lmb_bram_if_cntlr_mb_inst/SLMB/Mem] -force


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


