#!/bin/bash

DEV_NODE="/dev/sde"

# Проверяем, подключено ли устройство к ПК
if [ -b "$DEV_NODE" ]; then
    echo "{\"text\": \"󱊟 \", \"class\": \"mounted\", \"tooltip\": \"Устройство $DEV_NODE подключено\"}"
   else
    # Устройство вообще не подключено
    echo ""
fi

