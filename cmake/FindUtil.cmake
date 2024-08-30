# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

function(gen_bd direction speed)
  if(${ARGC} EQUAL 2)
    set(BD_NAME design_1.tcl)
  else()
    set(BD_NAME ${ARGV2})
  endif()

  set(BASED_BD ${CMAKE_CURRENT_SOURCE_DIR}/../../10g/${direction}/${BD_NAME})
  set(TARGET_BD ${CMAKE_CURRENT_SOURCE_DIR}/${BD_NAME})
  set(BASED_FREQ 125000000)

  if(speed STREQUAL "2p5g")
    set(TARGET_FREQ 31250000)
  elseif(speed STREQUAL "5g")
    set(TARGET_FREQ 62500000)
  elseif(speed STREQUAL "7p5g")
    set(TARGET_FREQ 93750000)
  elseif(speed STREQUAL "10g")
    set(TARGET_FREQ 125000000)
  else()
    return()
  endif()

  add_custom_target(gen_bd_${direction}_${speed} SOURCES ${TARGET_BD})
  add_custom_command(
    OUTPUT ${TARGET_BD}
    DEPENDS ${BASED_BD}
    COMMAND
      sed -e "s/${BASED_FREQ}/${TARGET_FREQ}/g" ${BASED_BD} > ${TARGET_BD};
  )
endfunction()

function(add_power_prj direction speed)
  # Set BIT_NAME
  if(${direction} STREQUAL tx)
    set(BIT_DIRECTION t)
  elseif(${direction} STREQUAL rx)
    set(BIT_DIRECTION r)
  elseif(${direction} STREQUAL loopback)
    set(BIT_DIRECTION l)
  else()
    return()
  endif()
  set(BIT_CLK c125_000)
  if(${speed} STREQUAL 7p5g)
    set(BIT_CLK c117_188)
    set(BIT_SPEED 075)
  elseif(${speed} STREQUAL 10g)
    set(BIT_SPEED 100)
  elseif(${speed} STREQUAL 5g)
    set(BIT_SPEED 050)
  elseif(${speed} STREQUAL 2p5g)
    set(BIT_SPEED 025)
  else()
    return()
  endif()
  set (BIT_NAME hw_${BIT_DIRECTION}${BIT_SPEED}_${BIT_CLK})

  # Set constraint name
  set (CONSTRAINT ${CONSTRAINT_DIR}/${direction}.xdc)
  if(${speed} STREQUAL 7p5g)
    set (CONSTRAINT ${CONSTRAINT_DIR}/${direction}_${speed}.xdc)
  endif()

  # Generate board file
  gen_bd(${direction} ${speed})

  # Define vivado
  define_vivado(${direction}_${speed}
    TOP         ${direction}
    BOARD       *kc705*
    TCL1        ${IP_DIR}/${direction}_gt_${speed}.tcl
    RTL         ${RTL_DIR}
    CONSTRAINT  ${CONSTRAINT_DIR}/kc705.xdc
                ${CONSTRAINT}
    IP          ${BUILD_HLS_DIR}
    DESIGN      design_1.tcl
    DEPENDS     gen_bd_${direction}_${speed}
                csynth_comma_injector
                csynth_data_aligner
                csynth_data_checker
                csynth_power_manager
                csynth_test_app_base
                csynth_ber_test_manager
  )
  after_copy_bitstream(
    ${direction}_${speed}
    ${CMAKE_BINARY_DIR}/bitstream/power
    ${BIT_NAME}
  )
endfunction()

function(gen_bd_swpmbus direction speed)
  if(${ARGC} EQUAL 2)
    set(BD_NAME design_1.tcl)
  else()
    set(BD_NAME ${ARGV2})
  endif()

  set(BASED_BD ${CMAKE_CURRENT_SOURCE_DIR}/../../10g/${direction}/${BD_NAME})
  set(TARGET_BD ${CMAKE_CURRENT_SOURCE_DIR}/${BD_NAME})
  set(BASED_FREQ 125000000)

  if(speed STREQUAL "2p5g")
    set(TARGET_FREQ 31250000)
  elseif(speed STREQUAL "5g")
    set(TARGET_FREQ 62500000)
  elseif(speed STREQUAL "7p5g")
    set(TARGET_FREQ 93750000)
  elseif(speed STREQUAL "10g")
    set(TARGET_FREQ 125000000)
  else()
    return()
  endif()

  add_custom_target(gen_bd_${direction}_${speed}_swpmbus SOURCES ${TARGET_BD})
  add_custom_command(
    OUTPUT ${TARGET_BD}
    DEPENDS ${BASED_BD}
    COMMAND
      sed -e "s/${BASED_FREQ}/${TARGET_FREQ}/g" ${BASED_BD} > ${TARGET_BD};
  )
endfunction()

function(add_power_prj_swmpbus direction speed)
  # Set BIT_NAME
  if(${direction} STREQUAL tx)
    set(BIT_DIRECTION t)
  elseif(${direction} STREQUAL rx)
    set(BIT_DIRECTION r)
  elseif(${direction} STREQUAL loopback)
    set(BIT_DIRECTION l)
  else()
    return()
  endif()
  set(BIT_CLK c125_000)
  if(${speed} STREQUAL 7p5g)
    set(BIT_CLK c117_188)
    set(BIT_SPEED 075)
  elseif(${speed} STREQUAL 10g)
    set(BIT_SPEED 100)
  elseif(${speed} STREQUAL 5g)
    set(BIT_SPEED 050)
  elseif(${speed} STREQUAL 2p5g)
    set(BIT_SPEED 025)
  else()
    return()
  endif()
  set (BIT_NAME sw_${BIT_DIRECTION}${BIT_SPEED}_${BIT_CLK})

  # Set constraint name
  set (CONSTRAINT ${CONSTRAINT_DIR}/${direction}.xdc)
  if(${speed} STREQUAL 7p5g)
    set (CONSTRAINT ${CONSTRAINT_DIR}/${direction}_${speed}.xdc)
  endif()

  # Generate board file
  gen_bd_swpmbus(${direction} ${speed})

  # Define vivado
  define_vivado(${direction}_${speed}_swpmbus
    TOP         ${direction}_swpmbus
    BOARD       *kc705*
    TCL1        ${IP_DIR}/${direction}_gt_${speed}.tcl
    RTL         ${RTL_DIR}
    CONSTRAINT  ${CONSTRAINT_DIR}/kc705.xdc
                ${CONSTRAINT}
    IP          ${BUILD_HLS_DIR}
    DESIGN      design_1.tcl
    DEPENDS     gen_bd_${direction}_${speed}_swpmbus
                csynth_comma_injector
                csynth_data_aligner
                csynth_data_checker
                csynth_power_manager
                csynth_test_app_base
                csynth_ber_test_manager
  )

  # Difine vitis
  define_vitis(${direction}_${speed}_swpmbus_vitis
    XSA ${direction}_${speed}_swpmbus
    PROC pmbus_microblaze_0
    PROCPATH design_1_i/pmbus/microblaze_0
    LINKSCRPT ${VITIS_SRC}/lscript.ld
    SRC ${VITIS_SRC}/pmbus.cpp
        ${VITIS_SRC}/power_manager.cpp
        ${VITIS_SRC}/powermanager.cpp
    INCDIR ${VITIS_SRC}
    DEFS KC705 # for pm_common_host.hpp
  )
  vitis_after_copy_bitstream(
    ${direction}_${speed}_swpmbus
    ${direction}_${speed}_swpmbus_vitis
    ${CMAKE_BINARY_DIR}/bitstream/power
    ${BIT_NAME}
  )
endfunction()
