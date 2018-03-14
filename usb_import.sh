#!/bin/sh

# Copyright (C) 2017-2018 Vilniaus Blokas UAB, https://blokas.io/pisound
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

# Allow overriding environment variables.
if [ -z "$EXTERNAL_MEDIA_DIR" ]; then
	EXTERNAL_MEDIA_DIR=/media
fi
if [ -z "$PUREDATA_DST_DIR" ]; then
	PUREDATA_DST_DIR=/usr/local/puredata-patches
fi

echo Starting USB import at "$EXTERNAL_MEDIA_DIR"...


puredata_import() {
	PD_SRC_DIR=puredata-patches

	echo Looking for Pure Data patches in "$1/$PD_SRC_DIR"...

	if [ -e "$1/$PD_SRC_DIR" ]; then
		ls "$1/$PD_SRC_DIR" | while read -r dir; do
			if [ -e "$PUREDATA_DST_DIR/$dir" ]; then
				echo Merging "$dir" to "$PUREDATA_DST_DIR/$dir"...
			else
				echo Importing "$dir" to "$PUREDATA_DST_DIR/$dir"...
			fi
			mkdir -p "$PUREDATA_DST_DIR/$dir"
			cp -r "$1/$PD_SRC_DIR/$dir" "$PUREDATA_DST_DIR"
		done
	else
		>&2 echo "$1" does not contain "$PD_SRC_DIR"...
	fi
	echo
}

import_all() {
	puredata_import "$1"
	# Add more importers here...
}

mount_all_usb_drives() {
	ls /dev/disk/by-id/ | grep usb | while read -r usb_dev; do
		DISKPATH="/dev/disk/by-id/$usb_dev"
		DEV=$(readlink -f $DISKPATH)

		LABEL=`sudo blkid -s LABEL -o value $DEV`
		if [ -z "$LABEL" ]; then
			echo "Skipping $DISKPATH"
			continue
		fi

		MEDIAPATH="/media/$LABEL"
		echo "Mounting $DEV ($LABEL) to $MEDIAPATH"
		sudo mkdir -p "$MEDIAPATH"
		sudo mount "$DEV" "$MEDIAPATH"
	done
}

mount_all_usb_drives


ls "$EXTERNAL_MEDIA_DIR" | while read -r usb; do
	echo Found '"'$usb'"'...
	import_all "$EXTERNAL_MEDIA_DIR/$usb"
done

echo Done! Thank you!
