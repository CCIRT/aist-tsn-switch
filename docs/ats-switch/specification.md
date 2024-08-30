# Specifications of ats-switch

This document describes specifications of the 4-port L2 switch with ATS implemented on FPGA.

## Basic specifications

- Support 1000BASE-T
  - Maximum designed speed is 1 Gbps
- Supported Ethernet frame list
  - Ethernet II
  - IEEE 802.3ac
    - Vlan tag is supported
- MTU is 1500 Byte
- Support FDB
- Detect flow from IPv4 header
- Support ATS

### Flow detection

- The flow is detected from the following four fields in the IPv4 header of the input frame
  - Src IP address
  - Src port number
  - Dst IP address
  - Dst port number
- There are 16 types of flows from 0 to 15
- Which flow an input frame is detected to be is based on register settings
  - When all four fields in the input frame match the register settings, that flow is determined
  - Match confirmation is performed in order from flows 1 to 15, and when matched, the flow is confirmed
    - In other words, if multiple flow conditions are matched, the flow will have the lowest number
  - When it does not match any flow, it is determined to be flow 0
- When the value 0 is set in the register, it is always detected to be matched regardless of the input frame value
- Frames without IPv4 header like ARP are always detected to flow 0

#### Examples

##### Register settings

- Flow = 1
  - src_ip = 192.168.1.1
  - src_port = 5201
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- Flow = 2
  - src_ip = 192.168.1.1
  - src_port 0
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- Flow = 3
  - src_ip = 0.0.0.0
  - src_port 0
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- Flow = 4 ~ 15
  - src_ip = 255.255.255.255
  - src_port 65535
  - dst_ip = 255.255.255.255
  - dst_port = 65535

##### Behavior

- When the following frame is input, Flow = 1 will be detected
  - src_ip = 192.168.1.1
  - src_port = 5201
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- When the following frame is input, Flow = 2 will be detected
  - src_ip = 192.168.1.1
  - src_port = 5000
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- When the following frame is input, Flow = 3 will be detected
  - src_ip = 192.168.1.3
  - src_port = 5201
  - dst_ip = 192.168.1.2
  - dst_port = 5202
- When the following frame is input, Flow = 0 will be detected
  - src_ip = 192.168.1.1
  - src_port = 5201
  - dst_ip = 192.168.1.2
  - dst_port = 5203

### ATS behavior

- ATS means Asynchronous Traffic Shaping algorithm
- ATS behavior conform to IEEE Std 802.1Q-2022 8.6.11 ATS Scheduler state machines
- ATS has following parameters
  - CommittedInformationRate
  - CommittedBurstSize
  - MaxResidenceTime
- The parameters can set independently per input port, priority and flow
  - However, MaxResidenceTime is shared between flows
- Internally, time is managed as unsigned integer 72 bit
  - The value is zero when the power is turned on, and is incremented by 8,000 every 8 ns
  - Overflow will occur, but only 149 years after the power is turned on
    - 2^72 ps = 4.72+21 ps = 4.72+9 s = 54,657 days = 149 years

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

| Name                                          | Address     | Type                    | Initial value   | Description                                                 |
|-----------------------------------------------|-------------|-------------------------|----------------:|-------------------------------------------------------------|
| detect_flow (Input Port = 0, Priority = 0)    | 0x0000_0000 | -                       | -               | Include following registers                                 |
|  ├ src_ip   (Flow = 1)                        |  ├ + 0x0000 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 1: IPv4 Src IP address                  |
|  ├ src_port (Flow = 1)                        |  ├ + 0x0004 | Unsigned Integer 16 bit | 66535           | Condition of Flow = 1: IPv4 Src port number                 |
|  ├ dst_ip   (Flow = 1)                        |  ├ + 0x0008 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 1: IPv4 Dst IP address                  |
|  ├ dst_port (Flow = 1)                        |  ├ + 0x000C | Unsigned Integer 16 bit | 66535           | Condition of Flow = 1: IPv4 Dst port number                 |
|  ├ src_ip   (Flow = 2)                        |  ├ + 0x0010 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 2: IPv4 Src IP address                  |
|  ├ src_port (Flow = 2)                        |  ├ + 0x0014 | Unsigned Integer 16 bit | 66535           | Condition of Flow = 2: IPv4 Src port number                 |
|  ├ dst_ip   (Flow = 2)                        |  ├ + 0x0018 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 2: IPv4 Dst IP address                  |
|  ├ dst_port (Flow = 2)                        |  ├ + 0x001C | Unsigned Integer 16 bit | 66535           | Condition of Flow = 2: IPv4 Dst port number                 |
|    ...                                        |    ...      | ...                     | ...             | ...                                                         |
|  ├ src_ip   (Flow = 15)                       |  ├ + 0x00E0 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 15: IPv4 Src IP address                 |
|  ├ src_port (Flow = 15)                       |  ├ + 0x00E4 | Unsigned Integer 16 bit | 65535           | Condition of Flow = 15: IPv4 Src port number                |
|  ├ dst_ip   (Flow = 15)                       |  ├ + 0x00E8 | Unsigned Integer 32 bit | 255.255.255.255 | Condition of Flow = 15: IPv4 Dst Ip address                 |
|  └ dst_port (Flow = 15)                       |  └ + 0x00EC | Unsigned Integer 16 bit | 65535           | Condition of Flow = 15: IPv4 Dst port number                |
| process_frame (Input Port = 0, Priority = 0)  | 0x0000_1000 | -                       | -               | Include following registers                                 |
|  ├ committed_information_rate_inv (Flow = 0)  |  ├ + 0x0000 | Unsigned Integer 32 bit | 0               | Committed Information Rate of ATS algorithm: set in ps/Byte |
|  ├ committed_burst_size           (Flow = 0)  |  ├ + 0x0004 | Unsigned Integer 32 bit | 0               | Committed Burst Size of ATS algorithm: set in Byte          |
|  ├ committed_information_rate_inv (Flow = 1)  |  ├ + 0x0008 | Unsigned Integer 32 bit | 0               | Refer to committed_information_rate_inv (Flow = 0)          |
|  ├ committed_burst_size           (Flow = 1)  |  ├ + 0x000C | Unsigned Integer 32 bit | 0               | Refer to committed_burst_size (Flow = 0)                    |
|    ...                                        |    ...      | ...                     | ...             | ...                                                         |
|  ├ committed_information_rate_inv (Flow = 15) |  ├ + 0x0078 | Unsigned Integer 32 bit | 0               | Refer to committed_information_rate_inv (Flow = 0)          |
|  ├ committed_burst_size           (Flow = 15) |  ├ + 0x007C | Unsigned Integer 32 bit | 0               | Refer to committed_burst_size (Flow = 0)                    |
|  └ max_residence_time                         |  └ + 0x0080 | Unsigned Integer 72 bit | All Hi          | Max Residence Time of ATS algorithm: set in ps              |
| detect_flow   (Input Port = 0, Priority = 1)  | 0x0000_2000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 0, Priority = 1)  | 0x0000_3000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 1, Priority = 0)  | 0x0000_4000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 1, Priority = 0)  | 0x0000_5000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 1, Priority = 1)  | 0x0000_6000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 1, Priority = 1)  | 0x0000_7000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 2, Priority = 0)  | 0x0000_8000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 2, Priority = 0)  | 0x0000_9000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 2, Priority = 1)  | 0x0000_A000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 2, Priority = 1)  | 0x0000_B000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 3, Priority = 0)  | 0x0000_C000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 3, Priority = 0)  | 0x0000_D000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| detect_flow   (Input Port = 3, Priority = 1)  | 0x0000_E000 | -                       | -               | Refer to detect_flow   (Input Port = 0, Priority = 0)       |
| process_frame (Input Port = 3, Priority = 1)  | 0x0000_F000 | -                       | -               | Refer to process_frame (Input Port = 0, Priority = 0)       |
| enable_pause_req_and_drop_enable              | 0x0001_0000 | Boolean 1 bit           | False           | When True, enable pause_req of TEMAC                        |
| gpio_processing_delay_max                     | 0x0002_0000 | Unsigned Integer 72 bit | 50000000        | Processing Delay Max of ATS algorithm: set in ps            |
| priority_mapper_0                             | 0x5000_0000 | -                       | -               | -                                                           |
|  ├ priority (PCP = 0)                         |  ├ + 0x0000 | Unsigned Integer 3 bit  | 1               | Priority when PCP = 0                                       |
|  ├ priority (PCP = 1)                         |  ├ + 0x0004 | Unsigned Integer 3 bit  | 0               | Priority when PCP = 1                                       |
|  ├ priority (PCP = 2)                         |  ├ + 0x0008 | Unsigned Integer 3 bit  | 6               | Priority when PCP = 2                                       |
|  ├ priority (PCP = 3)                         |  ├ + 0x000C | Unsigned Integer 3 bit  | 7               | Priority when PCP = 3                                       |
|  ├ priority (PCP = 4)                         |  ├ + 0x0010 | Unsigned Integer 3 bit  | 2               | Priority when PCP = 4                                       |
|  ├ priority (PCP = 5)                         |  ├ + 0x0014 | Unsigned Integer 3 bit  | 3               | Priority when PCP = 5                                       |
|  ├ priority (PCP = 6)                         |  ├ + 0x0018 | Unsigned Integer 3 bit  | 4               | Priority when PCP = 6                                       |
|  ├ priority (PCP = 7)                         |  ├ + 0x001C | Unsigned Integer 3 bit  | 5               | Priority when PCP = 7                                       |
|  └ priority (No vlan tag)                     |  └ + 0x0020 | Unsigned Integer 3 bit  | 1               | Priority when no vlan tag                                   |
| priority_mapper_1                             | 0x5001_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_2                             | 0x5002_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_3                             | 0x5003_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_4                             | 0x5004_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_5                             | 0x5005_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_6                             | 0x5006_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_7                             | 0x5007_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_8                             | 0x5008_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_9                             | 0x5009_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_10                            | 0x500A_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_11                            | 0x500B_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_12                            | 0x500C_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_13                            | 0x500D_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_14                            | 0x500E_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |
| priority_mapper_15                            | 0x500F_0000 | -                       | -               | ⚠️ Must be same as priority_mapper_0                        |

#### Note: How to set IP address

- In oder to set "192.168.1.2" ("0xC0"."0xA8"."0x01"."0x02"), write "0xC0A80102"

#### Note: How to set committed_information_rate_inv

- "committed_information_rate_inv" is the reciprocal value of Committed Information Rate
- In order to set "100 Mbps", write "80,000 ps/Byte"
  - (8 bit/Byte) * 1,000,000 / (100 Mbps) = 80,000 ps/Byte
- In order to set "50 Mbps", write "160,000 ps/Byte"
  - (8 bit/Byte) * 1,000,000 / (50 Mbps) = 160,000 ps/Byte

#### Note: How to set max_residence_time

- As "max_residence_time" has 72 bits, write in three parts
  - 0x0080: Lower  32 bit
  - 0x0084: Middle 32 bit
  - 0x0088: Upper   8 bit

#### Note: How to set processing_delay_max

- As "processing_delay_max" has 72 bits, write in three parts
  - 0x20000: Lower  32 bit
  - 0x20004: Middle 32 bit
  - 0x20008: Upper   8 bit

