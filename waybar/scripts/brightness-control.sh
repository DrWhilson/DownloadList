#!/bin/bash

# Конфигурация
MONITORS=(1 2)
STEP=10
MAX_BRIGHTNESS=100
MIN_BRIGHTNESS=20
CACHE_FILE="/tmp/waybar_brightness_cache"
LOCK_FILE="/tmp/waybar_brightness.lock"

# Функция блокировки
acquire_lock() {
    local timeout=10  # 10 секунд таймаут
    local start_time=$(date +%s)
    
    while [ -f "$LOCK_FILE" ] && [ $(( $(date +%s) - start_time )) -lt $timeout ]; do
        sleep 0.1
    done
    
    if [ -f "$LOCK_FILE" ]; then
        return 1
    fi
    
    touch "$LOCK_FILE"
    return 0
}

release_lock() {
    rm -f "$LOCK_FILE"
}

# Функция для получения текущей яркости
get_brightness() {
    local monitor=$1
    local brightness
    
    if ! acquire_lock; then
        echo "50"  # Возвращаем значение по умолчанию при таймауте
        return
    fi
    
    brightness=$(ddcutil getvcp 10 --display "$monitor" 2>/dev/null | awk '/current value:/ {print $NF}' | tr -d ',')
    release_lock
    
    if [ -z "$brightness" ] || ! [[ "$brightness" =~ ^[0-9]+$ ]]; then
        brightness=50
    fi
    
    echo "$brightness"
}

# Функция для установки яркости
set_brightness() {
    local monitor=$1
    local brightness=$2
    
    if ! acquire_lock; then
        return 1
    fi
    
    # Устанавливаем яркость с таймаутом
    timeout 5s ddcutil setvcp 10 "$brightness" --display "$monitor" >/dev/null 2>&1
    local result=$?
    
    release_lock
    return $result
}

# Функция для изменения яркости
change_brightness() {
    local monitor=$1
    local direction=$2
    local value=$3
    local current_brightness new_brightness
    
    # Получаем текущую яркость
    current_brightness=$(get_brightness "$monitor")
    new_brightness=$current_brightness

    case $direction in
        "up")
            new_brightness=$((current_brightness + STEP))
            [ $new_brightness -gt $MAX_BRIGHTNESS ] && new_brightness=$MAX_BRIGHTNESS
            ;;
        "down")
            new_brightness=$((current_brightness - STEP))
            [ $new_brightness -lt $MIN_BRIGHTNESS ] && new_brightness=$MIN_BRIGHTNESS
            ;;
        "set")
            new_brightness=$value
            ;;
    esac

    # Устанавливаем новую яркость
    if set_brightness "$monitor" "$new_brightness"; then
        echo "$new_brightness"
    else
        echo "$current_brightness"  # Возвращаем старое значение при ошибке
    fi
}

# Обработка аргументов
case $1 in
    "up"|"down")
        result=""
        for monitor in "${MONITORS[@]}"; do
            monitor_result=$(change_brightness "$monitor" "$1")
            # Используем значение от первого монитора для отображения
            [ -z "$result" ] && result="$monitor_result"
        done
        echo "$result"
        ;;
    "set")
        if [ -n "$2" ]; then
            result=""
            for monitor in "${MONITORS[@]}"; do
                change_brightness "$monitor" "set" "$2" >/dev/null
            done
            echo "$2"
        else
            echo "Error: No brightness value provided"
            exit 1
        fi
        ;;
    "get")
        get_brightness "${MONITORS[0]}"
        ;;
    *)
        echo "Usage: $0 {up|down|set <value>|get}"
        exit 1
        ;;
esac
