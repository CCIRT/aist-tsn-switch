<<<<<<< HEAD
=======

# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/detect_flow_v1_0.gtcl]

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
<<<<<<< HEAD
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_REGISTERS" -parent ${Page_0}
=======
  ipgui::add_param $IPINST -name "C_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_AXIS_TKEEP_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_MATCH_RATE" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "FLOW_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_REGISTERS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OPT_LEVEL" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "RAM_STYLE" -parent ${Page_0} -widget comboBox
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)


}

<<<<<<< HEAD
=======
proc update_PARAM_VALUE.C_AXIS_TKEEP_WIDTH { PARAM_VALUE.C_AXIS_TKEEP_WIDTH PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_AXIS_TKEEP_WIDTH when any of the dependent parameters in the arguments change
	
	set C_AXIS_TKEEP_WIDTH ${PARAM_VALUE.C_AXIS_TKEEP_WIDTH}
	set C_AXIS_TDATA_WIDTH ${PARAM_VALUE.C_AXIS_TDATA_WIDTH}
	set values(C_AXIS_TDATA_WIDTH) [get_property value $C_AXIS_TDATA_WIDTH]
	set_property value [gen_USERPARAMETER_C_AXIS_TKEEP_WIDTH_VALUE $values(C_AXIS_TDATA_WIDTH)] $C_AXIS_TKEEP_WIDTH
}

proc validate_PARAM_VALUE.C_AXIS_TKEEP_WIDTH { PARAM_VALUE.C_AXIS_TKEEP_WIDTH } {
	# Procedure called to validate C_AXIS_TKEEP_WIDTH
	return true
}

proc update_PARAM_VALUE.C_AXIS_TDATA_WIDTH { PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXIS_TDATA_WIDTH { PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_AXIS_TDATA_WIDTH
	return true
}

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

<<<<<<< HEAD
proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
=======
proc update_PARAM_VALUE.FLOW_MATCH_RATE { PARAM_VALUE.FLOW_MATCH_RATE } {
	# Procedure called to update FLOW_MATCH_RATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FLOW_MATCH_RATE { PARAM_VALUE.FLOW_MATCH_RATE } {
	# Procedure called to validate FLOW_MATCH_RATE
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
	return true
}

proc update_PARAM_VALUE.FLOW_NUM { PARAM_VALUE.FLOW_NUM } {
	# Procedure called to update FLOW_NUM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FLOW_NUM { PARAM_VALUE.FLOW_NUM } {
	# Procedure called to validate FLOW_NUM
	return true
}

proc update_PARAM_VALUE.FLOW_WIDTH { PARAM_VALUE.FLOW_WIDTH } {
	# Procedure called to update FLOW_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FLOW_WIDTH { PARAM_VALUE.FLOW_WIDTH } {
	# Procedure called to validate FLOW_WIDTH
	return true
}

proc update_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to update NUM_OF_REGISTERS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to validate NUM_OF_REGISTERS
	return true
}

<<<<<<< HEAD

proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
=======
proc update_PARAM_VALUE.OPT_LEVEL { PARAM_VALUE.OPT_LEVEL } {
	# Procedure called to update OPT_LEVEL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OPT_LEVEL { PARAM_VALUE.OPT_LEVEL } {
	# Procedure called to validate OPT_LEVEL
	return true
}

proc update_PARAM_VALUE.RAM_STYLE { PARAM_VALUE.RAM_STYLE } {
	# Procedure called to update RAM_STYLE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.RAM_STYLE { PARAM_VALUE.RAM_STYLE } {
	# Procedure called to validate RAM_STYLE
	return true
}


proc update_MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH { MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH PARAM_VALUE.C_AXIS_TKEEP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXIS_TKEEP_WIDTH}] ${MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH}
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
}

proc update_MODELPARAM_VALUE.FLOW_NUM { MODELPARAM_VALUE.FLOW_NUM PARAM_VALUE.FLOW_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FLOW_NUM}] ${MODELPARAM_VALUE.FLOW_NUM}
}

proc update_MODELPARAM_VALUE.FLOW_WIDTH { MODELPARAM_VALUE.FLOW_WIDTH PARAM_VALUE.FLOW_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FLOW_WIDTH}] ${MODELPARAM_VALUE.FLOW_WIDTH}
}

<<<<<<< HEAD
=======
proc update_MODELPARAM_VALUE.FLOW_MATCH_RATE { MODELPARAM_VALUE.FLOW_MATCH_RATE PARAM_VALUE.FLOW_MATCH_RATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FLOW_MATCH_RATE}] ${MODELPARAM_VALUE.FLOW_MATCH_RATE}
}

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.NUM_OF_REGISTERS { MODELPARAM_VALUE.NUM_OF_REGISTERS PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_OF_REGISTERS}] ${MODELPARAM_VALUE.NUM_OF_REGISTERS}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

<<<<<<< HEAD
=======
proc update_MODELPARAM_VALUE.OPT_LEVEL { MODELPARAM_VALUE.OPT_LEVEL PARAM_VALUE.OPT_LEVEL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OPT_LEVEL}] ${MODELPARAM_VALUE.OPT_LEVEL}
}

proc update_MODELPARAM_VALUE.RAM_STYLE { MODELPARAM_VALUE.RAM_STYLE PARAM_VALUE.RAM_STYLE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.RAM_STYLE}] ${MODELPARAM_VALUE.RAM_STYLE}
}

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
