#!/bin/bash
DEV="/dev/sde1"
TARGET_DIR="/mnt/flash_folder"

if [ ! -d "$TARGET_DIR" ]; then
    sudo mkdir -p "$TARGET_DIR"
fi

MOUNT_POINT=$(findmnt -n -o TARGET "$DEV")

if [ -z "$MOUNT_POINT" ]; then
    sudo mount "$DEV" "$TARGET_DIR"
    sleep 0.3
    
    pkill -RTMIN+5 waybar
    
    MOUNT_POINT=$(findmnt -n -o TARGET "$DEV")
fi

if [ -n "$MOUNT_POINT" ]; then
  mate-terminal -e "zsh -c 'spf $TARGET_DIR'"
fi
