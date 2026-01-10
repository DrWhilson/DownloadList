#!/bin/bash

# Путь к основному скрипту управления яркостью
BRIGHTNESS_SCRIPT="$HOME/.config/waybar/scripts/brightness-control.sh"

# Функция для получения текущей яркости
get_display_brightness() {
    local brightness=$($BRIGHTNESS_SCRIPT get)
    echo "$brightness"
}

# Функция для обновления вывода Waybar
print_brightness() {
    local brightness=$(get_display_brightness)
    local icon="󰃠"
    
    # Разные иконки в зависимости от уровня яркости
    if [ "$brightness" -ge 80 ]; then
        icon="󰃠"
    elif [ "$brightness" -ge 50 ]; then
        icon="󰃟"
    elif [ "$brightness" -ge 20 ]; then
        icon="󰃝"
    else
        icon="󰃛"
    fi
    
    echo "{\"text\": \"$icon $brightness%\", \"percentage\": $brightness}"
}

# Обработка событий
case $1 in
    "up")
        $BRIGHTNESS_SCRIPT up
        ;;
    "down")
        $BRIGHTNESS_SCRIPT down
        ;;
    *)
        print_brightness
        ;;
esac
