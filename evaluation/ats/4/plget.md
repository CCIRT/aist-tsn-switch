## plget results of TC7
### flow1 log (10.0.0.1:0 -> 10.0.0.2:5201, CIR = 100 Mbps)
TX
```shell
$ sudo ./plget -i enp4s0.4 -t udp -u 5201 -m pkt-gen -n 16 -l 1500 -s 41556 -a 10.0.0.2
setting ts_flags: 0x50
new ts_flags: 0x50
```
RX
```shell
$ sudo ip netns exec ns1 ./plget -i enp5s0.4 -t udp -u 5201 -m rx-rate -n 16
setting ts_flags: 0x58
new ts_flags: 0x58
H/W RAW RATE = 99468.82kbps, PPS = 8289.1
AVERAGE PERIOD = 120640.82ns (120.64us)
H/W RAW RATE = 99469.91kbps, PPS = 8289.2
AVERAGE PERIOD = 120639.49ns (120.64us)
H/W RAW RATE = 99469.40kbps, PPS = 8289.1
AVERAGE PERIOD = 120640.12ns (120.64us)
:
```
### flow2 log (10.0.0.1:0 -> 10.0.0.2:5202, CIR = 200 Mbps)
TX
```shell
$ sudo ./plget -i enp4s0.4 -t udp -u 5202 -m pkt-gen -n 16 -l 1500 -s 41556 -a 10.0.0.3
setting ts_flags: 0x50
new ts_flags: 0x50
```
RX
```shell
$ sudo ip netns exec ns1 ./plget -i enp5s0.4 -t udp -u 5202 -m rx-rate -n 16
setting ts_flags: 0x58
new ts_flags: 0x58
H/W RAW RATE = 198941.50kbps, PPS = 16578.5
AVERAGE PERIOD = 60319.24ns (60.32us)
H/W RAW RATE = 198937.13kbps, PPS = 16578.1
AVERAGE PERIOD = 60320.57ns (60.32us)
H/W RAW RATE = 198939.85kbps, PPS = 16578.3
AVERAGE PERIOD = 60319.74ns (60.32us)
:
```
