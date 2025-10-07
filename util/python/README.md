# Python modules

This directory contains python module to control our switches.  
This directory also contains python module for our another project, [TSN-Fixure](fixstars/aist-fpga-deterministic-network/1g-tsn-prototype>) (TODO: fix link).  
TSN-EFCC is useful for testing functionality of our switches, and it is used in [evaluation2](../../evaluation2).

## Directories

```
├── ats_switch        : Python module for ATS Switch
├── cbs_switch        : Python module for CBS Switch
├── pyxsdb            : Python wrapper of xsdb command
└── tsn_efcc          : Python module for TSN-EFCC
```

## Module description

### pyxsdb

pyxsdb is a python wrapper of `xsdb`, provided by AMD Vivado™.  
With pyxsdb, users can control FPGA registers from python scripts.  
Our other python modules, such as cbs_switch, are use pyxsdb to provide their functionalities.

pyxsdb is designed to control FPGA registers, so the following xsdb commands are only supported:

- connect: connect to hw server
- target: select target device to run mrd/mwr
- mrd: read value from FPGA memory
- mwr: write value to FPGA memory

### cbs_switch

cbs_switch provides easy configuration interface of our CBS Switch.  
The following functions are provided:

- Set mapping from PCP to Traffic Class (TC).
- Set CBS parameters for each TC.

### ats_switch

ats_switch provides easy configuration interface of our ATS Switch.  
The following functions are provided:

- Set mapping from PCP to Traffic Class (TC).
- Define or undefine flow.
- Set ATS parameters for each flow.

### tsn_efcc

tsn_efcc provides easy frame generate/capture interface of our TSN EFCC (Ethernet Frame Crafter & Capture for TSN research).  
The following functions are provided:

- Test frame generation
- Test frame capture and compute statistics

To show usage of tsn_efcc, please refer to [TSN-EFCC]() document (TODO: fix link).

## How-to use python modules

Add our python modules to `PYTHONPATH`.

```sh
cd /path/to/this/directory
export PYTHONPATH=$(pwd):${PYTHONPATH}
```

Add xsdb to `PATH`.  

```sh
cd /vivado_or_vivado_lab/install/dir
source settings64.sh
```

The below code is a simple example of pyxsdb and cbs_switch module.  
This example creates pyxsdb connection, and do register settings of CBS Switch.

```python
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch

print('Open xsdb connection')
xsdb = PyXsdb()
xsdb.connect()

print('Select target')
target = xsdb.select_target()

print('Open CBS Switch')
switch = CbsSwitch(xsdb, target, design='kc705')

print('Do register settings...')
switch.set_traffic_class(priority=3, traffic_class=7)
switch.set_slope(tc=7, idle_slope=100000, send_slope=-900000)
```

<details>

<summary> Output log of the above script </summary>

`xsdb.select_target()` is an interactive function.  
Users can select the correct JTAG2AXI target for their use.

```
Open xsdb connection
xsdb server launched.
Select target
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
Please type the number of target: 3
Open CBS Switch
Do register settings...
```

</details>

To show the API specification, please read docstring of our python modules.

We also implemented helper scripts to set FPGA registers by these modules for common usecases.  
For details, please see [../cbs-python](../cbs-python) and [../ats-python](../ats-python) directory.
