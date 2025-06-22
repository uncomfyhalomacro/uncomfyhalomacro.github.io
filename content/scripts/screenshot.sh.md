+++
title = "Screenshot script I use on both X11 and Wayland"
authors = ["Soc Virnyl Estela"]
date = "2025-06-22"
+++

**Dependencies**:
- `grim`
- `ImageMagick`
- `xdg-user-dirs` or `xdg-utils`
- `swappy`
- `xclip`
- `libnotify-tools`
- `waysip`

```bash
#!/bin/bash

export APP_NAME="My Grim Shot"
export SCREENSHOTS_PATH="$(xdg-user-dir PICTURES)/Screenshots"
if ! [ -d "${SCREENSHOTS_PATH}" ]; then
    mkdir -p "${SCREENSHOTS_PATH}"
fi

function fullscreenshot {
    SAVE_PATH="$(xdg-user-dir PICTURES)/Screenshots/Screenshot-$(date +'%m%d%H%M%S.png')"
    if [ -n "$WAYLAND_DISPLAY" ]; then
        grim - | swappy -f - -o "$SAVE_PATH"
        # Press ctrl c instead
        wl-copy -t image/png < "$SAVE_PATH"
    else
        TEMP_PNG="$(mktemp)".png
        import -window root "$TEMP_PNG"
        swappy -f "$TEMP_PNG" -o "$SAVE_PATH"
        xclip -selection clipboard -target image/png -i "$SAVE_PATH"
        rm "$TEMP_PNG"
    fi
    if [ -s "$SAVE_PATH" ]; then
        notify-send --app-name "${APP_NAME}" --icon "$SAVE_PATH" "Successfully" "Screenshot saved as $SAVE_PATH"
    else
        rm "$SAVE_PATH"
        notify-send --app-name "${APP_NAME}" --icon "$SAVE_PATH" "Aborted" --urgency critical
    fi
}

function selectarea {
    SAVE_PATH="$(xdg-user-dir PICTURES)/Screenshots/Screenshot-$(date +'%m%d%H%M%S.png')"
    if [ -n "$WAYLAND_DISPLAY" ]; then
        GEOMETRY=$(waysip -d)
        grim -g "${GEOMETRY}" - | swappy -f - -o "$SAVE_PATH"
        # press ctrl c instead
        wl-copy < "$SAVE_PATH"
    else
        # TMPFILE="/tmp/$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32)".png
        import -format png "${SAVE_PATH}"
        swappy -f "${SAVE_PATH}" -o "$SAVE_PATH" 
        xclip -selection clipboard -target image/png -i "$SAVE_PATH"
        # rm "${TMPFILE}"
    fi
    if [ -s "$SAVE_PATH" ]; then
        notify-send --app-name "${APP_NAME}" --icon "$SAVE_PATH" "Successful" "Screenshot saved as $SAVE_PATH"
    else
        rm "$SAVE_PATH"
        notify-send --app-name "${APP_NAME}" --icon "$SAVE_PATH" "Aborted" --urgency critical
    fi
}

whichMode(){
    if [ "$1" = "full" ] || [ "$1" = "" ]; then
        fullscreenshot
    elif [ "$1" = "area" ]; then
        selectarea
    else
        notify-send "Please select 'area' or 'full'"
    fi
}

whichMode "$@"
```

