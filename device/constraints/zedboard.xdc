# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# clock
set_property DIFF_TERM TRUE [get_ports ref_clk_clk_p]
set_property DIFF_TERM TRUE [get_ports ref_clk_clk_n]
set_property IOSTANDARD LVDS_25 [get_ports ref_clk_clk_p]
set_property IOSTANDARD LVDS_25 [get_ports ref_clk_clk_n]
set_property IOSTANDARD LVCMOS25 [get_ports {ref_clk_oe[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {ref_clk_fsel[0]}]
set_property PACKAGE_PIN L19 [get_ports ref_clk_clk_n]
set_property PACKAGE_PIN L17 [get_ports {ref_clk_oe[0]}]
set_property PACKAGE_PIN K19 [get_ports {ref_clk_fsel[0]}]
create_clock -period 8.000 -name ref_clk_clk_p -waveform {0.000 4.000} [get_ports ref_clk_clk_p]

# reset
set_property IOSTANDARD LVCMOS25 [get_ports reset_port_0]
set_property IOSTANDARD LVCMOS25 [get_ports reset_port_1]
set_property IOSTANDARD LVCMOS25 [get_ports reset_port_2]
set_property IOSTANDARD LVCMOS25 [get_ports reset_port_3]
set_property PACKAGE_PIN K18 [get_ports reset_port_0]
set_property PACKAGE_PIN J17 [get_ports reset_port_1]
set_property PACKAGE_PIN A19 [get_ports reset_port_2]
set_property PACKAGE_PIN A22 [get_ports reset_port_3]

# MDIO
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_0_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_1_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_2_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_3_mdc]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_0_io]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_1_io]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_2_io]
set_property IOSTANDARD LVCMOS25 [get_ports mdio_io_port_3_io]
set_property PACKAGE_PIN J18 [get_ports mdio_io_port_0_mdc]
set_property PACKAGE_PIN M17 [get_ports mdio_io_port_1_mdc]
set_property PACKAGE_PIN A18 [get_ports mdio_io_port_2_mdc]
set_property PACKAGE_PIN B15 [get_ports mdio_io_port_3_mdc]
set_property PACKAGE_PIN L22 [get_ports mdio_io_port_0_io]
set_property PACKAGE_PIN K20 [get_ports mdio_io_port_1_io]
set_property PACKAGE_PIN C22 [get_ports mdio_io_port_2_io]
set_property PACKAGE_PIN A21 [get_ports mdio_io_port_3_io]

# RGMII (RX)
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_rd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_rd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_rd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_rd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_0_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_0_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_rd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_rd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_rd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_rd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_1_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_1_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_rd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_rd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_rd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_rd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_2_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_2_rxc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_rd[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_rd[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_rd[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_rd[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_3_rx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_3_rxc]
set_property PACKAGE_PIN P17 [get_ports {rgmii_port_0_rd[0]}]
set_property PACKAGE_PIN P18 [get_ports {rgmii_port_0_rd[1]}]
set_property PACKAGE_PIN N22 [get_ports {rgmii_port_0_rd[2]}]
set_property PACKAGE_PIN P22 [get_ports {rgmii_port_0_rd[3]}]
set_property PACKAGE_PIN M20 [get_ports rgmii_port_0_rx_ctl]
set_property PACKAGE_PIN M19 [get_ports rgmii_port_0_rxc]
set_property PACKAGE_PIN L21 [get_ports {rgmii_port_1_rd[0]}]
set_property PACKAGE_PIN R20 [get_ports {rgmii_port_1_rd[1]}]
set_property PACKAGE_PIN T19 [get_ports {rgmii_port_1_rd[2]}]
set_property PACKAGE_PIN R21 [get_ports {rgmii_port_1_rd[3]}]
set_property PACKAGE_PIN N20 [get_ports rgmii_port_1_rx_ctl]
set_property PACKAGE_PIN N19 [get_ports rgmii_port_1_rxc]
set_property PACKAGE_PIN G21 [get_ports {rgmii_port_2_rd[0]}]
set_property PACKAGE_PIN G15 [get_ports {rgmii_port_2_rd[1]}]
set_property PACKAGE_PIN E15 [get_ports {rgmii_port_2_rd[2]}]
set_property PACKAGE_PIN D15 [get_ports {rgmii_port_2_rd[3]}]
set_property PACKAGE_PIN G20 [get_ports rgmii_port_2_rx_ctl]
set_property PACKAGE_PIN B19 [get_ports rgmii_port_2_rxc]
set_property PACKAGE_PIN F18 [get_ports {rgmii_port_3_rd[0]}]
set_property PACKAGE_PIN E21 [get_ports {rgmii_port_3_rd[1]}]
set_property PACKAGE_PIN E18 [get_ports {rgmii_port_3_rd[2]}]
set_property PACKAGE_PIN D21 [get_ports {rgmii_port_3_rd[3]}]
set_property PACKAGE_PIN C20 [get_ports rgmii_port_3_rx_ctl]
set_property PACKAGE_PIN D20 [get_ports rgmii_port_3_rxc]

# RGMII (TX)
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_td[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_td[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_td[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_0_td[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_0_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_0_txc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_td[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_td[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_td[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_1_td[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_1_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_1_txc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_td[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_td[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_td[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_2_td[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_2_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_2_txc]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_td[0]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_td[1]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_td[2]}]
set_property IOSTANDARD LVCMOS25 [get_ports {rgmii_port_3_td[3]}]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_3_tx_ctl]
set_property IOSTANDARD LVCMOS25 [get_ports rgmii_port_3_txc]
set_property PACKAGE_PIN M21 [get_ports {rgmii_port_0_td[0]}]
set_property PACKAGE_PIN J21 [get_ports {rgmii_port_0_td[1]}]
set_property PACKAGE_PIN J22 [get_ports {rgmii_port_0_td[2]}]
set_property PACKAGE_PIN T16 [get_ports {rgmii_port_0_td[3]}]
set_property PACKAGE_PIN T17 [get_ports rgmii_port_0_tx_ctl]
set_property PACKAGE_PIN M22 [get_ports rgmii_port_0_txc]
set_property PACKAGE_PIN P21 [get_ports {rgmii_port_1_td[0]}]
set_property PACKAGE_PIN N17 [get_ports {rgmii_port_1_td[1]}]
set_property PACKAGE_PIN J20 [get_ports {rgmii_port_1_td[2]}]
set_property PACKAGE_PIN K21 [get_ports {rgmii_port_1_td[3]}]
set_property PACKAGE_PIN J16 [get_ports rgmii_port_1_tx_ctl]
set_property PACKAGE_PIN N18 [get_ports rgmii_port_1_txc]
set_property PACKAGE_PIN G16 [get_ports {rgmii_port_2_td[0]}]
set_property PACKAGE_PIN G19 [get_ports {rgmii_port_2_td[1]}]
set_property PACKAGE_PIN F19 [get_ports {rgmii_port_2_td[2]}]
set_property PACKAGE_PIN E20 [get_ports {rgmii_port_2_td[3]}]
set_property PACKAGE_PIN D22 [get_ports rgmii_port_2_tx_ctl]
set_property PACKAGE_PIN E19 [get_ports rgmii_port_2_txc]
set_property PACKAGE_PIN C18 [get_ports {rgmii_port_3_td[0]}]
set_property PACKAGE_PIN A16 [get_ports {rgmii_port_3_td[1]}]
set_property PACKAGE_PIN B16 [get_ports {rgmii_port_3_td[2]}]
set_property PACKAGE_PIN B17 [get_ports {rgmii_port_3_td[3]}]
set_property PACKAGE_PIN C15 [get_ports rgmii_port_3_tx_ctl]
set_property PACKAGE_PIN A17 [get_ports rgmii_port_3_txc]

# LEDs
set_property PACKAGE_PIN T22 [get_ports {frame_error_0}];
set_property PACKAGE_PIN U22 [get_ports {frame_error_1}];
set_property PACKAGE_PIN V22 [get_ports {frame_error_2}];
set_property PACKAGE_PIN U19 [get_ports {frame_error_3}];
set_property PACKAGE_PIN T21 [get_ports {activity_flash_0}];
set_property PACKAGE_PIN U21 [get_ports {activity_flash_1}];
set_property PACKAGE_PIN W22 [get_ports {activity_flash_2}];
set_property PACKAGE_PIN U14 [get_ports {activity_flash_3}];

# Push Buttons
# center: update_speed
# top:    reset_error
# right:  glbl_rst
# left:   config_board
# bottom: pause_req_s
set_property PACKAGE_PIN P16 [get_ports {update_speed}];
set_property PACKAGE_PIN T18 [get_ports {reset_error}];
set_property PACKAGE_PIN R18 [get_ports {glbl_rst}];
set_property PACKAGE_PIN N15 [get_ports {config_board}];
set_property PACKAGE_PIN R16 [get_ports {pause_req_s}];
set_false_path -from [get_ports glbl_rst]
set_property IOSTANDARD LVCMOS25 [get_ports update_speed]
set_property IOSTANDARD LVCMOS25 [get_ports reset_error]
set_property IOSTANDARD LVCMOS25 [get_ports glbl_rst]
set_property IOSTANDARD LVCMOS25 [get_ports config_board]
set_property IOSTANDARD LVCMOS25 [get_ports pause_req_s]

# DIP Switches
set_property PACKAGE_PIN F22 [get_ports mac_speed[0]];
set_property PACKAGE_PIN G22 [get_ports mac_speed[1]];
set_property PACKAGE_PIN H22 [get_ports gen_tx_data];
set_property PACKAGE_PIN F21 [get_ports chk_tx_data];
set_property IOSTANDARD LVCMOS25 [get_ports mac_speed[0]]
set_property IOSTANDARD LVCMOS25 [get_ports mac_speed[1]]
set_property IOSTANDARD LVCMOS25 [get_ports gen_tx_data]
set_property IOSTANDARD LVCMOS25 [get_ports chk_tx_data]

# constraints
set_false_path -from [get_ports config_board]
set_false_path -from [get_ports pause_req_s]
set_false_path -from [get_ports reset_error]
set_false_path -from [get_ports mac_speed[0]]
set_false_path -from [get_ports mac_speed[1]]
set_false_path -from [get_ports gen_tx_data]
set_false_path -from [get_ports chk_tx_data]
set_false_path -from [get_ports pause_req*]
set_false_path -from [get_cells *_i/hier_mac_*/eth_driver_*/inst/pause_req* -filter {IS_SEQUENTIAL}]
set_false_path -from [get_cells *_i/hier_mac_*/eth_driver_*/inst/pause_val* -filter {IS_SEQUENTIAL}]
set_false_path -to [get_pins *_i/hier_mac_*/eth_driver_*/inst/example_resets/axi_lite_reset_gen/reset_sync*/CE]
set_false_path -to [get_cells *_i/hier_mac_*/eth_driver_*/inst/pause_req_*/data_sync_reg0]
set_false_path -to [get_ports frame_error_0]
set_false_path -to [get_ports frame_error_1]
set_false_path -to [get_ports frame_error_2]
set_false_path -to [get_ports frame_error_3]
set_false_path -from [get_cells *_i/gpio_processing_dela_0/inst/axi4_lite_slave_i/val_reg_reg*] -to [get_cells *_i/hier_ats_*/hier_et_gate_*/et_gate_*/inst/*assigned_eligibility_timestamp_reg_reg*]

set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]];
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]];

# output to pmod JA and JB
set_property IOSTANDARD LVCMOS33 [get_ports pulse_out_0[0]]
set_property IOSTANDARD LVCMOS33 [get_ports pulse_out_0[1]]
set_property IOSTANDARD LVCMOS33 [get_ports pulse_out_0[2]]
set_property IOSTANDARD LVCMOS33 [get_ports pulse_out_0[3]]
set_property PACKAGE_PIN Y11 [get_ports pulse_out_0[0]]
set_property PACKAGE_PIN AA11 [get_ports pulse_out_0[1]]
set_property PACKAGE_PIN W12 [get_ports pulse_out_0[2]]
set_property PACKAGE_PIN W11 [get_ports pulse_out_0[3]]
