# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

# Default Values
set(HLS_VENDOR_NAME "xxx" CACHE STRING "default hls ip vendor name")
set(HLS_TAXONOMY "xxx" CACHE STRING "default taxonomy")
set(HLS_SOLUTION_NAME "solution1" CACHE STRING "default project solution name")
set(HLS_TRACE_LEVEL "port_hier" CACHE STRING "default cosim trace level")
set(HLS_DEFAULT_VERSION "0.0" CACHE STRING "default hls ip version")
set(HLS_CFLAGS "" CACHE STRING "default hls compile option")

# find vitis_hls
find_path(VITIS_HLS_BIN_DIR
  vitis_hls
  PATHS ${VITIS_HLS_ROOT} ENV XILINX_HLS
  PATH_SUFFIXES bin
)

find_path(VITIS_HLS_INCLUDE_DIR
  NAMES hls_stream.h
  PATHS ${VITIS_HLS_ROOT} ENV XILINX_HLS
  PATH_SUFFIXES include
)

set(HLS_EXEC ${VITIS_HLS_BIN_DIR}/vitis_hls)
set(HLS_BIN_DIR ${VITIS_HLS_BIN_DIR})
set(HLS_INCLUDE_DIR ${VITIS_HLS_INCLUDE_DIR})

# save current directory
set(HLS_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(HLS_TCL_DIR ${CMAKE_CURRENT_LIST_DIR}/tcl)


include(CheckIncludeFile)
CHECK_INCLUDE_FILE(gmp.h HLS_GMP_EXISTS)
if (HLS_GMP_EXISTS)
  set(HLS_GMP_INC_DIR ${CMAKE_CURRENT_LIST_DIR}/gmp_const)
else()
  set(HLS_GMP_INC_DIR ${CMAKE_CURRENT_LIST_DIR}/gmp_dummy)
endif()

# find package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(HLS
  REQUIRED_VARS
  HLS_BIN_DIR
  HLS_INCLUDE_DIR
  HLS_TCL_DIR
)

# provide HLS::HLS
if(HLS_FOUND AND NOT TARGET HLS::HLS)
  add_library(HLS::HLS INTERFACE IMPORTED)
  set_target_properties(HLS::HLS
    PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES ${HLS_INCLUDE_DIR}
  )
endif()

# HLS_VERSION: Vitis HLS Version
get_filename_component(HLS_VERSION "${HLS_BIN_DIR}" DIRECTORY)
get_filename_component(HLS_VERSION "${HLS_VERSION}" NAME)

# vivado
file(TO_CMAKE_PATH ${HLS_BIN_DIR}/../../../Vivado/${HLS_VERSION}/bin/vivado HLS_VIVADO_EXE)

# hide variables
mark_as_advanced(
  HLS_INCLUDE_DIR HLS_CMAKE_DIR HLS_TCL_DIR
  HLS_PROJECT_FILE_NAME HLS_GMP_INC_DIR HLS_GMP_EXISTS HLS_VIVADO_EXE
)

macro(_hls_map_abs NEWVAR VAR)
  foreach(HLS_M_TMP IN LISTS ${VAR})
    if (IS_ABSOLUTE ${HLS_M_TMP})
      list(APPEND ${NEWVAR} ${HLS_M_TMP})
    else()
      list(APPEND ${NEWVAR} ${CMAKE_CURRENT_SOURCE_DIR}/${HLS_M_TMP})
    endif()
  endforeach()
endmacro()

macro(_hls_add_incdir NEWVAR VAR)
  foreach(HLS_M_TMP IN LISTS ${VAR})
    if (IS_ABSOLUTE ${HLS_M_TMP})
      list(APPEND ${NEWVAR} -I${HLS_M_TMP})
    else()
      list(APPEND ${NEWVAR} -I${CMAKE_CURRENT_SOURCE_DIR}/${HLS_M_TMP})
    endif()
  endforeach()
endmacro()

macro(_ARG_lib NEWVAR VAR)
  foreach(HLS_M_TMP IN LISTS ${VAR})
    get_target_property(HLS_M_TMP_TYPE ${HLS_M_TMP} TYPE)
    if (NOT ${HLS_M_TMP_TYPE} STREQUAL "INTERFACE_LIBRARY")
      message(FATAL_ERROR "LINK: `${HLS_M_TMP}` is not an INTERFACE library")
    endif()

    get_target_property(HLS_M_TMP_DIRS ${HLS_M_TMP} INTERFACE_INCLUDE_DIRECTORIES)
    foreach(HLS_M_TMP_DIR ${HLS_M_TMP_DIRS})
      if (NOT IS_ABSOLUTE ${HLS_M_TMP_DIR})
        get_filename_component(HLS_M_TMP_DIR ${HLS_M_TMP_DIR} ABSOLUTE)
      endif()

      if (NOT ${HLS_M_TMP_DIR} STREQUAL ${HLS_INCLUDE_DIR})
        list(APPEND ${NEWVAR} -I${HLS_M_TMP_DIR})
      endif()
    endforeach()
  endforeach()
endmacro()

macro(_hls_add_macro NEWVAR VAR)
  foreach(HLS_M_TMP IN LISTS ${VAR})
    list(APPEND ${NEWVAR} -D${HLS_M_TMP})
  endforeach()
endmacro()


function(define_hls_project project)
  cmake_parse_arguments(
    ARG
    ""
    "TOP;PERIOD;PART;VERSION;DESCRIPTION;NAME"
    "SOURCES;TB_SOURCES;INCDIRS;TB_INCDIRS;DEPENDS;LINK;TB_LINK;COSIM_LDFLAGS;CFLAG;TB_CFLAG;DEFINE;TB_DEFINE"
    ${ARGN}
  )

  # Check arguments
  if(NOT ARG_TOP)
    message(FATAL_ERROR "add_hls_project: TOP (top module name) is not defined.")
  endif()

  if(NOT ARG_PERIOD)
    message(FATAL_ERROR "add_hls_project: PERIOD (clock period) is not defined.")
  endif()

  if(NOT ARG_PART)
    message(FATAL_ERROR "add_hls_project: PART (device part) is not defined.")
  endif()

  if(NOT ARG_SOURCES)
    message(FATAL_ERROR "add_hls_project: SOURCES (HLS source file) is not defined.")
  endif()

  # set default option value
  if(NOT ARG_VERSION)
    set(ARG_VERSION ${HLS_DEFAULT_VERSION})
  endif()
  #  * Version string separated by underscores
  string(REPLACE "." "_" ARG_VERSION_ ${ARG_VERSION})

  if(NOT ARG_DESCRIPTION)
    set(ARG_DESCRIPTION ${project})
  endif()

  if(NOT ARG_NAME)
    set(ARG_NAME ${project})
  endif()

  string(REPLACE "-" "_" IPNAME "${project}")
  string(REPLACE "." "_" IPNAME "${IPNAME}")

  # fix relative path
  set(SRC_ABS)
  _hls_map_abs(SRC_ABS   ARG_SOURCES)
  set(TBSRC_ABS)
  _hls_map_abs(TBSRC_ABS ARG_TB_SOURCES)

  # create -I** option
  if (NOT ARG_CFLAG)
    set(ARG_CFLAG ${HLS_CFLAGS} -I${CMAKE_CURRENT_SOURCE_DIR})
  else()
    list(APPEND ARG_CFLAG ${HLS_CFLAGS} -I${CMAKE_CURRENT_SOURCE_DIR})
  endif()

  _hls_add_incdir(ARG_CFLAG ARG_INCDIRS)
  get_directory_property(ARG_INCDIRS_2 INCLUDE_DIRECTORIES)
  _hls_add_incdir(ARG_CFLAG ARG_INCDIRS_2)
  _ARG_lib(ARG_CFLAG ARG_LINK)
  _hls_add_macro(ARG_CFLAG ARG_DEFINE)
  list(APPEND ARG_CFLAG -I${HLS_GMP_INC_DIR})

  if (NOT ARG_TB_CFLAG)
    set(ARG_TB_CFLAG ${ARG_CFLAG})
  else()
    list(APPEND ARG_TB_CFLAG ${ARG_CFLAG})
  endif()
  _hls_add_incdir(ARG_TB_CFLAG ARG_TB_INCDIRS)
  _ARG_lib(ARG_TB_CFLAG ARG_TB_LINK)
  _hls_add_macro(ARG_TB_CFLAG ARG_TB_DEFINE)

  # define compile target
  add_library(lib_${project} STATIC ${ARG_SOURCES})
  target_link_libraries(lib_${project}
    PUBLIC
      HLS::HLS
      ${ARG_LINK}
  )
  if (ARG_DEFINE)
    target_compile_definitions(lib_${project} PUBLIC ${ARG_DEFINE})
  endif()
  target_include_directories(lib_${project}
    PUBLIC
      ${ARG_INCDIRS}
      ${HLS_GMP_INC_DIR}
  )

  # define test-bench compile target
  if(ARG_TB_SOURCES)
    add_executable(test_${project}
        ${ARG_TB_SOURCES}
    )
    target_compile_options(test_${project} PUBLIC -g -O0)

    if (ARG_TB_DEFINE)
      target_compile_definitions(test_${project} PUBLIC ${ARG_TB_DEFINE})
    endif()

    target_link_libraries(test_${project}
      PUBLIC
        ${ARG_TB_LINK}
        lib_${project}
    )
    target_include_directories(test_${project}
      PUBLIC
        ${ARG_TB_INCDIRS}
        ${HLS_GMP_INC_DIR}
    )
    set_target_properties(test_${project}
      PROPERTIES
      RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
  endif()

  # define vitis hls project target
  set(PRJ_NAME "${project}_hls_prj")
  set(PRJ_DIR ${CMAKE_CURRENT_BINARY_DIR}/${PRJ_NAME})
  set(PRJ_FILE ${PRJ_DIR}/hls.app)

  add_custom_target(create_project_${project} SOURCES ${PRJ_FILE})
  add_custom_command(
    OUTPUT ${PRJ_FILE}
    DEPENDS ${ARG_DEPENDS}
    COMMAND
      # Define Environment Variables
      ENV_PROJECT_NAME=${PRJ_NAME}
      ENV_TCL_DIR="${HLS_TCL_DIR}"
      ENV_SOLUTION_NAME="${HLS_SOLUTION_NAME}"
      ENV_CFLAGS="${ARG_CFLAG}"
      ENV_TB_CFLAGS="${ARG_TB_CFLAG}"
      ENV_SOURCES="${SRC_ABS}"
      ENV_TB_SOURCES="${TBSRC_ABS}"
      ENV_TOP="${ARG_TOP}"
      ENV_PART="${ARG_PART}"
      ENV_PERIOD="${ARG_PERIOD}"
      # Call ${HLS_EXEC}
      ${HLS_EXEC} -f ${HLS_TCL_DIR}/create_hls_project.tcl
  )

  # synthesis target
  set(ARG_CSYNTH_ZIP ${PRJ_DIR}/${HLS_SOLUTION_NAME}/impl/ip/${HLS_VENDOR_NAME}_hls_${project}_${ARG_VERSION_}.zip)
  add_custom_target(csynth_${project} SOURCES ${ARG_CSYNTH_ZIP})
  add_custom_command(
    OUTPUT ${ARG_CSYNTH_ZIP}
    DEPENDS create_project_${project} ${ARG_SOURCES}
    COMMAND
      # Define Environment Variables
      ENV_PROJECT_NAME=${PRJ_NAME}
      ENV_TCL_DIR="${HLS_TCL_DIR}"
      ENV_SOLUTION_NAME="${HLS_SOLUTION_NAME}"
      ENV_CFLAGS="${ARG_CFLAG}"
      ENV_TB_CFLAGS="${ARG_TB_CFLAG}"
      ENV_SOURCES="${SRC_ABS}"
      ENV_TB_SOURCES="${TBSRC_ABS}"
      ENV_TOP="${ARG_TOP}"
      ENV_PART="${ARG_PART}"
      ENV_PERIOD="${ARG_PERIOD}"
      # ip option
      ENV_NAME="${ARG_NAME}"
      ENV_DESCRIPTION="${ARG_DESCRIPTION}"
      ENV_IPNAME="${IPNAME}"
      ENV_IP_TAXONOMY="${HLS_TAXONOMY}"
      ENV_IP_VENDOR="${HLS_VENDOR_NAME}"
      ENV_IP_VERSION="${ARG_VERSION}"
      # Call ${HLS_EXEC}
      ${HLS_EXEC} -f ${HLS_TCL_DIR}/csynth.tcl
  )

  # C/RTL simulation target
  add_custom_target(cosim_${project}
    DEPENDS csynth_${project}
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND
      # Define Environment Variables
      ENV_PROJECT_NAME=${PRJ_NAME}
      ENV_SOLUTION_NAME="${HLS_SOLUTION_NAME}"
      ENV_COSIM_LDFLAGS="${ARG_COSIM_LDFLAGS}"
      ENV_COSIM_TRACE_LEVEL="${HLS_TRACE_LEVEL}"
      # Call ${HLS_EXEC}
      ${HLS_EXEC} -f ${HLS_TCL_DIR}/cosim.tcl
  )

  # delete project target
  add_custom_target(clear_${project}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${PRJ_DIR}
  )

  # open project
  add_custom_target(open_${project}
    DEPENDS create_project_${project}
    COMMAND ${HLS_EXEC} -p ${PRJ_DIR}&
  )

  # open wave file
  set(ARG_WAVE_DATABASE ${PRJ_DIR}/${HLS_SOLUTION_NAME}/sim/verilog/${ARG_TOP}.wdb)
  if (EXISTS ${HLS_VIVADO_EXE})
    add_custom_target(wave_${project}
      COMMAND ${HLS_VIVADO_EXE} ${ARG_WAVE_DATABASE}&
    )
  endif()
endfunction()



function(define_hls_interface project)
  cmake_parse_arguments(
    ARG
    ""
    ""
    "INCDIRS;"
    ${ARGN}
  )
  add_library(${project} INTERFACE)
  if(NOT ARG_INCDIRS)
    target_include_directories(${project}
      INTERFACE
        ${HLS_INCLUDE_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR} # default
    )
  else()
    target_include_directories(${project}
      INTERFACE
        ${HLS_INCLUDE_DIR}
        ${ARG_INCDIRS}
    )
  endif()
endfunction()
