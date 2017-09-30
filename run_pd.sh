#!/bin/sh

# Copyright (C) 2017 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

# This block will get executed with a 3 second delay, so that Pure Data has enough time to start up and the virtual MIDI devices
# it creates will get taken into account.
(
	sleep 3

	READABLE_PORTS=`aconnect -i | egrep -iv "(Through|Pure Data|System)" | egrep -o "[0-9]+:" | egrep -o "[0-9]+"`
	RANGE="0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15"

	for p in $READABLE_PORTS; do
		for i in $RANGE; do
			aconnect $p:$i "Pure Data" 2> /dev/null;
			aconnect "Pure Data:1" $p:$i 2> /dev/null;
		done;
	done
) &

PATCH=$@

puredata -stderr -nogui -alsa -audioadddev pisound -alsamidi -channels 2 -r 48000 -mididev 1 -send ";pd dsp 1" "$PATCH"
