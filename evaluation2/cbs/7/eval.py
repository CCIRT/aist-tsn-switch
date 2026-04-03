# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

import sys
sys.path.append('../common_script')
sys.path.append('../6')
import utility
from eval_base import TestModule
import cbs_switch_loader as swloader


def main():
    print(f'Evaluation 7: Measure the latency of the 2nd priority flow competing with the 1st priority flow and the best-effort flow.')
    parser = utility.common_argument('Evaluation 7')
    swloader.update_parser(parser)
    parser.set_defaults(send_port0=0, send_port1=1, send_port2=2, recv_port=3)
    args = parser.parse_args()

    # Run test
    tm = TestModule(args)

    print(f'Scenario A: TC6 Only')
    tc5_rate = 0
    tc6_rate = 97
    tc7_rate = 0
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc6_only')

    print(f'Scenario B: TC6 + TC7 (1000 Mbps, but limited to 100 Mbps by CBS)')
    tc5_rate = 0
    tc6_rate = 97
    tc7_rate = 1000
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc6_tc7_{tc7_rate}')

    tc5_rates = [100, 200, 300, 400, 500, 600, 700, 800, 900]
    tc7_rate = 0
    print(f'Scenario C: TC6 + TC5 ({tc5_rates})')
    for tc5_rate in tc5_rates:
        num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
        tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc6_tc5_{tc5_rate}')

    print(f'Scenario D: TC6 + TC7 (1000 Mbps, but limited to 100 Mbps by CBS) + TC5 (900M)')
    tc5_rate = 900
    tc7_rate = 1000
    num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
    tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc6_tc7_{tc7_rate}_tc5_{tc5_rate}')

    print(f'Scenario E: TC5 + TC7 (100 Mbps) + TC5 ({tc5_rates})')
    tc7_rate = 100
    for tc5_rate in tc5_rates:
        num_frames = int(1000 * (tc7_rate + tc6_rate + tc5_rate) / tc6_rate)
        tm.test(tc5_rate, tc6_rate, tc7_rate, num_frames, result_dir=f'results/tc6_tc7_{tc7_rate}_tc5_{tc5_rate}')


if __name__ == '__main__':
    main()
