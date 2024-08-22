# AIST-TSN
AIST-TSN is an open source project developed by the National Institute of Advanced Industrial Science and Technology (AIST), Japan.
It introduces the hardware design of an L2 network switch design supporting Time Sensitive Networks (TSN). 
We aim to provide an open platform that can be used as a reference design so scientists can implement their desired functionalities and make the different evaluations and comparisons to highlight the appropriate design choices for a given TSN system.

This repository includes two flavors of an L2 TSN switch supporting two different scheduling algorithms. Both designes are implemented and validated on an AMD Xilinx KC705 FPGA evaluation board:

- L2 switch supporting CBS:
  - Specification
  - FPGA design docs

- L2 switch supporting ATS:
  - Specification
  - FPGA design docs

## Licensing
Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
All rights reserved.
This software is released under the MIT License.

When using the provided designs in this repository, please refer to the following citations:
- CBS:
> Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI "FPGA-based Network Switch Architecture Supporting Credit Based Shaper for Time Sensitive Networks", The 29th IEEE International Conference on Emerging Technologies and Factory Automation (ETFA2024), Sep 2024

- ATS:
> Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI, "Hardware design and Evaluation of an FPGA-based Network Switch Supporting Asynchronous Traffic Shaping for Time Sensitive Networking", IEEE Access, Sep 2024
 
