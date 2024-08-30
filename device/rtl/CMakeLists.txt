# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

function(module_test MODULE_NAME PCAP_NAME REPEAT_NUM MODULE_DIR TB_DIR UTIL_FILES INPUT_FRAME_LENGTH)

  set(TB_NAME    "tb_${MODULE_NAME}")
  set(TEST_NAME  "${TB_NAME}.${PCAP_NAME}")
  set(PCAP_FILE  "${CMAKE_BINARY_DIR}/script/${PCAP_NAME}.pcap")
  set(VCD_FILE   "${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.vcd")
  set(BIN_FILE   "${CMAKE_CURRENT_BINARY_DIR}/${TEST_NAME}.out")

  add_custom_target(build_${TEST_NAME}
    DEPENDS generate_pcap
    COMMAND
      iverilog
        -P ${TB_NAME}.PCAP_FILENAME='"${PCAP_FILE}"'
        -P ${TB_NAME}.VCD_FILENAME='"${VCD_FILE}"'
        -P ${TB_NAME}.REPEAT_NUM=${REPEAT_NUM}
        -P ${TB_NAME}.INPUT_FRAME_LENGTH=${INPUT_FRAME_LENGTH}
        -o ${BIN_FILE}
        "${CMAKE_SOURCE_DIR}/rtl/src/util/axi4_lite_slave.v"
        ${UTIL_FILES}
        ${MODULE_DIR}/${MODULE_NAME}.v
        ${TB_DIR}/${TB_NAME}.v
  )

  add_custom_target(run_${TEST_NAME}
    DEPENDS build_${TEST_NAME}
    COMMAND ${BIN_FILE}
  )

  add_custom_target(display_${TEST_NAME}
    COMMAND gtkwave ${VCD_FILE} &
  )
endfunction()

add_subdirectory(test)
