# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import argparse
import cbs_switch


def update_parser(parser: argparse.ArgumentParser) -> None:
    parser.add_argument('--board',
                        choices=['kc705', 'zedboard', 'u45n'],
                        default='u45n',
                        help='Target board. Default is "u45n"')


def open_cbs_switch(xsdb, jtag_target, args) -> cbs_switch.CbsSwitch:
    return cbs_switch.CbsSwitch(xsdb, jtag_target, args.board)
