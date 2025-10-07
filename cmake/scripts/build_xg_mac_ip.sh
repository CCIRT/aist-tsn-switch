# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

#! /bin/bash

CURRENT_DIR=$(cd $(dirname $0);pwd)

cd $CURRENT_DIR/../../3rdparty/xg_mac/xg_mac
make
