# ATS evaluation data 5

## Files

```
├── iperf.md                : iperf3's Output Data
├── README.md               : This file
└── results_5.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0.4
    - 10.0.0.1 (TC7)
- Host B (= Host A)
  - enp5s0.4
    - 10.0.0.2 (TC7)
  - enp5s0
    - 192.168.1.2 (TC5)
- Host C
  - enp4s0
    - 192.168.1.3 (TC5)

## ATS configuration
- TC7
    - CommittedInformationRate: ~~100 Mbps~~ **1000 Mbps**
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps
- TC6 (not used)
    - CommittedInformationRate: 1000 Mbps
    - CommittedBurstSize: 1542 Byte
    - ProcessingDelayMax: 50,000,000 ps
    - MaxResidenceTime: 134,217,728 ps

## Additional setup

- Modify FPGA registers to treat communication without VLAN TAG as TC5.

### Setting for Host A
none.

### Setting for Host B
none.

## Measurement Procedure

### Execute two iperf3 server processes on host B

- Host B
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5201
   ```
- Host B
   ```shell
   $ sudo ip netns exec ns1 iperf3 -s -p 5202
   ```

### Execute iperf3 client on Host A and Host C
- If phc2sys is running, stop it and then perform NTP synchronization manually on each host.
  - Host A
     ```shell
     $ sudo ntpdate ntp.nict.jp
     ```
  - Host C
     ```shell
     $ sudo ntpdate ntp.nict.jp
     ```
- Change `<bandwidth>` of job.sh from `1` to `1000M` and do the following.
  - Change the time as appropriate and execute the following on each host.
    - Host A
       ```shell
       $ at -f job.sh 10:00
       ```
    - Host C
       ```shell
       $ at -f job.sh 10:00
       ```

sample of job.sh (Host A)
```shell
#!/usr/bin/env bash
iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b <bandwidth> > logA.txt
```
sample of job.sh (Host C)
```shell
#!/usr/bin/env bash
iperf3 -c 192.168.1.2 -p 5202 -u -l 1472 -b 1000M > logC.txt
```
