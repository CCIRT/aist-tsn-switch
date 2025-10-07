# ATS evaluation data 2

## Files

```
├── N=*.log                 : tcpdump's Raw Data (RX hardware timestamp)
├── README.md               : This file
└── results_2.xlsx          : Excel files containing post-processed numbers and graphs
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
    - CommittedInformationRate: 100 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
- TC6 (not used)
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
- Host B: tcpdump
  ```shell
  $ sudo ip netns exec ns1 tcpdump --time-stamp-precision nano --time-stamp-type adapter_unsynced
  ```
- Host B: iperf3 server
  ```shell
  $ sudo ip netns exec ns1 iperf3 -s -p 5201
  ```
- Host A: iperf3 client
<<<<<<< HEAD
  - Set CommittedBurstSize for Port0 input and Port1 output flows.
=======
  - Set CommittedBurstSize for flows from Port0 to Port1.
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  - Run iperf3 client to obtain the frame reception time from the tcpdump log.
    ```shell
    $ iperf3 -c 10.0.0.2 -u -b 1000M -l 1472 -p 5201 -t 1
    ```
