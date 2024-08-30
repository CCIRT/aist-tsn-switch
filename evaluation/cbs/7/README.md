# CBS evaluation data 6

## Files

```
├── *_RX.csv                : plget's Raw Data (RX hardware timestamp)
├── *_TX.csv                : plget's Raw Data (TX hardware timestamp)
├── README.md               : This file
└── results_7.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC6)
  - enp4s0.4
    - 10.0.0.1 (TC5) not used
  - enp4s0.5
    - 172.16.0.1 (TC7) not used
- Host B
  - enp4s0
    - 192.168.1.2 (TC6)
  - enp4s0.4
    - 10.0.0.2 (TC7)
  - enp4s0.5
    - 172.16.0.2 (TC5)
- Host C
  - enp5s0
    - 192.168.1.3 (TC6) not used
  - enp5s0.4
    - 10.0.0.3 (TC7)
  - enp5s0.5
    - 172.16.0.3 (TC5)

## CBS configuration
- TC7
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %
- TC6
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %

## Additional setup

- Modify the FPGA registers to set idleSlope, sendSlope, maxCredit, and minCredit.
- Modify FPGA registers to treat communication without VLAN TAG as TC6.

### Setting for Host A
- Configure PCP to treat 10.0.0.x communications as TC7 (PCP=3).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.4 0 3
   ```
- Configure PCP to treat 172.16.0.x communications as TC5 (PCP=7).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.5 0 7
   ```

### Setting for Host B
- Configure PCP to treat 10.0.0.x communications as TC7 (PCP=3).
   ```shell
   $ sudo ip netns exec ns1 vconfig set_egress_map enp5s0.4 0 3
   ```
- Configure PCP to treat 172.16.0.x communications as TC5 (PCP=7).
   ```shell
   $ sudo ip netns exec ns1 vconfig set_egress_map enp5s0.5 0 7
   ```

### Setting for Host C
- Configure PCP to treat 10.0.0.x communications as TC7 (PCP=3).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.4 0 3
   ```
- Configure PCP to treat 172.16.0.x communications as TC5 (PCP=7).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.5 0 7
   ```

## Measurement Procedure

### Execute interrupt communications from Host C to Host B (TC7)
- Host B (server)
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5201
   ```
- Host C (client)
   ```shell
   $ iperf3 -c 10.0.0.3 -p 5201 -u -l 1472 -b 100M -t 600
   ```

### Execute interrupt communications from Host C to Host B (TC5)
- Host B (server)
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5202
   ```
- Host C (client)
   ```shell
   $ iperf3 -c 172.16.0.3 -p 5202 -u -l 1472 -b 900M -t 600
   ```

### Measure latency with plget (TC6)
- Host B (RX)
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A (TX)
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```
