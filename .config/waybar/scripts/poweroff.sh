#!/bin/bash
# Скрипт быстрого обновления (20 FPS)

# Обновление каждые 50ms (0.05 секунды)
while true; do
  # Ваша логика здесь - примеры ниже
  if [[ $(cat /tmp/waybar-power-menu.state) == "expanded" ]]; then 
    echo "󰐥"; 
  else 
    echo ""; 
  fi
  sleep 0.1
done