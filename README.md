# AIST-TSN

AIST-TSN is an open source project developed by the National Institute of Advanced Industrial Science and Technology (AIST), Japan.
It introduces the hardware design of an L2 network switch supporting Time Sensitive Networks (TSN).
We aim to provide an open platform that can be used as a reference design so scientists can implement their desired functionalities and make the different evaluations and comparisons to highlight the appropriate design choices for a given TSN system.

## Designs

<<<<<<< HEAD
This repository includes two flavors of an L2 TSN switch supporting two different scheduling algorithms. Both designs are implemented and validated on an AMD Xilinx KC705 FPGA evaluation board which was attached to an [Opsero OP031-2V5 Ethernet FMC](https://ethernetfmc.com/docs/ethernet-fmc/compatibility/#series-7-boards) via the "FMC HPC" connector:

- L2 switch supporting CBS:
=======
This repository includes two flavors of an L2 TSN switch supporting two different scheduling algorithms. Both designs are implemented and validated on an AMD Xilinx KC705 FPGA evaluation board and an Avnet ZedBoard which were attached to an [Opsero OP031-2V5 Ethernet FMC](https://ethernetfmc.com/docs/ethernet-fmc/compatibility/#series-7-boards) via FMC connector:

- 1GbE L2 switch supporting CBS:
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  - [Specification](./docs/cbs-switch/specification.md)
  - [FPGA design docs](./docs/cbs-switch/design_top.md)

![alt text](./docs/cbs-switch/img/overwiew_cbs-switch.drawio.svg)

<<<<<<< HEAD
- L2 switch supporting ATS:
=======
- 1GbE L2 switch supporting ATS:
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  - [Specification](./docs/ats-switch/specification.md)
  - [FPGA design docs](./docs/ats-switch/design_top.md)

![alt text](./docs/ats-switch/img/overwiew_ats-switch.drawio.svg)

<<<<<<< HEAD
=======

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
## Licensing

Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
All rights reserved.

This software is released under the [MIT License](LICENSE).

When using the provided designs in this repository, please refer to the following citations:

CBS:
<<<<<<< HEAD
> Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI "FPGA-based Network Switch Architecture Supporting Credit Based Shaper for Time Sensitive Networks", The 29th IEEE International Conference on Emerging Technologies and Factory Automation - [ETFA2024](./docs/IEEEAccess_June2024_Published_corrected.pdf), pp. 1-8, Sep 2024
=======
> Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI "FPGA-based Network Switch Architecture Supporting Credit Based Shaper for Time Sensitive Networks", The 29th IEEE International Conference on Emerging Technologies and Factory Automation (ETFA2024), Sep 2024
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

ATS:
> Akram BEN AHMED, Takahiro HIROFUCHI, and Takaaki FUKAI, "Hardware design and Evaluation of an FPGA-based Network Switch Supporting Asynchronous Traffic Shaping for Time Sensitive Networking", [IEEE Access](https://ieeexplore.ieee.org/document/10658978), vol. 12, pp. 123149-123165, Aug 2024 

<<<<<<< HEAD
### Erratum Notice
Unfortunately, we have discovered the presence of a couple of typos in the above published IEEE Access article.
We urge readers to pay attention to these typos and refer to the [Corrected version](./docs/IEEEAccess_June2024_Published_corrected.pdf) as they may compromise the correct understanding of our proposed approach. The discovered typos are summarized as follow:

**Page 5, Section IV.A:** 
> Physical Coding Sublayer (PCS) <br>

Must be corrected to:<br>

> Frame Check Sequence (FCS)

**Page 6, Algoithm 1:** 
> BucketFullTime = BucketEmptyTime **/** EmptyToFullDuration; <br>
> SchedulerEligibilityTime = BucketEmptyTime **/** LengthRecoveryDuration; <br>

Must be corrected to:<br>

> BucketFullTime = BucketEmptyTime **+** EmptyToFullDuration; <br>
> SchedulerEligibilityTime = BucketEmptyTime **+** LengthRecoveryDuration; 

**Page 7, End of Section IV-C-2:**
> In our prototype, ... the Input Ethernet frame embedded in the **Ethernet** Header, <br>

Must be corrected to:<br>

> In our prototype, ... the Input Ethernet frame embedded in the **IP** Header 

**Page 8, End of Section IV-E:**
> If EligibilityTime **<** (t), ... <br>
> EligibilityTime **≥** (t), ...

Must be corrected to:
> If  (t) **<** EligibilityTime, ... <br>
>  (t) **≥** EligibilityTime, ...
=======
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

We would be happy to hear from you when you use the deliverables from this repository in your project.
It will be our encouragement.

## Requirements

The design was implemented and validated using the following environment

<<<<<<< HEAD
### Hardware

- AMD Kintex 7 FPGA KC705 Evaluation Kit
- Opsero OP031 Ethernet FMC
  - Connect to the "FMC HPC" connector on KC705
=======
### Hardware (1G)

- AMD Kintex 7 FPGA KC705 Evaluation Kit or Avnet ZedBoard
- Opsero OP031-2V5 Ethernet FMC
  - Connect to the "FMC HPC" connector (KC705)
  - Connect to the "FMC LPC" connector (ZedBoard)

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

### Software

- Ubuntu 20.04.3 LTS
- Vivado v2022.1
  - Set the `PATH` environment variable for Vivado properly
- CMake 3.14 or later

## How to build the device

A license for AMD Tri-mode Ethernet MAC (TEMAC) IP is required to synthesize the Vivado project. You can obtain the evaluation license free of charge.

- Set the `XILINXD_LICENSE_FILE` environment variable properly to refer to the license file.

All designs will be built by running the command below.

```sh
cd <Repository top>
<<<<<<< HEAD
./build_device.sh impl_all
=======
# KC705 design
./build_device.sh impl_all
# ZedBoard design
./build_device.sh impl_all-zedboard
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
```

Bitstreams will be generated below.

- L2 switch with ATS
<<<<<<< HEAD
  - `./build-device/vivado/ats-switch/ats-switch.prj/ats-switch.runs/impl_1/design_1_wrapper.bit`
- L2 switch with CBS
  - `build-device/vivado/cbs-switch/cbs-switch.prj/cbs-switch.runs/impl_1/design_1_wrapper.bit`
=======
  - `./build-device/vivado/ats-switch/ats-switch.prj/ats-switch.runs/impl_1/design_1_wrapper.bit` (KC705)
  - `./build-device/vivado/ats-switch/ats-switch-zedboard.prj/ats-switch-zedboard.runs/impl_1/design_1_wrapper.bit` (ZedBoard)
- L2 switch with CBS
  - `build-device/vivado/cbs-switch/cbs-switch.prj/cbs-switch.runs/impl_1/design_1_wrapper.bit` (KC705)
  - `build-device/vivado/cbs-switch/cbs-switch-zedboard.prj/cbs-switch-zedboard.runs/impl_1/design_1_wrapper.bit` (ZedBoard)

## Notes for each FPGA board
- KC705
  - Switch settings
    - Set DIP switch 2, labeled SW11, to the upper position as shown in the photo.
    - The status of the other switches does not matter.

      <img src="./docs/img/sw_settings_kc705.jpg" width="25%">

- Zedboard
  - Switch settings
    - To match VADJ to OP031-2V5, please short the jumper on J18 to the 2V5 position.
    - Set the SW1 toggle switch to the upper position as shown in the photo.
    - The status of the other switches does not matter.

      <img src="./docs/img/sw_settings_zedboard.jpg" width="25%">

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

## Directories

- [3rdparty](3rdparty): 3rd-party projects
- [cmake](cmake): Common CMake files
- [device](device): Source code. See [device/README.md](device/README.md).
- [docs](docs): Documentation (e.g., design overviews and register maps)
- [evaluation](evaluation): Evaluation data for the papers. See [evaluation/README.md](evaluation/README.md) for more info.
<<<<<<< HEAD
- [util](util): Scripts for FPGA register modification

## Contact

The Continuum Computing Infrastructure Research Team (CCIRT), the Digital Architecture Research Center (DigiARC), the National Institute of Advanced Industrial Science and Technology (AIST), Japan.
=======
- [evaluation2](evaluation2): Evaluation data with TSN-EFCC (TODO: link). See [evaluation2/README.md](evaluation2/README.md) for more info.
- [util](util): Scripts for FPGA register modification and python modules to use our switches.

## Release notes

- v2.0_10-2025
  - Added FPGA design of 1GbE, L2 switch with CBS for ZedBoard
  - Added FPGA design of 1GbE, L2 switch with ATS for ZedBoard
  - Added python modules to make our switches easier to use.
    - Added python scripts to perform register settings that are more useful than TCL scripts.
    - Obsoleted TCL scripts
  - Added evaluation scripts and results with our another project called TSN-EFCC. The evaluation is done in more complicated input patterns, and is easier to reproduce.
  - Optimized RTL implementation to reduce resources and latency.
- v1.0_09-2024
  - Initial release
  - FPGA design of 1GbE, L2 switch with CBS for KC705
  - FPGA design of 1GbE, L2 switch with ATS for KC705
  - Evaluation scripts and results for the papers
  - TCL script to perform register settings

## Contact

The Continuum Computing Architcture Research Group (CCARG), Inteligent Platforms Research Insititute (IPRI), the National Institute of Advanced Industrial Science and Technology (AIST), Japan.
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

E-mail: <M-digiarc-ccirt-contact-ml@aist.go.jp>

We are hiring postdocs and technical staffs. Collaborations are also welcome.

## Acknowledgment

This program is based on results obtained from the project, "Research and
Development Project of the Enhanced infrastructures for Post 5G Information and
Communication Systems" (JPNP20017), commissioned by the New Energy and
Industrial Technology Development Organization (NEDO).
