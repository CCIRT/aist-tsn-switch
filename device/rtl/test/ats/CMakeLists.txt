# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

module_test(connect_frame_length           ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(connect_frame_length           vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(connect_timestamp              ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(connect_timestamp              vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(detect_flow                    ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(detect_flow                    vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(detect_flow                    ethernet_tcp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(detect_flow                    vlan_tcp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(detect_flow                    ethernet_udp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(detect_flow                    vlan_udp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(get_frame_length               ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(get_frame_length               vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(get_frame_length_and_timestamp ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(get_frame_length_and_timestamp vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(process_frame                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1518")
module_test(process_frame                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1522")
module_test(reference_timer                ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1518")
module_test(reference_timer                vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1522")
module_test(scheduler                      ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(scheduler                      vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(separate_frame_length          ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(separate_frame_length          vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(separate_timestamp             ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(separate_timestamp             vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(set_timestamp                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518")
module_test(set_timestamp                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522")
module_test(connect_frame_length           ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(connect_frame_length           vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(connect_timestamp              ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1518" "" "")
module_test(connect_timestamp              vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1522" "" "")
module_test(connect_timestamp              ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1518" "DATA_WIDTH;16" 16 "")
module_test(connect_timestamp              vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1522" "DATA_WIDTH;16" 16 "")
module_test(connect_timestamp              ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1518" "DATA_WIDTH;64" 64 "")
module_test(connect_timestamp              vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES};${RTL_DIR}/src/ats/set_timestamp.v" "1522" "DATA_WIDTH;64" 64 "")
module_test(detect_flow                    ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;0" "")
module_test(detect_flow                    vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;0" "")
module_test(detect_flow                    ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;0;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;0;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    ethernet_tcp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15" "")
module_test(detect_flow                    vlan_tcp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15" "")
module_test(detect_flow                    ethernet_tcp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    vlan_tcp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    ethernet_udp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15" "")
module_test(detect_flow                    vlan_udp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15" "")
module_test(detect_flow                    ethernet_udp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    vlan_udp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;OPT_LEVEL;0" "_opt0")
module_test(detect_flow                    ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;0;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;0;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    ethernet_tcp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    vlan_tcp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    ethernet_udp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    vlan_udp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;DATA_WIDTH;16" 16 "")
module_test(detect_flow                    ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;0;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(detect_flow                    vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;0;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(detect_flow                    ethernet_tcp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(detect_flow                    vlan_tcp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(detect_flow                    ethernet_udp   3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "EXPECTED_FLOW;15;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(detect_flow                    vlan_udp       3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "EXPECTED_FLOW;15;DATA_WIDTH;64;FLOW_MATCH_RATE;8" 64 "")
module_test(et_arbiter                     ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(et_arbiter                     vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(et_arbiter                     ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" 64  "")
module_test(et_arbiter                     vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" 64  "")
module_test(et_gate                        ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(et_gate                        vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(et_gate                        ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" 64  "")
module_test(et_gate                        vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" 64  "")
module_test(et_deadline                    ethernet_frame 8 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(et_deadline                    vlan_frame     8 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(et_deadline                    ethernet_frame 8 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" 64  "")
module_test(et_deadline                    vlan_frame     8 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" 64  "")
module_test(get_frame_length               ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(get_frame_length               vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(get_frame_length               ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;16" 16 "")
module_test(get_frame_length               vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;16" 16 "")
module_test(get_frame_length               ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" 64 "")
module_test(get_frame_length               vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" 64 "")
module_test(process_frame                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1518" "" "")
module_test(process_frame                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1522" "" "")
module_test(reference_timer                ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1518" "" "")
module_test(reference_timer                vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1522" "" "")
module_test(reference_timer                ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1518" "CLOCK_PERIOD_PS;6400" 64 "")
module_test(reference_timer                vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "" "1522" "CLOCK_PERIOD_PS;6400" 64 "")
module_test(separate_timestamp             ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(separate_timestamp             vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(separate_timestamp             ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;16" 16 "")
module_test(separate_timestamp             vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;16" 16 "")
module_test(separate_timestamp             ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "OPT_LEVEL;1;DATA_WIDTH;64" 64 "")
module_test(separate_timestamp             vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "OPT_LEVEL;1;DATA_WIDTH;64" 64 "")
module_test(set_timestamp                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "" "")
module_test(set_timestamp                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "" "")
module_test(set_timestamp                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;16" 16 "")
module_test(set_timestamp                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;16" 16 "")
module_test(set_timestamp                  ethernet_frame 3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64;CLOCK_PERIOD_PS;6400" 64 "")
module_test(set_timestamp                  vlan_frame     3 ${RTL_DIR}/src/ats/ ${RTL_DIR}/test/ats/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64;CLOCK_PERIOD_PS;6400" 64 "")

add_custom_target(run_tb_ats_modules
  DEPENDS
    run_tb_connect_frame_length.ethernet_frame
    run_tb_connect_frame_length.vlan_frame
    run_tb_connect_timestamp.ethernet_frame
    run_tb_connect_timestamp.vlan_frame
    run_tb_detect_flow.ethernet_frame
    run_tb_detect_flow.vlan_frame
    run_tb_detect_flow.ethernet_tcp
    run_tb_detect_flow.vlan_tcp
    run_tb_detect_flow.ethernet_udp
    run_tb_detect_flow.vlan_udp
    run_tb_get_frame_length.ethernet_frame
    run_tb_get_frame_length.vlan_frame
    run_tb_get_frame_length_and_timestamp.ethernet_frame
    run_tb_get_frame_length_and_timestamp.vlan_frame
    run_tb_detect_flow.ethernet_frame_opt0
    run_tb_detect_flow.vlan_frame_opt0
    run_tb_detect_flow.ethernet_tcp
    run_tb_detect_flow.vlan_tcp
    run_tb_detect_flow.ethernet_tcp_opt0
    run_tb_detect_flow.vlan_tcp_opt0
    run_tb_detect_flow.ethernet_udp
    run_tb_detect_flow.vlan_udp
    run_tb_detect_flow.ethernet_udp_opt0
    run_tb_detect_flow.vlan_udp_opt0
    run_tb_et_arbiter.ethernet_frame
    run_tb_et_arbiter.vlan_frame
    run_tb_et_gate.ethernet_frame
    run_tb_et_gate.vlan_frame
    run_tb_get_frame_length.ethernet_frame
    run_tb_get_frame_length.vlan_frame
    run_tb_process_frame.ethernet_frame
    run_tb_process_frame.vlan_frame
    run_tb_reference_timer.ethernet_frame
    run_tb_reference_timer.vlan_frame
    run_tb_scheduler.ethernet_frame
    run_tb_scheduler.vlan_frame
    run_tb_separate_frame_length.ethernet_frame
    run_tb_separate_frame_length.vlan_frame
    run_tb_separate_timestamp.ethernet_frame
    run_tb_separate_timestamp.vlan_frame
    run_tb_set_timestamp.ethernet_frame
    run_tb_set_timestamp.vlan_frame
    run_tb_connect_timestamp.ethernet_frame64
    run_tb_connect_timestamp.vlan_frame64
    run_tb_detect_flow.ethernet_frame64
    run_tb_detect_flow.vlan_frame64
    run_tb_detect_flow.ethernet_tcp64
    run_tb_detect_flow.vlan_tcp64
    run_tb_detect_flow.ethernet_udp64
    run_tb_detect_flow.vlan_udp64
    run_tb_reference_timer.ethernet_frame64
    run_tb_reference_timer.vlan_frame64
    run_tb_separate_timestamp.ethernet_frame64
    run_tb_separate_timestamp.vlan_frame64
    run_tb_set_timestamp.ethernet_frame64
    run_tb_set_timestamp.vlan_frame64
)
