# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "COMMIT_VALUE_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_NUM" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FLOW_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FRAME_LENGTH_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_REGISTERS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIMESTAMP_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.COMMIT_VALUE_WIDTH { PARAM_VALUE.COMMIT_VALUE_WIDTH } {
	# Procedure called to update COMMIT_VALUE_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.COMMIT_VALUE_WIDTH { PARAM_VALUE.COMMIT_VALUE_WIDTH } {
	# Procedure called to validate COMMIT_VALUE_WIDTH
	return true
}

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

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
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

proc update_PARAM_VALUE.FRAME_LENGTH_WIDTH { PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to update FRAME_LENGTH_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FRAME_LENGTH_WIDTH { PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to validate FRAME_LENGTH_WIDTH
	return true
}

proc update_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to update NUM_OF_REGISTERS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to validate NUM_OF_REGISTERS
	return true
}

proc update_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to update TIMESTAMP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to validate TIMESTAMP_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.DATA_WIDTH { MODELPARAM_VALUE.DATA_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.DATA_WIDTH}] ${MODELPARAM_VALUE.DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.FLOW_NUM { MODELPARAM_VALUE.FLOW_NUM PARAM_VALUE.FLOW_NUM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FLOW_NUM}] ${MODELPARAM_VALUE.FLOW_NUM}
}

proc update_MODELPARAM_VALUE.FLOW_WIDTH { MODELPARAM_VALUE.FLOW_WIDTH PARAM_VALUE.FLOW_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FLOW_WIDTH}] ${MODELPARAM_VALUE.FLOW_WIDTH}
}

proc update_MODELPARAM_VALUE.FRAME_LENGTH_WIDTH { MODELPARAM_VALUE.FRAME_LENGTH_WIDTH PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FRAME_LENGTH_WIDTH}] ${MODELPARAM_VALUE.FRAME_LENGTH_WIDTH}
}

proc update_MODELPARAM_VALUE.TIMESTAMP_WIDTH { MODELPARAM_VALUE.TIMESTAMP_WIDTH PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIMESTAMP_WIDTH}] ${MODELPARAM_VALUE.TIMESTAMP_WIDTH}
}

proc update_MODELPARAM_VALUE.COMMIT_VALUE_WIDTH { MODELPARAM_VALUE.COMMIT_VALUE_WIDTH PARAM_VALUE.COMMIT_VALUE_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.COMMIT_VALUE_WIDTH}] ${MODELPARAM_VALUE.COMMIT_VALUE_WIDTH}
}

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

