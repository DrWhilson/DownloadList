#!/bin/bash
DEV="/dev/sde1"

# Проверяем, примонтировано ли уже устройство
MOUNT_POINT=$(findmnt -n -o TARGET "$DEV")

if [ -z "$MOUNT_POINT" ]; then
    # Если НЕ примонтировано: монтируем
    udisksctl mount -b "$DEV"
    sleep 0.3
    
    # Обновляем статус в Waybar
    pkill -RTMIN+5 waybar
    
    # Получаем новую точку монтирования
    MOUNT_POINT=$(findmnt -n -o TARGET "$DEV")
fi

# Если устройство успешно примонтировано (или уже было примонтировано) — открываем superfile
if [ -n "$MOUNT_POINT" ]; then
  mate-terminal -e "zsh -c 'spf /run/media/grossadmiral/'"
fi
