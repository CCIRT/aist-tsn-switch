<<<<<<< HEAD
=======

# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/credit_based_shaper_v1_0.gtcl]

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
<<<<<<< HEAD
  ipgui::add_page $IPINST -name "Page 0"
=======
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_AXIS_TDATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_AXIS_TKEEP_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "L1_LENGTH_OFFSET" -parent ${Page_0}
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

proc update_PARAM_VALUE.L1_LENGTH_OFFSET { PARAM_VALUE.L1_LENGTH_OFFSET } {
	# Procedure called to update L1_LENGTH_OFFSET when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.L1_LENGTH_OFFSET { PARAM_VALUE.L1_LENGTH_OFFSET } {
	# Procedure called to validate L1_LENGTH_OFFSET
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

proc update_MODELPARAM_VALUE.L1_LENGTH_OFFSET { MODELPARAM_VALUE.L1_LENGTH_OFFSET PARAM_VALUE.L1_LENGTH_OFFSET } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.L1_LENGTH_OFFSET}] ${MODELPARAM_VALUE.L1_LENGTH_OFFSET}
}
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

