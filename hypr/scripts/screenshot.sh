#!/bin/bash
# ~/.config/hypr/scripts/screenshot.sh

USER=$(whoami)
TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
DIR="/home/$USER/screenshot"
mkdir -p "$DIR"

case "$1" in
    full)
        grim -t jpg "$DIR/full_$TIMESTAMP.jpg"
        notify-send "Captura guardada" "$DIR/full_$TIMESTAMP.jpg"
        ;;
    window)
        grim -t jpg -o "$(hyprctl activewindow -j | jq -r '.monitor')" "$DIR/window_$TIMESTAMP.jpg"
        notify-send "Captura guardada" "$DIR/window_$TIMESTAMP.jpg"
        ;;
    selection)
        grim -t jpg -g "$(slurp)" "$DIR/selection_$TIMESTAMP.jpg"
        notify-send "Captura guardada" "$DIR/selection_$TIMESTAMP.jpg"
        ;;
    *)
        echo "Uso: $0 {full|window|selection}"
        exit 1
        ;;
esac
