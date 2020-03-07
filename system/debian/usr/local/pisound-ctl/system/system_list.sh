#!/bin/sh

# Copyright (C) 2017-2018 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

if [ -z "$SYSTEM_SCRIPTS_DIR" ]; then
	SYSTEM_SCRIPTS_DIR=/usr/local/pisound-ctl/system
fi

find "$SYSTEM_SCRIPTS_DIR/" | grep blokas\\.yml\$ | while read -r i; do
	echo "$i"
done
