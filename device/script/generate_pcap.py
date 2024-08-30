# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

from scapy.all import *

args = sys.argv

if len(args) <= 1:
    output_filepath = os.path.dirname(os.path.abspath(__file__))
else:
    output_filepath = args[1]

PRIO = 3
ether_payload = Raw(RandString(size=1500))
ether_pseudo_fcs = Raw(RandString(size=4))

# Ethernet II frame
ether_frame = (Ether()/ether_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/ethernet_frame.pcap', ether_frame)

# IEEE 802.1Q frame
vlan_frame = (Ether()/Dot1Q(prio=PRIO)/ether_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/vlan_frame.pcap', vlan_frame)

src_ip = '192.168.1.1'
src_port = 5001
dst_ip = '192.168.1.2'
dst_port = 5002

tcp_payload = Raw(RandString(size=(1500-(20+20))))
udp_payload = Raw(RandString(size=(1500-(20+8))))

# Ethernet II frame + TCP/IP
ether_tcp = (Ether()/IP(src=src_ip, dst=dst_ip)/TCP(sport=src_port, dport=dst_port)/tcp_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/ethernet_tcp.pcap', ether_tcp)

# IEEE 802.1Q frame + TCP/IP
vlan_tcp = (Ether()/Dot1Q(prio=PRIO)/IP(src=src_ip, dst=dst_ip)/TCP(sport=src_port, dport=dst_port)/tcp_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/vlan_tcp.pcap', vlan_tcp)

# Ethernet II frame + UDP/IP
ether_udp = (Ether()/IP(src=src_ip, dst=dst_ip)/UDP(sport=src_port, dport=dst_port)/udp_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/ethernet_udp.pcap', ether_udp)

# IEEE 802.1Q frame + UDP/IP
vlan_udp = (Ether()/Dot1Q(prio=PRIO)/IP(src=src_ip, dst=dst_ip)/UDP(sport=src_port, dport=dst_port)/udp_payload/ether_pseudo_fcs)
wrpcap(output_filepath + '/vlan_udp.pcap', vlan_udp)
