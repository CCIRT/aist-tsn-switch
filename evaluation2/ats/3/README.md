# ATS evaluation data 3

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
  - CommittedInformationRate: 100, 200, 400, 600, 800, 1000 Mbps
  - CommittedBurstSize: 1542 Byte
  - ProcessingDelayMax: 26,000,000 ps
  - MaxResidenceTime: 134,217,728 ps

## Input pattern

- frame size: 1522 Bytes
- the number of frames: 100
- input traffic classes: TC7
- input rate: 1000 Mbps
- committed information rate: 100, 200, 400, 600, 800, 1000 Mbps

## Experiment result

This graph show the arrival rate of frame, and the theoretical value.

![](./results/arrival_rate.png)

This graph show the frame loss rate of frame, and the theoretical value.

![](./results/frame_loss.png)

This graph show the minimum, average and maximum of frame latency, and the theoretical value.

![](./results/recv_interval.png)
