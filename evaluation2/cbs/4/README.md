# CBS evaluation data 4

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

## CBS configuration

- TC7 (default)
  - idleSlope: 100 % (1000 Mbps)
  - sendSlope: -0 %

## Input pattern

- frame size: 1500 B
- the number of frames: 1000
- input traffic classes: 
  - pattern (A):
    - flow1: TC5
    - flow2: TC4
  - pattern (B):
    - flow1: TC5
    - flow2: TC5
  - pattern (C):
    - flow1: TC7
    - flow2: TC5
  - pattern (D):
    - flow1: TC7 (The slopes is configured to be the same value with input rate)
    - flow2: TC5
- input rate:
  - flow1: 0, 200, 400, 600, 800, 1000 Mbps
  - flow2: 1000 Mbps

## Experiment result

These graphs show the frame arrival rate of frames of each TC, and frame loss rate of each TC.

### pattern (A)

![](./results/arrival_rate_tc5_tc4.png)
![](./results/frame_loss_tc5_tc4.png)

### pattern (B)

![](./results/arrival_rate_tc5_tc5.png)
![](./results/frame_loss_tc5_tc5.png)

### pattern (C)

![](./results/arrival_rate_tc7_tc5.png)
![](./results/frame_loss_tc7_tc5.png)

### pattern (D)

![](./results/arrival_rate_tc7_tc5_with_cbs.png)
![](./results/frame_loss_tc7_tc5_with_cbs.png)

