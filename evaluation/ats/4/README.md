# ATS evaluation data 4

## Files

```
├── flow*.log               : tcpdump's Raw Data (RX hardware timestamp)
├── plget.md                : plget's Output Data
├── README.md               : This file
└── results_4.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0.4
    - 10.0.0.1 (TC7)
- Host B (= Host A)
  - enp5s0.4
    - 10.0.0.2 (TC7)

## ATS configuration (Initial)
- TC7
  - flow1
    - 10.0.0.1:0 -> 10.0.0.2:5201
    - CommittedInformationRate: 100 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
  - flow2
    - 10.0.0.1:0 -> 10.0.0.2:5202
    - CommittedInformationRate: 200 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
  - other flow (not used)
    - 255.255.255.255:65535 -> 255.255.255.255:65535 (ANY communication)
    - CommittedInformationRate: 1000 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
- TC6 (not used)
  - ANY flow
    - 255.255.255.255:65535 -> 255.255.255.255:65535 (ANY communication)
    - CommittedInformationRate: 1000 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps

## Additional setup
none.

### Setting for Host A
none.

### Setting for Host B
none.

## Measurement Procedure
- Host B: tcpdump (flow1 + flow2)
  ```shell
  $ sudo ip netns exec ns1 tcpdump --time-stamp-precision nano --time-stamp-type adapter_unsynced
  ```
- Host B: plget RX (flow1)
  ```shell
  $ sudo ip netns exec ns1 ./plget -i enp5s0.4 -t udp -u 5201 -m rx-rate -n 16
  ```
- Host B: plget RX (flow2)
  ```shell
  $ sudo ip netns exec ns1 ./plget -i enp5s0.4 -t udp -u 5202 -m rx-rate -n 16
  ```
- Host A: plget TX (flow1, 500 Mbps)
  ```shell
  $ sudo ./plget -i enp4s0.4 -t udp -u 5201 -m pkt-gen -n 16 -l 1500 -s 41556 -a 10.0.0.2
- Host A: plget TX (flow2, 500 Mbps)
  ```shell
  $ sudo ./plget -i enp4s0.4 -t udp -u 5202 -m pkt-gen -n 16 -l 1500 -s 41556 -a 10.0.0.2
    ```
