# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set HOME $::env(HOME)
set VIVADO_VERSION [version -short]
set_param board.repoPaths [list ${HOME}/.Xilinx/Vivado/${VIVADO_VERSION}/xhub/board_store/xilinx_board_store]
xhub::refresh_catalog [xhub::get_xstores xilinx_board_store]
xhub::install [xhub::get_xitems *zedboard*]
