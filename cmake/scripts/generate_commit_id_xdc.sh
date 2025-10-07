# Copyright (c) 2025 National Institute of Advanced Industrial Science and Technology (AIST)
# All rights reserved.
# This software is released under the MIT License.
# http://opensource.org/licenses/mit-license.php

#!/bin/sh
hash=$(git show --format='%H' --no-patch 2> /dev/null || echo 00000000)
hash=$(echo $hash | head -c 8)
echo "set_property BITSTREAM.CONFIG.USR_ACCESS 0x${hash} [current_design]" > $1
