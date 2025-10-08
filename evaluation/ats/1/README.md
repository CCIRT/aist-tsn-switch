# ATS evaluation data 1

## Files

```
├── *_RX.csv                : plget's Raw Data (RX hardware timestamp)
├── *_TX.csv                : plget's Raw Data (TX hardware timestamp)
├── README.md               : This file
└── results_1.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC5 or TC7)
- Host B (= Host A)
  - enp4s0
    - 192.168.1.2 (TC5 or TC7)

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

### evaluation 1A (TC5)
- Modify FPGA registers to treat communication without VLAN TAG as TC5.
- Change `<filesize>` from 64 Bytes to 1500 Bytes and do the following.
  - Host B plget-RX
    ```shell
    $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
    ```
  - Host A plget-TX
    ```shell
    $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l <framesize> -a 192.168.1.2 -f lat,hwts,ipgap
    ```

### evaluation 1B-2a (TC7)
- Modify FPGA registers to treat communication without VLAN TAG as TC7.
- Set CommittedInformationRate for Port0 input and Port1 output flows to 100 Mbps.
- Set CommittedInformationRate for flows from Port0 to Port1 to 100 Mbps.
- Change `<filesize>` from 64 Bytes to 1500 Bytes and do the following.
  - Host B plget-RX
    ```shell
    $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
    ```
  - Host A plget-TX
    ```shell
    $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l <framesize> -a 192.168.1.2 -f lat,hwts,ipgap
    ```

### evaluation 1B-2a (TC7)
- Modify FPGA registers to treat communication without VLAN TAG as TC7.
- Set CommittedInformationRate for Port0 input and Port1 output flows to 10 Mbps.
- Set CommittedInformationRate for flows from Port0 to Port1 to 10 Mbps.
- Change `<filesize>` from 64 Bytes to 1500 Bytes and do the following.
  - Host B plget-RX
    ```shell
    $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
    ```
  - Host A plget-TX
    ```shell
    $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l <framesize> -a 192.168.1.2 -f lat,hwts,ipgap
    ```

### evaluation 1F
- Modify FPGA registers to treat communication without VLAN TAG as TC7.
- Set CommittedInformationRate for Port0 input and Port1 output flows to 100 Mbps.
- Set CommittedInformationRate for flows from Port0 to Port1 to 100 Mbps.
- Set ProcessingDelayMax to 0 ps or 50000000 ps or more.
- Change `<filesize>` to 64Byte and 1500Byte and do the following.
  - Host B plget-RX
    ```shell
    $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
    ```
  - Host A plget-TX
    ```shell
    $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l <framesize> -a 192.168.1.2 -f lat,hwts,ipgap
    ```

