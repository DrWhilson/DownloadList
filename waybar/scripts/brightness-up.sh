#!/bin/bash
LOCK_FILE="/tmp/ddcutil-brightness.lock"

# Ожидание блокировки с таймаутом
exec 200>$LOCK_FILE
flock -w 5 200 || exit 1

# Выполнение команды
ddcutil setvcp 10 + 25 2>/dev/null

# Небольшая пауза перед получением значения
sleep 0.2
current=$(~/.config/waybar/scripts/get-brightness.sh 2>/dev/null)

# Снятие блокировки
flock -u 200

# ddcutil setvcp 10 + 10
# current=$(~/.config/waybar/scripts/get-brightness.sh)
# notify-send "Яркость" "Увеличена: $current%" -t 1000
