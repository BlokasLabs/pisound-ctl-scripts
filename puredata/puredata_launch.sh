#!/bin/sh

# Copyright (C) 2017-2018 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

. /usr/local/pisound/scripts/common/start_puredata.sh
PATCH="$1"
shift

echo
echo "$PATCH"
echo "$@"

start_puredata "$PATCH" $@
