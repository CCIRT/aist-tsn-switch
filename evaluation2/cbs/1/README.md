# CBS evaluation data 1

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

fport2 --- lb{ }
fport3 --- lb
```

### Additional setup
Port 2 and Port 3 is connected directly.

## Input pattern

- frame size: 64B or 1500B
- the number of frames: 1000
- input traffic classes: TC5, TC6, TC7
- input rate: less than 5 Mbps

## Experiment result

The graph shows the number of frames with a latency of 0 ns or 8 ns.  
As TSN-EFCC has a function of latency adjustment internally, the only visible timestamp is 0 ns or 8 ns (1-cycle dispersion).

![](./results/latency.png)
