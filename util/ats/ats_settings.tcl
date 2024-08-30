# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

proc ip {ip0 ip1 ip2 ip3} {
    set ip $ip0
    set ip [expr [expr $ip << 8] | $ip1]
    set ip [expr [expr $ip << 8] | $ip2]
    set ip [expr [expr $ip << 8] | $ip3]
    return $ip
}

proc set_flow_val {port priority fow src_ip src_port dst_ip dst_port committed_information_rate_mbps committed_burst_size_byte} {
    if {$fow != 0} {
        mwr [expr [expr [expr 0x0000 + [expr 0x10 * [expr $fow - 1]]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $src_ip
        mwr [expr [expr [expr 0x0004 + [expr 0x10 * [expr $fow - 1]]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $src_port
        mwr [expr [expr [expr 0x0008 + [expr 0x10 * [expr $fow - 1]]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $dst_ip
        mwr [expr [expr [expr 0x000C + [expr 0x10 * [expr $fow - 1]]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $dst_port
    }
    set committed_information_rate_inv [expr 8000000 / $committed_information_rate_mbps]
    mwr [expr [expr [expr 0x1000 + [expr 0x8 * $fow]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $committed_information_rate_inv
    mwr [expr [expr [expr 0x1004 + [expr 0x8 * $fow]] + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $committed_burst_size_byte
}

proc set_max_residence_time {port priority max_residence_time_ps} {
    set wval1 [expr $max_residence_time_ps % 0x100000000]
    set wval2 [expr [expr $max_residence_time_ps / 0x100000000] % 0x100000000]
    set wval3 [expr $max_residence_time_ps / 0x10000000000000000]
    mwr [expr [expr 0x1080 + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $wval1
    mwr [expr [expr 0x1084 + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $wval2
    mwr [expr [expr 0x1088 + [expr 0x2000 * $priority]] + [expr 0x4000 * $port]] $wval3
}

# Connect to target
conn
target 3

### MaxResidenceTime (Common)
for {set i 0} {$i < 4} {incr i} {
    for {set j 0} {$j < 2} {incr j} {
        # 134 us
        set_max_residence_time $i $j 0x08000000
        # 65.356 ns (need CommittedBurstSize >= 3084)
        # set_max_residence_time $i $j 0x00010000
    }
}

# Src-Port 0
## Priority 0 (TC6)
### CommittedInformationRate and CommittedBurstSize per flow
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 0 0 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 0 0 0xFFFFFFFF

## Priority 1 (TC7)
set_flow_val 0 1 0 [ip  10   0   0   1]     0 [ip  10   0   0   2]  5201  100 1542
for {set i 1} {$i < 16} {incr i} {
    set_flow_val 0 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 0 1 0xFFFFFFFF

# Src-Port 1
## Priority 0 (TC6)
### CommittedInformationRate and CommittedBurstSize per flow
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 1 0 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 1 0 0xFFFFFFFF

## Priority 1 (TC7)
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 1 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 1 1 0xFFFFFFFF

# Src-Port 2
## Priority 0 (TC6)
### CommittedInformationRate and CommittedBurstSize per flow
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 2 0 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 2 0 0xFFFFFFFF

## Priority 1 (TC7)
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 2 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 2 1 0xFFFFFFFF

# Src-Port 3
## Priority 0 (TC6)
### CommittedInformationRate and CommittedBurstSize per flow
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 3 0 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 3 0 0xFFFFFFFF

## Priority 1 (TC7)
for {set i 0} {$i < 16} {incr i} {
    set_flow_val 3 1 $i [ip 255 255 255 255] 65535 [ip 255 255 255 255] 65535 1000 1542
}
### MaxResidenceTime (Individual)
# set_max_residence_time 3 1 0xFFFFFFFF
