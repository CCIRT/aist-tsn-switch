# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set(UTIL_FILES "${CMAKE_SOURCE_DIR}/rtl/test/util/pcap_to_stream.v"
               "${CMAKE_SOURCE_DIR}/rtl/test/util/compare_stream_with_pcap.v")

add_subdirectory(ats)
add_subdirectory(cbs)
