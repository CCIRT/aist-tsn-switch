# Specifications of 1GbE cbs-switch

This document describes specifications of the 1GbE, 4-port L2 switch with CBS implemented on FPGA.

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
- Support auto negotiation

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

## How to perform register settings

Please use [our utility scripts](../../util).

