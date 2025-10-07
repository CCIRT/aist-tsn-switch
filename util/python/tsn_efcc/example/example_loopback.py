# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
import tsn_efcc
import pyxsdb

PORT_TX=0
PORT_RX=1

print('This file contains simple test sequence of TSN-EFCC function.')

print('---------------------------------------------')
print('1. Open xsdb device to access TSN-EFCC.')
print('---------------------------------------------')

def parse_args():
    parser = argparse.ArgumentParser('')
    parser.add_argument('--xsdb_target', default=-1, type=int, help='Xsdb target to access TSN EFCC.')

    return parser.parse_args()

args = parse_args()

# Open xsdb connection
xsdb = pyxsdb.PyXsdb()
xsdb.connect()

# Select target
print('Connect JTAG2AXI target. By default, you interactively select and connect to a target from the device list.')
print('If you want to quickly connect to a specific target, use the --xsdb_target command line argument of this script.\n')
xsdb_target = args.xsdb_target
if xsdb_target == -1:
    xsdb_target = xsdb.select_target()
else:
    print(f'xsdb_target = {xsdb_target}')

print()
print('-------------------------------------')
print('2. Configure the internal switch.')
print('-------------------------------------')

print('Get the default address table object.')
default_addr_table = tsn_efcc.default_tsn_efcc_address_table()
print(f'{default_addr_table}\n')

print('Get the default config table object.')
switch_config = tsn_efcc.default_axis_switch_config_table()
print(f'{switch_config}\n')

print('Initialize AxisNetSwitch object.')
switch = tsn_efcc.AxisNetSwitch(xsdb, xsdb_target, default_addr_table, switch_config)

print('\nShow commit hash of the current bitstream.')
print('The current bitstream was implemented using the commit hash ' + switch.get_commit_hash() + '.\n')

print('This object can control the connection between input port and output port.')
print(f'In this test, we connect ef_crafter0(port {PORT_TX + switch_config.num_valid_ports}) to TX{PORT_TX}(port {PORT_TX}), and ef_crafter1(port {PORT_RX + switch_config.num_valid_ports}) to TX{PORT_RX}(port {PORT_RX}).')
print('Other input ports are disconnected from output port.')
switch.start_config()
switch.connect(PORT_TX + switch_config.num_valid_ports, PORT_TX)
switch.connect(PORT_RX + switch_config.num_valid_ports, PORT_RX)
switch.commit()

print('Configuration is done. show current switch status...')
switch.show_configuration()

print()
print('--------------------------------------------------')
print(f'3. Send Frame from Port{PORT_TX} and Port{PORT_RX} each other.')
print('--------------------------------------------------')

print('Frame class is a helper class to create the frame information sent by ef_crafter.')
print(f'Firstly, we create a frame information which flows Port{PORT_TX} -> Port{PORT_RX}.')
frame0 = tsn_efcc.Frame('Frame0').ether(dst=1, src=2).ipv4(dst=1, src=2).udp(dst=1000, src=2000).payload(length=1024)

print(f'Format of frame0: {frame0}\n')

print(f'Secondly, Create a frame information which flows reversely (Port{PORT_RX} -> Port{PORT_TX})')
frame1 = tsn_efcc.Frame('Frame1').ether(dst=2, src=1).ipv4(dst=2, src=1).udp(dst=2000, src=1000).payload(length=1024)
print(f'Format of frame1: {frame1}\n')

print('Initialize EFCrafter object.')
crafter = tsn_efcc.EFCrafter(xsdb, xsdb_target, default_addr_table)

print('Show what MAC/IP value is set to the transmit frame.')
print('In above code, we set ether(dst=1, src=2).ipv4(dst=1, src=2), these values are the index of LUT table.')
print('By using crafter.get_mac_address(port, index) or get_ip_address(port, index) function, you can show this value.')
mac1 = crafter.get_mac_address(port=PORT_TX, index=1)
mac2 = crafter.get_mac_address(port=PORT_TX, index=2)
ip1 = crafter.get_ip_address(port=PORT_TX, index=1)
ip2 = crafter.get_ip_address(port=PORT_TX, index=2)
print(f'Read done. ether(dst=1, src=2).ipv4(dst=1, src=2) means ether(dst={mac1}, src={mac2}).ipv4(dst={ip1}, src={ip2})')

print('You can set these LUT table by set_mac/ip_address function.')
print('We set "aa:bb:cc:dd:ee:ff" to MAC index 100, and "11.22.33.44" to IP index 200.')
crafter.set_mac_address(port=PORT_TX, index=100, val='aa:bb:cc:dd:ee:ff')
crafter.set_ip_address(port=PORT_TX, index=200, val='11.22.33.44')

print(f'Setting is done. mac={crafter.get_mac_address(port=PORT_TX, index=100)}, ip={crafter.get_ip_address(port=PORT_TX, index=200)}')

print(f'Show the initial status of ef_crafter port {PORT_TX}.')
print('-------')
for k, v in crafter.get_status(PORT_TX).items():
    print(f'{k}: {v}')
print('-------')

print('Next, send frame0 frame from ef_crafter0.')
print('Push the frame object to ef_crafter. The last frame must be a special frame named EOL frame.')

eol_frame = tsn_efcc.Frame.eol()
crafter.set_frame(port=PORT_TX, index=0, frame=frame0)
crafter.set_frame(port=PORT_TX, index=1, frame=eol_frame)

print('Dump the frame information pushed to ef_crafter.')

print('-------')
for frame in crafter.get_frames(port=PORT_TX):
    print(frame)
print('-------')


print('Send these frames from ef_crafter.')
port = PORT_TX
bit_mask = 1 << port
crafter.reset(bit_mask)
crafter.start(bit_mask)
crafter.wait(port)

print('Transfer done. After transfer, framecounter value must be increased to 2 (1 frame + 1 EOL frame). Current status is ')
print('-------')
for k, v in crafter.get_status(PORT_TX).items():
    print(f'{k}: {v}')
print('-------')

print(f'Next, send frames from port{PORT_TX} and port{PORT_RX} simultaneously.')
crafter.set_frame(port=PORT_RX, index=0, frame=frame1)
crafter.set_frame(port=PORT_RX, index=1, frame=eol_frame)

port0 = PORT_TX
port1 = PORT_RX
bit_mask = (1 << port0) | (1 << port1)
crafter.reset(bit_mask)
crafter.start(bit_mask)
crafter.wait(port0)
crafter.wait(port1)

print('Transfer done. After transfer, framecounter value must be increased to 2 (1 frame + 1 EOL frame). Current status is ')
print('-------')
print(f'Port{PORT_TX}:')
for k, v in crafter.get_status(PORT_TX).items():
    print(f'  {k}: {v}')
print(f'Port{PORT_RX}:')
for k, v in crafter.get_status(PORT_RX).items():
    print(f'  {k}: {v}')
print('-------')

print(f'Finally, we send frames from port{PORT_TX} and port{PORT_RX} simultaneously, in repeat mode.')
print('Repeat mode means that ef_crafter automatically restart after stopping.')

port0 = PORT_TX
port1 = PORT_RX
bit_mask = (1 << port0) | (1 << port1)
crafter.reset(bit_mask)
crafter.set_repeat(bit_mask)
crafter.start(bit_mask)

print('Wait until 1000 frames are sent')
crafter.wait_until(port0, 1000)
crafter.wait_until(port1, 1000)

print('1000 frames are sent. Since the ef_crafter is still sending frame, the counter value is larger than 1000. Current status is ')
print('-------')
print(f'Port{PORT_TX}:')
for k, v in crafter.get_status(PORT_TX).items():
    print(f'  {k}: {v}')
print(f'Port{PORT_RX}:')
for k, v in crafter.get_status(PORT_RX).items():
    print(f'  {k}: {v}')
print('-------')

print('Reset ef_crafter to stop repeating.')
crafter.reset(0xff)

print()
print('--------------------------------------------------')
print(f'4. Record timestamps at Port{PORT_TX} TX and Port{PORT_RX} RX.')
print('--------------------------------------------------')

print(f'Next, records frame timestamps which is sent from Port{PORT_TX} to Port{PORT_RX}.')
print(f'Instance EFCapture object for port{PORT_TX} and port{PORT_RX}.')

capture0 = tsn_efcc.EFCapture(xsdb, xsdb_target, default_addr_table, PORT_TX)
capture1 = tsn_efcc.EFCapture(xsdb, xsdb_target, default_addr_table, PORT_RX)

print('Set recording port. EF_Capture0 records TX port, and EF_Capture1 records RX port')
capture0.select_port('tx')
capture1.select_port('rx')

print('After setting port, recording is start automatically.')
print('However, we reset timestamp capture to ensure that there is no previous records.')

capture0.reset()
capture1.reset()

print('Current capture status is')
print('-------------')
print('EF_Capture0: ')
for k, v in capture0.get_status().items():
    print(f'  {k}: {v}')
print('EF_Capture1: ')
for k, v in capture1.get_status().items():
    print(f'  {k}: {v}')
print('-------------')

print(f'The setup is done. Use ef_crafter to send 1 frame from port{PORT_TX} to port{PORT_RX}.')
port = PORT_TX
bit_mask = 1 << port
crafter.reset(bit_mask)
crafter.start(bit_mask)
crafter.wait(port)

print('Then, check timestamp result')
print('capture.wait(N) function waits until N frames is recorded in ef_capture.')
capture0.wait(framecounter=1)
capture1.wait(framecounter=1)

print('Wait completed. Current capture status is')
print('-------------')
print('EF_Capture0: ')
for k, v in capture0.get_status().items():
    print(f'  {k}: {v}')
print('EF_Capture1: ')
for k, v in capture1.get_status().items():
    print(f'  {k}: {v}')
print('-------------')

print('Next, read timestamps from hardware. capture.read_timestamp(N) function reads N timestamps from hardware.')
stat0 = capture0.read_timestamp(1)
stat1 = capture1.read_timestamp(1)

print('The stat object contains a list of timestamps. The timestamps are')
print('----------------')
print(f'Timestamp(Port{PORT_TX}):')
for k, v in stat0.get_stats().items():
    print(f'  id={k}, timestamp={v}')
print(f'Timestamp(Port{PORT_RX}):')
for k, v in stat1.get_stats().items():
    print(f'  id={k}, timestamp={v}')
print('----------------')

print('The stat object is an instance of TimestampStatistic class. This class support helper functions such as latency computation.')
print('To compute latency, the TX timestamp is subtracted by RX timestamp. To do this, call stat1.subtract(stat0) function.')
diff = stat1.subtract(stat0)

print('The diff object is also an instance of TimestampStatistic class. The dump of timestamps are')
print('----------------')
print('Timestamp(Diff):')
for k, v in diff.get_stats().items():
    print(f'  id={k}, timestamp={v}')
print('----------------')

capture0.reset()
capture1.reset()

print()
print('------------------------------------------------------------------------------')
print(f'5. Evaluate latency and throughput of frames from Port{PORT_TX} TX and Port{PORT_RX} RX.')
print('------------------------------------------------------------------------------')

print('We use 1000 frames for evaluation.')
print('Firstly, use ef_crafter with repeat mode to send frames.')
port = PORT_TX
bit_mask = 1 << port
crafter.reset(bit_mask)
crafter.set_repeat(bit_mask)
crafter.start(bit_mask)
crafter.wait_until(port, 1000)

print('At least 1000 frames are sent. Current status of ef_crafter is ')
print('-------')
print('Port{PORT_TX}:')
for k, v in crafter.get_status(PORT_TX).items():
    print(f'  {k}: {v}')
print('-------')
crafter.reset(bit_mask)

print('Check whether TimestampStatistics records 1000 timestamps or not.')
capture0.wait(1000)
capture1.wait(1000)

print('At least 1000 frames are capture. Current status of ef_capture is')
print('-------------')
print('EF_Capture0: ')
for k, v in capture0.get_status().items():
    print(f'  {k}: {v}')
print('EF_Capture1: ')
for k, v in capture1.get_status().items():
    print(f'  {k}: {v}')
print('-------------')

print('Read 1000 frames from hardware.')
stat0 = capture0.read_timestamp(1000)
stat1 = capture1.read_timestamp(1000)

print('Compute the timestamp difference.')
diff = stat1.subtract(stat0)

print('The timestamp difference of 1000 frames are computed. To show statistics information, call diff.summary() function.')
diff.summary(freq_mhz=125, name='Latency')
print('------------------------')

print('Next, compute bandwidth of each port.')
print('We need frame size information to compute bandwidth, compute by frame0 object, and add function to map timestamp ID to frame size.')
l2_size, l7_size = frame0.get_length()
print(f'l2 size of Frame0: {l2_size}, l7 size of Frame0: {l7_size}')
def timestamp_to_size(tid: int) -> int:
    return l2_size

tsn_efcc.TimestampStatistic.summary_bandwidth(stat0, stat1, 125, timestamp_to_size)
