# CBS evaluation data 3

## Files

```
├── *_RX.csv                : plget's Raw Data (RX hardware timestamp)
├── *_TX.csv                : plget's Raw Data (TX hardware timestamp)
├── README.md               : This file
└── results_3.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC7)
- Host B (= Host A)
  - enp4s0
    - 192.168.1.2 (TC7)

## CBS configuration
- TC7
    - idleSlope: 0.1 ~ 100 % (1 ~ 1000 Mbps)
    - sendSlope: -99.9 ~ 0 %
- TC6 (not used)
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %

## Additional setup

- Modify FPGA registers to treat communication without VLAN TAG as TC7.

### Setting for Host A
none.

### Setting for Host B
none.

## Measurement Procedure

### Measure latency with plget (TC7)
- Modify the FPGA registers to set idleSlope, sendSlope, maxCredit, and minCredit.
- Host B (RX)
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A (TX)
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```
