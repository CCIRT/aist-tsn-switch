# CBS evaluation data 2

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

## CBS configuration

- TC7
  - idleSlope: 10 % (100 Mbps)
  - sendSlope: -90 %
- TC6
  - idleSlope: 1 % (10 Mbps)
  - sendSlope: -90 %

## Input pattern

- frame size: 64B, 100B, 300B, 500B, 700B, 900B, 110B, 1300B, 1500B
- the number of frames: 1000
- input traffic classes: TC5, TC6, TC7
- input rate: less than 5 Mbps

## Experiment result

These graphs show the average, minimum, maximum, and standard deviation of frame latency.

![](./results/avg_lat.png)
![](./results/min_lat.png)
![](./results/max_lat.png)
![](./results/std_lat.png)

