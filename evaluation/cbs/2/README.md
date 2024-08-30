# CBS evaluation data 2

## Files

```
├── *_RX.csv                : plget's Raw Data (RX hardware timestamp)
├── *_TX.csv                : plget's Raw Data (TX hardware timestamp)
├── README.md               : This file
└── results_2.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC5)
  - enp4s0.4
    - 10.0.0.1 (TC7)
  - enp4s0.5
    - 172.16.0.1 (TC6)
- Host B (= Host A)
  - enp4s0
    - 192.168.1.2 (TC5)
  - enp4s0.4
    - 10.0.0.2 (TC7)
  - enp4s0.5
    - 172.16.0.2 (TC6)
- Host C
  - enp5s0
    - 192.168.1.3 (TC5)
  - enp5s0.4
    - 10.0.0.3 (TC7)
  - enp5s0.5
    - 172.16.0.3 (TC6)

## CBS configuration
- TC7
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %
- TC6
    - idleSlope: 1 % (10 Mbps)
    - sendSlope: -99 %

## Additional setup

- Modify the FPGA registers to set idleSlope, sendSlope, maxCredit, and minCredit.

### Setting for Host A
none.

### Setting for Host B
none.

## Measurement Procedure

### plget (TC7)
- Modify FPGA registers to treat communication without VLAN TAG as TC7.
- Host B plget-RX
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A plget-TX
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```

### plget (TC6)
- Modify FPGA registers to treat communication without VLAN TAG as TC6.
- Host B plget-RX
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A plget-TX
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```

### plget (TC5)
- Modify FPGA registers to treat communication without VLAN TAG as TC5.
- Host B plget-RX
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A plget-TX
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```
