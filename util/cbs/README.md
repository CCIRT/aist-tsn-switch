# TCL scripts for CBS

This directory contains TCL scripts that facilitate register modification in FPGA.

## Files

- [README.md](./README.md): This file
- [set_flow_control.tcl](./set_flow_control.tcl): Enable/disable flow control and frame drop functions
  - Usage: xsdb set_flow_control.tcl <flow_control_enable> (<drop_enable>)
    - Bracketed item is optional
    - 0 means disable and 1 means enable
    - Usage example: `xsdb set_flow_control.tcl 0 1`
- [set_slope.tcl](./set_slope.tcl): Change the values of idleSlope and sendSlope
  - Usage: xsdb set_slope.tcl <idle_slope_bps_TC7> <send_slope_bps_TC7> (<idle_slope_bps_TC6> <send_slope_bps_TC6>) (<hi_credit_common> <lo_credit_common>)
    - Bracketed items are optional
    - Note: Set the value so that `idleSlope - sendSlope = portTransmitRate (1000000)`
    - Usage example: `xsdb set_slope.tcl 100000 -900000 10000 -990000 0x7FFFFFFF 0x80000000`
- [set_traffic_class.tcl](./set_traffic_class.tcl): Change the Traffic Class corresponding to the PCP value
  - Usage: xsdb set_traffic_class.tcl <priority_mapper_no-vlan-tag> (<priority_mapper_pcp3>) (<priority_mapper_pcp2>)
    - Bracketed items are optional
    - Usage example: `xsdb set_traffic_class.tcl 5 7 6`
