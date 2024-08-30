# Copyright (c) 2024 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

set ws        [lindex $argv 0]
set project   [lindex $argv 1]

setws $ws

app build -name $project
