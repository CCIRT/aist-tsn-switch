# ATS evaluation data 6

## Files

```
├── README.md       : This file
├── eval.py         : evaluation script
├── plot.py         : plot script
└── results         : result directory
```

## Network configuration

```mermaid
graph LR

subgraph TSN-EFCC
craft0[EFCrafter 0]
craft1[EFCrafter 1]
fport0[Port 0]
fport1[Port 1]
fport3[Port 3]

craft0 -->|flow1| fport0
craft1 -->|flow2| fport1
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

fport0 --- sport0
fport1 --- sport1
fport3 --- sport3
```

## ATS configuration

- TC7
  - CommittedInformationRate: 1000 Mbps
  - CommittedBurstSize: 1542 Byte
  - ProcessingDelayMax: 26,000,000 ps
  - MaxResidenceTime: 134,217,728 ps

## Input pattern

- frame size: 1522 Bytes
- the number of frames: 1000
- input traffic classes: TC7 (flow1) and TC5 (flow2)
- input rate:
  - flow1: 97 Mbps
  - flow2: 0, 100, 300, 500, 700, 900, 1000 Mbps

## Experiment result

This graph shows the latency of TC7 frames competing with TC5 frames.

![](./results/latency_summary.png)

This graph plots the latency of each TC7 frame, competing with 500 Mbps of TC5 frames.

![](./results/each_frame_500.png)
