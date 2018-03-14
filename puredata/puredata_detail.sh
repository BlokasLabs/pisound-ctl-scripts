#!/bin/sh

# Copyright (C) 2017-2018 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

if echo "$1" | grep -q "blokas.yml\$"; then
	# Echo the entire file with all the filled information.
	cat "$1"
else
	# Generate json with only the information we know on the 'legacy' patches.
	PATCH_DIR=`dirname "$1"`
	DIR_NAME=`basename "$PATCH_DIR"`
	JSON='{"name":"'$DIR_NAME'","entry":"main.pd"}'
	echo $JSON
fi
