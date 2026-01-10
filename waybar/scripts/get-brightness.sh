#!/bin/bash

# Получаем яркость с флагом --no-lock
brightness=$(ddcutil getvcp 10 --display 1  2>/dev/null | grep -o "current value = *[0-9]*" | awk '{print $4}')

# Если не получилось, пробуем второй монитор
if [ -z "$brightness" ]; then
    brightness=$(ddcutil getvcp 10 --display 2 2>/dev/null | grep -o "current value = *[0-9]*" | awk '{print $4}')
fi

echo "${brightness:-100}"
