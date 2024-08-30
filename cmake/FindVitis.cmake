# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

find_path(VITIS_BIN_DIR
  vitis
  PATHS ${VITIS_ROOT} ENV XILINX_VITIS
  PATH_SUFFIXES bin
)

find_path(VITIS_ROOT_DIR
  settings64.sh
  PATHS ${VITIS_BIN_DIR}/..
)

# VITIS_VERSION: Vitis VITIS Version
get_filename_component(VITIS_VERSION "${VITIS_BIN_DIR}" DIRECTORY)
get_filename_component(VITIS_VERSION "${VITIS_VERSION}" NAME)

# find package
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Vitis
  REQUIRED_VARS
    VITIS_BIN_DIR
)
set(VITIS_XSCT ${VITIS_BIN_DIR}/xsct)
set(VITIS_EXE ${VITIS_BIN_DIR}/vitis)
set(VITIS_UPDATEMEM ${VITIS_BIN_DIR}/updatemem)

# save current directory
set(VITIS_CMAKE_DIR ${CMAKE_CURRENT_LIST_DIR})
set(VITIS_TCL_DIR ${CMAKE_CURRENT_LIST_DIR}/tcl)
set(VITIS_CMAKE_LIB_DIR ${CMAKE_CURRENT_BINARY_DIR}/lib)

macro(_vitis_map_abs NEWVAR VAR)
  set(${NEWVAR})
  foreach(TMP IN LISTS ${VAR})
    if (IS_ABSOLUTE ${TMP})
      list(APPEND ${NEWVAR} ${TMP})
    else()
      list(APPEND ${NEWVAR} ${CMAKE_CURRENT_SOURCE_DIR}/${TMP})
    endif()
  endforeach()
endmacro()

function(define_vitis project)
  cmake_parse_arguments(
    VARG
    "DEBUG;RELEASE"
    "XSA;PROC;OS;PROCPATH;LINKSCRPT"
    "SRC;INCDIR;DEPENDS;TCL0;TCL1;TCL2;TCL3;DEFS"
    ${ARGN}
  )
  if (NOT VARG_XSA)
    message(FATAL_ERROR "add_vitis_hw_project:${project}: XSA(exported hardware) is not defined.")
  endif()

  if (NOT VARG_PROC)
    message(FATAL_ERROR "add_vitis_hw_project:${project}: PROC is not defined")
  endif()

  if (NOT VARG_PROCPATH)
    message(FATAL_ERROR "add_vitis_hw_project:${project}: PROCPATH is not defined")
  endif()


  # set template
  if (VARG_TEMPLATE)
    set(template ${VARG_TEMPLATE})
  else()
    set(template ${DEFAULT_TEMPLATE})
  endif()

  # set os
  if (VARG_OS)
    set(os ${VARG_OS})
  else()
    set(os "standalone")
  endif()

  if (VARG_LINKSCRPT)
    set(linker_script ${VARG_LINKSCRPT})
  else()
    set(linker_script "")
  endif()

  set(build_mode Release)
  if (VARG_DEBUG)
    set(build_mode Debug)
  endif()

  # init depends
  set(DEPENDS)
  if (VARG_DEPENDS)
    set(DEPENDS ${VARG_DEPENDS})
  endif()

  # get xsa file from vivado target
  get_property(xsa_file TARGET ${VARG_XSA} PROPERTY XSA)
  set(platform_name ${VARG_XSA})
  list(APPEND DEPENDS xsa_${VARG_XSA})
  set(XSA_DEPEND xsa_${VARG_XSA})
  get_property(bit_file TARGET ${VARG_XSA} PROPERTY BITSTREAM)
  get_filename_component(bit_name ${bit_file} NAME)
  get_filename_component(bit_name ${bit_file} NAME_WE)


  # set project directory
  set(domain "${os}_${platform_name}")
  set(workspace ${CMAKE_CURRENT_BINARY_DIR}/${project})
  set(PRJDIR ${workspace}/${project})
  set(PRJFILE ${PRJDIR}/.project)
  set(DebugELF ${PRJDIR}/Debug/${project}.elf)
  set(ReleaseELF ${PRJDIR}/Release/${project}.elf)
  set(mmi_path ${PRJDIR}/_ide/bitstream/${bit_name}.mmi)
  set(bit_path ${PRJDIR}/_ide/bitstream/${bit_name}.bit)
  set(DebugBit ${PRJDIR}/Debug/${project}.bit)
  set(ReleaseBit ${PRJDIR}/Release/${project}.bit)


  if (${build_mode} STREQUAL "Debug")
    set(ELF ${DebugELF})
    set(out_bit_path ${DebugBit})
  else()
    set(ELF ${ReleaseELF})
    set(out_bit_path ${ReleaseBit})
  endif()
  set(BITSTREAM ${PRJDIR}/_ide/bitstream/${platform_name}.bit)
  _vitis_map_abs(SRC VARG_SRC)
  _vitis_map_abs(INC VARG_INCDIR)
  _vitis_map_abs(TCL0 VARG_TCL0)
  _vitis_map_abs(TCL1 VARG_TCL1)
  _vitis_map_abs(TCL2 VARG_TCL2)

  # generate workspace and project
  add_custom_target(create_${project} SOURCES ${PRJFILE})
  add_custom_command(
    OUTPUT ${PRJFILE}
    DEPENDS ${DEPENDS}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${workspace}
    COMMAND
      ENV_DUMMY=dummy
      ENV_SRC="${SRC}"
      ENV_INC="${INC}"
      ENV_TCL0="${TCL0}"
      ENV_TCL1="${TCL1}"
      ENV_TCL2="${TCL2}"
      ENV_DEFS="${VARG_DEFS}"
    ${VITIS_XSCT} ${VITIS_TCL_DIR}/create_vitis_project.tcl
      "${workspace}"
      ${project}
      ${platform_name}
      ${domain}
      ${os}
      ${VARG_PROC}
      "${xsa_file}"
      ${build_mode}
      ${linker_script}
  )

  # build project
  add_custom_target(${project} SOURCES ${ELF})
  add_custom_command(
    OUTPUT ${ELF}
    DEPENDS create_${project}
    COMMAND
    ${VITIS_XSCT} ${VITIS_TCL_DIR}/vitis_build.tcl
      "${workspace}"
      ${project}
  )

  # generate bitstream with updatemem
  add_custom_target(bit_${project} SOURCES ${out_bit_path})
  add_custom_command(
    OUTPUT ${out_bit_path}
    DEPENDS ${ELF}
    COMMAND ${VITIS_UPDATEMEM}
      --force
      --meminfo ${mmi_path}
      --data ${ELF}
      --bit ${bit_path}
      --proc ${VARG_PROCPATH}
      --out ${out_bit_path}
  )

  # open project
  add_custom_target(open_${project}
    COMMAND ${VITIS_EXE} -workspace ${workspace}&
  )

  # delete project target
  add_custom_target(clear_${project}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${workspace}
  )


  # set target property
  set_target_properties(${project}
    PROPERTIES
      VIVADO_PROJECT VITIS
      PROJECT_NAME   ${project}
      PROJECT_DIR    ${PRJDIR}
      PROJECT_FILE   ${PRJFILE}
      # TOP_LTX        ${LTX}
      IMPL_TARGET    ${project}
      XSA            "${xsa_file}"
      BITSTREAM      ${out_bit_path}
  )
endfunction()

function(vitis_after_copy_bitstream vivado_project vitis_project outdir filename)
  add_custom_command(
    TARGET bit_${vitis_project} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E make_directory ${outdir}
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_PROPERTY:${vitis_project},BITSTREAM> ${outdir}/${filename}.bit
    COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_PROPERTY:${vivado_project},LTX> ${outdir}/${filename}.ltx
  )
endfunction()
