
# Loading additional proc with user specified bodies to compute parameter values.
source [file join [file dirname [file dirname [info script]]] gui/axi_gpio_parameters_v1_0.gtcl]

# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_S_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_DATA_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "PROCCESSING_DELAY_MAX" -parent ${Page_0}
  ipgui::add_param $IPINST -name "TIMESTAMP_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_WRITE_REGISTERS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "NUM_OF_READ_REGISTERS" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_PROCESSINGDELAYMAX_OUT" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ENABLE_COMMITHASH_READ" -parent ${Page_0}


}

proc update_PARAM_VALUE.NUM_OF_READ_REGISTERS { PARAM_VALUE.NUM_OF_READ_REGISTERS PARAM_VALUE.ENABLE_COMMITHASH_READ } {
	# Procedure called to update NUM_OF_READ_REGISTERS when any of the dependent parameters in the arguments change
	
	set NUM_OF_READ_REGISTERS ${PARAM_VALUE.NUM_OF_READ_REGISTERS}
	set ENABLE_COMMITHASH_READ ${PARAM_VALUE.ENABLE_COMMITHASH_READ}
	set values(ENABLE_COMMITHASH_READ) [get_property value $ENABLE_COMMITHASH_READ]
	set_property value [gen_USERPARAMETER_NUM_OF_READ_REGISTERS_VALUE $values(ENABLE_COMMITHASH_READ)] $NUM_OF_READ_REGISTERS
}

proc validate_PARAM_VALUE.NUM_OF_READ_REGISTERS { PARAM_VALUE.NUM_OF_READ_REGISTERS } {
	# Procedure called to validate NUM_OF_READ_REGISTERS
	return true
}

proc update_PARAM_VALUE.NUM_OF_WRITE_REGISTERS { PARAM_VALUE.NUM_OF_WRITE_REGISTERS PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT } {
	# Procedure called to update NUM_OF_WRITE_REGISTERS when any of the dependent parameters in the arguments change
	
	set NUM_OF_WRITE_REGISTERS ${PARAM_VALUE.NUM_OF_WRITE_REGISTERS}
	set ENABLE_PROCESSINGDELAYMAX_OUT ${PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT}
	set values(ENABLE_PROCESSINGDELAYMAX_OUT) [get_property value $ENABLE_PROCESSINGDELAYMAX_OUT]
	set_property value [gen_USERPARAMETER_NUM_OF_WRITE_REGISTERS_VALUE $values(ENABLE_PROCESSINGDELAYMAX_OUT)] $NUM_OF_WRITE_REGISTERS
}

proc validate_PARAM_VALUE.NUM_OF_WRITE_REGISTERS { PARAM_VALUE.NUM_OF_WRITE_REGISTERS } {
	# Procedure called to validate NUM_OF_WRITE_REGISTERS
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

proc update_PARAM_VALUE.ENABLE_COMMITHASH_READ { PARAM_VALUE.ENABLE_COMMITHASH_READ } {
	# Procedure called to update ENABLE_COMMITHASH_READ when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_COMMITHASH_READ { PARAM_VALUE.ENABLE_COMMITHASH_READ } {
	# Procedure called to validate ENABLE_COMMITHASH_READ
	return true
}

proc update_PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT { PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT } {
	# Procedure called to update ENABLE_PROCESSINGDELAYMAX_OUT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT { PARAM_VALUE.ENABLE_PROCESSINGDELAYMAX_OUT } {
	# Procedure called to validate ENABLE_PROCESSINGDELAYMAX_OUT
	return true
}

proc update_PARAM_VALUE.PROCCESSING_DELAY_MAX { PARAM_VALUE.PROCCESSING_DELAY_MAX } {
	# Procedure called to update PROCCESSING_DELAY_MAX when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PROCCESSING_DELAY_MAX { PARAM_VALUE.PROCCESSING_DELAY_MAX } {
	# Procedure called to validate PROCCESSING_DELAY_MAX
	return true
}

proc update_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to update TIMESTAMP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TIMESTAMP_WIDTH { PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to validate TIMESTAMP_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.PROCCESSING_DELAY_MAX { MODELPARAM_VALUE.PROCCESSING_DELAY_MAX PARAM_VALUE.PROCCESSING_DELAY_MAX } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PROCCESSING_DELAY_MAX}] ${MODELPARAM_VALUE.PROCCESSING_DELAY_MAX}
}

proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.NUM_OF_WRITE_REGISTERS { MODELPARAM_VALUE.NUM_OF_WRITE_REGISTERS PARAM_VALUE.NUM_OF_WRITE_REGISTERS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_OF_WRITE_REGISTERS}] ${MODELPARAM_VALUE.NUM_OF_WRITE_REGISTERS}
}

proc update_MODELPARAM_VALUE.NUM_OF_READ_REGISTERS { MODELPARAM_VALUE.NUM_OF_READ_REGISTERS PARAM_VALUE.NUM_OF_READ_REGISTERS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.NUM_OF_READ_REGISTERS}] ${MODELPARAM_VALUE.NUM_OF_READ_REGISTERS}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.TIMESTAMP_WIDTH { MODELPARAM_VALUE.TIMESTAMP_WIDTH PARAM_VALUE.TIMESTAMP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TIMESTAMP_WIDTH}] ${MODELPARAM_VALUE.TIMESTAMP_WIDTH}
}

