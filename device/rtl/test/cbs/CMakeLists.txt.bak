# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

<<<<<<< HEAD
module_test(credit_based_shaper     ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(credit_based_shaper     vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(add_tdest_from_vlan_tag ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(add_tdest_from_vlan_tag vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(ethernet_frame_dropper  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(ethernet_frame_dropper  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(ethernet_frame_arbiter  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(ethernet_frame_arbiter  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
=======
module_test(credit_based_shaper     ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "" "")
module_test(credit_based_shaper     vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "" "")
module_test(add_tdest_from_vlan_tag ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "EXPECTED_TDEST;1" "")
module_test(add_tdest_from_vlan_tag vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "EXPECTED_TDEST;7" "")
module_test(add_tdest_from_vlan_tag ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "EXPECTED_TDEST;1;OPT_LEVEL;0" "_opt0")
module_test(add_tdest_from_vlan_tag vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "EXPECTED_TDEST;7;OPT_LEVEL;0" "_opt0")
module_test(ethernet_frame_dropper  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "" "")
module_test(ethernet_frame_dropper  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "" "")
module_test(ethernet_frame_arbiter  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "" "")
module_test(ethernet_frame_arbiter  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "FRAME_GAP;5" "")
module_test(pulse_generator         ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "" "")
module_test(channel_in_opt          ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "" "")
module_test(credit_based_shaper     ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" "_10g")
module_test(credit_based_shaper     vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" "_10g")
module_test(add_tdest_from_vlan_tag ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "EXPECTED_TDEST;1;DATA_WIDTH;64" "_10g")
module_test(add_tdest_from_vlan_tag vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "EXPECTED_TDEST;7;DATA_WIDTH;64" "_10g")
module_test(ethernet_frame_dropper  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" "_10g")
module_test(ethernet_frame_dropper  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" "_10g")
module_test(ethernet_frame_arbiter  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518" "DATA_WIDTH;64" "_10g")
module_test(ethernet_frame_arbiter  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522" "DATA_WIDTH;64" "_10g")
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

add_custom_target(run_tb_cbs_modules
  DEPENDS
    run_tb_credit_based_shaper.ethernet_frame
    run_tb_credit_based_shaper.vlan_frame
    run_tb_add_tdest_from_vlan_tag.ethernet_frame
    run_tb_add_tdest_from_vlan_tag.vlan_frame
<<<<<<< HEAD
=======
    run_tb_add_tdest_from_vlan_tag.ethernet_frame_opt0
    run_tb_add_tdest_from_vlan_tag.vlan_frame_opt0
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
    run_tb_ethernet_frame_dropper.ethernet_frame
    run_tb_ethernet_frame_dropper.vlan_frame
    run_tb_ethernet_frame_arbiter.ethernet_frame
    run_tb_ethernet_frame_arbiter.vlan_frame
<<<<<<< HEAD
=======
    run_tb_pulse_generator.ethernet_frame
    run_tb_channel_in_opt.ethernet_frame
    run_tb_credit_based_shaper.ethernet_frame_10g
    run_tb_credit_based_shaper.vlan_frame_10g
    run_tb_add_tdest_from_vlan_tag.ethernet_frame_10g
    run_tb_add_tdest_from_vlan_tag.vlan_frame_10g
    run_tb_ethernet_frame_dropper.ethernet_frame_10g
    run_tb_ethernet_frame_dropper.vlan_frame_10g
    run_tb_ethernet_frame_arbiter.ethernet_frame_10g
    run_tb_ethernet_frame_arbiter.vlan_frame_10g
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
)
