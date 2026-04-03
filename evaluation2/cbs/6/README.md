# CBS evaluation data 6

## Files

```
|-- README.md       : This file
|-- eval.py         : evaluation script
|-- eval_base.py    : evaluation script (shared by CBS evaluation 7)
|-- plot.py         : plot script
`-- results         : result directory
```

## Network configuration

```mermaid
graph LR

subgraph TSN-EFCC
craft0[EFCrafter 0]
craft1[EFCrafter 1]
craft2[EFCrafter 2]
fport0[Port 0]
fport1[Port 1]
fport2[Port 2]
fport3[Port 3]

craft0 -->|flow1| fport0
craft1 -->|flow2| fport1
craft2 -->|flow3| fport2
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
fport2 --- sport2
fport3 --- sport3
```

## CBS configuration

- TC7
  - idleSlope: 10 % (100 Mbps)
  - sendSlope: -90 %
- TC6
  - idleSlope: 10 % (100 Mbps)
  - sendSlope: -90 %

## Input pattern

- frame size: 1500 B
- the number of frames: 1000
- input traffic classes: TC7 (flow1), TC6 (flow2) and TC5 (flow3)
- input rate:
  - pattern (A):
    - flow3 (TC7): 97 Mbps
  - pattern (B):
    - flow3 (TC7): 97 Mbps
    - flow2 (TC6): 100 Mbps
  - pattern (C):
    - flow3 (TC7): 97 Mbps
    - flow1 (TC5): 100, 200, 300, 400, 500, 600, 700, 800, 900 Mbps
  - pattern (D):
    - flow3 (TC7): 97 Mbps
    - flow2 (TC6): 100 Mbps
    - flow1 (TC5): 100, 200, 300, 400, 500, 600, 700, 800, 900 Mbps

## Experiment result

This graph shows the minimum, average and maximum of TC7 frame latency competing with frames of the other TCs.

![](./results/latency.png)

This graph shows the difference between the maximum latency of TC7 and the minimum latency of TC7, and the difference between the maximum latency of (B), (C), (D) and the maximum latency of (A).

![](./results/diff.png)
