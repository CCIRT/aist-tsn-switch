# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "CLOCK_PERIOD_PS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIMESTAMP_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.CLOCK_PERIOD_PS { PARAM_VALUE.CLOCK_PERIOD_PS } {
	# Procedure called to update CLOCK_PERIOD_PS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.CLOCK_PERIOD_PS { PARAM_VALUE.CLOCK_PERIOD_PS } {
	# Procedure called to validate CLOCK_PERIOD_PS
	return true
}

proc update_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to update TIMESTAMP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to validate TIMESTAMP_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.TIMESTAMP_WIDTH { MODELPARAM_VALUE.TIMESTAMP_WIDTH PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIMESTAMP_WIDTH}] ${MODELPARAM_VALUE.TIMESTAMP_WIDTH}
}

proc update_MODELPARAM_VALUE.CLOCK_PERIOD_PS { MODELPARAM_VALUE.CLOCK_PERIOD_PS PARAM_VALUE.CLOCK_PERIOD_PS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.CLOCK_PERIOD_PS}] ${MODELPARAM_VALUE.CLOCK_PERIOD_PS}
}

