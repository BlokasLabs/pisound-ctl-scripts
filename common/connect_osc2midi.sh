#!/bin/sh

# Copyright (C) 2017-2018 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#


READABLE_PORTS=`aconnect -i | egrep -iv "(Through|$1|System)" | egrep -o "[0-9]+:" | egrep -o "[0-9]+"`
RANGE="0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

for p in $READABLE_PORTS; do
	for i in $RANGE; do
		aconnect $p:$i "$1" 2> /dev/null;
	done;
done
