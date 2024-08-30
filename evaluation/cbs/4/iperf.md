<details><summary>TC5 (FIFO) and TC4 (FIFO)</summary>

## iperf3 results of TC5: 1000 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 41876
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 50919
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   109 MBytes   914 Mbits/sec  0.001 ms  0/77624 (0%)  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  0.003 ms  0/81254 (0%)  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81274 (0%)  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81274 (0%)  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81274 (0%)  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81260 (0%)  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81271 (0%)  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  0.000 ms  0/81250 (0%)  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81274 (0%)  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  0.001 ms  0/81167 (0%)  
[  5]  10.00-10.04  sec  5.01 MBytes   957 Mbits/sec  0.002 ms  0/3569 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  1.11 GBytes   953 Mbits/sec  0.002 ms  0/812491 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1000M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 50919 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81238  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81257  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81274  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81274  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81275  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81256  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81274  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81248  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81274  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  81166  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812536 (0%)  sender
[  5]   0.00-10.04  sec  1.11 GBytes   953 Mbits/sec  0.002 ms  0/812491 (0%)  receiver

iperf Done.
```
### iperf log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 48682
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 35468
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  0.00 Bytes  0.00 bits/sec  0.000 ms  0/0 (0%)  
[  5]   1.00-2.00   sec  28.8 KBytes   236 Kbits/sec  50.131 ms  100469/100489 (1e+02%)  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec  50.131 ms  0/0 (0%)  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  50.131 ms  0/0 (0%)  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  50.131 ms  0/0 (0%)  
[  5]   5.00-6.00   sec  20.1 KBytes   165 Kbits/sec  330.476 ms  324201/324215 (1e+02%)  
[  5]   6.00-7.00   sec  4.31 KBytes  35.3 Kbits/sec  338.114 ms  0/3 (0%)  
[  5]   7.00-8.00   sec  34.5 KBytes   283 Kbits/sec  132.175 ms  163404/163428 (1e+02%)  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec  132.175 ms  0/0 (0%)  
[  5]   9.00-10.00  sec   154 KBytes  1.26 Mbits/sec  0.581 ms  186959/187066 (1e+02%)  
[  5]  10.00-10.04  sec  4.42 MBytes   863 Mbits/sec  0.001 ms  32148/35299 (91%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  4.66 MBytes  3.89 Mbits/sec  0.001 ms  807181/810500 (1e+02%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 35468 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81025  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   2.00-3.00   sec   114 MBytes   954 Mbits/sec  81025  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81062  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810543 (0%)  sender
[  5]   0.00-10.04  sec  4.66 MBytes  3.89 Mbits/sec  0.001 ms  807181/810500 (1e+02%)  receiver

iperf Done.
```

## iperf3 results of TC5: 800 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 47250
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 54586
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  91.1 MBytes   764 Mbits/sec  0.027 ms  0/64910 (0%)  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  0.025 ms  0/67937 (0%)  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67932 (0%)  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67935 (0%)  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67935 (0%)  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67935 (0%)  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67932 (0%)  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67937 (0%)  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67936 (0%)  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  0.024 ms  0/67938 (0%)  
[  5]  10.00-10.04  sec  4.17 MBytes   799 Mbits/sec  0.010 ms  0/2973 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.010 ms  0/679300 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 800M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 54586 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  95.3 MBytes   799 Mbits/sec  67894  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  67927  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  67933  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  67936  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   954 MBytes   800 Mbits/sec  0.000 ms  0/679300 (0%)  sender
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.010 ms  0/679300 (0%)  receiver

iperf Done.
```
### iperf server log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 44626
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 53407
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  17.9 MBytes   150 Mbits/sec  0.142 ms  64861/77612 (84%)  
[  5]   1.00-2.00   sec  18.7 MBytes   157 Mbits/sec  0.104 ms  67831/81144 (84%)  
[  5]   2.00-3.00   sec  18.7 MBytes   157 Mbits/sec  0.123 ms  67758/81062 (84%)  
[  5]   3.00-4.00   sec  18.7 MBytes   157 Mbits/sec  0.108 ms  67758/81064 (84%)  
[  5]   4.00-5.00   sec  18.7 MBytes   157 Mbits/sec  0.122 ms  67759/81063 (84%)  
[  5]   5.00-6.00   sec  18.7 MBytes   157 Mbits/sec  0.099 ms  67759/81064 (84%)  
[  5]   6.00-7.00   sec  18.7 MBytes   157 Mbits/sec  0.121 ms  67757/81063 (84%)  
[  5]   7.00-8.00   sec  18.7 MBytes   157 Mbits/sec  0.113 ms  67760/81064 (84%)  
[  5]   8.00-9.00   sec  4.27 MBytes  35.8 Mbits/sec  0.091 ms  15449/18492 (84%)  
[  5]   9.00-10.00  sec  14.0 MBytes   117 Mbits/sec  0.120 ms  50725/60674 (84%)  
[  5]  10.00-10.04  sec  4.21 MBytes   879 Mbits/sec  0.001 ms  268/3270 (8.2%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   171 MBytes   143 Mbits/sec  0.001 ms  605685/727572 (83%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 53407 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec  21.5 MBytes   180 Mbits/sec  15281  
[  5]   9.00-10.00  sec  89.7 MBytes   752 Mbits/sec  63881  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1021 MBytes   857 Mbits/sec  0.000 ms  0/727616 (0%)  sender
[  5]   0.00-10.04  sec   171 MBytes   143 Mbits/sec  0.001 ms  605685/727572 (83%)  receiver

iperf Done.
```

## TC5: 600 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 49596
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 60896
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  68.3 MBytes   573 Mbits/sec  0.024 ms  0/48681 (0%)  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  0.020 ms  0/50954 (0%)  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  0.022 ms  0/50950 (0%)  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  0.023 ms  0/50950 (0%)  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  0.023 ms  0/50952 (0%)  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  0.024 ms  0/50949 (0%)  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  0.021 ms  0/50954 (0%)  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  0.024 ms  0/50948 (0%)  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  0.024 ms  0/50951 (0%)  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  0.025 ms  0/50950 (0%)  
[  5]  10.00-10.04  sec  3.13 MBytes   600 Mbits/sec  0.011 ms  0/2232 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509471 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 600M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 60896 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  71.5 MBytes   600 Mbits/sec  50913  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  50950  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  50953  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  50950  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  50949  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  50952  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   715 MBytes   600 Mbits/sec  0.000 ms  0/509471 (0%)  sender
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509471 (0%)  receiver

iperf Done.
```
### iperf server log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 57276
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 59883
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  40.7 MBytes   341 Mbits/sec  0.023 ms  48642/77620 (63%)  
[  5]   1.00-2.00   sec  42.3 MBytes   355 Mbits/sec  0.022 ms  50535/80655 (63%)  
[  5]   2.00-3.00   sec  42.4 MBytes   356 Mbits/sec  0.021 ms  50746/80953 (63%)  
[  5]   3.00-4.00   sec  42.5 MBytes   356 Mbits/sec  0.021 ms  50817/81063 (63%)  
[  5]   4.00-5.00   sec  42.5 MBytes   356 Mbits/sec  0.020 ms  50820/81064 (63%)  
[  5]   5.00-6.00   sec  42.5 MBytes   356 Mbits/sec  0.023 ms  50819/81063 (63%)  
[  5]   6.00-7.00   sec  42.5 MBytes   356 Mbits/sec  0.022 ms  50821/81064 (63%)  
[  5]   7.00-8.00   sec  42.5 MBytes   356 Mbits/sec  0.021 ms  50818/81064 (63%)  
[  5]   8.00-9.00   sec  42.5 MBytes   356 Mbits/sec  0.021 ms  50818/81063 (63%)  
[  5]   9.00-10.00  sec  42.5 MBytes   356 Mbits/sec  0.020 ms  50819/81064 (63%)  
[  5]  10.00-10.04  sec  4.12 MBytes   841 Mbits/sec  0.000 ms  407/3342 (12%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   427 MBytes   356 Mbits/sec  0.000 ms  506062/810015 (62%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 59883 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81025  
[  5]   1.00-2.00   sec   113 MBytes   950 Mbits/sec  80654  
[  5]   2.00-3.00   sec   114 MBytes   953 Mbits/sec  80950  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810059 (0%)  sender
[  5]   0.00-10.04  sec   427 MBytes   356 Mbits/sec  0.000 ms  506062/810015 (62%)  receiver

iperf Done.
```

## TC5: 400 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 44376
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 57719
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  45.6 MBytes   382 Mbits/sec  0.016 ms  0/32458 (0%)  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33966 (0%)  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33968 (0%)  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33966 (0%)  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33967 (0%)  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  0.017 ms  0/33970 (0%)  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33966 (0%)  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33967 (0%)  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33968 (0%)  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  0.018 ms  0/33967 (0%)  
[  5]  10.00-10.04  sec  2.08 MBytes   398 Mbits/sec  0.011 ms  0/1483 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.011 ms  0/339646 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 400M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 57719 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  47.6 MBytes   400 Mbits/sec  33941  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  33965  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  33969  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  33966  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  33969  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  33967  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   477 MBytes   400 Mbits/sec  0.000 ms  0/339646 (0%)  sender
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.011 ms  0/339646 (0%)  receiver

iperf Done.
```
### iperf server log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 51144
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 48152
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  63.5 MBytes   533 Mbits/sec  0.005 ms  32446/77673 (42%)  
[  5]   1.00-2.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81063 (42%)  
[  5]   2.00-3.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81063 (42%)  
[  5]   3.00-4.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33880/81064 (42%)  
[  5]   4.00-5.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33881/81064 (42%)  
[  5]   5.00-6.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81064 (42%)  
[  5]   6.00-7.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81063 (42%)  
[  5]   7.00-8.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81063 (42%)  
[  5]   8.00-9.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33881/81064 (42%)  
[  5]   9.00-10.00  sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33880/81064 (42%)  
[  5]  10.00-10.04  sec  3.86 MBytes   801 Mbits/sec  0.000 ms  541/3290 (16%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   663 MBytes   554 Mbits/sec  0.000 ms  337904/810535 (42%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 48152 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810579 (0%)  sender
[  5]   0.00-10.04  sec   663 MBytes   554 Mbits/sec  0.000 ms  337904/810535 (42%)  receiver

iperf Done.
```

## TC5: 200 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 59088
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 34647
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  22.8 MBytes   191 Mbits/sec  0.017 ms  0/16230 (0%)  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  0.018 ms  0/16983 (0%)  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  0.018 ms  0/16984 (0%)  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16985 (0%)  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16982 (0%)  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16984 (0%)  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16984 (0%)  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16983 (0%)  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  0.018 ms  0/16984 (0%)  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  0.015 ms  0/16986 (0%)  
[  5]  10.00-10.04  sec  1.04 MBytes   198 Mbits/sec  0.012 ms  0/738 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   238 MBytes   199 Mbits/sec  0.012 ms  0/169823 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 200M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 34647 connected to 192.168.1.3 port 5202
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
[  5]   0.00-10.04  sec   238 MBytes   199 Mbits/sec  0.012 ms  0/169823 (0%)  receiver
```
### iperf server log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 54512
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 45551
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  88.9 MBytes   746 Mbits/sec  0.001 ms  14071/77398 (18%)  
[  5]   1.00-2.00   sec  89.6 MBytes   751 Mbits/sec  0.001 ms  16839/80649 (21%)  
[  5]   2.00-3.00   sec  89.7 MBytes   752 Mbits/sec  0.002 ms  16860/80741 (21%)  
[  5]   3.00-4.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16940/81063 (21%)  
[  5]   4.00-5.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16939/81064 (21%)  
[  5]   5.00-6.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16941/81064 (21%)  
[  5]   6.00-7.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16940/81063 (21%)  
[  5]   7.00-8.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16939/81063 (21%)  
[  5]   8.00-9.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16940/81064 (21%)  
[  5]   9.00-10.00  sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16941/81064 (21%)  
[  5]  10.00-10.05  sec  4.41 MBytes   754 Mbits/sec  0.001 ms  829/3971 (21%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   903 MBytes   754 Mbits/sec  0.001 ms  167179/810204 (21%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 45551 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   955 Mbits/sec  81066  
[  5]   1.00-2.00   sec   113 MBytes   950 Mbits/sec  80687  
[  5]   2.00-3.00   sec   113 MBytes   951 Mbits/sec  80780  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81102  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81102  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810247 (0%)  sender
[  5]   0.00-10.05  sec   903 MBytes   754 Mbits/sec  0.001 ms  167179/810204 (21%)  receiver

iperf Done.
```

## TC5: 0 Mbps, TC4: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 48264
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 47956
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
[  5]   0.00-10.05  sec  1.44 KBytes  1.17 Kbits/sec  0.000 ms  0/1 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 47956 connected to 192.168.1.3 port 5202
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
[  5]   0.00-10.05  sec  1.44 KBytes  1.17 Kbits/sec  0.000 ms  0/1 (0%)  receiver

iperf Done.
```
### iperf server log (TC4)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 172.16.0.2, port 38970
[  5] local 172.16.0.3 port 5201 connected to 172.16.0.2 port 59509
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   109 MBytes   915 Mbits/sec  0.000 ms  0/77663 (0%)  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81064 (0%)  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81064 (0%)  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81063 (0%)  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81064 (0%)  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81062 (0%)  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81064 (0%)  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  0.000 ms  0/81064 (0%)  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  0/81064 (0%)  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  0.000 ms  0/81063 (0%)  
[  5]  10.00-10.04  sec  4.06 MBytes   954 Mbits/sec  0.001 ms  0/2893 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  0.001 ms  0/810128 (0%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 172.16.0.3, port 5201
[  5] local 172.16.0.2 port 59509 connected to 172.16.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  80985  
[  5]   1.00-2.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   2.00-3.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   3.00-4.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   4.00-5.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   5.00-6.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   6.00-7.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   7.00-8.00   sec   114 MBytes   954 Mbits/sec  81021  
[  5]   8.00-9.00   sec   114 MBytes   954 Mbits/sec  81020  
[  5]   9.00-10.00  sec   114 MBytes   954 Mbits/sec  81021  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810173 (0%)  sender
[  5]   0.00-10.04  sec  1.11 GBytes   951 Mbits/sec  0.001 ms  0/810128 (0%)  receiver

iperf Done.
```
</details>

<details><summary>TC5 (FIFO) and TC5 (FIFO)</summary>

## iperf3 results of TC5: 1000 Mbps, TC5: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 48692
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 36679
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  55.9 MBytes   469 Mbits/sec  0.002 ms  37450/77274 (48%)  
[  5]   1.00-2.00   sec  57.9 MBytes   485 Mbits/sec  0.002 ms  40037/81262 (49%)  
[  5]   2.00-3.00   sec  57.9 MBytes   486 Mbits/sec  0.002 ms  40030/81268 (49%)  
[  5]   3.00-4.00   sec  57.9 MBytes   485 Mbits/sec  0.001 ms  40036/81261 (49%)  
[  5]   4.00-5.00   sec  57.9 MBytes   485 Mbits/sec  0.001 ms  40037/81262 (49%)  
[  5]   5.00-6.00   sec  57.9 MBytes   485 Mbits/sec  0.001 ms  40039/81263 (49%)  
[  5]   6.00-7.00   sec  57.6 MBytes   483 Mbits/sec  0.002 ms  40270/81271 (50%)  
[  5]   7.00-8.00   sec  57.9 MBytes   485 Mbits/sec  0.002 ms  40044/81268 (49%)  
[  5]   8.00-9.00   sec  57.9 MBytes   485 Mbits/sec  0.002 ms  40044/81269 (49%)  
[  5]   9.00-10.00  sec  57.6 MBytes   483 Mbits/sec  0.002 ms  39852/80893 (49%)  
[  5]  10.00-10.05  sec  2.79 MBytes   485 Mbits/sec  0.001 ms  1932/3921 (49%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   579 MBytes   483 Mbits/sec  0.001 ms  399771/812212 (49%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1000M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 36679 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81233  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81262  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81260  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81261  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81264  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   9.00-10.00  sec   114 MBytes   953 Mbits/sec  80891  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812249 (0%)  sender
[  5]   0.00-10.05  sec   579 MBytes   483 Mbits/sec  0.001 ms  399771/812212 (49%)  receiver

iperf Done.
```
### iperf log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.2, port 37792
[  5] local 192.168.1.3 port 5201 connected to 192.168.1.2 port 45182
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  53.7 MBytes   450 Mbits/sec  0.001 ms  39990/78868 (51%)  
[  5]   1.00-2.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41865/82544 (51%)  
[  5]   2.00-3.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41851/82516 (51%)  
[  5]   3.00-4.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41879/82558 (51%)  
[  5]   4.00-5.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41879/82558 (51%)  
[  5]   5.00-6.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41878/82557 (51%)  
[  5]   6.00-7.00   sec  55.7 MBytes   467 Mbits/sec  0.001 ms  42242/82557 (51%)  
[  5]   7.00-8.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41879/82558 (51%)  
[  5]   8.00-9.00   sec  56.2 MBytes   471 Mbits/sec  0.001 ms  41879/82558 (51%)  
[  5]   9.00-10.00  sec  56.4 MBytes   473 Mbits/sec  0.001 ms  41692/82557 (51%)  
[  5]  10.00-10.04  sec  3.34 MBytes   638 Mbits/sec  0.000 ms  1217/3638 (33%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   562 MBytes   470 Mbits/sec  0.000 ms  418251/825469 (51%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.1.2 port 45182 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  82523  
[  5]   1.00-2.00   sec   114 MBytes   956 Mbits/sec  82548  
[  5]   2.00-3.00   sec   114 MBytes   956 Mbits/sec  82518  
[  5]   3.00-4.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   4.00-5.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   6.00-7.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   7.00-8.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   8.00-9.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  82560  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  0.000 ms  0/825513 (0%)  sender
[  5]   0.00-10.04  sec   562 MBytes   470 Mbits/sec  0.000 ms  418251/825469 (51%)  receiver

iperf Done.
```

## iperf3 results of TC5: 800 Mbps, TC5: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 44442
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 49768
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  55.6 MBytes   467 Mbits/sec  0.070 ms  24982/64624 (39%)  
[  5]   1.00-2.00   sec  57.4 MBytes   481 Mbits/sec  0.071 ms  27072/67935 (40%)  
[  5]   2.00-3.00   sec  57.4 MBytes   482 Mbits/sec  0.068 ms  27023/67936 (40%)  
[  5]   3.00-4.00   sec  57.6 MBytes   484 Mbits/sec  0.063 ms  26875/67938 (40%)  
[  5]   4.00-5.00   sec  57.6 MBytes   483 Mbits/sec  0.068 ms  26878/67932 (40%)  
[  5]   5.00-6.00   sec  57.6 MBytes   483 Mbits/sec  0.069 ms  26885/67934 (40%)  
[  5]   6.00-7.00   sec  57.6 MBytes   483 Mbits/sec  0.065 ms  26930/67938 (40%)  
[  5]   7.00-8.00   sec  57.6 MBytes   483 Mbits/sec  0.071 ms  26874/67931 (40%)  
[  5]   8.00-9.00   sec  57.5 MBytes   482 Mbits/sec  0.069 ms  26980/67935 (40%)  
[  5]   9.00-10.00  sec  57.7 MBytes   484 Mbits/sec  0.068 ms  26869/67936 (40%)  
[  5]  10.00-10.05  sec  2.77 MBytes   484 Mbits/sec  0.022 ms  1287/3258 (40%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   576 MBytes   481 Mbits/sec  0.022 ms  268655/679297 (40%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 49768 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  95.3 MBytes   799 Mbits/sec  67885  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  67937  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  67931  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  67935  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   954 MBytes   800 Mbits/sec  0.000 ms  0/679298 (0%)  sender
[  5]   0.00-10.05  sec   576 MBytes   481 Mbits/sec  0.022 ms  268655/679297 (40%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.2, port 35728
[  5] local 192.168.1.3 port 5201 connected to 192.168.1.2 port 35120
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  54.1 MBytes   453 Mbits/sec  0.002 ms  39816/78963 (50%)  
[  5]   1.00-2.00   sec  56.6 MBytes   475 Mbits/sec  0.001 ms  41541/82556 (50%)  
[  5]   2.00-3.00   sec  56.6 MBytes   475 Mbits/sec  0.001 ms  41563/82557 (50%)  
[  5]   3.00-4.00   sec  56.4 MBytes   473 Mbits/sec  0.001 ms  41712/82557 (51%)  
[  5]   4.00-5.00   sec  56.4 MBytes   473 Mbits/sec  0.001 ms  41708/82559 (51%)  
[  5]   5.00-6.00   sec  56.4 MBytes   473 Mbits/sec  0.001 ms  41690/82557 (50%)  
[  5]   6.00-7.00   sec  56.5 MBytes   474 Mbits/sec  0.001 ms  41661/82558 (50%)  
[  5]   7.00-8.00   sec  56.4 MBytes   473 Mbits/sec  0.001 ms  41715/82557 (51%)  
[  5]   8.00-9.00   sec  56.6 MBytes   474 Mbits/sec  0.001 ms  41606/82558 (50%)  
[  5]   9.00-10.00  sec  56.3 MBytes   472 Mbits/sec  0.001 ms  41789/82557 (51%)  
[  5]  10.00-10.04  sec  3.72 MBytes   729 Mbits/sec  0.001 ms  850/3543 (24%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   566 MBytes   473 Mbits/sec  0.001 ms  415651/825522 (50%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.1.2 port 35120 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  82521  
[  5]   1.00-2.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   2.00-3.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   3.00-4.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   4.00-5.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   6.00-7.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   7.00-8.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   8.00-9.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  82560  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  0.000 ms  0/825566 (0%)  sender
[  5]   0.00-10.04  sec   566 MBytes   473 Mbits/sec  0.001 ms  415651/825522 (50%)  receiver

iperf Done.
```

## TC5: 600 Mbps, TC5: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 60434
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 44463
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  44.3 MBytes   372 Mbits/sec  0.063 ms  17088/48670 (35%)  
[  5]   1.00-2.00   sec  45.4 MBytes   381 Mbits/sec  0.053 ms  18582/50956 (36%)  
[  5]   2.00-3.00   sec  45.5 MBytes   381 Mbits/sec  0.063 ms  18564/50946 (36%)  
[  5]   3.00-4.00   sec  45.5 MBytes   381 Mbits/sec  0.063 ms  18562/50951 (36%)  
[  5]   4.00-5.00   sec  45.4 MBytes   381 Mbits/sec  0.057 ms  18594/50954 (36%)  
[  5]   5.00-6.00   sec  45.4 MBytes   381 Mbits/sec  0.064 ms  18574/50948 (36%)  
[  5]   6.00-7.00   sec  45.4 MBytes   381 Mbits/sec  0.058 ms  18584/50954 (36%)  
[  5]   7.00-8.00   sec  45.5 MBytes   382 Mbits/sec  0.058 ms  18536/50951 (36%)  
[  5]   8.00-9.00   sec  45.4 MBytes   381 Mbits/sec  0.058 ms  18586/50951 (36%)  
[  5]   9.00-10.00  sec  45.4 MBytes   381 Mbits/sec  0.064 ms  18588/50949 (36%)  
[  5]  10.00-10.04  sec  2.01 MBytes   383 Mbits/sec  0.025 ms  809/2240 (36%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   455 MBytes   380 Mbits/sec  0.025 ms  185067/509470 (36%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 600M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 44463 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  71.5 MBytes   600 Mbits/sec  50913  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  50949  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  50953  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  50948  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   715 MBytes   600 Mbits/sec  0.000 ms  0/509470 (0%)  sender
[  5]   0.00-10.04  sec   455 MBytes   380 Mbits/sec  0.025 ms  185067/509470 (36%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.2, port 45064
[  5] local 192.168.1.3 port 5201 connected to 192.168.1.2 port 33214
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  65.3 MBytes   548 Mbits/sec  0.004 ms  31297/78603 (40%)  
[  5]   1.00-2.00   sec  68.6 MBytes   575 Mbits/sec  0.005 ms  32884/82558 (40%)  
[  5]   2.00-3.00   sec  68.6 MBytes   575 Mbits/sec  0.004 ms  32831/82486 (40%)  
[  5]   3.00-4.00   sec  68.6 MBytes   575 Mbits/sec  0.005 ms  32902/82556 (40%)  
[  5]   4.00-5.00   sec  68.6 MBytes   576 Mbits/sec  0.005 ms  32873/82559 (40%)  
[  5]   5.00-6.00   sec  68.6 MBytes   575 Mbits/sec  0.004 ms  32891/82557 (40%)  
[  5]   6.00-7.00   sec  68.6 MBytes   575 Mbits/sec  0.006 ms  32887/82557 (40%)  
[  5]   7.00-8.00   sec  68.5 MBytes   575 Mbits/sec  0.005 ms  32216/81845 (39%)  
[  5]   8.00-9.00   sec  68.6 MBytes   575 Mbits/sec  0.005 ms  32878/82557 (40%)  
[  5]   9.00-10.00  sec  68.6 MBytes   575 Mbits/sec  0.004 ms  32883/82557 (40%)  
[  5]  10.00-10.05  sec  4.84 MBytes   859 Mbits/sec  0.001 ms  403/3905 (10%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   687 MBytes   574 Mbits/sec  0.001 ms  326945/824740 (40%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.1.2 port 33214 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  82523  
[  5]   1.00-2.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   2.00-3.00   sec   114 MBytes   956 Mbits/sec  82489  
[  5]   3.00-4.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   4.00-5.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   6.00-7.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   7.00-8.00   sec   113 MBytes   948 Mbits/sec  81847  
[  5]   8.00-9.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  82561  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/824784 (0%)  sender
[  5]   0.00-10.05  sec   687 MBytes   574 Mbits/sec  0.001 ms  326945/824740 (40%)  receiver

iperf Done.
```

## TC5: 400 Mbps, TC5: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 39024
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 50576
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  32.4 MBytes   271 Mbits/sec  0.051 ms  9402/32447 (29%)  
[  5]   1.00-2.00   sec  33.4 MBytes   280 Mbits/sec  0.053 ms  10195/33966 (30%)  
[  5]   2.00-3.00   sec  33.4 MBytes   280 Mbits/sec  0.053 ms  10176/33968 (30%)  
[  5]   3.00-4.00   sec  33.4 MBytes   280 Mbits/sec  0.051 ms  10208/33968 (30%)  
[  5]   4.00-5.00   sec  33.4 MBytes   280 Mbits/sec  0.052 ms  10203/33966 (30%)  
[  5]   5.00-6.00   sec  33.3 MBytes   279 Mbits/sec  0.053 ms  10240/33968 (30%)  
[  5]   6.00-7.00   sec  33.4 MBytes   280 Mbits/sec  0.051 ms  10200/33968 (30%)  
[  5]   7.00-8.00   sec  33.3 MBytes   280 Mbits/sec  0.051 ms  10221/33968 (30%)  
[  5]   8.00-9.00   sec  33.4 MBytes   280 Mbits/sec  0.052 ms  10203/33967 (30%)  
[  5]   9.00-10.00  sec  33.3 MBytes   280 Mbits/sec  0.052 ms  10219/33967 (30%)  
[  5]  10.00-10.04  sec  1.47 MBytes   281 Mbits/sec  0.028 ms  444/1492 (30%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   334 MBytes   279 Mbits/sec  0.028 ms  101711/339645 (30%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 400M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 50576 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  47.6 MBytes   400 Mbits/sec  33940  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  33966  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  33970  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  33965  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  33966  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   477 MBytes   400 Mbits/sec  0.000 ms  0/339645 (0%)  sender
[  5]   0.00-10.04  sec   334 MBytes   279 Mbits/sec  0.028 ms  101711/339645 (30%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.2, port 51178
[  5] local 192.168.1.3 port 5201 connected to 192.168.1.2 port 52445
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  77.1 MBytes   647 Mbits/sec  0.002 ms  23019/78880 (29%)  
[  5]   1.00-2.00   sec  80.3 MBytes   673 Mbits/sec  0.003 ms  23984/82115 (29%)  
[  5]   2.00-3.00   sec  80.7 MBytes   677 Mbits/sec  0.003 ms  24113/82557 (29%)  
[  5]   3.00-4.00   sec  80.7 MBytes   677 Mbits/sec  0.002 ms  24133/82557 (29%)  
[  5]   4.00-5.00   sec  80.7 MBytes   677 Mbits/sec  0.002 ms  24148/82557 (29%)  
[  5]   5.00-6.00   sec  80.7 MBytes   677 Mbits/sec  0.002 ms  24099/82558 (29%)  
[  5]   6.00-7.00   sec  80.7 MBytes   677 Mbits/sec  0.003 ms  24145/82558 (29%)  
[  5]   7.00-8.00   sec  80.7 MBytes   677 Mbits/sec  0.002 ms  24126/82556 (29%)  
[  5]   8.00-9.00   sec  80.7 MBytes   677 Mbits/sec  0.002 ms  24141/82558 (29%)  
[  5]   9.00-10.00  sec  80.7 MBytes   677 Mbits/sec  0.003 ms  24125/82559 (29%)  
[  5]  10.00-10.04  sec  4.73 MBytes   905 Mbits/sec  0.001 ms  198/3625 (5.5%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   808 MBytes   675 Mbits/sec  0.001 ms  240231/825080 (29%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.1.2 port 52445 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  82523  
[  5]   1.00-2.00   sec   113 MBytes   951 Mbits/sec  82117  
[  5]   2.00-3.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   3.00-4.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   4.00-5.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   6.00-7.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   7.00-8.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   8.00-9.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  82561  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  0.000 ms  0/825125 (0%)  sender
[  5]   0.00-10.04  sec   808 MBytes   675 Mbits/sec  0.001 ms  240231/825080 (29%)  receiver

iperf Done.
```

## TC5: 200 Mbps, TC5: 1000 Mbps
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 37394
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 59755
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  20.8 MBytes   175 Mbits/sec  0.046 ms  1378/16224 (8.5%)  
[  5]   1.00-2.00   sec  21.7 MBytes   182 Mbits/sec  0.050 ms  1503/16982 (8.9%)  
[  5]   2.00-3.00   sec  21.7 MBytes   182 Mbits/sec  0.047 ms  1494/16985 (8.8%)  
[  5]   3.00-4.00   sec  21.7 MBytes   182 Mbits/sec  0.048 ms  1507/16983 (8.9%)  
[  5]   4.00-5.00   sec  21.7 MBytes   182 Mbits/sec  0.046 ms  1496/16985 (8.8%)  
[  5]   5.00-6.00   sec  21.7 MBytes   182 Mbits/sec  0.047 ms  1499/16982 (8.8%)  
[  5]   6.00-7.00   sec  21.7 MBytes   182 Mbits/sec  0.049 ms  1495/16984 (8.8%)  
[  5]   7.00-8.00   sec  21.8 MBytes   182 Mbits/sec  0.046 ms  1488/16985 (8.8%)  
[  5]   8.00-9.00   sec  21.7 MBytes   182 Mbits/sec  0.049 ms  1494/16982 (8.8%)  
[  5]   9.00-10.00  sec  21.7 MBytes   182 Mbits/sec  0.049 ms  1500/16984 (8.8%)  
[  5]  10.00-10.04  sec   979 KBytes   183 Mbits/sec  0.031 ms  65/746 (8.7%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   217 MBytes   182 Mbits/sec  0.031 ms  14919/169822 (8.8%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 200M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 59755 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  23.8 MBytes   200 Mbits/sec  16969  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  16983  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   238 MBytes   200 Mbits/sec  0.000 ms  0/169822 (0%)  sender
[  5]   0.00-10.04  sec   217 MBytes   182 Mbits/sec  0.031 ms  14919/169822 (8.8%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 192.168.1.2, port 59084
[  5] local 192.168.1.3 port 5201 connected to 192.168.1.2 port 56643
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  88.1 MBytes   739 Mbits/sec  0.001 ms  14997/78831 (19%)  
[  5]   1.00-2.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15728/82558 (19%)  
[  5]   2.00-3.00   sec  92.0 MBytes   772 Mbits/sec  0.001 ms  15667/82295 (19%)  
[  5]   3.00-4.00   sec  92.3 MBytes   774 Mbits/sec  0.002 ms  15724/82558 (19%)  
[  5]   4.00-5.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15732/82557 (19%)  
[  5]   5.00-6.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15729/82557 (19%)  
[  5]   6.00-7.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15738/82558 (19%)  
[  5]   7.00-8.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15742/82558 (19%)  
[  5]   8.00-9.00   sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15732/82558 (19%)  
[  5]   9.00-10.00  sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15733/82557 (19%)  
[  5]  10.00-10.04  sec  4.98 MBytes   940 Mbits/sec  0.000 ms  66/3673 (1.8%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   923 MBytes   771 Mbits/sec  0.000 ms  156588/825260 (19%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 192.168.1.3, port 5201
[  5] local 192.168.1.2 port 56643 connected to 192.168.1.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  82521  
[  5]   1.00-2.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   2.00-3.00   sec   114 MBytes   953 Mbits/sec  82298  
[  5]   3.00-4.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   4.00-5.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   5.00-6.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   6.00-7.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   7.00-8.00   sec   114 MBytes   956 Mbits/sec  82560  
[  5]   8.00-9.00   sec   114 MBytes   956 Mbits/sec  82561  
[  5]   9.00-10.00  sec   114 MBytes   956 Mbits/sec  82560  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   956 Mbits/sec  0.000 ms  0/825304 (0%)  sender
[  5]   0.00-10.04  sec   923 MBytes   771 Mbits/sec  0.000 ms  156588/825260 (19%)  receiver

iperf Done.
```
</details>

<details><summary>TC7 (CBS, no Limit) and TC5 (FIFO)</summary>

## iperf3 results of TC7: 1000 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 48496
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 39559
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   109 MBytes   914 Mbits/sec  0.001 ms  0/77622 (0%)  
[  5]   1.00-2.00   sec   114 MBytes   956 Mbits/sec  0.000 ms  39/81250 (0.048%)  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81266 (0%)  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81265 (0%)  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]  10.00-10.04  sec  5.01 MBytes   957 Mbits/sec  0.001 ms  0/3570 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec  1.11 GBytes   953 Mbits/sec  0.001 ms  39/812587 (0.0048%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1000M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 39559 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   956 Mbits/sec  81213  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81266  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81264  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81269  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812629 (0%)  sender
[  5]   0.00-10.04  sec  1.11 GBytes   953 Mbits/sec  0.001 ms  39/812587 (0.0048%)  receiver

iperf Done.
```
### iperf log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 35022
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 46186
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  2.88 KBytes  23.5 Kbits/sec  0.000 ms  0/2 (0%)  
[  5]   1.00-2.00   sec  27.3 KBytes   224 Kbits/sec  55.828 ms  79618/79637 (1e+02%)  
[  5]   2.00-3.00   sec  4.31 KBytes  35.3 Kbits/sec  101.470 ms  0/3 (0%)  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  101.470 ms  0/0 (0%)  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  101.470 ms  0/0 (0%)  
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec  101.470 ms  0/0 (0%)  
[  5]   6.00-7.00   sec  4.31 KBytes  35.3 Kbits/sec  301.759 ms  0/3 (0%)  
[  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec  301.759 ms  0/0 (0%)  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec  301.759 ms  0/0 (0%)  
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec  301.759 ms  0/0 (0%)  
[  5]  10.00-10.05  sec  64.7 KBytes  11.8 Mbits/sec  86.941 ms  730844/730889 (1e+02%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   104 KBytes  84.4 Kbits/sec  86.941 ms  810462/810534 (1e+02%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 46186 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81024  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810577 (0%)  sender
[  5]   0.00-10.05  sec   104 KBytes  84.4 Kbits/sec  86.941 ms  810462/810534 (1e+02%)  receiver

iperf Done.
```

## iperf3 results of TC7: 800 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 58418
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 56194
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  91.1 MBytes   764 Mbits/sec  0.028 ms  0/64908 (0%)  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67937 (0%)  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  0.024 ms  0/67938 (0%)  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67930 (0%)  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67936 (0%)  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  0.026 ms  0/67934 (0%)  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67932 (0%)  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67938 (0%)  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  0.027 ms  0/67934 (0%)  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  0.028 ms  0/67934 (0%)  
[  5]  10.00-10.04  sec  4.18 MBytes   800 Mbits/sec  0.010 ms  0/2977 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.010 ms  0/679298 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 800M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 56194 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  95.3 MBytes   799 Mbits/sec  67887  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  67938  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  67929  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  67932  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  67937  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  67932  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   954 MBytes   800 Mbits/sec  0.000 ms  0/679298 (0%)  sender
[  5]   0.00-10.04  sec   954 MBytes   796 Mbits/sec  0.010 ms  0/679298 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 35454
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 44436
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  17.9 MBytes   150 Mbits/sec  0.121 ms  64776/77504 (84%)  
[  5]   1.00-2.00   sec  18.7 MBytes   157 Mbits/sec  0.116 ms  67758/81058 (84%)  
[  5]   2.00-3.00   sec  18.7 MBytes   157 Mbits/sec  0.113 ms  67763/81059 (84%)  
[  5]   3.00-4.00   sec  18.7 MBytes   157 Mbits/sec  0.115 ms  67755/81058 (84%)  
[  5]   4.00-5.00   sec  18.7 MBytes   157 Mbits/sec  0.127 ms  67759/81058 (84%)  
[  5]   5.00-6.00   sec  18.7 MBytes   157 Mbits/sec  0.113 ms  67758/81059 (84%)  
[  5]   6.00-7.00   sec  18.7 MBytes   157 Mbits/sec  0.126 ms  67760/81058 (84%)  
[  5]   7.00-8.00   sec  18.7 MBytes   157 Mbits/sec  0.122 ms  67758/81058 (84%)  
[  5]   8.00-9.00   sec  18.7 MBytes   157 Mbits/sec  0.116 ms  67762/81059 (84%)  
[  5]   9.00-10.00  sec  24.8 MBytes   208 Mbits/sec  0.001 ms  63419/81064 (78%)  
[  5]  10.00-10.04  sec  4.91 MBytes   954 Mbits/sec  0.001 ms  0/3500 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   197 MBytes   164 Mbits/sec  0.001 ms  670268/810535 (83%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 44436 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   954 Mbits/sec  81059  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810579 (0%)  sender
[  5]   0.00-10.04  sec   197 MBytes   164 Mbits/sec  0.001 ms  670268/810535 (83%)  receiver

iperf Done.
```

## TC7: 600 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 55790
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 48025
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  68.3 MBytes   573 Mbits/sec  0.026 ms  0/48679 (0%)  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  0.025 ms  0/50952 (0%)  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  0.025 ms  0/50950 (0%)  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  0.026 ms  0/50951 (0%)  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  0.025 ms  0/50952 (0%)  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  0.026 ms  0/50950 (0%)  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  0.026 ms  0/50952 (0%)  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  0.026 ms  0/50951 (0%)  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  0.026 ms  0/50951 (0%)  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  0.027 ms  0/50950 (0%)  
[  5]  10.00-10.04  sec  3.13 MBytes   600 Mbits/sec  0.011 ms  0/2232 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509470 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 600M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 48025 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  71.5 MBytes   599 Mbits/sec  50911  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  50950  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  50951  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   715 MBytes   600 Mbits/sec  0.000 ms  0/509470 (0%)  sender
[  5]   0.00-10.04  sec   715 MBytes   597 Mbits/sec  0.011 ms  0/509470 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 49426
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 53977
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  40.7 MBytes   341 Mbits/sec  0.021 ms  48699/77695 (63%)  
[  5]   1.00-2.00   sec  42.4 MBytes   356 Mbits/sec  0.021 ms  50820/81058 (63%)  
[  5]   2.00-3.00   sec  42.4 MBytes   356 Mbits/sec  0.020 ms  50724/80944 (63%)  
[  5]   3.00-4.00   sec  42.4 MBytes   356 Mbits/sec  0.021 ms  50820/81059 (63%)  
[  5]   4.00-5.00   sec  42.4 MBytes   356 Mbits/sec  0.021 ms  50819/81058 (63%)  
[  5]   5.00-6.00   sec  42.4 MBytes   356 Mbits/sec  0.020 ms  50802/81037 (63%)  
[  5]   6.00-7.00   sec  42.4 MBytes   356 Mbits/sec  0.023 ms  50820/81058 (63%)  
[  5]   7.00-8.00   sec  42.4 MBytes   356 Mbits/sec  0.022 ms  50819/81058 (63%)  
[  5]   8.00-9.00   sec  42.4 MBytes   356 Mbits/sec  0.021 ms  50819/81058 (63%)  
[  5]   9.00-10.00  sec  50.5 MBytes   423 Mbits/sec  0.001 ms  45128/81067 (56%)  
[  5]  10.00-10.04  sec  4.64 MBytes   954 Mbits/sec  0.001 ms  0/3307 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   435 MBytes   364 Mbits/sec  0.001 ms  500270/810399 (62%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 53977 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   954 Mbits/sec  81053  
[  5]   2.00-3.00   sec   114 MBytes   953 Mbits/sec  80956  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   954 Mbits/sec  81056  
[  5]   5.00-6.00   sec   114 MBytes   954 Mbits/sec  81046  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810443 (0%)  sender
[  5]   0.00-10.04  sec   435 MBytes   364 Mbits/sec  0.001 ms  500270/810399 (62%)  receiver

iperf Done.
```

## TC7: 400 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 33822
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 35194
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  45.6 MBytes   382 Mbits/sec  0.022 ms  0/32453 (0%)  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33969 (0%)  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33968 (0%)  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33967 (0%)  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33966 (0%)  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33968 (0%)  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  0.020 ms  0/33969 (0%)  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33966 (0%)  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33967 (0%)  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  0.021 ms  0/33967 (0%)  
[  5]  10.00-10.04  sec  2.09 MBytes   399 Mbits/sec  0.012 ms  0/1486 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.012 ms  0/339646 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 400M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 35194 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  47.6 MBytes   400 Mbits/sec  33939  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  33968  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   477 MBytes   400 Mbits/sec  0.000 ms  0/339646 (0%)  sender
[  5]   0.00-10.04  sec   477 MBytes   398 Mbits/sec  0.012 ms  0/339646 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 43718
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 48566
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  63.4 MBytes   531 Mbits/sec  0.005 ms  32375/77507 (42%)  
[  5]   1.00-2.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81058 (42%)  
[  5]   2.00-3.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33875/81053 (42%)  
[  5]   3.00-4.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33880/81058 (42%)  
[  5]   4.00-5.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81059 (42%)  
[  5]   5.00-6.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33879/81058 (42%)  
[  5]   6.00-7.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33880/81058 (42%)  
[  5]   7.00-8.00   sec  66.2 MBytes   556 Mbits/sec  0.004 ms  33863/81042 (42%)  
[  5]   8.00-9.00   sec  66.2 MBytes   556 Mbits/sec  0.005 ms  33881/81059 (42%)  
[  5]   9.00-10.00  sec  70.6 MBytes   592 Mbits/sec  0.001 ms  30763/81071 (38%)  
[  5]  10.00-10.04  sec  4.90 MBytes   954 Mbits/sec  0.000 ms  0/3488 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   669 MBytes   559 Mbits/sec  0.000 ms  334154/810511 (41%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 48566 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81056  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   7.00-8.00   sec   114 MBytes   954 Mbits/sec  81045  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810555 (0%)  sender
[  5]   0.00-10.04  sec   669 MBytes   559 Mbits/sec  0.000 ms  334154/810511 (41%)  receiver

iperf Done.
```

## TC7: 200 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 44846
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 45658
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  22.8 MBytes   191 Mbits/sec  0.016 ms  0/16232 (0%)  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  0.014 ms  0/16984 (0%)  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16983 (0%)  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  0.015 ms  0/16984 (0%)  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16983 (0%)  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16984 (0%)  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16984 (0%)  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16983 (0%)  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  0.017 ms  0/16985 (0%)  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  0.016 ms  0/16984 (0%)  
[  5]  10.00-10.04  sec  1.03 MBytes   198 Mbits/sec  0.014 ms  0/736 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   238 MBytes   199 Mbits/sec  0.014 ms  0/169822 (0%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 200M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 45658 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  23.8 MBytes   200 Mbits/sec  16969  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  16984  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   238 MBytes   200 Mbits/sec  0.000 ms  0/169822 (0%)  sender
[  5]   0.00-10.04  sec   238 MBytes   199 Mbits/sec  0.014 ms  0/169822 (0%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 37474
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 42235
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  86.0 MBytes   722 Mbits/sec  0.001 ms  16168/77462 (21%)  
[  5]   1.00-2.00   sec  90.0 MBytes   755 Mbits/sec  0.002 ms  16940/81059 (21%)  
[  5]   2.00-3.00   sec  90.0 MBytes   755 Mbits/sec  0.002 ms  16913/81019 (21%)  
[  5]   3.00-4.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16939/81058 (21%)  
[  5]   4.00-5.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16941/81059 (21%)  
[  5]   5.00-6.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16930/81041 (21%)  
[  5]   6.00-7.00   sec  90.0 MBytes   755 Mbits/sec  0.001 ms  16941/81059 (21%)  
[  5]   7.00-8.00   sec  90.0 MBytes   755 Mbits/sec  0.002 ms  16939/81058 (21%)  
[  5]   8.00-9.00   sec  90.0 MBytes   755 Mbits/sec  0.002 ms  16940/81058 (21%)  
[  5]   9.00-10.00  sec  92.3 MBytes   774 Mbits/sec  0.001 ms  15314/81069 (19%)  
[  5]  10.00-10.04  sec  4.97 MBytes   954 Mbits/sec  0.000 ms  0/3537 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   903 MBytes   755 Mbits/sec  0.000 ms  166965/810479 (21%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 42235 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   954 Mbits/sec  81045  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81062  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810523 (0%)  sender
[  5]   0.00-10.04  sec   903 MBytes   755 Mbits/sec  0.000 ms  166965/810479 (21%)  receiver

iperf Done.
```
</details>

<details><summary>TC7 (CBS, with Limit) and TC5 (FIFO)</summary>

## iperf3 results of TC7: 1000 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 100 % (1000 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 37924
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 39771
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   109 MBytes   910 Mbits/sec  0.001 ms  0/77296 (0%)  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  0.001 ms  171/81269 (0.21%)  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  0.002 ms  0/81268 (0%)  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  0.000 ms  0/81270 (0%)  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  0.002 ms  0/81268 (0%)  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81262 (0%)  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  0.001 ms  0/81269 (0%)  
[  5]  10.00-10.05  sec  5.47 MBytes   957 Mbits/sec  0.001 ms  0/3898 (0%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec  1.11 GBytes   952 Mbits/sec  0.001 ms  171/812607 (0.021%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 1000M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 39771 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   957 Mbits/sec  81237  
[  5]   1.00-2.00   sec   114 MBytes   957 Mbits/sec  81270  
[  5]   2.00-3.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   3.00-4.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   4.00-5.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   5.00-6.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   6.00-7.00   sec   114 MBytes   957 Mbits/sec  81261  
[  5]   7.00-8.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   8.00-9.00   sec   114 MBytes   957 Mbits/sec  81269  
[  5]   9.00-10.00  sec   114 MBytes   957 Mbits/sec  81270  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   957 Mbits/sec  0.000 ms  0/812652 (0%)  sender
[  5]   0.00-10.05  sec  1.11 GBytes   952 Mbits/sec  0.001 ms  171/812607 (0.021%)  receiver

iperf Done.
```
### iperf log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 50824
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 47648
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  1.10 MBytes  9.20 Mbits/sec  0.001 ms  0/782 (0%)  
[  5]   1.00-2.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec  0.001 ms  0/0 (0%)  
[  5]   7.00-8.00   sec  10.1 KBytes  82.4 Kbits/sec  296.197 ms  0/7 (0%)  
[  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec  296.197 ms  0/0 (0%)  
[  5]   9.00-10.00  sec  0.00 Bytes  0.00 bits/sec  296.197 ms  0/0 (0%)  
[  5]  10.00-10.25  sec  14.4 KBytes   465 Kbits/sec  557.090 ms  565794/565804 (1e+02%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.25  sec  1.12 MBytes   918 Kbits/sec  557.090 ms  565794/566593 (1e+02%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 47648 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81059  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81062  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810577 (0%)  sender
[  5]   0.00-10.25  sec  1.12 MBytes   918 Kbits/sec  557.090 ms  565794/566593 (1e+02%)  receiver

iperf Done.
```

## iperf3 results of TC7: 800 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 80 % (800 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 35300
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 41955
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  85.7 MBytes   719 Mbits/sec  0.043 ms  3825/64903 (5.9%)  
[  5]   1.00-2.00   sec  90.0 MBytes   755 Mbits/sec  0.044 ms  3836/67935 (5.6%)  
[  5]   2.00-3.00   sec  90.0 MBytes   755 Mbits/sec  0.043 ms  3830/67934 (5.6%)  
[  5]   3.00-4.00   sec  90.0 MBytes   755 Mbits/sec  0.041 ms  3837/67937 (5.6%)  
[  5]   4.00-5.00   sec  90.0 MBytes   755 Mbits/sec  0.043 ms  3837/67933 (5.6%)  
[  5]   5.00-6.00   sec  90.0 MBytes   755 Mbits/sec  0.042 ms  3829/67938 (5.6%)  
[  5]   6.00-7.00   sec  90.0 MBytes   755 Mbits/sec  0.042 ms  3808/67931 (5.6%)  
[  5]   7.00-8.00   sec  89.5 MBytes   751 Mbits/sec  0.041 ms  4173/67936 (6.1%)  
[  5]   8.00-9.00   sec  89.8 MBytes   754 Mbits/sec  0.042 ms  3931/67934 (5.8%)  
[  5]   9.00-10.00  sec  90.0 MBytes   755 Mbits/sec  0.043 ms  3833/67935 (5.6%)  
[  5]  10.00-10.04  sec  3.95 MBytes   756 Mbits/sec  0.012 ms  168/2983 (5.6%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   899 MBytes   751 Mbits/sec  0.012 ms  38907/679299 (5.7%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 800M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 41955 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  95.3 MBytes   799 Mbits/sec  67888  
[  5]   1.00-2.00   sec  95.4 MBytes   800 Mbits/sec  67933  
[  5]   2.00-3.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   3.00-4.00   sec  95.4 MBytes   800 Mbits/sec  67937  
[  5]   4.00-5.00   sec  95.4 MBytes   800 Mbits/sec  67931  
[  5]   5.00-6.00   sec  95.4 MBytes   800 Mbits/sec  67935  
[  5]   6.00-7.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   7.00-8.00   sec  95.4 MBytes   800 Mbits/sec  67936  
[  5]   8.00-9.00   sec  95.4 MBytes   800 Mbits/sec  67934  
[  5]   9.00-10.00  sec  95.4 MBytes   800 Mbits/sec  67938  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   954 MBytes   800 Mbits/sec  0.000 ms  0/679300 (0%)  sender
[  5]   0.00-10.04  sec   899 MBytes   751 Mbits/sec  0.012 ms  38907/679299 (5.7%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 44422
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 59968
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  23.6 MBytes   198 Mbits/sec  0.018 ms  60624/77469 (78%)  
[  5]   1.00-2.00   sec  23.9 MBytes   200 Mbits/sec  0.015 ms  63219/80212 (79%)  
[  5]   2.00-3.00   sec  24.0 MBytes   202 Mbits/sec  0.011 ms  63890/81008 (79%)  
[  5]   3.00-4.00   sec  24.0 MBytes   202 Mbits/sec  0.014 ms  63942/81066 (79%)  
[  5]   4.00-5.00   sec  24.1 MBytes   202 Mbits/sec  0.014 ms  63930/81062 (79%)  
[  5]   5.00-6.00   sec  24.0 MBytes   202 Mbits/sec  0.017 ms  63945/81057 (79%)  
[  5]   6.00-7.00   sec  24.0 MBytes   201 Mbits/sec  0.016 ms  63949/81051 (79%)  
[  5]   7.00-8.00   sec  24.5 MBytes   206 Mbits/sec  0.017 ms  63609/81071 (78%)  
[  5]   8.00-9.00   sec  24.2 MBytes   203 Mbits/sec  0.020 ms  63830/81051 (79%)  
[  5]   9.00-10.00  sec  24.0 MBytes   202 Mbits/sec  0.015 ms  63939/81062 (79%)  
[  5]  10.00-10.26  sec  1.06 MBytes  34.8 Mbits/sec  0.016 ms  2827/3581 (79%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.26  sec   241 MBytes   197 Mbits/sec  0.016 ms  637704/809690 (79%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 59968 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   113 MBytes   945 Mbits/sec  80218  
[  5]   2.00-3.00   sec   114 MBytes   954 Mbits/sec  81018  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81062  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   953 Mbits/sec  0.000 ms  0/809693 (0%)  sender
[  5]   0.00-10.26  sec   241 MBytes   197 Mbits/sec  0.016 ms  637704/809690 (79%)  receiver

iperf Done.
```

## TC7: 600 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 60 % (600 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 52942
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 35296
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  54.0 MBytes   453 Mbits/sec  0.044 ms  9978/48473 (21%)  
[  5]   1.00-2.00   sec  56.7 MBytes   476 Mbits/sec  0.043 ms  10533/50951 (21%)  
[  5]   2.00-3.00   sec  56.7 MBytes   476 Mbits/sec  0.045 ms  10546/50951 (21%)  
[  5]   3.00-4.00   sec  56.7 MBytes   476 Mbits/sec  0.044 ms  10538/50951 (21%)  
[  5]   4.00-5.00   sec  56.8 MBytes   476 Mbits/sec  0.045 ms  10522/50950 (21%)  
[  5]   5.00-6.00   sec  56.8 MBytes   476 Mbits/sec  0.046 ms  10524/50952 (21%)  
[  5]   6.00-7.00   sec  56.8 MBytes   476 Mbits/sec  0.046 ms  10521/50951 (21%)  
[  5]   7.00-8.00   sec  56.8 MBytes   476 Mbits/sec  0.043 ms  10520/50952 (21%)  
[  5]   8.00-9.00   sec  57.3 MBytes   480 Mbits/sec  0.044 ms  10167/50951 (20%)  
[  5]   9.00-10.00  sec  56.9 MBytes   477 Mbits/sec  0.046 ms  10417/50950 (20%)  
[  5]  10.00-10.05  sec  2.72 MBytes   477 Mbits/sec  0.019 ms  504/2439 (21%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec   568 MBytes   474 Mbits/sec  0.019 ms  104770/509471 (21%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 600M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 35296 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  71.5 MBytes   599 Mbits/sec  50911  
[  5]   1.00-2.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   2.00-3.00   sec  71.5 MBytes   600 Mbits/sec  50952  
[  5]   3.00-4.00   sec  71.5 MBytes   600 Mbits/sec  50949  
[  5]   4.00-5.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   5.00-6.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   6.00-7.00   sec  71.5 MBytes   600 Mbits/sec  50953  
[  5]   7.00-8.00   sec  71.5 MBytes   600 Mbits/sec  50951  
[  5]   8.00-9.00   sec  71.5 MBytes   600 Mbits/sec  50949  
[  5]   9.00-10.00  sec  71.5 MBytes   600 Mbits/sec  50952  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   715 MBytes   600 Mbits/sec  0.000 ms  0/509471 (0%)  sender
[  5]   0.00-10.05  sec   568 MBytes   474 Mbits/sec  0.019 ms  104770/509471 (21%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 42722
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 58766
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  54.8 MBytes   460 Mbits/sec  0.014 ms  38379/77449 (50%)  
[  5]   1.00-2.00   sec  57.0 MBytes   479 Mbits/sec  0.014 ms  40190/80829 (50%)  
[  5]   2.00-3.00   sec  57.2 MBytes   480 Mbits/sec  0.013 ms  40254/80999 (50%)  
[  5]   3.00-4.00   sec  57.2 MBytes   480 Mbits/sec  0.013 ms  40308/81058 (50%)  
[  5]   4.00-5.00   sec  57.2 MBytes   480 Mbits/sec  0.014 ms  40325/81059 (50%)  
[  5]   5.00-6.00   sec  57.2 MBytes   480 Mbits/sec  0.014 ms  40304/81034 (50%)  
[  5]   6.00-7.00   sec  57.2 MBytes   480 Mbits/sec  0.013 ms  40325/81058 (50%)  
[  5]   7.00-8.00   sec  57.2 MBytes   480 Mbits/sec  0.013 ms  40327/81058 (50%)  
[  5]   8.00-9.00   sec  11.5 MBytes  96.1 Mbits/sec  0.013 ms  8070/16239 (50%)  
[  5]   9.00-10.00  sec  44.4 MBytes   373 Mbits/sec  0.015 ms  31288/62916 (50%)  
[  5]  10.00-10.04  sec  2.51 MBytes   480 Mbits/sec  0.014 ms  1774/3559 (50%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   513 MBytes   429 Mbits/sec  0.014 ms  361544/727258 (50%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 58766 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81025  
[  5]   1.00-2.00   sec   113 MBytes   952 Mbits/sec  80832  
[  5]   2.00-3.00   sec   114 MBytes   954 Mbits/sec  81002  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   954 Mbits/sec  81057  
[  5]   5.00-6.00   sec   114 MBytes   954 Mbits/sec  81042  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   8.00-9.00   sec  17.8 MBytes   149 Mbits/sec  12688  
[  5]   9.00-10.00  sec  93.3 MBytes   783 Mbits/sec  66473  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1021 MBytes   856 Mbits/sec  0.000 ms  0/727303 (0%)  sender
[  5]   0.00-10.04  sec   513 MBytes   429 Mbits/sec  0.014 ms  361544/727258 (50%)  receiver

iperf Done.
```

## TC7: 400 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 40 % (400 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 55684
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 55470
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  31.7 MBytes   266 Mbits/sec  0.061 ms  9863/32449 (30%)  
[  5]   1.00-2.00   sec  33.2 MBytes   278 Mbits/sec  0.059 ms  10325/33968 (30%)  
[  5]   2.00-3.00   sec  33.2 MBytes   278 Mbits/sec  0.062 ms  10319/33967 (30%)  
[  5]   3.00-4.00   sec  33.2 MBytes   278 Mbits/sec  0.060 ms  10324/33968 (30%)  
[  5]   4.00-5.00   sec  33.2 MBytes   279 Mbits/sec  0.057 ms  10307/33968 (30%)  
[  5]   5.00-6.00   sec  33.2 MBytes   279 Mbits/sec  0.062 ms  10313/33966 (30%)  
[  5]   6.00-7.00   sec  33.2 MBytes   278 Mbits/sec  0.061 ms  10324/33968 (30%)  
[  5]   7.00-8.00   sec  33.2 MBytes   278 Mbits/sec  0.062 ms  10345/33967 (30%)  
[  5]   8.00-9.00   sec  33.2 MBytes   278 Mbits/sec  0.060 ms  10331/33968 (30%)  
[  5]   9.00-10.00  sec  33.2 MBytes   278 Mbits/sec  0.061 ms  10323/33967 (30%)  
[  5]  10.00-10.04  sec  1.45 MBytes   278 Mbits/sec  0.037 ms  452/1487 (30%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   332 MBytes   277 Mbits/sec  0.037 ms  103226/339643 (30%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 400M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 55470 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  47.6 MBytes   400 Mbits/sec  33939  
[  5]   1.00-2.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   2.00-3.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   3.00-4.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   4.00-5.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   5.00-6.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   6.00-7.00   sec  47.7 MBytes   400 Mbits/sec  33967  
[  5]   7.00-8.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   8.00-9.00   sec  47.7 MBytes   400 Mbits/sec  33968  
[  5]   9.00-10.00  sec  47.7 MBytes   400 Mbits/sec  33966  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   477 MBytes   400 Mbits/sec  0.000 ms  0/339645 (0%)  sender
[  5]   0.00-10.04  sec   332 MBytes   277 Mbits/sec  0.037 ms  103226/339643 (30%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 48012
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 42202
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  77.1 MBytes   646 Mbits/sec  0.004 ms  22504/77400 (29%)  
[  5]   1.00-2.00   sec  80.7 MBytes   677 Mbits/sec  0.004 ms  23582/81059 (29%)  
[  5]   2.00-3.00   sec  80.6 MBytes   676 Mbits/sec  0.005 ms  23551/80950 (29%)  
[  5]   3.00-4.00   sec  80.7 MBytes   677 Mbits/sec  0.005 ms  23583/81058 (29%)  
[  5]   4.00-5.00   sec  80.7 MBytes   677 Mbits/sec  0.005 ms  23601/81059 (29%)  
[  5]   5.00-6.00   sec  80.7 MBytes   677 Mbits/sec  0.004 ms  23590/81058 (29%)  
[  5]   6.00-7.00   sec  80.7 MBytes   677 Mbits/sec  0.005 ms  23583/81058 (29%)  
[  5]   7.00-8.00   sec  80.7 MBytes   677 Mbits/sec  0.005 ms  23548/81042 (29%)  
[  5]   8.00-9.00   sec  80.7 MBytes   677 Mbits/sec  0.004 ms  23574/81058 (29%)  
[  5]   9.00-10.00  sec  80.5 MBytes   675 Mbits/sec  0.005 ms  23717/81059 (29%)  
[  5]  10.00-10.04  sec  3.88 MBytes   731 Mbits/sec  0.001 ms  847/3608 (23%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   807 MBytes   674 Mbits/sec  0.001 ms  235680/810409 (29%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 42202 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81026  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   2.00-3.00   sec   114 MBytes   953 Mbits/sec  80953  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   954 Mbits/sec  81045  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81061  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810453 (0%)  sender
[  5]   0.00-10.04  sec   807 MBytes   674 Mbits/sec  0.001 ms  235680/810409 (29%)  receiver

iperf Done.
```

## TC7: 200 Mbps, TC5: 1000 Mbps
### idleSlope
TC7: 20 % (200 Mbps)
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5202
-----------------------------------------------------------
Server listening on 5202
-----------------------------------------------------------
Accepted connection from 192.168.1.1, port 33626
[  5] local 192.168.1.3 port 5202 connected to 192.168.1.1 port 36465
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  18.7 MBytes   157 Mbits/sec  0.120 ms  2892/16225 (18%)  
[  5]   1.00-2.00   sec  19.6 MBytes   164 Mbits/sec  0.120 ms  3027/16983 (18%)  
[  5]   2.00-3.00   sec  19.6 MBytes   164 Mbits/sec  0.120 ms  3030/16984 (18%)  
[  5]   3.00-4.00   sec  19.6 MBytes   164 Mbits/sec  0.119 ms  3035/16984 (18%)  
[  5]   4.00-5.00   sec  19.6 MBytes   164 Mbits/sec  0.119 ms  3034/16983 (18%)  
[  5]   5.00-6.00   sec  19.6 MBytes   164 Mbits/sec  0.120 ms  3026/16984 (18%)  
[  5]   6.00-7.00   sec  19.6 MBytes   164 Mbits/sec  0.120 ms  3029/16984 (18%)  
[  5]   7.00-8.00   sec  19.6 MBytes   164 Mbits/sec  0.119 ms  3026/16983 (18%)  
[  5]   8.00-9.00   sec  19.6 MBytes   164 Mbits/sec  0.121 ms  3024/16984 (18%)  
[  5]   9.00-10.00  sec  19.6 MBytes   164 Mbits/sec  0.121 ms  3034/16984 (18%)  
[  5]  10.00-10.04  sec   877 KBytes   164 Mbits/sec  0.088 ms  134/744 (18%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   196 MBytes   164 Mbits/sec  0.088 ms  30291/169822 (18%)  receiver
```
```shell
$ iperf3 -c 192.168.1.3 -p 5202 -u -l 1472 -b 200M
Connecting to host 192.168.1.3, port 5202
[  5] local 192.168.1.1 port 36465 connected to 192.168.1.3 port 5202
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec  23.8 MBytes   200 Mbits/sec  16969  
[  5]   1.00-2.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   2.00-3.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   3.00-4.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   4.00-5.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   5.00-6.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   6.00-7.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   7.00-8.00   sec  23.8 MBytes   200 Mbits/sec  16984  
[  5]   8.00-9.00   sec  23.8 MBytes   200 Mbits/sec  16983  
[  5]   9.00-10.00  sec  23.8 MBytes   200 Mbits/sec  16984  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec   238 MBytes   200 Mbits/sec  0.000 ms  0/169822 (0%)  sender
[  5]   0.00-10.04  sec   196 MBytes   164 Mbits/sec  0.088 ms  30291/169822 (18%)  receiver

iperf Done.
```
### iperf server log (TC5)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.2, port 52404
[  5] local 10.0.0.3 port 5201 connected to 10.0.0.2 port 54101
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  90.1 MBytes   756 Mbits/sec  0.005 ms  13297/77494 (17%)  
[  5]   1.00-2.00   sec  94.3 MBytes   791 Mbits/sec  0.005 ms  13920/81059 (17%)  
[  5]   2.00-3.00   sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13917/81058 (17%)  
[  5]   3.00-4.00   sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13914/81058 (17%)  
[  5]   4.00-5.00   sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13913/81059 (17%)  
[  5]   5.00-6.00   sec  94.2 MBytes   791 Mbits/sec  0.004 ms  13922/81058 (17%)  
[  5]   6.00-7.00   sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13919/81058 (17%)  
[  5]   7.00-8.00   sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13920/81059 (17%)  
[  5]   8.00-9.00   sec  94.2 MBytes   791 Mbits/sec  0.004 ms  13925/81058 (17%)  
[  5]   9.00-10.00  sec  94.3 MBytes   791 Mbits/sec  0.004 ms  13914/81058 (17%)  
[  5]  10.00-10.04  sec  4.31 MBytes   834 Mbits/sec  0.001 ms  444/3514 (13%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   943 MBytes   787 Mbits/sec  0.001 ms  139005/810533 (17%)  receiver
```
```shell
$ iperf3 -c 172.16.0.3 -p 5201 -l 1472 -u -b 1000M
Connecting to host 10.0.0.3, port 5201
[  5] local 10.0.0.2 port 54101 connected to 10.0.0.3 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81023  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81062  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81061  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81062  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810577 (0%)  sender
[  5]   0.00-10.04  sec   943 MBytes   787 Mbits/sec  0.001 ms  139005/810533 (17%)  receiver

iperf Done.
```
</details>
