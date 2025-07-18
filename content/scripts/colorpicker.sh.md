+++
title = "Colorpicker script for Wayland"
authors = ["Soc Virnyl Estela"]
date = "2025-06-22"
+++

**Dependencies**:
- `grim`
- `ImageMagick`
- `xclip`
- `libnotify-tools`
- `waysip`
- `hexcolor`

`hexcolor`:

```bash
#!/bin/bash

# Copyright 2019 sharkwouter
#
#Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


# Variables
IMAGE="/tmp/screen.bmp" # temporary image file
DEPS="xwininfo xdotool import convert"


# printed when -h option is used
usage ( )
{
	cat <<EOF
$0 [OPTION]
Returns the rgb color code of of the pixel under the mouse after clicking.

Options:
  -h	Print this message
EOF
}

# checks if all dependencies are installed
deps ( ) {
	for dep in ${DEPS}; do
		if which ${dep} > /dev/null 2>&1; then
			:
		else
			echo "The command \"${dep}\" is unavailable, make sure all dependencies are installed."
			exit 1
		fi
	done
}

# getopts:
while getopts ":h" option
do
	case "${option}" in
		h)
			usage
			exit 0
		;;
	esac
done


# Actual script:

# Check if all required dependencies are installed first
deps

# Change the cursor and wait until a click has been made. Using xwininfo for this works, but there may be better options
xwininfo > /dev/null

# Get the mouse location, make a screenshot and get the information on the pixel on which the mouse was
RESULT=$(eval $(xdotool getmouselocation --shell) && import -window root ${IMAGE} && convert ${IMAGE} -crop 1x1+${X}+${Y} txt:)
#clean up
rm -f ${IMAGE}

# return only the hex code for the rgb color
echo ${RESULT}|cut -f8 -d' '
```

`colorpicker.sh`:

```bash
#!/bin/bash

shopt -s lastpipe

if [ -z "${WAYLAND_DISPLAY}" ]
then
  COLOR=$($HOME/.local/bin/hexcolor)
  notify-send -a "Colorpicker" "Color on selected pixel: ${COLOR}" "Hex value copied to clipboard"
  printf "${COLOR}" | xclip -sel clip
else
  COLOR=$(grim -g "$(waysip -p)" - | /usr/bin/gm convert - -format '%[{0,0}]' txt:-)
  [ -z "${COLOR}" ] && exit 
  notify-send -a "Colorpicker" "Color on selected pixel: ${COLOR}" "Hex value copied to clipboard"
  HEX="$(echo $COLOR | cut -d')' -f2 | cut -d' ' -f2)"
  wl-copy "${HEX}"
fi
```
