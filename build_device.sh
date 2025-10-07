# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php                                                            |

#!/bin/bash
TARGET_VIVADO_VERSION=2022.1

#---------------------------------------------------
all_targets="impl_ats-switch impl_cbs-switch"
<<<<<<< HEAD
=======
all_targets_zedboard="impl_ats-switch-zedboard impl_cbs-switch-zedboard"
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)

_usage() {
    echo -e "Usage: $0 [-b <Dir>] [-h] [-V <Vivado Root Dir>] <make targets>..."
    echo -e " Options:"
    echo -e "\t-b, --build    : build directory"
    echo -e "\t-V, --vivado   : Vivado Root Directory"
    echo -e "\t-h, --help     : show this help"
    echo -e "\t<make targets> : Make target list"
    echo -e "\t                   impl_all: build following designs"
<<<<<<< HEAD
    echo -e "\t                     - L2 switch with ATS"
    echo -e "\t                     - L2 switch with CBS"
    echo -e "\t                   impl_ats-switch: build the design of L2 switch with ATS"
    echo -e "\t                   impl_cbs-switch: build the design of L2 switch with CBS"
    echo -e "\t                   open_ats-switch: open the design of L2 switch with ATS"
    echo -e "\t                   open_cbs-switch: open the design of L2 switch with CBS"
=======
    echo -e "\t                     - L2 switch with ATS (KC705)"
    echo -e "\t                     - L2 switch with CBS (KC705)"
    echo -e "\t                   impl_all-zedboard: build following designs"
    echo -e "\t                     - L2 switch with ATS (ZedBoard)"
    echo -e "\t                     - L2 switch with CBS (ZedBoard)"
    echo -e "\t                   impl_ats-switch: build the design of L2 switch with ATS for KC705"
    echo -e "\t                   impl_cbs-switch: build the design of L2 switch with CBS for KC705"
    echo -e "\t                   impl_ats-switch-zedboard: build the design of L2 switch with ATS for ZedBoard"
    echo -e "\t                   impl_cbs-switch-zedboard: build the design of L2 switch with CBS for ZedBoard"
    echo -e "\t                   impl_cbs-switch-zedboard-with-probes: build the design of L2 switch with CBS for ZedBoard with probes"
    echo -e "\t                   open_ats-switch: open the design of L2 switch with ATS for KC705"
    echo -e "\t                   open_cbs-switch: open the design of L2 switch with CBS for KC705"
    echo -e "\t                   open_ats-switch-zedboard: open the design of L2 switch with ATS for ZedBoard"
    echo -e "\t                   open_cbs-switch-zedboard: open the design of L2 switch with CBS for ZedBoard"
    echo -e "\t                   open_cbs-switch-zedboard-with-probes: open the design of L2 switch with CBS for ZedBoard with probes"
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
    echo -e "\t                   run_tb_ats_modules: run test bench for ATS modules"
    echo -e "\t                   run_tb_cbs_modules: run test bench for CBS modules"
    echo -e "\t                   run_tb_<test_name>: run test bench of the specified module"
    echo -e "\t                     - Note: scapy and iverilog are required"
    echo -e "\t                     - ex: run_tb_connect_frame_length.ethernet_frame"
    echo -e "\t                   display_tb_<test_name>: display waveform of the specified module"
    echo -e "\t                     - Note: gtkwave is required"
    echo -e "\t                     - ex: display_tb_connect_frame_length.ethernet_frame"
}
# -------------------------------------------------
set -e
build=build-device
mgtavcc=""
evmmode=""
vroot=""
hroot=""
make_target=""

for OPT in "$@"
do
  case $OPT in
    -h | --help)
      _usage
      exit
      ;;

    -b | --build)
      build="$1"
      shift 2
      ;;

    -V | --vivado)
      vroot="$1"
      shift 2
      ;;

    *)
      make_target="$make_target $1"
      shift 1
      ;;
  esac
done

# -------------------------------------------------
cd `dirname $0`
if [ ! -d $build ]; then
  mkdir -p $build
fi
cd $build
echo $build
if [ ! -f CMakeCache.txt ]; then
  #
  # Run CMake
  #

  # find default vivado path
  if [ ! -z $vroot ]; then
    if [ ! -d $vroot ]; then
      echo "Vivado directory: $vroot does not exist."
      exit 1
    fi
    if [ $(basename $vroot) != $TARGET_VIVADO_VERSION ]; then
      echo "Vivado directory: $vroot is not Vivado $TARGET_VIVADO_VERSION ."
      exit 1
    fi
  fi

  if [ -z $vroot ] && [ ! -z $XILINX_VIVADO ]; then
    if [ $(basename $XILINX_VIVADO) != $TARGET_VIVADO_VERSION ]; then
      vroot=$XILINX_VIVADO
    fi
  fi
  if [ -z $hroot ] && [ ! -z $XILINX_HLS ]; then
    if [ $(basename $XILINX_HLS) != $TARGET_VIVADO_VERSION ]; then
      hroot=$XILINX_HLS
    fi
  fi

  if [ -z $vroot ]; then
    if [ -d /opt/Xilinx/Vivado/$TARGET_VIVADO_VERSION ]; then
      vroot=/opt/Xilinx/Vivado/$TARGET_VIVADO_VERSION
    elif [ -d /tools/Xilinx/Vivado/$TARGET_VIVADO_VERSION ]; then
      vroot=/tools/Xilinx/Vivado/$TARGET_VIVADO_VERSION
    else
      echo "Vivado $TARGET_VIVADO_VERSION is not found."
    fi
  fi

  cmake ../device \
    $mgtavcc $evmmode \
    -DVIVADO_ROOT=$vroot
fi

# trim space
make_target=$(echo $make_target)

if [ ! -z $make_target ]; then
  if [ "$make_target" = "impl_all" ]; then
    make $all_targets
<<<<<<< HEAD
=======
  elif [ "$make_target" = "impl_all-zedboard" ]; then
    make $all_targets_zedboard
>>>>>>> dbb0d5b (AIST-TSN Switch V2.0 First commit)
  else
    make $make_target
  fi
else
  echo ""
  echo "  Please work in $(pwd)"
  echo ""
  echo "   $ cd $(pwd)"
  echo "   $ make *target*"
  echo ""
fi
