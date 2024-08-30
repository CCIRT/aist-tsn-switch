# ATS evaluation data 10

## Files

```
├── *_RX.csv                : plget's Raw Data (RX hardware timestamp)
├── *_TX.csv                : plget's Raw Data (TX hardware timestamp)
├── README.md               : This file
└── results_10.xlsx         : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC6)
- Host B (= Host A)
  - enp5s0
    - 192.168.1.2 (TC6)
  - enp5s0.4
    - 10.0.0.2 (TC7)
  - enp5s0.5
    - 172.16.0.2 (TC5)
- Host C
  - enp4s0.4
    - 10.0.0.3 (TC7)
  - enp4s0.5
    - 172.16.0.3 (TC5)

## ATS configuration (Initial)
- TC7
  - flow1
    - 10.0.0.3:0 -> 10.0.0.2:5201
    - CommittedInformationRate: 100 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
  - other flow (not used)
    - 255.255.255.255:65535 -> 255.255.255.255:65535 (ANY communication)
    - CommittedInformationRate: 1000 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
- TC6
  - flow1
    - 192.168.1.1:0 -> 192.168.1.2:385
    - CommittedInformationRate: 100 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
  - other flow (not used)
    - 255.255.255.255:65535 -> 255.255.255.255:65535 (ANY communication)
    - CommittedInformationRate: 1000 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps

## Additional setup

- Modify the FPGA registers to set CommittedInformationRate.
- Modify FPGA registers to treat communication without VLAN TAG as TC6.
- Modify the FPGA register to treat communication with a VLAN TAG of PCP=3 as TC7.
- Modify the FPGA register to treat communication with a VLAN TAG of PCP=2 as TC5.

### Setting for Host A
none.

### Setting for Host B
none.

### Setting for Host C
none.

## Measurement Procedure

### Execute interrupt communications from Host C to Host B (TC7)
- Host B (server)
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5201
   ```
- Host C (client)
   ```shell
   $ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 100M -t 600
   ```

### Execute interrupt communications from Host C to Host B (TC5)
- Host B (server)
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5202
   ```
- Host C (client)
   ```shell
   $ iperf3 -c 172.16.0.2 -p 5202 -u -l 1472 -b 900M -t 600
   ```

### Measure latency from Host A to Host B (TC6) by plget
- Host B (RX)
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A (TX)
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.2 -f lat,hwts,ipgap
   ```
