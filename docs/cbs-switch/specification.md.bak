<<<<<<< HEAD
# Specifications of cbs-switch

This document describes specifications of the 4-port L2 switch with CBS implemented on FPGA.
=======
# Specifications of 1GbE cbs-switch

This document describes specifications of the 1GbE, 4-port L2 switch with CBS implemented on FPGA.
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

## Basic specifications

- Support 1000BASE-T
  - Maximum designed speed is 1 Gbps
- Supported Ethernet frame list
  - Ethernet II
  - IEEE 802.3ac
    - Vlan tag is supported
- MTU is 1500 Byte
- Support FDB
- Support CBS
  - Only when priority is 7 or 6
<<<<<<< HEAD
=======
- Support auto negotiation
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

### CBS behavior

- CBS stands for Credit Based Shaping
- CBS behavior conform to IEEE Std 802.1Q-2022 8.6.8.2 Credit-based shaper algorithm
- CBS has following parameters
  - idleSlope
  - sendSlope
  - maxCredit
  - minCredit
- The parameters can set independently per output port and priority
  - However, CBS only works on priority 7 or 6
- Credits are managed as integer 32 bit
  - So, minimum value is -2147483648 and maximum value is 2147483647
  - They are managed so that no positive/negative overflow occurs

<<<<<<< HEAD
### Table of PCP vs priority

| PCP in vlan tag | Priority (= Traffic class) |
|----------------:| --------------------------:|
| 0               | 1                          |
| 1               | 0                          |
| 2               | 6                          |
| 3               | 7                          |
| 4               | 2                          |
| 5               | 3                          |
| 6               | 4                          |
| 7               | 5                          |
| (No vlan tag)   | 1                          |

- Note: These values ​​can be changed by register settings
- ⚠️ Must change settings when no communication is occurring

### Register map

| Name                                       | Address     | Type                    | Initial value | Description                                                  |
|--------------------------------------------|-------------|-------------------------|--------------:|--------------------------------------------------------------|
| idle_slope (Output Port = 0, Priority = 6) | 0x4000_0000 | Integer 32 bit          |  1            | IdleSlope parameter of Credit Based Shaping algorithm        |
| send_slope (Output Port = 0, Priority = 6) | 0x4000_0008 | Integer 32 bit          | -1            | SendSlope parameter of Credit Based Shaping algorithm        |
| max_credit (Output Port = 0, Priority = 6) | 0x4001_0000 | Integer 32 bit          |  2147483647   | MaxCredit parameter of Credit Based Shaping algorithm        |
| min_credit (Output Port = 0, Priority = 6) | 0x4001_0008 | Integer 32 bit          | -2147483648   | MinCredit parameter of Credit Based Shaping algorithm        |
| idle_slope (Output Port = 0, Priority = 7) | 0x4002_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 0, Priority = 7) | 0x4002_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 0, Priority = 7) | 0x4003_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 0, Priority = 7) | 0x4003_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 1, Priority = 6) | 0x4004_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 1, Priority = 6) | 0x4004_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 1, Priority = 6) | 0x4005_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 1, Priority = 6) | 0x4005_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 1, Priority = 7) | 0x4006_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 1, Priority = 7) | 0x4006_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 1, Priority = 7) | 0x4007_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 1, Priority = 7) | 0x4007_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 2, Priority = 6) | 0x4008_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 2, Priority = 6) | 0x4008_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 2, Priority = 6) | 0x4009_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 2, Priority = 6) | 0x4009_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 2, Priority = 7) | 0x400A_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 2, Priority = 7) | 0x400A_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 2, Priority = 7) | 0x400B_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 2, Priority = 7) | 0x400B_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 3, Priority = 6) | 0x400C_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 3, Priority = 6) | 0x400C_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 3, Priority = 6) | 0x400D_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 3, Priority = 6) | 0x400D_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| idle_slope (Output Port = 3, Priority = 7) | 0x400E_0000 | Integer 32 bit          |  1            | Refer to idle_slope (Output Port = 0, Priority = 6)          |
| send_slope (Output Port = 3, Priority = 7) | 0x400E_0008 | Integer 32 bit          | -1            | Refer to send_slope (Output Port = 0, Priority = 6)          |
| max_credit (Output Port = 3, Priority = 7) | 0x400F_0000 | Integer 32 bit          |  2147483647   | Refer to max_credit (Output Port = 0, Priority = 6)          |
| min_credit (Output Port = 3, Priority = 7) | 0x400F_0008 | Integer 32 bit          | -2147483648   | Refer to min_credit (Output Port = 0, Priority = 6)          |
| enable_pause_req_and_drop_enable           | 0x4010_0000 | Boolean  1 bit          | False         | When True, enable pause_req of TEMAC and drop_enable of FIFO |
| priority_mapper_0                          | 0x5000_0000 | -                       | -             | -                                                            |
|  ├ priority (PCP = 0)                      |  ├ + 0x0000 | Unsigned Integer 3 bit  | 1             | Priority when PCP = 0                                        |
|  ├ priority (PCP = 1)                      |  ├ + 0x0004 | Unsigned Integer 3 bit  | 0             | Priority when PCP = 1                                        |
|  ├ priority (PCP = 2)                      |  ├ + 0x0008 | Unsigned Integer 3 bit  | 6             | Priority when PCP = 2                                        |
|  ├ priority (PCP = 3)                      |  ├ + 0x000C | Unsigned Integer 3 bit  | 7             | Priority when PCP = 3                                        |
|  ├ priority (PCP = 4)                      |  ├ + 0x0010 | Unsigned Integer 3 bit  | 2             | Priority when PCP = 4                                        |
|  ├ priority (PCP = 5)                      |  ├ + 0x0014 | Unsigned Integer 3 bit  | 3             | Priority when PCP = 5                                        |
|  ├ priority (PCP = 6)                      |  ├ + 0x0018 | Unsigned Integer 3 bit  | 4             | Priority when PCP = 6                                        |
|  ├ priority (PCP = 7)                      |  ├ + 0x001C | Unsigned Integer 3 bit  | 5             | Priority when PCP = 7                                        |
|  └ priority (No vlan tag)                  |  └ + 0x0020 | Unsigned Integer 3 bit  | 1             | Priority when no vlan tag                                    |
| priority_mapper_1                          | 0x5001_0000 | -                       | -             | ⚠️ Must be same as priority_mapper_0                         |
| priority_mapper_2                          | 0x5002_0000 | -                       | -             | ⚠️ Must be same as priority_mapper_0                         |
| priority_mapper_3                          | 0x5003_0000 | -                       | -             | ⚠️ Must be same as priority_mapper_0                         |
=======
## How to perform register settings

Please use [our utility scripts](../../util).

# Specifications of 10GbE cbs-switch

This document describes specifications of the 10GbE, 4-port L2 switch with CBS implemented on FPGA.

## Basic specifications

Same as the 1GbE version except for the following.
- Support 10000BASE-R
  - Maximum designed speed is 10 Gbps
- Does not support auto negotiation

### CBS behavior

Same as the 1GbE version.

## How to perform register settings

Please use [our utility scripts](../../util).

>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
