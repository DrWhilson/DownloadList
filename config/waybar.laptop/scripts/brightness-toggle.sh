#!/bin/bash

# Скрипт для Waybar - переключение яркости двух экранов между 100% и 40%
# с защитой от конфликтов блокировок i2c и обновлением Waybar

# Файл для хранения текущего состояния яркости
STATE_FILE="/tmp/waybar_brightness_state"
LOCK_FILE="/tmp/waybar_brightness.lock"

# Функция для обновления Waybar
update_waybar() {
    # Отправляем сигнал обновления модулю brightness-toggle
    pkill -SIGRTMIN+2 waybar 2>/dev/null || true
}

# Функция для безопасной установки блокировки
acquire_lock() {
    local max_attempts=10
    local attempt=0
    
    while [ $attempt -lt $max_attempts ]; do
        if mkdir "$LOCK_FILE" 2>/dev/null; then
            return 0
        fi
        sleep 0.1
        ((attempt++))
    done
    echo "Не удалось получить блокировку после $max_attempts попыток"
    return 1
}

# Функция для освобождения блокировки
release_lock() {
    rm -rf "$LOCK_FILE"
}

# Функция для последовательной установки яркости на мониторы
set_brightness_sequential() {
    local brightness=$1
    
    # Устанавливаем яркость на первый монитор
    if ddcutil setvcp 10 $brightness --display 1 --noverify --sleep-multiplier 0.1 >/dev/null 2>&1; then
        echo "Монитор 1: установлена яркость $brightness%" >&2
    else
        echo "Монитор 1: ошибка установки яркости" >&2
    fi
    
    sleep 0.2  # Пауза между командами
    
    # Устанавливаем яркость на второй монитор
    if ddcutil setvcp 10 $brightness --display 2 --noverify --sleep-multiplier 0.1 >/dev/null 2>&1; then
        echo "Монитор 2: установлена яркость $brightness%" >&2
    else
        echo "Монитор 2: ошибка установки яркости" >&2
    fi
}

# Функция для получения текущей яркости (проверяет только первый рабочий монитор)
get_current_brightness() {
    # Пытаемся получить яркость с первого монитора
    local brightness=$(ddcutil getvcp 10 --display 1 --brief 2>/dev/null | awk -F' ' '{print $4}')
    
    if [ -n "$brightness" ] && [ "$brightness" -ge 0 ] && [ "$brightness" -le 100 ]; then
        echo "$brightness"
        return 0
    fi
    
    # Если первый не сработал, пробуем второй
    brightness=$(ddcutil getvcp 10 --display 2 --brief 2>/dev/null | awk -F' ' '{print $4}')
    
    if [ -n "$brightness" ] && [ "$brightness" -ge 0 ] && [ "$brightness" -le 100 ]; then
        echo "$brightness"
        return 0
    fi
    
    # Если оба не сработали, используем значение из файла состояния
    if [ -f "$STATE_FILE" ]; then
        cat "$STATE_FILE"
    else
        echo "100"
    fi
}

# Функция переключения яркости
toggle_brightness() {
    if ! acquire_lock; then
        echo "Ошибка: не удалось получить блокировку i2c" >&2
        return 1
    fi
    
    local current_brightness=$(get_current_brightness)
    
    echo "Текущая яркость: $current_brightness%" >&2
    
    # Определяем новую яркость
    if [ "$current_brightness" -ge 90 ]; then
        new_brightness=5
        echo "Переключение на 5%" >&2
    else
        new_brightness=100
        echo "Переключение на 100%" >&2
    fi
    
    # Устанавливаем новую яркость
    set_brightness_sequential $new_brightness
    
    # Сохраняем состояние
    echo "$new_brightness" > "$STATE_FILE"
    
    release_lock
    
    # Обновляем Waybar
    update_waybar
}

# Функция для проверки доступности мониторов
check_monitors() {
    local available_count=0
    
    if ddcutil getvcp 10 --display 1 --brief >/dev/null 2>&1; then
        ((available_count++))
    fi
    
    if ddcutil getvcp 10 --display 2 --brief >/dev/null 2>&1; then
        ((available_count++))
    fi
    
    echo $available_count
}

# Функция для отображения статуса в Waybar
display_status() {
    local MONITOR_COUNT=$(check_monitors)
    local CURRENT=$(get_current_brightness)
    
    # Определяем класс и иконку
    if [ "$MONITOR_COUNT" -eq 0 ]; then
        TEXT="󰅛 No DDC"
        CLASS="error"
    elif [ "$MONITOR_COUNT" -eq 1 ]; then
        TEXT="󰃞 $CURRENT%"
        CLASS="warning"
    elif [ "$CURRENT" -le 40 ]; then
        TEXT="󰃞 $CURRENT%"
        CLASS="low"
    else
        TEXT="󰃠 $CURRENT%"
        CLASS="high"
    fi
    
    echo "{\"text\": \"$TEXT\", \"class\": \"$CLASS\", \"tooltip\": \"Доступно мониторов: $MONITOR_COUNT\"}"
}

# Основной код
case "${1}" in
    "click")
        if [ "${2}" = "left" ]; then
            toggle_brightness
        elif [ "${2}" = "right" ]; then
            # Правый клик - принудительная установка 100%
            if acquire_lock; then
                set_brightness_sequential 100
                echo "100" > "$STATE_FILE"
                release_lock
                update_waybar
            fi
        fi
        ;;
    *)
        display_status
        ;;
esac
