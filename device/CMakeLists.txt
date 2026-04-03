# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

cmake_minimum_required(VERSION 3.14)
project(device)

############# init cmake #####################################
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/../cmake)
# avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP
if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
	cmake_policy(SET CMP0135 NEW)
endif()
find_package(Vivado REQUIRED MODULE)

##############################################################
# ZCU104 Setting
##############################################################
set(FPGA_PART xczu7ev-ffvc1156-2-e)

##############################################################
# Directories
##############################################################
set(BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})
set(RTL_DIR ${CMAKE_CURRENT_SOURCE_DIR}/rtl)
set(IP_DIR ${CMAKE_CURRENT_SOURCE_DIR}/ip)
set(CONSTRAINT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/constraints)
set(3RDPARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/../3rdparty)

add_subdirectory(rtl)
add_subdirectory(script)
add_subdirectory(vivado)
