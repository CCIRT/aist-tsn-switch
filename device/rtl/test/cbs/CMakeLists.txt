# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

module_test(credit_based_shaper     ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(credit_based_shaper     vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(add_tdest_from_vlan_tag ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(add_tdest_from_vlan_tag vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(ethernet_frame_dropper  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(ethernet_frame_dropper  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")
module_test(ethernet_frame_arbiter  ethernet_frame 3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1518")
module_test(ethernet_frame_arbiter  vlan_frame     3 ${RTL_DIR}/src/cbs/ ${RTL_DIR}/test/cbs/ "${UTIL_FILES}" "1522")

add_custom_target(run_tb_cbs_modules
  DEPENDS
    run_tb_credit_based_shaper.ethernet_frame
    run_tb_credit_based_shaper.vlan_frame
    run_tb_add_tdest_from_vlan_tag.ethernet_frame
    run_tb_add_tdest_from_vlan_tag.vlan_frame
    run_tb_ethernet_frame_dropper.ethernet_frame
    run_tb_ethernet_frame_dropper.vlan_frame
    run_tb_ethernet_frame_arbiter.ethernet_frame
    run_tb_ethernet_frame_arbiter.vlan_frame
)
