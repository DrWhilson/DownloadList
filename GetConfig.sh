#!/bin/bash

SOURCE_DIR="./config/"
DEST_DIR="~/.config/"

for filepath in "$SOURCE_DIR"/*; do
    if [ -f "$filepath" ]; then
        filename=$(basename "$filepath")
        # Удаляем файл в целевой папке, если он там существует
        rm -f "$DEST_DIR/$filename"
    fi
done

# Копируем все файлы из исходной папки в целевую
cp "$SOURCE_DIR"/* "$DEST_DIR/"

mkdir -p /usr/share/wallpaper/
cp -r ./wallpaper/* /usr/share/wallpaper/
