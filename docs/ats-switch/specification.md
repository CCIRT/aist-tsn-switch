# Specifications of 1GbE ats-switch

This document describes specifications of the 1GbE, 4-port L2 switch with ATS implemented on FPGA.

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
- Support auto negotiation

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
- Wildcard matching is supported. If a field is set as wildcard, it can match any IP or port value.
- Frames without IPv4 header like ARP are always detected to flow 0

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

## How to perform register settings

Please use [our utility scripts](../../util).

