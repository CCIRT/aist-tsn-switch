
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/ethernet_frame_dropper_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_AXIS_TKEEP_WIDTH" -parent ${Page_0}


}

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


proc update_MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH { MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH PARAM_VALUE.C_AXIS_TKEEP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXIS_TKEEP_WIDTH}] ${MODELPARAM_VALUE.C_AXIS_TKEEP_WIDTH}
}

