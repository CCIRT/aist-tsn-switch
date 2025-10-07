# ATS evaluation data 1

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
craft2[EFCrafter 2]
fport2[Port 2]
fport3[Port 3]

craft2 --- fport2
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
  - CommittedInformationRate: 100 Mbps
  - CommittedBurstSize: 1542 Byte
  - ProcessingDelayMax: 26,000,000 ps
  - MaxResidenceTime: 134,217,728 ps
- TC6
  - CommittedInformationRate: 100 Mbps
  - CommittedBurstSize: 1542 Byte
  - ProcessingDelayMax: 26,000,000 ps
  - MaxResidenceTime: 134,217,728 ps

## Input pattern

- frame size: 64B, 100B, 300B, 500B, 700B, 900B, 110B, 1300B, 1500B
- the number of frames: 1000
- input traffic classes: TC5, TC7
- input rate: less than 5 Mbps

## Experiment result

These graphs show the average, minimum, maximum, and standard deviation of frame latency.

![](./results/avg_lat.png)
![](./results/min_lat.png)
![](./results/max_lat.png)
![](./results/std_lat.png)

### Processing Delay Max (PDM) measurement

These graphs show the average, minimum, maximum, and standard deviation of frame latency of TC7, with different PDM values.

![](./results/avg_lat_pdm.png)
![](./results/min_lat_pdm.png)
![](./results/max_lat_pdm.png)
![](./results/std_lat_pdm.png)
