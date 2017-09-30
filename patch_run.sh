#!/bin/sh

# Copyright (C) 2017 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

CURRENT_SCRIPT_DIR=$(dirname $(readlink -f $0))

echo "Starting patch $@..."

extension="${@##*.}"
case $extension in
	"pd")
		$CURRENT_SCRIPT_DIR/run_pd.sh "$@"
		;;
#	"scd")
#		$CURRENT_SCRIPT_DIR/run_supercollider.sh "$@"
#		;;
	* )
		>&2 echo "No handler for .$extension!"
		;;
esac
