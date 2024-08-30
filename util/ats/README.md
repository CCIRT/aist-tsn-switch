# TCL scripts for ATS

This directory contains TCL scripts that facilitate register modification in FPGA.

## Files

- [ats_settings.tcl](./ats_settings.tcl): Set ATS parameters other than ProcessingDelayMax
  - usage: `xsdb ats_settings.tcl`
    - Edit the contents of the tcl file as appropriate before execution
    - Please configure 16 flows for each Traffic Class.
    - The remaining settings can be made by changing the start number of the for statement.
      - example 1
        ```tcl
        set_flow_val 0 1 0 [ip  10   0   0   1]     0 [ip  10   0   0   2]  5201  100 1542   # flow 0
        for {set i 1} {$i < 16} {incr i} {   # flow 1 - 15
            set_flow_val 0 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
        }
        ```
      - example 2
        ```tcl
        set_flow_val 0 1 0 [ip  10   0   0   1]     0 [ip  10   0   0   2]  5201  100 1542   # flow 0
        set_flow_val 0 1 1 [ip 172  16   0   1]     0 [ip  10   0   0   2]  5202  100 1542   # flow 1
        for {set i 2} {$i < 16} {incr i} {   # flow 2 - 15
            set_flow_val 0 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
        }
        ```
    - The following values are magic numbers with wildcard meanings.
      | name     | value           |
      | ------   | ------          |
      | src_ip   |   0   0   0   0 |
      | src_port |   0           |
      | dst_ip   |   0   0   0   0 |
      | dst_port |   0           |
- [README.md](./README.md): This file
- [set_processing_delay_max.tcl](./set_processing_delay_max.tcl): Change the values of ProcessingDelayMax
  - Usage: xsdb set_processing_delay_max.tcl <processing_delay_max (ps)>
    - Usage example: `xsdb set_processing_delay_max.tcl 50000000`
- [set_traffic_class.tcl](./set_traffic_class.tcl): Change the Traffic Class corresponding to the PCP value
  - Usage: xsdb set_traffic_class.tcl <priority_mapper_no-vlan-tag> (<priority_mapper_pcp3>) (<priority_mapper_pcp2>)
    - Bracketed items are optional
    - Usage example: `xsdb set_traffic_class.tcl 5 7 6`
