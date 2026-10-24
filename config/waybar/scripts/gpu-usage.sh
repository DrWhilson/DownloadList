#!/bin/bash

# Проверяем наличие nvidia-smi
if ! command -v nvidia-smi &> /dev/null; then
    # Возвращаем JSON с классом "hidden" для скрытия модуля
    echo '{"text": "", "class": "hidden", "tooltip": ""}'
    exit 0
fi

# Получаем загрузку GPU
GPU_USAGE=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits 2>/dev/null | head -1)

if [ -n "$GPU_USAGE" ] && [[ "$GPU_USAGE" =~ ^[0-9]+$ ]]; then
    echo "{\"text\": \"$GPU_USAGE\", \"tooltip\": \"GPU: ${GPU_USAGE}%\"}"
else
    # Если данные не получены — скрываем модуль
    echo '{"text": "[DELETED]",}'
fi
