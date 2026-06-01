# *************************************************************************
#
# Copyright 2020 Xilinx, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# *************************************************************************

# This file should be read in as unmanaged Tcl constraints to enable the usage
# of if statement
# 300 MHz Bank65
set_property PACKAGE_PIN AL23 [get_ports sysclk_300_clk_n]
set_property PACKAGE_PIN AK23 [get_ports sysclk_300_clk_p]
set_property IOSTANDARD  LVDS [get_ports sysclk_300_clk_n]
set_property IOSTANDARD  LVDS [get_ports sysclk_300_clk_p]
# 100 MHz Bank225
# set_property PACKAGE_PIN AK7 [get_ports sysclk1_100_clk_n]
# set_property PACKAGE_PIN AK8 [get_ports sysclk1_100_clk_p]
# 100 MHz Bank227
# set_property PACKAGE_PIN AE9 [get_ports sysclk2_100_clk_n]
# set_property PACKAGE_PIN AE10 [get_ports sysclk2_100_clk_p]
# 100 MHz Bank228
# set_property PACKAGE_PIN AC9 [get_ports sysclk3_100_clk_n]
# set_property PACKAGE_PIN AC10 [get_ports sysclk3_100_clk_p]

# set_property PACKAGE_PIN AK18 [get_ports pcie_rstn[0]]
# set_property IOSTANDARD LVCMOS18 [get_ports pcie_rstn[0]]

# GTM Ref Clock 161.1328125Mhz Bank 234
set_property PACKAGE_PIN G9  [get_ports dual0_gtm_refclk_clk_n]
set_property PACKAGE_PIN G10 [get_ports dual0_gtm_refclk_clk_p]
# GTM Ref Clock 161.1328125Mhz Bank 233
set_property PACKAGE_PIN J9  [get_ports dual1_gtm_refclk_clk_n]
set_property PACKAGE_PIN J10 [get_ports dual1_gtm_refclk_clk_p]
# GTY Ref Clock 161.1328125Mhz Bank 231
set_property PACKAGE_PIN P8 [get_ports gty_refclk_clk_n]
set_property PACKAGE_PIN P9 [get_ports gty_refclk_clk_p]

#unplace all GTs
#unplace_cell [get_cells -hierarchical -filter {NAME =~ *qdma_wrapper_arm*gen_channel_container[*].*gen_gtye4_channel_inst[*].GTYE4_CHANNEL_PRIM_INST}]
#unplace_cell [get_cells -hierarchical -filter {NAME =~ *qdma_wrapper_inst*gen_channel_container[*].*gen_gtye4_channel_inst[*].GTYE4_CHANNEL_PRIM_INST}]

# unplace_cell [get_cells cmac_port[0].cmac_subsystem_inst/cmac_wrapper_inst/cmac_inst/inst/i_cmac_usplus_0_gtm/inst/dual0/gtm_dual_inst]
# unplace_cell [get_cells cmac_port[0].cmac_subsystem_inst/cmac_wrapper_inst/cmac_inst/inst/i_cmac_usplus_0_gtm/inst/dual1/gtm_dual_inst]

set_property PACKAGE_PIN AN27                [get_ports "c0_sys_clk_p"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_SYSCLK_P        - IO_L13P_T2L_N0_GC_QBC_66
set_property IOSTANDARD  LVDS                [get_ports "c0_sys_clk_p"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_SYSCLK_P        - IO_L13P_T2L_N0_GC_QBC_66
#create_clock -period 3.332 -name c0sysclk           [get_ports "c0_sys_clk_p"]

##################################################################################################################################################################
##
##				Input Clocks for Gen3 x16  or Dual x8 Bifurcation on Lane 8-15
##				PCIe 100Mhz Host clock
##
##################################################################################################################################################################
set_property PACKAGE_PIN AL9                 [get_ports "diff_clock_rtl_0_clk_n"]              ;# Bank 225 - MGTREFCLK0N_225
set_property PACKAGE_PIN AL10                [get_ports "diff_clock_rtl_0_clk_p"]              ;# Bank 225 - MGTREFCLK0P_225
create_clock -period 10.000 -name pcierefclk0 [get_ports {diff_clock_rtl_0_clk_p}]
#set_property PACKAGE_PIN AF7                 [get_ports "diff_clock_rtl_1_clk_n"]              ;# Bank 227 - MGTREFCLK0N_227
#set_property PACKAGE_PIN AF8                 [get_ports "diff_clock_rtl_1_clk_p"]              ;# Bank 227 - MGTREFCLK0P_227
#create_clock -period 10.000 -name pcierefclk1         [get_ports "diff_clock_rtl_1_clk_p"]

##################################################################################################################################################################
##
##	PCIE_PERST_LS_65 Active low input from PCIe Connector to FPGA to detect the Active low Reset.
##  PEX_PWRBRKN_FPGA_65 Active low input from PCIe Connector Signaling PCIe card to shut down card power in Server failing condition.
##
##################################################################################################################################################################
#set_property PACKAGE_PIN AK18                [get_ports "PCIE_PERST_LS_65"]            ;# Bank  65 VCCO - 1V8                                    - IO_T3U_N12_PERSTN0_65
#set_property IOSTANDARD  LVCMOS18            [get_ports "PCIE_PERST_LS_65"]            ;# Bank  65 VCCO - 1V8                                    - IO_T3U_N12_PERSTN0_65
#set_property PACKAGE_PIN AM20                [get_ports "PEX_PWRBRKN_FPGA_65"]         ;# Bank  65 VCCO - 1V8                                    - IO_L17N_T2U_N9_AD10N_D15_65
#set_property IOSTANDARD  LVCMOS18            [get_ports "PEX_PWRBRKN_FPGA_65"]         ;# Bank  65 VCCO - 1V8                                    - IO_L17N_T2U_N9_AD10N_D15_65
set_property PACKAGE_PIN AK18                [get_ports "reset_rtl_0"]            ;# Bank  65 VCCO - 1V8                                    - IO_T3U_N12_PERSTN0_65
set_property IOSTANDARD  LVCMOS18            [get_ports "reset_rtl_0"]            ;# Bank  65 VCCO - 1V8                                    - IO_T3U_N12_PERSTN0_65

#################################################################################################################################################################
#
# DDR4 DRAM Controller 1, Channel 0, 72-bit Data Interface, x16 data width
#
#################################################################################################################################################################
set_property PACKAGE_PIN AT30                [get_ports "c0_ddr4_adr[0]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A0              - IO_L6N_T0U_N11_AD6N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[0]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A0              - IO_L6N_T0U_N11_AD6N_66
set_property PACKAGE_PIN AT31                [get_ports "c0_ddr4_adr[10]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A10             - IO_L5N_T0U_N9_AD14N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[10]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A10             - IO_L5N_T0U_N9_AD14N_66
set_property PACKAGE_PIN AP26                [get_ports "c0_ddr4_adr[11]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A11             - IO_L12P_T1U_N10_GC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[11]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A11             - IO_L12P_T1U_N10_GC_66
set_property PACKAGE_PIN AL31                [get_ports "c0_ddr4_adr[12]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A12             - IO_L1N_T0L_N1_DBC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[12]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A12             - IO_L1N_T0L_N1_DBC_66
set_property PACKAGE_PIN AN29                [get_ports "c0_ddr4_adr[13]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A13             - IO_L3P_T0L_N4_AD15P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[13]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_A13             - IO_L3P_T0L_N4_AD15P_66
set_property PACKAGE_PIN AJ27                [get_ports "c0_ddr4_adr[1]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A1              - IO_L17P_T2U_N8_AD10P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[1]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A1              - IO_L17P_T2U_N8_AD10P_66
set_property PACKAGE_PIN AP30                [get_ports "c0_ddr4_adr[2]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A2              - IO_L4N_T0U_N7_DBC_AD7N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[2]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A2              - IO_L4N_T0U_N7_DBC_AD7N_66
set_property PACKAGE_PIN AM31                [get_ports "c0_ddr4_adr[3]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A3              - IO_L2N_T0L_N3_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[3]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A3              - IO_L2N_T0L_N3_66
set_property PACKAGE_PIN AM30                [get_ports "c0_ddr4_adr[4]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A4              - IO_L2P_T0L_N2_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[4]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A4              - IO_L2P_T0L_N2_66
set_property PACKAGE_PIN AP29                [get_ports "c0_ddr4_adr[5]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A5              - IO_L4P_T0U_N6_DBC_AD7P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[5]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A5              - IO_L4P_T0U_N6_DBC_AD7P_66
set_property PACKAGE_PIN AU25                [get_ports "c0_ddr4_adr[6]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A6              - IO_T1U_N12_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[6]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A6              - IO_T1U_N12_66
set_property PACKAGE_PIN AP27                [get_ports "c0_ddr4_adr[7]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A7              - IO_L12N_T1U_N11_GC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[7]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A7              - IO_L12N_T1U_N11_GC_66
set_property PACKAGE_PIN AR26                [get_ports "c0_ddr4_adr[8]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A8              - IO_L11P_T1U_N8_GC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[8]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A8              - IO_L11P_T1U_N8_GC_66
set_property PACKAGE_PIN AL26                [get_ports "c0_ddr4_adr[9]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A9              - IO_L16N_T2U_N7_QBC_AD3N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[9]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_A9              - IO_L16N_T2U_N7_QBC_AD3N_66
set_property PACKAGE_PIN AN30                [get_ports "c0_ddr4_act_n"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_ACT_B           - IO_L3N_T0L_N5_AD15N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_act_n"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_ACT_B           - IO_L3N_T0L_N5_AD15N_66
set_property PACKAGE_PIN AK26                [get_ports "c0_ddr4_alert_n"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_ALERT_B         - IO_L16P_T2U_N6_QBC_AD3P_66
set_property IOSTANDARD  LVCMOS12            [get_ports "c0_ddr4_alert_n"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_ALERT_B         - IO_L16P_T2U_N6_QBC_AD3P_66
set_property PACKAGE_PIN AT26                [get_ports "c0_ddr4_ba[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BA0             - IO_L10P_T1U_N6_QBC_AD4P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_ba[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BA0             - IO_L10P_T1U_N6_QBC_AD4P_66
set_property PACKAGE_PIN AU27                [get_ports "c0_ddr4_ba[1]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BA1             - IO_L9P_T1L_N4_AD12P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_ba[1]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BA1             - IO_L9P_T1L_N4_AD12P_66
set_property PACKAGE_PIN AU26                [get_ports "c0_ddr4_bg[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BG0             - IO_L10N_T1U_N7_QBC_AD4N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_bg[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_BG0             - IO_L10N_T1U_N7_QBC_AD4N_66
set_property PACKAGE_PIN AR28                [get_ports "c0_ddr4_adr[15]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CAS_B           - IO_L8P_T1L_N2_AD5P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[15]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CAS_B           - IO_L8P_T1L_N2_AD5P_66
set_property PACKAGE_PIN AU30                [get_ports "c0_ddr4_ck_c[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CK0_C           - IO_L7N_T1L_N1_QBC_AD13N_66
set_property IOSTANDARD  DIFF_SSTL12_DCI     [get_ports "c0_ddr4_ck_c[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CK0_C           - IO_L7N_T1L_N1_QBC_AD13N_66
set_property PACKAGE_PIN AT29                [get_ports "c0_ddr4_ck_t[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CK0_T           - IO_L7P_T1L_N0_QBC_AD13P_66
set_property IOSTANDARD  DIFF_SSTL12_DCI     [get_ports "c0_ddr4_ck_t[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CK0_T           - IO_L7P_T1L_N0_QBC_AD13P_66
set_property PACKAGE_PIN AT28                [get_ports "c0_ddr4_cke[0]"]              ;# Bank  66 VCCO  -          -Net DDR4_C0_CKE0            - IO_L8N_T1L_N3_AD5N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_cke[0]"]              ;# Bank  66 VCCO  -          -Net DDR4_C0_CKE0            - IO_L8N_T1L_N3_AD5N_66
set_property PACKAGE_PIN AL30                [get_ports "c0_ddr4_cs_n[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CS0_B           - IO_L1P_T0L_N0_DBC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_cs_n[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_CS0_B           - IO_L1P_T0L_N0_DBC_66
set_property PACKAGE_PIN AK29                [get_ports "c0_ddr4_dm_n[0]"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_DM_B0           - IO_L19P_T3L_N0_DBC_AD9P_66
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[0]"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_DM_B0           - IO_L19P_T3L_N0_DBC_AD9P_66
set_property PACKAGE_PIN AN37                [get_ports "c0_ddr4_dm_n[1]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B1           - IO_L7P_T1L_N0_QBC_AD13P_67
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[1]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B1           - IO_L7P_T1L_N0_QBC_AD13P_67
set_property PACKAGE_PIN Y33                 [get_ports "c0_ddr4_dm_n[2]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B2           - IO_L19P_T3L_N0_DBC_AD9P_68
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[2]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B2           - IO_L19P_T3L_N0_DBC_AD9P_68
set_property PACKAGE_PIN AB36                [get_ports "c0_ddr4_dm_n[3]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B3           - IO_L1P_T0L_N0_DBC_68
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[3]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B3           - IO_L1P_T0L_N0_DBC_68
set_property PACKAGE_PIN AM36                [get_ports "c0_ddr4_dm_n[4]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B4           - IO_L13P_T2L_N0_GC_QBC_67
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[4]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B4           - IO_L13P_T2L_N0_GC_QBC_67
set_property PACKAGE_PIN AH37                [get_ports "c0_ddr4_dm_n[5]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B5           - IO_L19P_T3L_N0_DBC_AD9P_67
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[5]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B5           - IO_L19P_T3L_N0_DBC_AD9P_67
set_property PACKAGE_PIN AC37                [get_ports "c0_ddr4_dm_n[6]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B6           - IO_L7P_T1L_N0_QBC_AD13P_68
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[6]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B6           - IO_L7P_T1L_N0_QBC_AD13P_68
set_property PACKAGE_PIN AE32                [get_ports "c0_ddr4_dm_n[7]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B7           - IO_L13P_T2L_N0_GC_QBC_68
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[7]"]             ;# Bank  68 VCCO  -          -Net DDR4_C0_DM_B7           - IO_L13P_T2L_N0_GC_QBC_68
set_property PACKAGE_PIN AU31                [get_ports "c0_ddr4_dm_n[8]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B8           - IO_L1P_T0L_N0_DBC_67
set_property IOSTANDARD  POD12_DCI          [get_ports "c0_ddr4_dm_n[8]"]             ;# Bank  67 VCCO  -          -Net DDR4_C0_DM_B8           - IO_L1P_T0L_N0_DBC_67
set_property PACKAGE_PIN AJ29                [get_ports "c0_ddr4_dq[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ0             - IO_L21N_T3L_N5_AD8N_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[0]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ0             - IO_L21N_T3L_N5_AD8N_66
set_property PACKAGE_PIN AR37                [get_ports "c0_ddr4_dq[10]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ10            - IO_L8N_T1L_N3_AD5N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[10]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ10            - IO_L8N_T1L_N3_AD5N_67
set_property PACKAGE_PIN AN35                [get_ports "c0_ddr4_dq[11]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ11            - IO_L12N_T1U_N11_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[11]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ11            - IO_L12N_T1U_N11_GC_67
set_property PACKAGE_PIN AN33                [get_ports "c0_ddr4_dq[12]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ12            - IO_L9P_T1L_N4_AD12P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[12]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ12            - IO_L9P_T1L_N4_AD12P_67
set_property PACKAGE_PIN AN34                [get_ports "c0_ddr4_dq[13]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ13            - IO_L11N_T1U_N9_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[13]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ13            - IO_L11N_T1U_N9_GC_67
set_property PACKAGE_PIN AP34                [get_ports "c0_ddr4_dq[14]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ14            - IO_L9N_T1L_N5_AD12N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[14]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ14            - IO_L9N_T1L_N5_AD12N_67
set_property PACKAGE_PIN AM33                [get_ports "c0_ddr4_dq[15]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ15            - IO_L11P_T1U_N8_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[15]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ15            - IO_L11P_T1U_N8_GC_67
set_property PACKAGE_PIN AA29                [get_ports "c0_ddr4_dq[16]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ16            - IO_L24N_T3U_N11_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[16]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ16            - IO_L24N_T3U_N11_68
set_property PACKAGE_PIN W32                 [get_ports "c0_ddr4_dq[17]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ17            - IO_L20P_T3L_N2_AD1P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[17]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ17            - IO_L20P_T3L_N2_AD1P_68
set_property PACKAGE_PIN Y32                 [get_ports "c0_ddr4_dq[18]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ18            - IO_L20N_T3L_N3_AD1N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[18]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ18            - IO_L20N_T3L_N3_AD1N_68
set_property PACKAGE_PIN W31                 [get_ports "c0_ddr4_dq[19]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ19            - IO_L23N_T3U_N9_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[19]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ19            - IO_L23N_T3U_N9_68
set_property PACKAGE_PIN AJ31                [get_ports "c0_ddr4_dq[1]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ1             - IO_L20N_T3L_N3_AD1N_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[1]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ1             - IO_L20N_T3L_N3_AD1N_66
set_property PACKAGE_PIN AB32                [get_ports "c0_ddr4_dq[20]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ20            - IO_L21N_T3L_N5_AD8N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[20]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ20            - IO_L21N_T3L_N5_AD8N_68
set_property PACKAGE_PIN W30                 [get_ports "c0_ddr4_dq[21]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ21            - IO_L23P_T3U_N8_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[21]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ21            - IO_L23P_T3U_N8_68
set_property PACKAGE_PIN AB31                [get_ports "c0_ddr4_dq[22]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ22            - IO_L21P_T3L_N4_AD8P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[22]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ22            - IO_L21P_T3L_N4_AD8P_68
set_property PACKAGE_PIN Y29                 [get_ports "c0_ddr4_dq[23]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ23            - IO_L24P_T3U_N10_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[23]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ23            - IO_L24P_T3U_N10_68
set_property PACKAGE_PIN AA35                [get_ports "c0_ddr4_dq[24]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ24            - IO_L5N_T0U_N9_AD14N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[24]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ24            - IO_L5N_T0U_N9_AD14N_68
set_property PACKAGE_PIN Y34                 [get_ports "c0_ddr4_dq[25]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ25            - IO_L5P_T0U_N8_AD14P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[25]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ25            - IO_L5P_T0U_N8_AD14P_68
set_property PACKAGE_PIN Y36                 [get_ports "c0_ddr4_dq[26]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ26            - IO_L2P_T0L_N2_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[26]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ26            - IO_L2P_T0L_N2_68
set_property PACKAGE_PIN W37                 [get_ports "c0_ddr4_dq[27]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ27            - IO_L3N_T0L_N5_AD15N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[27]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ27            - IO_L3N_T0L_N5_AD15N_68
set_property PACKAGE_PIN AB35                [get_ports "c0_ddr4_dq[28]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ28            - IO_L6N_T0U_N11_AD6N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[28]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ28            - IO_L6N_T0U_N11_AD6N_68
set_property PACKAGE_PIN AA34                [get_ports "c0_ddr4_dq[29]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ29            - IO_L6P_T0U_N10_AD6P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[29]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ29            - IO_L6P_T0U_N10_AD6P_68
set_property PACKAGE_PIN AF30                [get_ports "c0_ddr4_dq[2]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ2             - IO_L23N_T3U_N9_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[2]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ2             - IO_L23N_T3U_N9_66
set_property PACKAGE_PIN AA36                [get_ports "c0_ddr4_dq[30]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ30            - IO_L2N_T0L_N3_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[30]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ30            - IO_L2N_T0L_N3_68
set_property PACKAGE_PIN W36                 [get_ports "c0_ddr4_dq[31]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ31            - IO_L3P_T0L_N4_AD15P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[31]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ31            - IO_L3P_T0L_N4_AD15P_68
set_property PACKAGE_PIN AL35                [get_ports "c0_ddr4_dq[32]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ32            - IO_L14P_T2L_N2_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[32]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ32            - IO_L14P_T2L_N2_GC_67
set_property PACKAGE_PIN AK37                [get_ports "c0_ddr4_dq[33]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ33            - IO_L17N_T2U_N9_AD10N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[33]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ33            - IO_L17N_T2U_N9_AD10N_67
set_property PACKAGE_PIN AL36                [get_ports "c0_ddr4_dq[34]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ34            - IO_L14N_T2L_N3_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[34]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ34            - IO_L14N_T2L_N3_GC_67
set_property PACKAGE_PIN AK36                [get_ports "c0_ddr4_dq[35]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ35            - IO_L17P_T2U_N8_AD10P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[35]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ35            - IO_L17P_T2U_N8_AD10P_67
set_property PACKAGE_PIN AL34                [get_ports "c0_ddr4_dq[36]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ36            - IO_L15N_T2L_N5_AD11N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[36]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ36            - IO_L15N_T2L_N5_AD11N_67
set_property PACKAGE_PIN AJ35                [get_ports "c0_ddr4_dq[37]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ37            - IO_L18P_T2U_N10_AD2P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[37]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ37            - IO_L18P_T2U_N10_AD2P_67
set_property PACKAGE_PIN AL33                [get_ports "c0_ddr4_dq[38]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ38            - IO_L15P_T2L_N4_AD11P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[38]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ38            - IO_L15P_T2L_N4_AD11P_67
set_property PACKAGE_PIN AJ36                [get_ports "c0_ddr4_dq[39]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ39            - IO_L18N_T2U_N11_AD2N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[39]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ39            - IO_L18N_T2U_N11_AD2N_67
set_property PACKAGE_PIN AF29                [get_ports "c0_ddr4_dq[3]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ3             - IO_L23P_T3U_N8_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[3]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ3             - IO_L23P_T3U_N8_66
set_property PACKAGE_PIN AG37                [get_ports "c0_ddr4_dq[40]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ40            - IO_L24N_T3U_N11_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[40]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ40            - IO_L24N_T3U_N11_67
set_property PACKAGE_PIN AH32                [get_ports "c0_ddr4_dq[41]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ41            - IO_L21P_T3L_N4_AD8P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[41]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ41            - IO_L21P_T3L_N4_AD8P_67
set_property PACKAGE_PIN AH34                [get_ports "c0_ddr4_dq[42]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ42            - IO_L20P_T3L_N2_AD1P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[42]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ42            - IO_L20P_T3L_N2_AD1P_67
set_property PACKAGE_PIN AG35                [get_ports "c0_ddr4_dq[43]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ43            - IO_L23P_T3U_N8_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[43]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ43            - IO_L23P_T3U_N8_67
set_property PACKAGE_PIN AH35                [get_ports "c0_ddr4_dq[44]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ44            - IO_L23N_T3U_N9_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[44]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ44            - IO_L23N_T3U_N9_67
set_property PACKAGE_PIN AJ32                [get_ports "c0_ddr4_dq[45]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ45            - IO_L21N_T3L_N5_AD8N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[45]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ45            - IO_L21N_T3L_N5_AD8N_67
set_property PACKAGE_PIN AJ34                [get_ports "c0_ddr4_dq[46]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ46            - IO_L20N_T3L_N3_AD1N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[46]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ46            - IO_L20N_T3L_N3_AD1N_67
set_property PACKAGE_PIN AG36                [get_ports "c0_ddr4_dq[47]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ47            - IO_L24P_T3U_N10_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[47]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ47            - IO_L24P_T3U_N10_67
set_property PACKAGE_PIN AE36                [get_ports "c0_ddr4_dq[48]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ48            - IO_L9P_T1L_N4_AD12P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[48]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ48            - IO_L9P_T1L_N4_AD12P_68
set_property PACKAGE_PIN AF34                [get_ports "c0_ddr4_dq[49]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ49            - IO_L12N_T1U_N11_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[49]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ49            - IO_L12N_T1U_N11_GC_68
set_property PACKAGE_PIN AH29                [get_ports "c0_ddr4_dq[4]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ4             - IO_L21P_T3L_N4_AD8P_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[4]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ4             - IO_L21P_T3L_N4_AD8P_66
set_property PACKAGE_PIN AD36                [get_ports "c0_ddr4_dq[50]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ50            - IO_L8P_T1L_N2_AD5P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[50]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ50            - IO_L8P_T1L_N2_AD5P_68
set_property PACKAGE_PIN AC34                [get_ports "c0_ddr4_dq[51]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ51            - IO_L11P_T1U_N8_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[51]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ51            - IO_L11P_T1U_N8_GC_68
set_property PACKAGE_PIN AF36                [get_ports "c0_ddr4_dq[52]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ52            - IO_L9N_T1L_N5_AD12N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[52]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ52            - IO_L9N_T1L_N5_AD12N_68
set_property PACKAGE_PIN AE34                [get_ports "c0_ddr4_dq[53]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ53            - IO_L12P_T1U_N10_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[53]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ53            - IO_L12P_T1U_N10_GC_68
set_property PACKAGE_PIN AE37                [get_ports "c0_ddr4_dq[54]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ54            - IO_L8N_T1L_N3_AD5N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[54]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ54            - IO_L8N_T1L_N3_AD5N_68
set_property PACKAGE_PIN AD34                [get_ports "c0_ddr4_dq[55]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ55            - IO_L11N_T1U_N9_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[55]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ55            - IO_L11N_T1U_N9_GC_68
set_property PACKAGE_PIN AB33                [get_ports "c0_ddr4_dq[56]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ56            - IO_L18P_T2U_N10_AD2P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[56]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ56            - IO_L18P_T2U_N10_AD2P_68
set_property PACKAGE_PIN AD30                [get_ports "c0_ddr4_dq[57]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ57            - IO_L14P_T2L_N2_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[57]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ57            - IO_L14P_T2L_N2_GC_68
set_property PACKAGE_PIN AC33                [get_ports "c0_ddr4_dq[58]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ58            - IO_L18N_T2U_N11_AD2N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[58]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ58            - IO_L18N_T2U_N11_AD2N_68
set_property PACKAGE_PIN AD29                [get_ports "c0_ddr4_dq[59]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ59            - IO_L15N_T2L_N5_AD11N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[59]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ59            - IO_L15N_T2L_N5_AD11N_68
set_property PACKAGE_PIN AG31                [get_ports "c0_ddr4_dq[5]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ5             - IO_L24N_T3U_N11_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[5]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ5             - IO_L24N_T3U_N11_66
set_property PACKAGE_PIN AE31                [get_ports "c0_ddr4_dq[60]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ60            - IO_L14N_T2L_N3_GC_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[60]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ60            - IO_L14N_T2L_N3_GC_68
set_property PACKAGE_PIN AC29                [get_ports "c0_ddr4_dq[61]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ61            - IO_L15P_T2L_N4_AD11P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[61]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ61            - IO_L15P_T2L_N4_AD11P_68
set_property PACKAGE_PIN AD32                [get_ports "c0_ddr4_dq[62]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ62            - IO_L17N_T2U_N9_AD10N_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[62]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ62            - IO_L17N_T2U_N9_AD10N_68
set_property PACKAGE_PIN AC32                [get_ports "c0_ddr4_dq[63]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ63            - IO_L17P_T2U_N8_AD10P_68
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[63]"]              ;# Bank  68 VCCO  -          -Net DDR4_C0_DQ63            - IO_L17P_T2U_N8_AD10P_68
set_property PACKAGE_PIN AT33                [get_ports "c0_ddr4_dq[64]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ64            - IO_L2P_T0L_N2_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[64]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ64            - IO_L2P_T0L_N2_67
set_property PACKAGE_PIN AT36                [get_ports "c0_ddr4_dq[65]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ65            - IO_L5N_T0U_N9_AD14N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[65]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ65            - IO_L5N_T0U_N9_AD14N_67
set_property PACKAGE_PIN AR33                [get_ports "c0_ddr4_dq[66]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ66            - IO_L3N_T0L_N5_AD15N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[66]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ66            - IO_L3N_T0L_N5_AD15N_67
set_property PACKAGE_PIN AR36                [get_ports "c0_ddr4_dq[67]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ67            - IO_L6N_T0U_N11_AD6N_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[67]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ67            - IO_L6N_T0U_N11_AD6N_67
set_property PACKAGE_PIN AR32                [get_ports "c0_ddr4_dq[68]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ68            - IO_L3P_T0L_N4_AD15P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[68]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ68            - IO_L3P_T0L_N4_AD15P_67
set_property PACKAGE_PIN AT35                [get_ports "c0_ddr4_dq[69]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ69            - IO_L5P_T0U_N8_AD14P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[69]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ69            - IO_L5P_T0U_N8_AD14P_67
set_property PACKAGE_PIN AJ30                [get_ports "c0_ddr4_dq[6]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ6             - IO_L20P_T3L_N2_AD1P_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[6]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ6             - IO_L20P_T3L_N2_AD1P_66
set_property PACKAGE_PIN AU33                [get_ports "c0_ddr4_dq[70]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ70            - IO_L2N_T0L_N3_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[70]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ70            - IO_L2N_T0L_N3_67
set_property PACKAGE_PIN AP35                [get_ports "c0_ddr4_dq[71]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ71            - IO_L6P_T0U_N10_AD6P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[71]"]              ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ71            - IO_L6P_T0U_N10_AD6P_67
set_property PACKAGE_PIN AF31                [get_ports "c0_ddr4_dq[7]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ7             - IO_L24P_T3U_N10_66
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[7]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_DQ7             - IO_L24P_T3U_N10_66
set_property PACKAGE_PIN AP36                [get_ports "c0_ddr4_dq[8]"]               ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ8             - IO_L8P_T1L_N2_AD5P_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[8]"]               ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ8             - IO_L8P_T1L_N2_AD5P_67
set_property PACKAGE_PIN AM35                [get_ports "c0_ddr4_dq[9]"]               ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ9             - IO_L12P_T1U_N10_GC_67
set_property IOSTANDARD  POD12_DCI           [get_ports "c0_ddr4_dq[9]"]               ;# Bank  67 VCCO  -          -Net DDR4_C0_DQ9             - IO_L12P_T1U_N10_GC_67
set_property PACKAGE_PIN AH30                [get_ports "c0_ddr4_dqs_c[0]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_DQS_C0          - IO_L22N_T3U_N7_DBC_AD0N_66
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[0]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_DQS_C0          - IO_L22N_T3U_N7_DBC_AD0N_66
set_property PACKAGE_PIN AN32                [get_ports "c0_ddr4_dqs_c[1]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C1          - IO_L10N_T1U_N7_QBC_AD4N_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[1]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C1          - IO_L10N_T1U_N7_QBC_AD4N_67
set_property PACKAGE_PIN AA31                [get_ports "c0_ddr4_dqs_c[2]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C2          - IO_L22N_T3U_N7_DBC_AD0N_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[2]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C2          - IO_L22N_T3U_N7_DBC_AD0N_68
set_property PACKAGE_PIN W35                 [get_ports "c0_ddr4_dqs_c[3]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C3          - IO_L4N_T0U_N7_DBC_AD7N_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[3]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C3          - IO_L4N_T0U_N7_DBC_AD7N_68
set_property PACKAGE_PIN AK34                [get_ports "c0_ddr4_dqs_c[4]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C4          - IO_L16N_T2U_N7_QBC_AD3N_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[4]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C4          - IO_L16N_T2U_N7_QBC_AD3N_67
set_property PACKAGE_PIN AG33                [get_ports "c0_ddr4_dqs_c[5]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C5          - IO_L22N_T3U_N7_DBC_AD0N_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[5]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C5          - IO_L22N_T3U_N7_DBC_AD0N_67
set_property PACKAGE_PIN AD35                [get_ports "c0_ddr4_dqs_c[6]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C6          - IO_L10N_T1U_N7_QBC_AD4N_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[6]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C6          - IO_L10N_T1U_N7_QBC_AD4N_68
set_property PACKAGE_PIN AD31                [get_ports "c0_ddr4_dqs_c[7]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C7          - IO_L16N_T2U_N7_QBC_AD3N_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[7]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_C7          - IO_L16N_T2U_N7_QBC_AD3N_68
set_property PACKAGE_PIN AU35                [get_ports "c0_ddr4_dqs_c[8]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C8          - IO_L4N_T0U_N7_DBC_AD7N_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_c[8]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_C8          - IO_L4N_T0U_N7_DBC_AD7N_67
set_property PACKAGE_PIN AG30                [get_ports "c0_ddr4_dqs_t[0]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_DQS_T0          - IO_L22P_T3U_N6_DBC_AD0P_66
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[0]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_DQS_T0          - IO_L22P_T3U_N6_DBC_AD0P_66
set_property PACKAGE_PIN AM32                [get_ports "c0_ddr4_dqs_t[1]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T1          - IO_L10P_T1U_N6_QBC_AD4P_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[1]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T1          - IO_L10P_T1U_N6_QBC_AD4P_67
set_property PACKAGE_PIN Y31                 [get_ports "c0_ddr4_dqs_t[2]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T2          - IO_L22P_T3U_N6_DBC_AD0P_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[2]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T2          - IO_L22P_T3U_N6_DBC_AD0P_68
set_property PACKAGE_PIN W34                 [get_ports "c0_ddr4_dqs_t[3]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T3          - IO_L4P_T0U_N6_DBC_AD7P_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[3]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T3          - IO_L4P_T0U_N6_DBC_AD7P_68
set_property PACKAGE_PIN AK33                [get_ports "c0_ddr4_dqs_t[4]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T4          - IO_L16P_T2U_N6_QBC_AD3P_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[4]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T4          - IO_L16P_T2U_N6_QBC_AD3P_67
set_property PACKAGE_PIN AF33                [get_ports "c0_ddr4_dqs_t[5]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T5          - IO_L22P_T3U_N6_DBC_AD0P_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[5]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T5          - IO_L22P_T3U_N6_DBC_AD0P_67
set_property PACKAGE_PIN AC35                [get_ports "c0_ddr4_dqs_t[6]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T6          - IO_L10P_T1U_N6_QBC_AD4P_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[6]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T6          - IO_L10P_T1U_N6_QBC_AD4P_68
set_property PACKAGE_PIN AC30                [get_ports "c0_ddr4_dqs_t[7]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T7          - IO_L16P_T2U_N6_QBC_AD3P_68
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[7]"]            ;# Bank  68 VCCO  -          -Net DDR4_C0_DQS_T7          - IO_L16P_T2U_N6_QBC_AD3P_68
set_property PACKAGE_PIN AT34                [get_ports "c0_ddr4_dqs_t[8]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T8          - IO_L4P_T0U_N6_DBC_AD7P_67
set_property IOSTANDARD  DIFF_POD12_DCI      [get_ports "c0_ddr4_dqs_t[8]"]            ;# Bank  67 VCCO  -          -Net DDR4_C0_DQS_T8          - IO_L4P_T0U_N6_DBC_AD7P_67
set_property PACKAGE_PIN AR31                [get_ports "c0_ddr4_odt[0]"]              ;# Bank  66 VCCO  -          -Net DDR4_C0_ODT0            - IO_L5P_T0U_N8_AD14P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_odt[0]"]              ;# Bank  66 VCCO  -          -Net DDR4_C0_ODT0            - IO_L5P_T0U_N8_AD14P_66
set_property PACKAGE_PIN AR29                [get_ports "c0_ddr4_parity[]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_PARITY          - IO_L6P_T0U_N10_AD6P_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_parity[]"]            ;# Bank  66 VCCO  -          -Net DDR4_C0_PARITY          - IO_L6P_T0U_N10_AD6P_66
set_property PACKAGE_PIN AU28                [get_ports "c0_ddr4_adr[16]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_RAS_B           - IO_L9N_T1L_N5_AD12N_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[16]"]               ;# Bank  66 VCCO  -          -Net DDR4_C0_RAS_B           - IO_L9N_T1L_N5_AD12N_66
set_property PACKAGE_PIN AK31                [get_ports "c0_ddr4_reset_n"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_RESET_B_FPGA    - IO_T3U_N12_66
set_property IOSTANDARD  LVCMOS12            [get_ports "c0_ddr4_reset_n"]             ;# Bank  66 VCCO  -          -Net DDR4_C0_RESET_B_FPGA    - IO_T3U_N12_66
set_property PACKAGE_PIN AR27                [get_ports "c0_ddr4_adr[14]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_WE_B            - IO_L11N_T1U_N9_GC_66
set_property IOSTANDARD  SSTL12_DCI          [get_ports "c0_ddr4_adr[14]"]                ;# Bank  66 VCCO  -          -Net DDR4_C0_WE_B            - IO_L11N_T1U_N9_GC_66
#make_diff_pair_ports c0_ddr4_ck_t[0] c0_ddr4_ck_c[0]
#make_diff_pair_ports c0_ddr4_dqs_t[0] c0_ddr4_dqs_c[0]
#make_diff_pair_ports c0_ddr4_dqs_t[1] c0_ddr4_dqs_c[1]
#make_diff_pair_ports c0_ddr4_dqs_t[2] c0_ddr4_dqs_c[2]
#make_diff_pair_ports c0_ddr4_dqs_t[3] c0_ddr4_dqs_c[3]
#make_diff_pair_ports c0_ddr4_dqs_t[4] c0_ddr4_dqs_c[4]
#make_diff_pair_ports c0_ddr4_dqs_t[5] c0_ddr4_dqs_c[5]
#make_diff_pair_ports c0_ddr4_dqs_t[6] c0_ddr4_dqs_c[6]
#make_diff_pair_ports c0_ddr4_dqs_t[7] c0_ddr4_dqs_c[7]
#make_diff_pair_ports c0_ddr4_dqs_t[8] c0_ddr4_dqs_c[8]

 ##################################################################################################################################################################
#
#        		 GTY Lanes Connected to PCIe Edge Fingers
#
##################################################################################################################################################################
# set_property PACKAGE_PIN AF3                 [get_ports "pcie_rxn[0]"]                   ;# Bank 227 - MGTYRXN3_227
# set_property PACKAGE_PIN AF4                 [get_ports "pcie_rxp[0]"]                   ;# Bank 227 - MGTYRXP3_227
# set_property PACKAGE_PIN AT7                 [get_ports "pcie_rxn[10]"]                  ;# Bank 225 - MGTYRXN1_225
# set_property PACKAGE_PIN AT8                 [get_ports "pcie_rxp[10]"]                  ;# Bank 225 - MGTYRXP1_225
# set_property PACKAGE_PIN AU9                 [get_ports "pcie_rxn[11]"]                  ;# Bank 225 - MGTYRXN0_225
# set_property PACKAGE_PIN AU10                [get_ports "pcie_rxp[11]"]                  ;# Bank 225 - MGTYRXP0_225
# set_property PACKAGE_PIN AU13                [get_ports "pcie_rxn[12]"]                  ;# Bank 224 - MGTYRXN3_224
# set_property PACKAGE_PIN AU14                [get_ports "pcie_rxp[12]"]                  ;# Bank 224 - MGTYRXP3_224
# set_property PACKAGE_PIN AT15                [get_ports "pcie_rxn[13]"]                  ;# Bank 224 - MGTYRXN2_224
# set_property PACKAGE_PIN AT16                [get_ports "pcie_rxp[13]"]                  ;# Bank 224 - MGTYRXP2_224
# set_property PACKAGE_PIN AU17                [get_ports "pcie_rxn[14]"]                  ;# Bank 224 - MGTYRXN1_224
# set_property PACKAGE_PIN AU18                [get_ports "pcie_rxp[14]"]                  ;# Bank 224 - MGTYRXP1_224
# set_property PACKAGE_PIN AU21                [get_ports "pcie_rxn[15]"]                  ;# Bank 224 - MGTYRXN0_224
# set_property PACKAGE_PIN AU22                [get_ports "pcie_rxp[15]"]                  ;# Bank 224 - MGTYRXP0_224
# set_property PACKAGE_PIN AG1                 [get_ports "pcie_rxn[1]"]                   ;# Bank 227 - MGTYRXN2_227
# set_property PACKAGE_PIN AG2                 [get_ports "pcie_rxp[1]"]                   ;# Bank 227 - MGTYRXP2_227
# set_property PACKAGE_PIN AJ1                 [get_ports "pcie_rxn[2]"]                   ;# Bank 227 - MGTYRXN1_227
# set_property PACKAGE_PIN AJ2                 [get_ports "pcie_rxp[2]"]                   ;# Bank 227 - MGTYRXP1_227
# set_property PACKAGE_PIN AK3                 [get_ports "pcie_rxn[3]"]                   ;# Bank 227 - MGTYRXN0_227
# set_property PACKAGE_PIN AK4                 [get_ports "pcie_rxp[3]"]                   ;# Bank 227 - MGTYRXP0_227
# set_property PACKAGE_PIN AL1                 [get_ports "pcie_rxn[4]"]                   ;# Bank 226 - MGTYRXN3_226
# set_property PACKAGE_PIN AL2                 [get_ports "pcie_rxp[4]"]                   ;# Bank 226 - MGTYRXP3_226
# set_property PACKAGE_PIN AM3                 [get_ports "pcie_rxn[5]"]                   ;# Bank 226 - MGTYRXN2_226
# set_property PACKAGE_PIN AM4                 [get_ports "pcie_rxp[5]"]                   ;# Bank 226 - MGTYRXP2_226
# set_property PACKAGE_PIN AN1                 [get_ports "pcie_rxn[6]"]                   ;# Bank 226 - MGTYRXN1_226
# set_property PACKAGE_PIN AN2                 [get_ports "pcie_rxp[6]"]                   ;# Bank 226 - MGTYRXP1_226
# set_property PACKAGE_PIN AR1                 [get_ports "pcie_rxn[7]"]                   ;# Bank 226 - MGTYRXN0_226
# set_property PACKAGE_PIN AR2                 [get_ports "pcie_rxp[7]"]                   ;# Bank 226 - MGTYRXP0_226
# set_property PACKAGE_PIN AT3                 [get_ports "pcie_rxn[8]"]                   ;# Bank 225 - MGTYRXN3_225
# set_property PACKAGE_PIN AT4                 [get_ports "pcie_rxp[8]"]                   ;# Bank 225 - MGTYRXP3_225
# set_property PACKAGE_PIN AU5                 [get_ports "pcie_rxn[9]"]                   ;# Bank 225 - MGTYRXN2_225
# set_property PACKAGE_PIN AU6                 [get_ports "pcie_rxp[9]"]                   ;# Bank 225 - MGTYRXP2_225
# set_property PACKAGE_PIN AD7                 [get_ports "pcie_txn[0]"]                   ;# Bank 227 - MGTYTXN3_227
# set_property PACKAGE_PIN AD8                 [get_ports "pcie_txp[0]"]                   ;# Bank 227 - MGTYTXP3_227
# set_property PACKAGE_PIN AR9                 [get_ports "pcie_txn[10]"]                  ;# Bank 225 - MGTYTXN1_225
# set_property PACKAGE_PIN AR10                [get_ports "pcie_txp[10]"]                  ;# Bank 225 - MGTYTXP1_225
# set_property PACKAGE_PIN AT11                [get_ports "pcie_txn[11]"]                  ;# Bank 225 - MGTYTXN0_225
# set_property PACKAGE_PIN AT12                [get_ports "pcie_txp[11]"]                  ;# Bank 225 - MGTYTXP0_225
# set_property PACKAGE_PIN AR13                [get_ports "pcie_txn[12]"]                  ;# Bank 224 - MGTYTXN3_224
# set_property PACKAGE_PIN AR14                [get_ports "pcie_txp[12]"]                  ;# Bank 224 - MGTYTXP3_224
# set_property PACKAGE_PIN AR17                [get_ports "pcie_txn[13]"]                  ;# Bank 224 - MGTYTXN2_224
# set_property PACKAGE_PIN AR18                [get_ports "pcie_txp[13]"]                  ;# Bank 224 - MGTYTXP2_224
# set_property PACKAGE_PIN AT19                [get_ports "pcie_txn[14]"]                  ;# Bank 224 - MGTYTXN1_224
# set_property PACKAGE_PIN AT20                [get_ports "pcie_txp[14]"]                  ;# Bank 224 - MGTYTXP1_224
# set_property PACKAGE_PIN AR21                [get_ports "pcie_txn[15]"]                  ;# Bank 224 - MGTYTXN0_224
# set_property PACKAGE_PIN AR22                [get_ports "pcie_txp[15]"]                  ;# Bank 224 - MGTYTXP0_224
# set_property PACKAGE_PIN AE5                 [get_ports "pcie_txn[1]"]                   ;# Bank 227 - MGTYTXN2_227
# set_property PACKAGE_PIN AE6                 [get_ports "pcie_txp[1]"]                   ;# Bank 227 - MGTYTXP2_227
# set_property PACKAGE_PIN AG5                 [get_ports "pcie_txn[2]"]                   ;# Bank 227 - MGTYTXN1_227
# set_property PACKAGE_PIN AG6                 [get_ports "pcie_txp[2]"]                   ;# Bank 227 - MGTYTXP1_227
# set_property PACKAGE_PIN AH3                 [get_ports "pcie_txn[3]"]                   ;# Bank 227 - MGTYTXN0_227
# set_property PACKAGE_PIN AH4                 [get_ports "pcie_txp[3]"]                   ;# Bank 227 - MGTYTXP0_227
# set_property PACKAGE_PIN AJ5                 [get_ports "pcie_txn[4]"]                   ;# Bank 226 - MGTYTXN3_226
# set_property PACKAGE_PIN AJ6                 [get_ports "pcie_txp[4]"]                   ;# Bank 226 - MGTYTXP3_226
# set_property PACKAGE_PIN AL5                 [get_ports "pcie_txn[5]"]                   ;# Bank 226 - MGTYTXN2_226
# set_property PACKAGE_PIN AL6                 [get_ports "pcie_txp[5]"]                   ;# Bank 226 - MGTYTXP2_226
# set_property PACKAGE_PIN AN5                 [get_ports "pcie_txn[6]"]                   ;# Bank 226 - MGTYTXN1_226
# set_property PACKAGE_PIN AN6                 [get_ports "pcie_txp[6]"]                   ;# Bank 226 - MGTYTXP1_226
# set_property PACKAGE_PIN AP3                 [get_ports "pcie_txn[7]"]                   ;# Bank 226 - MGTYTXN0_226
# set_property PACKAGE_PIN AP4                 [get_ports "pcie_txp[7]"]                   ;# Bank 226 - MGTYTXP0_226
# set_property PACKAGE_PIN AP7                 [get_ports "pcie_txn[8]"]                   ;# Bank 225 - MGTYTXN3_225
# set_property PACKAGE_PIN AP8                 [get_ports "pcie_txp[8]"]                   ;# Bank 225 - MGTYTXP3_225
# set_property PACKAGE_PIN AR5                 [get_ports "pcie_txn[9]"]                   ;# Bank 225 - MGTYTXN2_225
# set_property PACKAGE_PIN AR6                 [get_ports "pcie_txp[9]"]                   ;# Bank 225 - MGTYTXP2_225



##################################################################################################################################################################
#
#        		 GTM Lanes Connected to QSFP #0 Connector
#
##################################################################################################################################################################
set_property PACKAGE_PIN A12                 [get_ports "dual0_gtm_rx_in_gt_port_0_n"]              ;# Bank 234 - MGTMRXN0_234
set_property PACKAGE_PIN A13                 [get_ports "dual0_gtm_rx_in_gt_port_0_p"]              ;# Bank 234 - MGTMRXP0_234
set_property PACKAGE_PIN A15                 [get_ports "dual0_gtm_rx_in_gt_port_1_n"]              ;# Bank 234 - MGTMRXN1_234
set_property PACKAGE_PIN A16                 [get_ports "dual0_gtm_rx_in_gt_port_1_p"]              ;# Bank 234 - MGTMRXP1_234

set_property PACKAGE_PIN A6                  [get_ports "dual1_gtm_rx_in_gt_port_0_n"]              ;# Bank 233 - MGTMRXN0_233
set_property PACKAGE_PIN A7                  [get_ports "dual1_gtm_rx_in_gt_port_0_p"]              ;# Bank 233 - MGTMRXP0_233
set_property PACKAGE_PIN A9                  [get_ports "dual1_gtm_rx_in_gt_port_1_n"]              ;# Bank 233 - MGTMRXN1_233
set_property PACKAGE_PIN A10                 [get_ports "dual1_gtm_rx_in_gt_port_1_p"]              ;# Bank 233 - MGTMRXP1_233

set_property PACKAGE_PIN C14                 [get_ports "dual0_gtm_tx_out_gt_port_0_n"]              ;# Bank 234 - MGTMTXN0_234
set_property PACKAGE_PIN C15                 [get_ports "dual0_gtm_tx_out_gt_port_0_p"]              ;# Bank 234 - MGTMTXP0_234
set_property PACKAGE_PIN C17                 [get_ports "dual0_gtm_tx_out_gt_port_1_n"]              ;# Bank 234 - MGTMTXN1_234
set_property PACKAGE_PIN C18                 [get_ports "dual0_gtm_tx_out_gt_port_1_p"]              ;# Bank 234 - MGTMTXP1_234

set_property PACKAGE_PIN C8                  [get_ports "dual1_gtm_tx_out_gt_port_0_n"]              ;# Bank 233 - MGTMTXN0_233
set_property PACKAGE_PIN C9                  [get_ports "dual1_gtm_tx_out_gt_port_0_p"]              ;# Bank 233 - MGTMTXP0_233
set_property PACKAGE_PIN C11                 [get_ports "dual1_gtm_tx_out_gt_port_1_n"]              ;# Bank 233 - MGTMTXN1_233
set_property PACKAGE_PIN C12                 [get_ports "dual1_gtm_tx_out_gt_port_1_p"]              ;# Bank 233 - MGTMTXP1_233



##################################################################################################################################################################
#
#        		 GTY Lanes Connected to QSFP #1 Connector
#
##################################################################################################################################################################
set_property LOC GTYE4_CHANNEL_X0Y28 [get_cells {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN K3                  [get_ports "gty_rx_in_gt_port_0_n"]              ;# Bank 231 - MGTYRXN0_231
set_property PACKAGE_PIN K4                  [get_ports "gty_rx_in_gt_port_0_p"]              ;# Bank 231 - MGTYRXP0_231
set_property PACKAGE_PIN J6                  [get_ports "gty_tx_out_gt_port_0_n"]             ;# Bank 231 - MGTYTXN0_231
set_property PACKAGE_PIN J7                  [get_ports "gty_tx_out_gt_port_0_p"]             ;# Bank 231 - MGTYTXP0_231
set_property LOC GTYE4_CHANNEL_X0Y29 [get_cells {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt_1/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_1_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN J1                  [get_ports "gty_rx_in_gt_port_1_n"]              ;# Bank 231 - MGTYRXN1_231
set_property PACKAGE_PIN J2                  [get_ports "gty_rx_in_gt_port_1_p"]              ;# Bank 231 - MGTYRXP1_231
set_property PACKAGE_PIN H4                  [get_ports "gty_tx_out_gt_port_1_n"]             ;# Bank 231 - MGTYTXN1_231
set_property PACKAGE_PIN H5                  [get_ports "gty_tx_out_gt_port_1_p"]             ;# Bank 231 - MGTYTXP1_231
set_property LOC GTYE4_CHANNEL_X0Y30 [get_cells {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt_2/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_2_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN G1                  [get_ports "gty_rx_in_gt_port_2_n"]              ;# Bank 231 - MGTYRXN2_231
set_property PACKAGE_PIN G2                  [get_ports "gty_rx_in_gt_port_2_p"]              ;# Bank 231 - MGTYRXP2_231
set_property PACKAGE_PIN G6                  [get_ports "gty_tx_out_gt_port_2_n"]             ;# Bank 231 - MGTYTXN2_231
set_property PACKAGE_PIN G7                  [get_ports "gty_tx_out_gt_port_2_p"]             ;# Bank 231 - MGTYTXP2_231
set_property LOC GTYE4_CHANNEL_X0Y31 [get_cells {design_top_i/xxv_ethernet_0/inst/i_design_top_xxv_ethernet_0_0_gt_3/inst/gen_gtwizard_gtye4_top.design_top_xxv_ethernet_0_0_gt_3_gtwizard_gtye4_inst/gen_gtwizard_gtye4.gen_channel_container[7].gen_enabled_channel.gtye4_channel_wrapper_inst/channel_inst/gtye4_channel_gen.gen_gtye4_channel_inst[0].GTYE4_CHANNEL_PRIM_INST}]
set_property PACKAGE_PIN E1                  [get_ports "gty_rx_in_gt_port_3_n"]              ;# Bank 231 - MGTYRXN3_231
set_property PACKAGE_PIN E2                  [get_ports "gty_rx_in_gt_port_3_p"]              ;# Bank 231 - MGTYRXP3_231
set_property PACKAGE_PIN F4                  [get_ports "gty_tx_out_gt_port_3_n"]             ;# Bank 231 - MGTYTXN3_231
set_property PACKAGE_PIN F5                  [get_ports "gty_tx_out_gt_port_3_p"]             ;# Bank 231 - MGTYTXP3_231

################### ARM PCIe

# set_property PACKAGE_PIN AJ17 [get_ports pcie_rstn[1]]
# set_property -dict {IOSTANDARD LVCMOS18} [get_ports pcie_rstn[1]]

# set_property PACKAGE_PIN AC9  [get_ports pcie_refclk_n[1]]
# set_property PACKAGE_PIN AC10 [get_ports pcie_refclk_p[1]]

##### TEMP CHANGE  ################## ACTUAL #############
# set_property PACKAGE_PIN AE2 [get_ports {pcie_rxp[16]}]
# set_property PACKAGE_PIN AD4 [get_ports {pcie_txp[16]}]
# set_property PACKAGE_PIN AC2 [get_ports {pcie_rxp[17]}]
# set_property PACKAGE_PIN AC6 [get_ports {pcie_txp[17]}]
# set_property PACKAGE_PIN AB4 [get_ports {pcie_rxp[18]}]
# set_property PACKAGE_PIN AB8 [get_ports {pcie_txp[18]}]
# set_property PACKAGE_PIN AA2 [get_ports {pcie_rxp[19]}]
# set_property PACKAGE_PIN AA6 [get_ports {pcie_txp[19]}]
# set_property PACKAGE_PIN Y4 [get_ports {pcie_rxp[20]}]
# set_property PACKAGE_PIN Y8 [get_ports {pcie_txp[20]}]
# set_property PACKAGE_PIN W2 [get_ports {pcie_rxp[21]}]
# set_property PACKAGE_PIN W6 [get_ports {pcie_txp[21]}]
# set_property PACKAGE_PIN V4 [get_ports {pcie_rxp[22]}]
# set_property PACKAGE_PIN U7 [get_ports {pcie_txp[22]}]
# set_property PACKAGE_PIN U2 [get_ports {pcie_rxp[23]}]
# set_property PACKAGE_PIN R7 [get_ports {pcie_txp[23]}]

##### CMS PORTS #######
# set_property -dict {PACKAGE_PIN AM17 IOSTANDARD LVCMOS18} [get_ports satellite_gpio[0]]
# set_property -dict {PACKAGE_PIN AL18 IOSTANDARD LVCMOS18} [get_ports satellite_gpio[1]]

# set_property -dict {PACKAGE_PIN AK21 IOSTANDARD LVCMOS18} [get_ports satellite_uart_0_rxd]
# set_property -dict {PACKAGE_PIN AJ21 IOSTANDARD LVCMOS18 DRIVE 4} [get_ports satellite_uart_0_txd]

## QSPI FLASH Interfaec
# set_property PACKAGE_PIN AH14 [get_ports spi_flash_io1_io]
# set_property PACKAGE_PIN AL14 [get_ports spi_flash_io2_io]
# set_property PACKAGE_PIN AL15 [get_ports spi_flash_io3_io]
# set_property PACKAGE_PIN AM15 [get_ports spi_flash_sck_io]
# set_property PACKAGE_PIN AK14 [get_ports spi_flash_ss_io]
# set_property PACKAGE_PIN AN15 [get_ports spi_flash_io0_io]

# set_property -dict {IOSTANDARD LVCMOS18}  [get_ports spi_flash_*]

