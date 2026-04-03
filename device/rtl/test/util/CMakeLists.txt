# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set(TEST_NAME  "tb_axi4_lite_slave_if")
set(VCD_FILE   "${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.vcd")
set(BIN_FILE   "${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.out")

add_custom_target(build_${TEST_NAME}
  COMMAND
    iverilog
      -P ${TEST_NAME}.VCD_FILENAME='"${VCD_FILE}"'
      -o ${BIN_FILE}
      -g 2012
      "${CMAKE_SOURCE_DIR}/rtl/src/util/axi4_lite_slave_if.v"
      "${CMAKE_CURRENT_SOURCE_DIR}/tb_axi4_lite_slave_if.sv"
)

add_custom_target(run_${TEST_NAME}
  DEPENDS build_${TEST_NAME}
  COMMAND ${BIN_FILE}
)

add_custom_target(display_${TEST_NAME}
  COMMAND gtkwave ${VCD_FILE} &
)
