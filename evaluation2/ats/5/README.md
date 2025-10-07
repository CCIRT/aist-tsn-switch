# ATS evaluation data 5

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
  - flow1: 0, 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000 Mbps
  - flow2: 1000 Mbps

## Experiment result

This graph shows the arrival rate and frame loss rate of flow1 (TC7) and flow2 (TC5) at different input rates of flow1.

![](./results/arrival_rate_tc7_tc5.png)

![](./results/frame_loss_tc7_tc5.png)
