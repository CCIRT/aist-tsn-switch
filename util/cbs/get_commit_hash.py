# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
from pyxsdb import PyXsdb
from cbs_switch import CbsSwitch


def main():
    parser = argparse.ArgumentParser('get_commit_hash', description='Get commit hash used to implement the current bitstream')
    parser.add_argument('--jtag_target', type=int, default=-1, help='AXI JTAG target. If omitted, select interactively')
    parser.add_argument('--board', default='kc705', choices=['kc705', 'u45n'], help='Target board')
    args = parser.parse_args()

    # Open xsdb connection
    xsdb = PyXsdb()
    xsdb.connect()

    # Select target
    target = args.jtag_target
    if target == -1:
        target = xsdb.select_target()
    xsdb.target(target)

    # Open CBS Switch
    switch = CbsSwitch(xsdb, target, args.board)

    # show commit hash
    print('The current bitstream was implemented using the commit hash ' + switch.get_commit_hash() + '.')

if __name__ == '__main__':
    main()
