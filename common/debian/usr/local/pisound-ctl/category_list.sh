#!/bin/sh

# Copyright (C) 2017-2020 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

CURDIR=$(dirname $(readlink -f $0))
find "${CURDIR}" -maxdepth 2 -mindepth 2 -name "*.yml"
