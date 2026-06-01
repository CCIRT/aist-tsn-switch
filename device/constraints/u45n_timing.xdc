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
#create_clock -period 3.333333 -name sysclk_300 [get_ports cmc_sysclk_300_p]
#create_clock -period 6.206061 -name gty_refclk [get_ports gty_refclk_clk_p]
#create_clock -period 6.206061 -name dual0_gtm_refclk [get_ports dual0_gtm_refclk_clk_p]
#create_clock -period 6.206061 -name dual1_gtm_refclk [get_ports dual1_gtm_refclk_clk_p]

set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]}] -group [get_clocks {rxoutclk_out[0]}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_1}] -group [get_clocks {rxoutclk_out[0]}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_2}] -group [get_clocks {rxoutclk_out[0]}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_3}] -group [get_clocks {rxoutclk_out[0]}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_1}] -group [get_clocks {rxoutclk_out[0]_1}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_2}] -group [get_clocks {rxoutclk_out[0]_2}]
set_clock_groups -asynchronous -group [get_clocks {txoutclk_out[0]_3}] -group [get_clocks {rxoutclk_out[0]_3}]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_clk_wiz_0_0] -group [get_clocks {txoutclk_out[0]}]

set_clock_groups -asynchronous -group [get_clocks gtm_ch0_rxprogdivclk] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch1_rxprogdivclk] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch0_rxprogdivclk_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch1_rxprogdivclk_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]

set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_2] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_3] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_2] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_3] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]

set_clock_groups -asynchronous -group [get_clocks gtm_ch0_rxprogdivclk] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch0_rxprogdivclk_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch1_rxprogdivclk] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks gtm_ch1_rxprogdivclk_1] -group [get_clocks clk_out1_design_1_clk_wiz_0_0]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_2]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_3]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_1_0_clk_wiz_1_3]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_2]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_3]
set_clock_groups -asynchronous -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_1] -group [get_clocks clk_out1_design_1_xxv_ethernet_2_0_clk_wiz_1_3]



set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
