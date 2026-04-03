# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

from eval_base import TestModule

import sys
sys.path.append('../common_script')
import utility
import cbs_switch_loader as swloader


def main():
    print(f'Evaluation 6: Measure the latency of the 1st priority flow competing with the 2nd priority flow and the best-effort flow.')
    parser = utility.common_argument('Evaluation 6')
    swloader.update_parser(parser)
    parser.set_defaults(send_port0=0, send_port1=1, send_port2=2, recv_port=3)
    args = parser.parse_args()

    # Run test
    tm = TestModule(args)

    print(f'Scenario A: TC7 Only')
    tc5_rate = 0
    tc6_rate = 0
    tc7_rate = 97
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc7_rate)
    tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc7_only')

    print(f'Scenario B: TC7 + TC6 (1000 Mbps, but limit 100 Mbps by CBS)')
    tc5_rate = 0
    tc6_rate = 1000
    tc7_rate = 97
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc7_rate)
    tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc7_tc6_{tc6_rate}')

    tc5_rates = [100, 200, 300, 400, 500, 600, 700, 800, 900]
    tc6_rate = 0
    print(f'Scenario C: TC7 + TC5 ({tc5_rates})')
    for tc5_rate in tc5_rates:
        num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc7_rate)
        tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc7_tc5_{tc5_rate}')

    print(f'Scenario D: TC7 + TC6 (100 Mbps) + TC5 ({tc5_rates})')
    tc6_rate = 100
    for tc5_rate in tc5_rates:
        num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc7_rate)
        tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc7_tc6_{tc6_rate}_tc5_{tc5_rate}')


if __name__ == '__main__':
    main()
