
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/et_arbiter_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "KEEP_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_INPUT_PORTS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIMESTAMP_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.KEEP_WIDTH { PARAM_VALUE.KEEP_WIDTH PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update KEEP_WIDTH when any of the dependent parameters in the arguments change
	
	set KEEP_WIDTH ${PARAM_VALUE.KEEP_WIDTH}
	set DATA_WIDTH ${PARAM_VALUE.DATA_WIDTH}
	set values(DATA_WIDTH) [get_property value $DATA_WIDTH]
	set_property value [gen_USERPARAMETER_KEEP_WIDTH_VALUE $values(DATA_WIDTH)] $KEEP_WIDTH
}

proc validate_PARAM_VALUE.KEEP_WIDTH { PARAM_VALUE.KEEP_WIDTH } {
	# Procedure called to validate KEEP_WIDTH
	return true
}

proc update_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to update DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.DATA_WIDTH { PARAM_VALUE.DATA_WIDTH } {
	# Procedure called to validate DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.NUM_INPUT_PORTS { PARAM_VALUE.NUM_INPUT_PORTS } {
	# Procedure called to update NUM_INPUT_PORTS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_INPUT_PORTS { PARAM_VALUE.NUM_INPUT_PORTS } {
	# Procedure called to validate NUM_INPUT_PORTS
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

proc update_MODELPARAM_VALUE.KEEP_WIDTH { MODELPARAM_VALUE.KEEP_WIDTH PARAM_VALUE.KEEP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.KEEP_WIDTH}] ${MODELPARAM_VALUE.KEEP_WIDTH}
}

proc update_MODELPARAM_VALUE.TIMESTAMP_WIDTH { MODELPARAM_VALUE.TIMESTAMP_WIDTH PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIMESTAMP_WIDTH}] ${MODELPARAM_VALUE.TIMESTAMP_WIDTH}
}

proc update_MODELPARAM_VALUE.NUM_INPUT_PORTS { MODELPARAM_VALUE.NUM_INPUT_PORTS PARAM_VALUE.NUM_INPUT_PORTS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_INPUT_PORTS}] ${MODELPARAM_VALUE.NUM_INPUT_PORTS}
}

