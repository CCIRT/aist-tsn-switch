# ATS evaluation data

## Directories

```
├── 1             : Directory of evaluation experiment 1
├── 2             : Directory of evaluation experiment 2
├── 3             : Directory of evaluation experiment 3
├── 4             : Directory of evaluation experiment 4
├── 5             : Directory of evaluation experiment 5
├── 6             : Directory of evaluation experiment 6
├── 7             : Directory of evaluation experiment 7
├── 8             : Skipped
├── 9             : Directory of evaluation experiment 9
├── 10            : Directory of evaluation experiment 10
└── README.md     : This file
```

## Base network configuration

- Host A
  - enp4s0
    - 192.168.1.1 (TC1)
  - enp4s0.4
    - 10.0.0.1 (TC7)
  - enp4s0.5
    - 172.16.0.1 (TC6)
- Host B (= Host A)
  - enp5s0
    - 192.168.1.2 (TC1)
  - enp5s0.4
    - 10.0.0.2 (TC7)
  - enp5s0.5
    - 172.16.0.2 (TC6)
- Host C
  - enp4s0
    - 192.168.1.3 (TC1)
  - enp4s0.4
    - 10.0.0.3 (TC7)
  - enp4s0.5
    - 172.16.0.3 (TC6)

## Common setup

### Setup (Host A, Host B)
```shell
$ sudo ethtool -C enp4s0 rx-usecs 0
$ sudo ethtool -C enp5s0 rx-usecs 0

$ sudo ethtool --set-eee enp4s0 eee off
$ sudo ethtool --set-eee enp5s0 eee off

# Disable powersaving for CPU
$ sudo cpupower frequency-set -g performance

# Disable NTP
$ sudo systemctl stop systemd-timesyncd

# Time synchronization (enp5s0 -> enp4s0)
$ sudo phc2sys -s enp5s0 -c enp4s0 -O 0 -m

# VLAN setup
$ sudo vconfig add enp4s0 4
$ sudo vconfig set_egress_map enp4s0.4 0 3
$ sudo vconfig add enp4s0 5
$ sudo vconfig set_egress_map enp4s0.5 0 2

$ sudo vconfig add enp5s0 4
$ sudo vconfig set_egress_map enp5s0.4 0 3
$ sudo vconfig add enp5s0 5
$ sudo vconfig set_egress_map enp5s0.5 0 2

$ sudo ip addr add 10.0.0.1/24 dev enp4s0.4
$ sudo ip addr add 172.16.0.1/24 dev enp4s0.5
$ sudo ip link set dev enp4s0.4 up
$ sudo ip link set dev enp4s0.5 up

$ sudo ip netns add ns1
$ sudo ip link set enp5s0 netns ns1
$ sudo ip link set enp5s0.4 netns ns1
$ sudo ip link set enp5s0.5 netns ns1
$ sudo ip netns exec ns1 ip addr add 192.168.1.2/24 dev enp5s0
$ sudo ip netns exec ns1 ip addr add 10.0.0.2/24 dev enp5s0.4
$ sudo ip netns exec ns1 ip addr add 172.16.0.2/24 dev enp5s0.5
$ sudo ip netns exec ns1 ip link set dev enp5s0 up
$ sudo ip netns exec ns1 ip link set dev enp5s0.4 up
$ sudo ip netns exec ns1 ip link set dev enp5s0.5 up
```
### Setup (Host C)
```shell
$ sudo ethtool -C enp4s0 rx-usecs 0

$ sudo ethtool --set-eee enp4s0 eee off

# Disable powersaving for CPU
$ sudo cpupower frequency-set -g performance

# VLAN setup
# TC7
$ sudo vconfig add enp4s0 4
$ sudo vconfig set_egress_map enp4s0.4 0 3
# TC5
$ sudo vconfig add enp4s0 5
$ sudo vconfig set_egress_map enp4s0.5 0 2

$ sudo ip addr add 10.0.0.3/24 dev enp4s0.4
$ sudo ip addr add 172.16.0.3/24 dev enp4s0.5
$ sudo ip link set dev enp4s0.4 up
$ sudo ip link set dev enp4s0.5 up
```

## Build plget
Please refer [../cbs/README.md](../cbs/README.md)

## Supplementary information

Since Excel does not seem to be able to handle numbers with more than 16 digits correctly, the hardware stamp is pasted as a string and only the lower 15 bits are used.
