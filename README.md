![overwiew_cbs-switch drawio](https://github.com/user-attachments/assets/c21761e5-2815-445a-99a1-44aa605878cf)# AIST-TSN
AIST-TSN is an open source project developed by the National Institute of Advanced Industrial Science and Technology (AIST), Japan.
It introduces the hardware design of an L2 network switch design supporting Time Sensitive Networks (TSN). 
We aim to provide an open platform that can be used as a reference design so scientists can implement their desired functionalities and make the different evaluations and comparisons to highlight the appropriate design choices for a given TSN system.

This repository includes two flavors of an L2 TSN switch supporting two different scheduling algorithms. Both designes are implemented and validated on an AMD Xilinx KC705 FPGA evaluation board:

- L2 switch supporting CBS:
  - [Specification]()
  - [FPGA design docs]()

- L2 switch supporting ATS:
  - [Specification]()
  - [FPGA design docs]()

## Licensing
Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
All rights reserved.
This software is released under the MIT License.

When using the provided designs in this repository, please refer to the following citations:
- CBS:
> _Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI "FPGA-based Network Switch Architecture Supporting Credit Based Shaper for Time Sensitive Networks", The 29th IEEE International Conference on Emerging Technologies and Factory Automation (ETFA2024), Sep 2024_

- ATS:
> _Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI, "Hardware design and Evaluation of an FPGA-based Network Switch Supporting Asynchronous Traffic Shaping for Time Sensitive Networking", IEEE Access, Sep 2024_
 
## Build device
**NOTE:** ⚠️ A license is required to synthesize Vivado project for KC705.
The design was implemented and validated using the following environment:
- Ubuntu 20.04.3 LTS
- CMake 3.14 or later
- Vivado v2022.1
  -Set Vivado to ```PATH```
- Set ```XILINXD_LICENSE_FILE``` to environment variables


All designs will be built by running the command below.
```
cd <Repository top>
./build_device.sh impl_all
```

Bitstreams will be generated below.

-L2 switch with ATS
  -build-device/vivado/ats-switch/ats-switch.prj/ats-switch.runs/impl_1/design_1_wrapper.bit

-L2 switch with CBS
  -build-device/vivado/cbs-switch/cbs-switch.prj/cbs-switch.runs/impl_1/design_1_wrapper.bit

## Directories
├── 3rdparty   : 3rd-party projects  
├── cmake      : Common CMake files  
├── device     : Source code for device including FPGA  
├── docs       : Documentation  
├── evaluation : Evaluation experiments and results  
└── util       : Scripts for FPGA register modification  

