# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ETHERNET_FRAME_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "FRAME_LENGTH_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIMESTAMP_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.ETHERNET_FRAME_WIDTH { PARAM_VALUE.ETHERNET_FRAME_WIDTH } {
	# Procedure called to update ETHERNET_FRAME_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ETHERNET_FRAME_WIDTH { PARAM_VALUE.ETHERNET_FRAME_WIDTH } {
	# Procedure called to validate ETHERNET_FRAME_WIDTH
	return true
}

proc update_PARAM_VALUE.FRAME_LENGTH_WIDTH { PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to update FRAME_LENGTH_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FRAME_LENGTH_WIDTH { PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to validate FRAME_LENGTH_WIDTH
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

proc update_MODELPARAM_VALUE.FRAME_LENGTH_WIDTH { MODELPARAM_VALUE.FRAME_LENGTH_WIDTH PARAM_VALUE.FRAME_LENGTH_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FRAME_LENGTH_WIDTH}] ${MODELPARAM_VALUE.FRAME_LENGTH_WIDTH}
}

proc update_MODELPARAM_VALUE.ETHERNET_FRAME_WIDTH { MODELPARAM_VALUE.ETHERNET_FRAME_WIDTH PARAM_VALUE.ETHERNET_FRAME_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ETHERNET_FRAME_WIDTH}] ${MODELPARAM_VALUE.ETHERNET_FRAME_WIDTH}
}

proc update_MODELPARAM_VALUE.TIMESTAMP_WIDTH { MODELPARAM_VALUE.TIMESTAMP_WIDTH PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIMESTAMP_WIDTH}] ${MODELPARAM_VALUE.TIMESTAMP_WIDTH}
}

