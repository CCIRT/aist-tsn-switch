# ATS evaluation data 4

## Files

```
├── README.md       : This file
├── eval.py         : evaluation script
├── plot.py         : plot script
└── results         : result directory
```

## Network configuration

This experiment send 2 flows from a ef_crafter.

```mermaid
graph LR

subgraph TSN-EFCC
craft2[EFCrafter 2]
fport2[Port 2]
fport3[Port 3]

craft2 -->|flow1| fport2
craft2 -->|flow2| fport2
end

subgraph TSN-Switch
slogic[Switch Logic]
sport0[Port 0]
sport1[Port 1]
sport2[Port 2]
sport3[Port 3]

sport0 --- slogic
sport1 --- slogic
sport2 --- slogic
sport3 --- slogic
end

fport2 --- sport2
fport3 --- sport3
```

## ATS configuration

- TC7
  - flow1: 
    - CommittedInformationRate: 100 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 26,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
  - flow2: 
    - CommittedInformationRate: 200 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 26,000,000 ps
    - MaxResidenceTime: 134,217,728 ps

## Input pattern

- frame size: 1522 Bytes
- the number of frames: 1000
- input traffic classes: TC7
- input rate:
  - flow1: 500 Mbps
  - flow2: 500 Mbps

## Experiment result

This graph shows the arrival rate of flow1 and flow2.

![](./results/receive_rate.png)

This graph shows the frame interval of arrived frame of flow1 and flow2.

![](./results/interval.png)

