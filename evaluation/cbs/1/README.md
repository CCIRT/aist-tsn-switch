# CBS evaluation data 1

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
    - 192.168.1.1
- Host B (= Host A)
  - enp5s0
    - 192.168.1.3

## Additional setup
Direct connection between NICs without switches.

### Setting for Host A
none.

### Setting for Host B
none.

## Measurement Procedure

### plget
- Host B plget-RX
   ```shell
   $ sudo ip netns exec ns1 ./plget -i enp5s0 -t udp -u 385 -m rx-lat -n 10000 -f lat,hwts,ipgap
   ```
- Host A plget-TX
   ```shell
   $ sudo ./plget -i enp4s0 -t udp -u 385 -m tx-lat -n 10000 -s 100 -l 1500 -a 192.168.1.3 -f lat,hwts,ipgap
   ```
