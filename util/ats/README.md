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
# Python scripts for ATS

This directory contains Python scripts that facilitate register modification in FPGA.

## Prerequisites

Add our python modules to `PYTHONPATH`.

```sh
cd /path/to/this/directory/
export PYTHONPATH=$(pwd)/../python/:${PYTHONPATH}
```

Add xsdb to `PATH`.  

```sh
cd /vivado_or_vivado_lab/install/dir
source settings64.sh
```

## Scripts usage


Set mapping rule from PCP to Traffic Class.

```sh
$ python3 set_traffic_class.py -h
usage: set_traffic_class [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}] pcp [tc]

Change the Traffic Class corresponding to the PCP value

positional arguments:
  pcp                   Target PCP value (-1 <= pcp < 8). -1 means non-VLAN-tagged frames
  tc                    Target TC value (0 <= tc < 8). If omitted, show current status

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

To map PCP3 to TC7, run the below command.

```sh
$ python3 set_traffic_class.py 3 7 --board kc705
xsdb server launched.
List of available targets are as below:
1  xc7k325t
     2  Legacy Debug Hub
        3  JTAG2AXI
  4  xc7k325t
     5  Legacy Debug Hub
        6  JTAG2AXI
  7  APU
     8  ARM Cortex-A9 MPCore #0 (Running)
     9  ARM Cortex-A9 MPCore #1 (Running)
 10  xc7z020
    11  Legacy Debug Hub
       12  JTAG2AXI
Please type the number of target: 6
Updated.
Show current traffic_class status
  Target PCP: 3
  Mapped TC: 7
```

The script lists available xsdb target and users need to select the corresponding JTAG2AXI target for ATS-Switch.  
If you know the target value in advance, you can use `--jtag_target <N>` option instead.

If you want to read the current register value, you can omit tc argument.

```
$ python3 set_traffic_class.py 3 --board kc705 --jtag_target 6
xsdb server launched.
Show current traffic_class status
  Target PCP: 3
  Mapped TC: 7
```

You can also omit value field and read register values in other Python scripts except for manage_flow.py.  
Please see the command help to find which arguments can be omitted or not.

### manage_flow.py

Add/Delete flow definition.

```sh
$ python3 manage_flow.py -h
usage: manage_flow [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}] {add,del,show} ...

Add/Delete flow definition

positional arguments:
  {add,del,show}        Action. add, del or show
    add                 Add commands
    del                 Delete commands
    show                Show commands

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board

$ python3 manage_flow.py add -h
usage: manage_flow add [-h] port tc flow_id [src_ip] [src_port] [dst_ip] [dst_port]

positional arguments:
  port        MAC RX port
  tc          Target TC value (6 or 7)
  flow_id     Flow id value (1-15)
  src_ip      Source IP (format: www.xxx.yyy.zzz or *(wildcard))
  src_port    Source port (format: uint16 or *(wildcard))
  dst_ip      Destination IP (format: www.xxx.yyy.zzz or *(wildcard))
  dst_port    Destination port (format: uint16 or *(wildcard))

options:
  -h, --help  show this help message and exit

$ python3 manage_flow.py del -h
usage: manage_flow del [-h] port tc flow_id

positional arguments:
  port        MAC RX port
  tc          Target TC value (6 or 7)
  flow_id     Flow id value (1-15)

options:
  -h, --help  show this help message and exit

$ python3 manage_flow.py show -h
usage: manage_flow show [-h] port tc flow_id

positional arguments:
  port        MAC RX port
  tc          Target TC value (6 or 7)
  flow_id     Flow id value (1-15)

options:
  -h, --help  show this help message and exit
```

In ATS switch, a tuple `(src_ip, src_port, dst_ip, dst_port)` is used to distinguish flow.  
Users can define up to `16 flows / TC / input port`.  

To add an flow (id=3), for `src_ip=192.168.1.20, src_port=<any_value>, dst_ip=192.168.1.30, dst_port=60000`, TC=6, port=0, run the following command.

```sh
$ python3 manage_flow.py --jtag_target 6 --board kc705 add 0 6 3 192.168.1.20 '*' 192.168.1.30 60000
xsdb server launched.
Added flow rule.
Show current flow status.
  Target Port      : 0
  Target TC        : 6
  Target Flow      : 3
  Source IP        : 192.168.1.20
  Source port      : *
  Destination IP   : 192.168.1.30
  Destination port : 60000
```

To remove this flow, run the following command.

```sh
$ python3 manage_flow.py --jtag_target 6 --board kc705 del 0 6 3
xsdb server launched.
Deleted flow rule.
Show current flow status.
  Target Port      : 0
  Target TC        : 6
  Target Flow      : 3
  Source IP        : 255.255.255.255
  Source port      : 65535
  Destination IP   : 255.255.255.255
  Destination port : 65535
```

To show the registered flow, run the following command.

```sh
$ python3 manage_flow.py --jtag_target 6 --board kc705 show 0 6 3
xsdb server launched.
Show current flow status.
  Target Port      : 0
  Target TC        : 6
  Target Flow      : 3
  Source IP        : 255.255.255.255
  Source port      : 65535
  Destination IP   : 255.255.255.255
  Destination port : 65535
```

### set_ats_param.py

Set Committed Information Rate (CIR) and Committed Burst Size (CBS) for a flow.

```sh
$ python3 set_ats_param.py -h
usage: set_ats_param [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}]
                     port tc flow_id [committed_information_rate] [committed_burst_size]

Set Committed Information Rate (CIR) and Committed Burst Size (CBS) for a flow.

positional arguments:
  port                  MAC RX port
  tc                    Target TC value (6 or 7)
  flow_id               Flow id value (0-15)
  committed_information_rate
                        Committed Information Rate (Mbps). If omitted, show current status
  committed_burst_size  Committed Burst Size (Bytes). If omitted, show current status

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

For each flow, unique CIR and CBS values can be assigned.  
For port=0, TC=6, flow_id=3, to assign CIR = 100 Mbps and CBS = 1542 bytes, run the following command.

```sh
$ python3 set_ats_param.py --jtag_target 6 --board kc705 0 6 3 100 1542
xsdb server launched.
Updated.
Show current ATS parameter.
  Target Port                : 0
  Target TC                  : 6
  Target Flow                : 3
  Committed Information Rate : 100 Mbps
  Committed Burst Size       : 1542 Bytes
```

### set_max_residence_time.py

Set MaxResidenceTime for ATS scheduler group.

```sh
$ python3 set_max_residence_time.py -h
usage: set_max_residence_time [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}] port tc [max_residence_time]

Set MaxResidenceTime for ATS scheduler group

positional arguments:
  port                  MAC RX port
  tc                    Target TC value (6 or 7)
  max_residence_time    MaxResidenceTime (ps). If omitted, show current status

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

MaxResidenceTime determines how long a frame can stay in the switch.  
For port=0, TC=6, to assign MaxResidenceTime = 1000000 ps, run the following command.

```sh
$ python3 set_max_residence_time.py --jtag_target 6 --board kc705 0 6 1000000
xsdb server launched.
Updated.
Show current max residence time value:
  Target Port        : 0
  Target TC          : 6
  Max Residence Time : 1.0 us
```

### set_processing_delay_max.py

Modify processing_delay_max value.

```sh
$ python3 set_processing_delay_max.py -h
usage: set_processing_delay_max [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}] [processing_delay_max]

Modify processing_delay_max value

positional arguments:
  processing_delay_max  Processing Delay Max (PDM) value in ps. If omitted, show current status

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

Processing Delay Max (PDM) is a value that indicates the internal latency of the switch.  
As default, this value is optimized to the best value got by [experiment](../../evaluation2/1).  
Therefore, users do not need to modify this value in the most situaiton.

To set PDM value to 1000000 ps, run the following command.

```sh
$ python3 set_processing_delay_max.py --jtag_target 6 --board kc705 1000000
xsdb server launched.
Updated
Show current processing delay max value:
  Processing Delay Max: 1000000 ps
```

### get_commit_hash.py

Get commit hash used to implement the current bitstream.

```sh
$ python3 get_commit_hash.py -h
usage: get_commit_hash [-h] [--jtag_target JTAG_TARGET]
                       [--board {kc705}]

Get commit hash used to implement the current bitstream

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select
                        interactively
  --board {kc705}
                        Target board
```
