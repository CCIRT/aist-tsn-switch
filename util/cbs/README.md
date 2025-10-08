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
# Python scripts for CBS

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

### set_traffic_class.py

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

You can also omit value field and read register values in other Python scripts.  
Please see the command help to find which arguments can be omitted or not.

### set_slope.py

Change the values of idleSlope and sendSlope.

```sh
$ python3 set_slope.py -h
usage: set_slope [-h] [--hi_credit HI_CREDIT] [--lo_credit LO_CREDIT] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}]
                 tc [idle_slope] [send_slope]

Change the values of idleSlope and sendSlope

positional arguments:
  tc                    Target TC value (6 or 7)
  idle_slope            idleSlope value (kbps). If omitted, show current status
  send_slope            sendSlope value (kbps). If omitted, show current status

options:
  -h, --help            show this help message and exit
  --hi_credit HI_CREDIT
                        high credit value
  --lo_credit LO_CREDIT
                        low credit value
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

In CBS switch, we can apply credit-based-shaper (CBS) to TC6 and TC7 frames.   

To assign 100,000 kbps idleSlope and -900,000 kbps sendSlope to TC6, frames, run the following command.

```sh
$ python3 set_slope.py --jtag_target 12 --board zedboard 6 100000 -900000
xsdb server launched.
Updated
Show current CBS status.
  Target TC: 6
  idleSlope: 100000 kbps
  sendSlope: -900000 kbps
  HiCredit: 2147483647 kbps
  LoCredit: -2147483648 kbps
```

### set_flow_control.py

Enable/disable flow control and frame drop functions on RX path.

```sh
$ python3 set_flow_control.py --jtag_target 12 --board zedboard -h
usage: set_flow_control [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard}] [flow_control_enable]

Enable/disable flow control and frame drop functions on RX path

positional arguments:
  flow_control_enable   flow control enable. If omitted, show current status

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard}
                        Target board
```

set_flow_control.py toggles 2 flow control mechanism in the switch.

- TEMAC's flow control (Global Pause). default=off
- Internal FIFO-based frame drop function. default=on
  - If FIFO becomes almost full, the later frames will be dropped.

To disable TEMAC's flow control and enable Internal FIFO-based drop function, run the following command.

```sh
$ python3 set_flow_control.py --jtag_target 12 --board zedboard 0
xsdb server launched.
Updated.
Show current flow control status:
  TEMAC flow control: OFF
  Frame drop functions: ON
```

### set_pulse.py

This script can be used in [ZedBoard with probes](../../docs/cbs-switch/with_probes/design_top.md) design.  

```
$ python3 set_pulse.py -h
usage: set_pulse [-h] [--jtag_target JTAG_TARGET] [--board {kc705,zedboard,zedboard_with_probes}] {probe,width} ...

Change pulse_generator registers

positional arguments:
  {probe,width}         Action. probe or width
    probe               Set probe port
    width               Set pulse width

options:
  -h, --help            show this help message and exit
  --jtag_target JTAG_TARGET
                        AXI JTAG target. If omitted, select interactively
  --board {kc705,zedboard,zedboard_with_probes}
                        Target board

$ python3 set_pulse.py probe -h
usage: set_pulse probe [-h] output_pin [probe]

positional arguments:
  output_pin  output pin
  probe       Probe value. If omitted, show current status

options:
  -h, --help  show this help message and exit

$ python3 set_pulse.py width -h
usage: set_pulse width [-h] [pulse_width]

positional arguments:
  pulse_width  Pulse width. If omitted, show current status

options:
  -h, --help   show this help message and exit
```

To enable all input probes pin and output to port 1, run the following command.

```
$ python3 set_pulse.py --board zedboard_with_probes --jtag_target 12 probe 1 0xff_ffffffff
xsdb server launched.
Updated.
Show current probe value:
  Output pin: 1
  Mask: 0xffffffffff
```

To set pulse width to 1500, run the following command.

```
$ python3 set_pulse.py --board zedboard_with_probes --jtag_target 12 width 1500
xsdb server launched.
Show current pulse width:
  Pulse width: 1500 cycles
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
