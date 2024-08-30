<details><summary>CIR: 1000 Mbps (fixed)</summary>

## TC7: 1000 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 58514
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 48096
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   108 MBytes   908 Mbits/sec  0.001 ms  245/77386 (0.32%)  
[  5]   1.00-2.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  262/81023 (0.32%)  
[  5]   2.00-3.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  261/81023 (0.32%)  
[  5]   3.00-4.00   sec   113 MBytes   951 Mbits/sec  0.000 ms  262/81023 (0.32%)  
[  5]   4.00-5.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  261/81023 (0.32%)  
[  5]   5.00-6.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  267/81023 (0.33%)  
[  5]   6.00-7.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  261/81023 (0.32%)  
[  5]   7.00-8.00   sec   113 MBytes   951 Mbits/sec  0.000 ms  262/81023 (0.32%)  
[  5]   8.00-9.00   sec   113 MBytes   951 Mbits/sec  0.000 ms  266/81023 (0.33%)  
[  5]   9.00-10.00  sec   113 MBytes   951 Mbits/sec  0.001 ms  261/81024 (0.32%)  
[  5]  10.00-10.04  sec  4.98 MBytes   951 Mbits/sec  0.002 ms  12/3560 (0.34%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  1.11 GBytes   947 Mbits/sec  0.002 ms  2620/810154 (0.32%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 48096 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  80991  
[  5]   1.00-2.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   2.00-3.00   sec   114 MBytes   954 Mbits/sec  81024  
[  5]   3.00-4.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   4.00-5.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   5.00-6.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   6.00-7.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   7.00-8.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   8.00-9.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   9.00-10.00  sec   114 MBytes   954 Mbits/sec  81023  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810199 (0%)  sender
[  5]   0.00-10.04  sec  1.11 GBytes   947 Mbits/sec  0.002 ms  2620/810154 (0.32%)  receiver

iperf Done.
```
### iperf log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 58654
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 53181
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  50.5 MBytes   424 Mbits/sec  0.007 ms  33902/69908 (48%)  
[  5]   1.00-2.00   sec   377 KBytes  3.09 Mbits/sec  0.005 ms  80680/80942 (1e+02%)  
[  5]   2.00-3.00   sec   378 KBytes  3.10 Mbits/sec  0.004 ms  80788/81051 (1e+02%)  
[  5]   3.00-4.00   sec   377 KBytes  3.09 Mbits/sec  0.004 ms  80800/81062 (1e+02%)  
[  5]   4.00-5.00   sec   378 KBytes  3.10 Mbits/sec  0.004 ms  81109/81372 (1e+02%)  
[  5]   5.00-6.00   sec   384 KBytes  3.14 Mbits/sec  0.190 ms  81792/82059 (1e+02%)  
[  5]   6.00-7.00   sec   378 KBytes  3.10 Mbits/sec  0.004 ms  80168/80431 (1e+02%)  
[  5]   7.00-8.00   sec   377 KBytes  3.09 Mbits/sec  0.004 ms  80801/81063 (1e+02%)  
[  5]   8.00-9.00   sec   384 KBytes  3.14 Mbits/sec  0.007 ms  81076/81343 (1e+02%)  
[  5]   9.00-10.00  sec   378 KBytes  3.10 Mbits/sec  0.004 ms  81108/81371 (1e+02%)  
[  5]  10.00-10.14  sec  51.8 KBytes  3.02 Mbits/sec  0.004 ms  11102/11138 (1e+02%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.14  sec  53.9 MBytes  44.6 Mbits/sec  0.004 ms  773326/811740 (95%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 53181 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  81196  
[  5]   1.00-2.00   sec   113 MBytes   952 Mbits/sec  80830  
[  5]   2.00-3.00   sec   114 MBytes   956 Mbits/sec  81191  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81231  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81232  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81232  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81231  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81232  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81231  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81232  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  0.000 ms  0/811838 (0%)  sender
[  5]   0.00-10.14  sec  53.9 MBytes  44.6 Mbits/sec  0.004 ms  773326/811740 (95%)  receiver

iperf Done.
```

## TC7: 800 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 44528
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 53330
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  91.1 MBytes   764 Mbits/sec  0.027 ms  0/64910 (0%)  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67935 (0%)  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67934 (0%)  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67936 (0%)  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67933 (0%)  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67935 (0%)  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67935 (0%)  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67933 (0%)  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67938 (0%)  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67935 (0%)  
[  5]  10.00-10.04  sec  4.18 MBytes   800 Mbits/sec  0.009 ms  0/2976 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.009 ms  0/679300 (0%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 800M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 53330 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  95.3 MBytes   799 Mbits/sec  67890  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  67931  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  67935  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   954 MBytes   800 Mbits/sec  0.000 ms  0/679300 (0%)  sender
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.009 ms  0/679300 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 44774
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 47733
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  53.8 MBytes   452 Mbits/sec  0.090 ms  38755/77110 (50%)  
[  5]   1.00-2.00   sec  18.4 MBytes   155 Mbits/sec  0.088 ms  68114/81235 (84%)  
[  5]   2.00-3.00   sec  18.4 MBytes   155 Mbits/sec  0.093 ms  68111/81233 (84%)  
[  5]   3.00-4.00   sec  18.4 MBytes   155 Mbits/sec  0.135 ms  68179/81303 (84%)  
[  5]   4.00-5.00   sec  18.4 MBytes   155 Mbits/sec  0.089 ms  68041/81165 (84%)  
[  5]   5.00-6.00   sec  18.4 MBytes   155 Mbits/sec  0.089 ms  68109/81234 (84%)  
[  5]   6.00-7.00   sec  18.4 MBytes   155 Mbits/sec  0.089 ms  68110/81232 (84%)  
[  5]   7.00-8.00   sec  18.4 MBytes   155 Mbits/sec  0.069 ms  68114/81235 (84%)  
[  5]   8.00-9.00   sec  18.4 MBytes   155 Mbits/sec  0.038 ms  68111/81234 (84%)  
[  5]   9.00-10.00  sec  18.4 MBytes   155 Mbits/sec  0.086 ms  68112/81234 (84%)  
[  5]  10.00-10.05  sec  1016 KBytes   154 Mbits/sec  0.095 ms  3678/4385 (84%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   221 MBytes   184 Mbits/sec  0.095 ms  655434/812600 (81%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 47733 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81236  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81272  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812686 (0%)  sender
[  5]   0.00-10.05  sec   221 MBytes   184 Mbits/sec  0.095 ms  655434/812600 (81%)  receiver

iperf Done.
```

## TC7: 600 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 33630
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 34210
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  68.3 MBytes   573 Mbits/sec  0.019 ms  0/48686 (0%)  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50950 (0%)  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50952 (0%)  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50952 (0%)  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50951 (0%)  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50949 (0%)  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  0.019 ms  0/50953 (0%)  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  0.017 ms  0/50952 (0%)  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  0.019 ms  0/50950 (0%)  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  0.021 ms  0/50950 (0%)  
[  5]  10.00-10.04  sec  3.12 MBytes   599 Mbits/sec  0.011 ms  0/2226 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509471 (0%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 600M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 34210 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  71.5 MBytes   599 Mbits/sec  50911  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  50954  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  50948  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  50950  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   715 MBytes   600 Mbits/sec  0.000 ms  0/509471 (0%)  sender
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509471 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 43668
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 45590
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  62.5 MBytes   525 Mbits/sec  0.018 ms  33195/77746 (43%)  
[  5]   1.00-2.00   sec  42.3 MBytes   355 Mbits/sec  0.019 ms  51085/81233 (63%)  
[  5]   2.00-3.00   sec  42.3 MBytes   355 Mbits/sec  0.054 ms  51133/81285 (63%)  
[  5]   3.00-4.00   sec  42.3 MBytes   355 Mbits/sec  0.020 ms  51032/81182 (63%)  
[  5]   4.00-5.00   sec  42.3 MBytes   355 Mbits/sec  0.017 ms  51084/81235 (63%)  
[  5]   5.00-6.00   sec  42.3 MBytes   355 Mbits/sec  0.054 ms  51059/81206 (63%)  
[  5]   6.00-7.00   sec  42.3 MBytes   355 Mbits/sec  0.017 ms  51035/81184 (63%)  
[  5]   7.00-8.00   sec  42.3 MBytes   355 Mbits/sec  0.017 ms  51083/81234 (63%)  
[  5]   8.00-9.00   sec  42.3 MBytes   355 Mbits/sec  0.017 ms  51083/81233 (63%)  
[  5]   9.00-10.00  sec  42.3 MBytes   355 Mbits/sec  0.018 ms  51083/81234 (63%)  
[  5]  10.00-10.05  sec  1.95 MBytes   351 Mbits/sec  0.043 ms  2402/3794 (63%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   445 MBytes   372 Mbits/sec  0.043 ms  495274/812566 (61%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 45590 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81236  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  81195  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81273  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812609 (0%)  sender
[  5]   0.00-10.05  sec   445 MBytes   372 Mbits/sec  0.043 ms  495274/812566 (61%)  receiver

iperf Done.
```

## TC7: 400 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 59650
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 35356
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  45.6 MBytes   382 Mbits/sec  0.018 ms  0/32457 (0%)  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  0.019 ms  0/33968 (0%)  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  0.019 ms  0/33967 (0%)  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  0.019 ms  0/33967 (0%)  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33967 (0%)  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33968 (0%)  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  0.019 ms  0/33968 (0%)  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33968 (0%)  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33966 (0%)  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33971 (0%)  
[  5]  10.00-10.04  sec  2.08 MBytes   398 Mbits/sec  0.011 ms  0/1479 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.011 ms  0/339646 (0%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 400M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 35356 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  47.6 MBytes   400 Mbits/sec  33940  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  33966  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  33969  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  33966  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  33968  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   477 MBytes   400 Mbits/sec  0.000 ms  0/339646 (0%)  sender
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.011 ms  0/339646 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 54764
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 52838
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  70.6 MBytes   592 Mbits/sec  0.010 ms  27333/77639 (35%)  
[  5]   1.00-2.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34054/81233 (42%)  
[  5]   2.00-3.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34055/81234 (42%)  
[  5]   3.00-4.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34056/81234 (42%)  
[  5]   4.00-5.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34055/81234 (42%)  
[  5]   5.00-6.00   sec  66.2 MBytes   556 Mbits/sec  0.009 ms  34055/81233 (42%)  
[  5]   6.00-7.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34056/81234 (42%)  
[  5]   7.00-8.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34056/81234 (42%)  
[  5]   8.00-9.00   sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34055/81234 (42%)  
[  5]   9.00-10.00  sec  66.2 MBytes   556 Mbits/sec  0.010 ms  34055/81234 (42%)  
[  5]  10.00-10.05  sec  3.18 MBytes   555 Mbits/sec  0.010 ms  1634/3898 (42%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   670 MBytes   559 Mbits/sec  0.010 ms  335464/812641 (41%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 52838 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81236  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81272  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812686 (0%)  sender
[  5]   0.00-10.05  sec   670 MBytes   559 Mbits/sec  0.010 ms  335464/812641 (41%)  receiver

iperf Done.
```

## TC7: 200 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 42014
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 53981
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  22.7 MBytes   190 Mbits/sec  0.014 ms  0/16169 (0%)  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16983 (0%)  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16984 (0%)  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16984 (0%)  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16984 (0%)  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  0.013 ms  0/16983 (0%)  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16984 (0%)  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  0.013 ms  0/16984 (0%)  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16983 (0%)  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  0.013 ms  0/16986 (0%)  
[  5]  10.00-10.05  sec  1.12 MBytes   197 Mbits/sec  0.013 ms  0/799 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   238 MBytes   199 Mbits/sec  0.013 ms  0/169823 (0%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 200M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 53981 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  23.8 MBytes   200 Mbits/sec  16969  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  16984  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   238 MBytes   200 Mbits/sec  0.000 ms  0/169823 (0%)  sender
[  5]   0.00-10.05  sec   238 MBytes   199 Mbits/sec  0.013 ms  0/169823 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 37760
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 38358
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  88.7 MBytes   744 Mbits/sec  0.002 ms  14404/77573 (19%)  
[  5]   1.00-2.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17028/81234 (21%)  
[  5]   2.00-3.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17028/81234 (21%)  
[  5]   3.00-4.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17026/81233 (21%)  
[  5]   4.00-5.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17028/81234 (21%)  
[  5]   5.00-6.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  16989/81152 (21%)  
[  5]   6.00-7.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17028/81234 (21%)  
[  5]   7.00-8.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17027/81234 (21%)  
[  5]   8.00-9.00   sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17028/81234 (21%)  
[  5]   9.00-10.00  sec  90.1 MBytes   756 Mbits/sec  0.002 ms  17027/81233 (21%)  
[  5]  10.00-10.05  sec  4.40 MBytes   755 Mbits/sec  0.004 ms  834/3965 (21%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   904 MBytes   755 Mbits/sec  0.004 ms  168447/812560 (21%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 38358 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81236  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  81191  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81273  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812605 (0%)  sender
[  5]   0.00-10.05  sec   904 MBytes   755 Mbits/sec  0.004 ms  168447/812560 (21%)  receiver

iperf Done.
```

## TC7: 1 bps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 57782
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 46296
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  1.44 KBytes  11.8 Kbits/sec  0.000 ms  0/1 (0%)  
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  1.44 KBytes  1.17 Kbits/sec  0.000 ms  0/1 (0%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 46296 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  1.44 KBytes  11.8 Kbits/sec  1  
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec  0  
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec  0  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.44 KBytes  1.18 Kbits/sec  0.000 ms  0/1 (0%)  sender
[  5]   0.00-10.04  sec  1.44 KBytes  1.17 Kbits/sec  0.000 ms  0/1 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.3, port 47342
[  5] local 192.168.1.2 port 5202 connected to 192.168.1.3 port 49992
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   109 MBytes   916 Mbits/sec  0.001 ms  0/77821 (0%)  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81233 (0%)  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]   7.00-8.00   sec   114 MBytes   956 Mbits/sec  0.000 ms  0/81211 (0%)  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  0.000 ms  0/81234 (0%)  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81234 (0%)  
[  5]  10.00-10.05  sec  5.22 MBytes   956 Mbits/sec  0.000 ms  0/3716 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec  1.11 GBytes   953 Mbits/sec  0.000 ms  0/812619 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.2 -p 5202 -l 1472 -u -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 192.168.1.2, port 5202
[  5] local 192.168.1.3 port 49992 connected to 192.168.1.2 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81236  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81273  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81250  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81272  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81272  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812663 (0%)  sender
[  5]   0.00-10.05  sec  1.11 GBytes   953 Mbits/sec  0.000 ms  0/812619 (0%)  receiver

iperf Done.
```
</details>
