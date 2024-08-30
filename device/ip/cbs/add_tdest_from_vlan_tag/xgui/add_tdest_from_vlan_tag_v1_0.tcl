# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_0" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_1" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_2" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_3" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_4" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_5" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_6" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_7" -parent ${Page_0}
  ipgui::add_param $IPINST -name "INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_REGISTERS" -parent ${Page_0}


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

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_0
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_1
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_2
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_3
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_4
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_5
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_6
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_7
	return true
}

proc update_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT } {
	# Procedure called to update INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT { PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT } {
	# Procedure called to validate INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT
	return true
}

proc update_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to update NUM_OF_REGISTERS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.NUM_OF_REGISTERS { PARAM_VALUE.NUM_OF_REGISTERS } {
	# Procedure called to validate NUM_OF_REGISTERS
	return true
}


proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_0}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_1}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_2}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_3}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_4}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_5}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_6}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_7}
}

proc update_MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT { MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT}] ${MODELPARAM_VALUE.INIT_VAL_OF_PRIORITY_MAPPER_DEFAULT}
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

