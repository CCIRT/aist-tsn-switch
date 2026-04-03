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

### describe_xdb_target.py

describe xsdb target with unique JTAG ID.

```sh
$ python3 describe_xsdb_target.py --help
usage: describe_xsdb_target.py [-h] [--url URL]

options:
  -h, --help  show this help message and exit
  --url URL   target URI of xsdb server. If omitted, connect to localhost
```

```sh
$ python3 describe_xsdb_target.py
xsdb server launched.
1: xc7k325t (Digilent JTAG-SMT1 210203AB909BA)
    2: Legacy Debug Hub (Digilent JTAG-SMT1 210203AB909BA)
        3: JTAG2AXI (Digilent JTAG-SMT1 210203AB909BA)
4: APU (Digilent Zed 210248687025)
    5: ARM Cortex-A9 MPCore #0 (Digilent Zed 210248687025)
    6: ARM Cortex-A9 MPCore #1 (Digilent Zed 210248687025)
7: xc7z020 (Digilent Zed 210248687025)
    8: Legacy Debug Hub (Digilent Zed 210248687025)
        9: JTAG2AXI (Digilent Zed 210248687025)
10: xcu26_ux35 (Xilinx Alveo-ADK-2-0 FT4232H 507711333S04AA)
    11: Legacy Debug Hub (Xilinx Alveo-ADK-2-0 FT4232H 507711333S04AA)
```
