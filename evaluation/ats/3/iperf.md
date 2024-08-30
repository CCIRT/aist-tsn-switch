## iperf3 results of TC7: CIR = 100 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 51724
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 34089
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  11.0 MBytes  92.4 Mbits/sec  0.003 ms  69567/77413 (90%)  
[  5]   1.00-2.00   sec  11.5 MBytes  96.7 Mbits/sec  0.003 ms  72851/81064 (90%)  
[  5]   2.00-3.00   sec  11.5 MBytes  96.7 Mbits/sec  0.004 ms  72852/81065 (90%)  
[  5]   3.00-4.00   sec  11.5 MBytes  96.7 Mbits/sec  0.002 ms  72852/81065 (90%)  
[  5]   4.00-5.00   sec  11.5 MBytes  96.7 Mbits/sec  0.003 ms  72845/81058 (90%)  
[  5]   5.00-6.00   sec  11.5 MBytes  96.7 Mbits/sec  0.003 ms  72852/81065 (90%)  
[  5]   6.00-7.00   sec  11.5 MBytes  96.7 Mbits/sec  0.004 ms  72851/81064 (90%)  
[  5]   7.00-8.00   sec  11.5 MBytes  96.7 Mbits/sec  0.003 ms  72852/81065 (90%)  
[  5]   8.00-9.00   sec  11.5 MBytes  96.7 Mbits/sec  0.004 ms  72835/81047 (90%)  
[  5]   9.00-10.00  sec  11.5 MBytes  96.7 Mbits/sec  0.003 ms  72836/81049 (90%)  
[  5]  10.00-10.04  sec   519 KBytes  96.8 Mbits/sec  0.003 ms  3202/3563 (90%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   115 MBytes  96.3 Mbits/sec  0.003 ms  728395/810518 (90%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 34089 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81028  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81057  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81056  
[  5]   9.00-10.00  sec   114 MBytes   954 Mbits/sec  81045  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810568 (0%)  sender
[  5]   0.00-10.04  sec   115 MBytes  96.3 Mbits/sec  0.003 ms  728395/810518 (90%)  receiver

iperf Done.
```

## iperf3 results of TC7: CIR = 200 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 43212
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 33182
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  22.0 MBytes   185 Mbits/sec  0.001 ms  61731/77423 (80%)  
[  5]   1.00-2.00   sec  23.1 MBytes   193 Mbits/sec  0.002 ms  64638/81064 (80%)  
[  5]   2.00-3.00   sec  23.1 MBytes   193 Mbits/sec  0.004 ms  64635/81060 (80%)  
[  5]   3.00-4.00   sec  23.1 MBytes   193 Mbits/sec  0.003 ms  64638/81064 (80%)  
[  5]   4.00-5.00   sec  23.1 MBytes   193 Mbits/sec  0.001 ms  64639/81065 (80%)  
[  5]   5.00-6.00   sec  23.1 MBytes   193 Mbits/sec  0.001 ms  64639/81065 (80%)  
[  5]   6.00-7.00   sec  23.1 MBytes   193 Mbits/sec  0.002 ms  64638/81064 (80%)  
[  5]   7.00-8.00   sec  23.1 MBytes   193 Mbits/sec  0.002 ms  64635/81060 (80%)  
[  5]   8.00-9.00   sec  23.1 MBytes   193 Mbits/sec  0.002 ms  64639/81065 (80%)  
[  5]   9.00-10.00  sec  23.1 MBytes   193 Mbits/sec  0.002 ms  64638/81064 (80%)  
[  5]  10.00-10.26  sec  1.03 MBytes  33.7 Mbits/sec  0.002 ms  2876/3607 (80%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.26  sec   231 MBytes   189 Mbits/sec  0.002 ms  646346/810601 (80%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 33182 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81028  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81065  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81064  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810601 (0%)  sender
[  5]   0.00-10.26  sec   231 MBytes   189 Mbits/sec  0.002 ms  646346/810601 (80%)  receiver

iperf Done.
```

## iperf3 results of TC7: CIR = 400 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 41434
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 37777
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  44.1 MBytes   370 Mbits/sec  0.018 ms  46019/77398 (59%)  
[  5]   1.00-2.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48209/81060 (59%)  
[  5]   2.00-3.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48213/81065 (59%)  
[  5]   3.00-4.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48211/81062 (59%)  
[  5]   4.00-5.00   sec  46.1 MBytes   387 Mbits/sec  0.005 ms  48213/81065 (59%)  
[  5]   5.00-6.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48212/81064 (59%)  
[  5]   6.00-7.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48211/81062 (59%)  
[  5]   7.00-8.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48213/81065 (59%)  
[  5]   8.00-9.00   sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48211/81062 (59%)  
[  5]   9.00-10.00  sec  46.1 MBytes   387 Mbits/sec  0.006 ms  48213/81065 (59%)  
[  5]  10.00-10.04  sec  2.03 MBytes   387 Mbits/sec  0.006 ms  2123/3570 (59%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   461 MBytes   385 Mbits/sec  0.006 ms  482048/810538 (59%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 37777 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81015  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81063  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810587 (0%)  sender
[  5]   0.00-10.04  sec   461 MBytes   385 Mbits/sec  0.006 ms  482048/810538 (59%)  receiver

iperf Done.
```

## iperf3 results of TC7: CIR = 600 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 36484
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 55115
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  66.1 MBytes   554 Mbits/sec  0.006 ms  30340/77409 (39%)  
[  5]   1.00-2.00   sec  69.2 MBytes   580 Mbits/sec  0.005 ms  31785/81063 (39%)  
[  5]   2.00-3.00   sec  69.2 MBytes   580 Mbits/sec  0.006 ms  31785/81064 (39%)  
[  5]   3.00-4.00   sec  69.2 MBytes   580 Mbits/sec  0.006 ms  31785/81064 (39%)  
[  5]   4.00-5.00   sec  69.2 MBytes   580 Mbits/sec  0.005 ms  31784/81062 (39%)  
[  5]   5.00-6.00   sec  69.2 MBytes   580 Mbits/sec  0.004 ms  31786/81065 (39%)  
[  5]   6.00-7.00   sec  69.2 MBytes   580 Mbits/sec  0.005 ms  31785/81064 (39%)  
[  5]   7.00-8.00   sec  69.2 MBytes   580 Mbits/sec  0.005 ms  31785/81063 (39%)  
[  5]   8.00-9.00   sec  69.2 MBytes   580 Mbits/sec  0.005 ms  31785/81064 (39%)  
[  5]   9.00-10.00  sec  69.2 MBytes   580 Mbits/sec  0.006 ms  31724/81002 (39%)  
[  5]  10.00-10.04  sec  3.05 MBytes   580 Mbits/sec  0.005 ms  1401/3573 (39%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   692 MBytes   578 Mbits/sec  0.005 ms  317745/810493 (39%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 55115 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81027  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   9.00-10.00  sec   114 MBytes   954 Mbits/sec  81003  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   954 Mbits/sec  0.000 ms  0/810539 (0%)  sender
[  5]   0.00-10.04  sec   692 MBytes   578 Mbits/sec  0.005 ms  317745/810493 (39%)  receiver

iperf Done.
```

## iperf3 results of TC7: CIR = 800 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 43020
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 58147
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec  88.1 MBytes   739 Mbits/sec  0.006 ms  14660/77415 (19%)  
[  5]   1.00-2.00   sec  92.2 MBytes   774 Mbits/sec  0.005 ms  15356/81060 (19%)  
[  5]   2.00-3.00   sec  92.2 MBytes   774 Mbits/sec  0.005 ms  15355/81058 (19%)  
[  5]   3.00-4.00   sec  92.2 MBytes   774 Mbits/sec  0.004 ms  15361/81064 (19%)  
[  5]   4.00-5.00   sec  92.2 MBytes   774 Mbits/sec  0.004 ms  15349/81052 (19%)  
[  5]   5.00-6.00   sec  92.2 MBytes   774 Mbits/sec  0.005 ms  15361/81064 (19%)  
[  5]   6.00-7.00   sec  92.2 MBytes   774 Mbits/sec  0.004 ms  15360/81063 (19%)  
[  5]   7.00-8.00   sec  92.2 MBytes   774 Mbits/sec  0.005 ms  15361/81065 (19%)  
[  5]   8.00-9.00   sec  92.2 MBytes   774 Mbits/sec  0.004 ms  15352/81055 (19%)  
[  5]   9.00-10.00  sec  92.2 MBytes   774 Mbits/sec  0.005 ms  15361/81064 (19%)  
[  5]  10.00-10.04  sec  4.06 MBytes   774 Mbits/sec  0.004 ms  676/3568 (19%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.04  sec   922 MBytes   770 Mbits/sec  0.004 ms  153552/810528 (19%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 58147 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81027  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81060  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81058  
[  5]   3.00-4.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   4.00-5.00   sec   114 MBytes   954 Mbits/sec  81052  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81056  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81064  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810572 (0%)  sender
[  5]   0.00-10.04  sec   922 MBytes   770 Mbits/sec  0.004 ms  153552/810528 (19%)  receiver

iperf Done.
```

## iperf3 results of TC7: CIR = 1000 Mbps
### iperf server log (TC7)
```shell
$ sudo ip netns exec ns1 iperf3 -s -p 5201
-----------------------------------------------------------
Server listening on 5201
-----------------------------------------------------------
Accepted connection from 10.0.0.1, port 43618
[  5] local 10.0.0.2 port 5201 connected to 10.0.0.1 port 36742
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-1.00   sec   108 MBytes   905 Mbits/sec  0.001 ms  244/77099 (0.32%)  
[  5]   1.00-2.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  265/81063 (0.33%)  
[  5]   2.00-3.00   sec   113 MBytes   952 Mbits/sec  0.001 ms  262/81064 (0.32%)  
[  5]   3.00-4.00   sec   113 MBytes   949 Mbits/sec  0.002 ms  426/81035 (0.53%)  
[  5]   4.00-5.00   sec   113 MBytes   952 Mbits/sec  0.001 ms  262/81065 (0.32%)  
[  5]   5.00-6.00   sec   113 MBytes   951 Mbits/sec  0.001 ms  264/81062 (0.33%)  
[  5]   6.00-7.00   sec   113 MBytes   952 Mbits/sec  0.001 ms  262/81064 (0.32%)  
[  5]   7.00-8.00   sec   113 MBytes   952 Mbits/sec  0.001 ms  262/81064 (0.32%)  
[  5]   8.00-9.00   sec   113 MBytes   952 Mbits/sec  0.001 ms  262/81064 (0.32%)  
[  5]   9.00-10.00  sec   113 MBytes   952 Mbits/sec  0.004 ms  262/81064 (0.32%)  
[  5]  10.00-10.05  sec  5.44 MBytes   951 Mbits/sec  0.001 ms  12/3888 (0.31%)  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.05  sec  1.11 GBytes   947 Mbits/sec  0.001 ms  2783/810532 (0.34%)  receiver
```
```shell
$ iperf3 -c 10.0.0.2 -p 5201 -u -l 1472 -b 1000M
warning: UDP block size 1472 exceeds TCP MSS 1448, may result in fragmentation / drops
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 36742 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   114 MBytes   954 Mbits/sec  81032  
[  5]   1.00-2.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   2.00-3.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   3.00-4.00   sec   114 MBytes   954 Mbits/sec  81035  
[  5]   4.00-5.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   5.00-6.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   6.00-7.00   sec   114 MBytes   955 Mbits/sec  81063  
[  5]   7.00-8.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   8.00-9.00   sec   114 MBytes   955 Mbits/sec  81064  
[  5]   9.00-10.00  sec   114 MBytes   955 Mbits/sec  81064  
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
[  5]   0.00-10.00  sec  1.11 GBytes   955 Mbits/sec  0.000 ms  0/810577 (0%)  sender
[  5]   0.00-10.05  sec  1.11 GBytes   947 Mbits/sec  0.001 ms  2783/810532 (0.34%)  receiver

iperf Done.
```
