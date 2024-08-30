# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

add_custom_target(generate_pcap
  COMMAND
    python3 ${CMAKE_CURRENT_SOURCE_DIR}/generate_pcap.py ${CMAKE_CURRENT_BINARY_DIR}
)
