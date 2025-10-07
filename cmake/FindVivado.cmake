# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

#default value
set(VIVADO_DEFAULT_IMPL "impl_1" CACHE STRING "default vivado impl name")
set(VIVADO_JOB "0" CACHE STRING "vivado implement job size")

# find path
find_path(VIVADO_BIN_DIR
  vivado
  PATHS ${VIVADO_ROOT} ENV XILINX_VIVADO
  PATH_SUFFIXES bin
)

# save currrent directory
if(NOT VIVADO_PROJECT_REPOGITORY_ROOT_DIR)
  # `root` variable of create_vivado_project.tcl
  set(VIVADO_PROJECT_REPOGITORY_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})
endif()
set(VIVADO_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(VIVADO_TCL_DIR ${CMAKE_CURRENT_LIST_DIR}/tcl)
set(VIVADO_CMAKE_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})

# hide variable
mark_as_advanced(VIVADO_BIN_DIR VIVADO_CMAKE_DIR VIVADO_TCL_DIR)

# find package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Vivado
  REQUIRED_VARS
    VIVADO_BIN_DIR
)

# VIVADO_VERSION: Vivado Version
get_filename_component(VIVADO_VERSION "${VIVADO_BIN_DIR}" DIRECTORY)
get_filename_component(VIVADO_VERSION "${VIVADO_VERSION}" NAME)

if(VIVADO_JOB STREQUAL "0")
  include(ProcessorCount)
  ProcessorCount(VIVADO_JOB_SIZE)
  if(VIVADO_JOB_SIZE EQUAL 0)
    set(VIVADO_JOB_SIZE 1)
  endif()
else()
  set(VIVADO_JOB_SIZE ${VIVADO_JOB})
endif()
set(VIVADO_EXE ${VIVADO_BIN_DIR}/vivado)


macro(_vivado_map_abs NEWVAR VAR)
  set(${NEWVAR})
  foreach(VIVADO_M_TMP IN LISTS ${VAR})
    if (IS_ABSOLUTE ${VIVADO_M_TMP})
      list(APPEND ${NEWVAR} ${VIVADO_M_TMP})
    else()
      list(APPEND ${NEWVAR} ${CMAKE_CURRENT_SOURCE_DIR}/${VIVADO_M_TMP})
    endif()
  endforeach()
endmacro()

set(TEMAC_EXAMPLE temac_example)
set(TEMAC_EXAMPLE_ROOT "${CMAKE_BINARY_DIR}")
set(TEMAC_EXAMPLE_PROJ "${TEMAC_EXAMPLE_ROOT}/tri_mode_ethernet_mac_0_ex")

add_custom_command(
  OUTPUT ${TEMAC_EXAMPLE_PROJ}
  COMMAND
  # Create example project
  ${VIVADO_EXE}
  -mode batch
  -source ${VIVADO_TCL_DIR}/create_temac_example.tcl -tclargs ${TEMAC_EXAMPLE_ROOT}
)

add_custom_target(
  ${TEMAC_EXAMPLE}
  DEPENDS
  ${TEMAC_EXAMPLE_PROJ}
  )

function(define_vivado project)
  cmake_parse_arguments(
    ARG
    ""
    "BOARD;DESIGN;DIR;TOP"
    "RTL;CONSTRAINT;IP;DEPENDS;IMPLEMENTS;TCL0;TCL1;TCL2"
    ${ARGN}
  )

  # Check arguments
  if(NOT ARG_BOARD)
    message(FATAL_ERROR "add_vivado_project: BOARD is not defined.")
  endif()

  if(NOT ARG_TOP)
    message(FATAL_ERROR "add_vivado_project: TOP (top module name) is not defined.")
  endif()

  # set default option value
  if(NOT ARG_DIR)
    set(ARG_DIR "${project}.prj")
  endif()

  if(NOT DESIGN_BD_NAME)
    set(DESIGN_BD_NAME "design_1")
  endif()

  # fix relative path
  _vivado_map_abs(RTL_ABS ARG_RTL)
  _vivado_map_abs(CONSTRAINT_ABS ARG_CONSTRAINT)
  _vivado_map_abs(IP_ABS ARG_IP)
  _vivado_map_abs(TCL0_ABS ARG_TCL0)
  _vivado_map_abs(TCL1_ABS ARG_TCL1)
  _vivado_map_abs(TCL2_ABS ARG_TCL2)

  if(ARG_DESIGN)
    if (NOT IS_ABSOLUTE ${ARG_DESIGN})
      set(ARG_DESIGN ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DESIGN})
    endif()
  endif()


  if(ARG_DFX)
    if (NOT IS_ABSOLUTE ${ARG_DFX})
      set(ARG_DFX ${CMAKE_CURRENT_SOURCE_DIR}/${ARG_DFX})
    endif()
  endif()


  # define ${project} target(create Vivado project)
  set(PRJ_DIR_ABS ${CMAKE_CURRENT_BINARY_DIR}/${ARG_DIR})
  set(PRJ_FILE ${PRJ_DIR_ABS}/${project}.xpr)
  add_custom_target(${project} SOURCES ${PRJ_FILE})
  set_target_properties(${project}
    PROPERTIES
      PROJECT_DIR  ${PRJ_DIR_ABS}
      RUNS_DIR     ${PRJ_DIR_ABS}/${project}.runs
      PROJECT_FILE ${PRJ_FILE})

  add_custom_command(
    OUTPUT ${PRJ_FILE}
    DEPENDS
      ${ARG_DEPENDS}
      ${TCL0_ABS}
      ${TCL1_ABS}
      ${TCL2_ABS}
      ${TEMAC_EXAMPLE}
    COMMAND
      bash ${CMAKE_SOURCE_DIR}/rtl/src/patch.sh ${TEMAC_EXAMPLE_PROJ}
    COMMAND
<<<<<<< HEAD
      # Define global
      ENV_DESIGN=${ARG_DESIGN}
      ENV_RTL="${RTL_ABS}"
      ENV_CONSTRAINT="${CONSTRAINT_ABS}"
=======
      bash ${CMAKE_SOURCE_DIR}/../cmake/scripts/build_xg_mac_ip.sh
    COMMAND
      bash ${CMAKE_SOURCE_DIR}/../cmake/scripts/generate_commit_id_xdc.sh ${CMAKE_CURRENT_BINARY_DIR}/commit_id.xdc
    COMMAND
      # Define global
      ENV_DESIGN=${ARG_DESIGN}
      ENV_RTL="${RTL_ABS}"
      ENV_CONSTRAINT="${CONSTRAINT_ABS};${CMAKE_CURRENT_BINARY_DIR}/commit_id.xdc"
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
      ENV_IP="${IP_ABS}"
      ENV_TCL0="${TCL0_ABS}"
      ENV_TCL1="${TCL1_ABS}"
      ENV_TCL2="${TCL2_ABS}"
      # Call vivado
      ${VIVADO_EXE}
        -mode batch
        -source ${VIVADO_TCL_DIR}/create_vivado_project.tcl
        -tclargs
          "${project}"
          "${ARG_DIR}"
          "${ARG_BOARD}"
          "${PRJ_DIR_ABS}"
          "${ARG_TOP}"
          "${CMAKE_CURRENT_SOURCE_DIR}"
          "${VIVADO_PROJECT_REPOGITORY_ROOT_DIR}"
          "${DESIGN_BD_NAME}"
  )

  # open project in vivado
  add_custom_target(open_${project}
    DEPENDS ${PRJ_FILE}
    COMMAND ${VIVADO_EXE} ${PRJ_FILE} &
  )

  # get default impl name
  if(NOT ARG_IMPLEMENTS)
    set(ARG_IMPLEMENTS ${VIVADO_DEFAULT_IMPL})
  endif()
  list(GET ARG_IMPLEMENTS 0 DEFAULT_IMPL)

  # synthesis,impl,gen bitstream target
  set(RUNS_DIR ${PRJ_DIR_ABS}/${project}.runs)
  set(BITSTREAM ${RUNS_DIR}/${DEFAULT_IMPL}/${ARG_TOP}.bit)
  set(XSA ${RUNS_DIR}/${DEFAULT_IMPL}/${ARG_TOP}.xsa)
  set(LTX ${RUNS_DIR}/${DEFAULT_IMPL}/${ARG_TOP}.ltx)

  #    run impl: impl_${project} target
  add_custom_target(impl_${project} SOURCES ${BITSTREAM})
  add_custom_command(
    OUTPUT ${BITSTREAM}
    DEPENDS ${project} ${ARG_DESIGN}
    COMMAND
      # Define global
      "ENV_IMPLEMENTS=${ARG_IMPLEMENTS}"
      # Call vivado
      ${VIVADO_EXE}
        -mode batch
        -source ${VIVADO_TCL_DIR}/implement.tcl
        -tclargs
          ${project}
          ${ARG_DIR}
          ${VIVADO_JOB_SIZE}
  )

  # xsa
  add_custom_target(xsa_${project} SOURCES ${XSA})
  add_custom_command(
    OUTPUT ${XSA}
    DEPENDS impl_${project}
    COMMAND
      # Define global
      "ENV_IMPLEMENTS=${ARG_IMPLEMENTS}"
      # Call vivado
      ${VIVADO_EXE}
        -mode batch
        -source ${VIVADO_TCL_DIR}/xsa.tcl
        -tclargs
        ${project}
        ${ARG_DIR}
        ${XSA}
  )

  # delete project target
  add_custom_target(clear_${project}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${PRJ_DIR_ABS}
    COMMAND ${CMAKE_COMMAND} -E remove ${CMAKE_CURRENT_BINARY_DIR}/vivado*
    COMMAND ${CMAKE_COMMAND} -E remove ${XSA}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${CMAKE_CURRENT_BINARY_DIR}/.Xil
  )

  set_target_properties(${project}
    PROPERTIES
      PROJECT_NAME   ${project}
      PROJECT_DIR    ${PRJ_DIR_ABS}
      BITSTREAM      ${BITSTREAM}
      LTX            ${LTX}
      XSA            ${XSA}
  )
endfunction()

function(after_copy_bitstream project outdir filename)
  add_custom_command(
    TARGET impl_${project} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory ${outdir}
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_PROPERTY:${project},BITSTREAM> ${outdir}/${filename}.bit
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_PROPERTY:${project},LTX> ${outdir}/${filename}.ltx
  )
endfunction()
