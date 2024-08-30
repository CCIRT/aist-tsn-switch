# CBS evaluation data 4

## Files

```
├── iperf.md                : plget's Output Data
├── README.md               : This file
└── results_4.xlsx          : Excel files containing post-processed numbers and graphs
```

## Network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC5)
  - enp4s0.5
    - 172.16.0.1 (TC4)
- Host B (= Host A)
  - enp4s0
    - 192.168.1.2 (TC5)
  - enp4s0.5
    - 172.16.0.2 (TC4)

## CBS configuration
- TC7 (not used)
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %
- TC6 (not used)
    - idleSlope: 10 % (100 Mbps)
    - sendSlope: -90 %

## Additional setup

- Modify the FPGA registers to set idleSlope, sendSlope, maxCredit, and minCredit.
- Modify FPGA registers to treat communication without VLAN TAG as TC5.

### Setting for Host A
- Configure PCP to treat 172.16.0.x communications as TC4 (PCP=6).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.5 0 6
   ```

### Setting for Host B
- Configure PCP to treat 172.16.0.x communications as TC4 (PCP=6).
   ```shell
   $ sudo ip netns exec ns1 vconfig set_egress_map enp5s0.5 0 6
   ```

### Setting for Host C
- Configure PCP to treat 172.16.0.x communications as TC4 (PCP=6).
   ```shell
   $ sudo vconfig set_egress_map enp4s0.5 0 6
   ```

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
If phc2sys is running, stop it and then perform NTP synchronization manually on each host.
- Host A
   ```shell
   $ sudo ntpdate ntp.nict.jp
   ```
- Host C
   ```shell
   $ sudo ntpdate ntp.nict.jp
   ```
Execute on each host, changing job.sh and time as appropriate.
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
iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1000M > log.txt
```
sample of job.sh (Host C)
```shell
#!/usr/bin/env bash
iperf3 -c 172.16.0.3 -p 5201 -u -l 1472 -b 1000M > log.txt
```
