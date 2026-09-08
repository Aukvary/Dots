#!/usr/bin/env python3
import json
import sys
from pathlib import Path

STATE_FILE = Path("/tmp/waybar-power-menu.state")

# Инициализация
if not STATE_FILE.exists():
    STATE_FILE.write_text("collapsed")

state = STATE_FILE.read_text().strip()

# Обработка переключения
if len(sys.argv) > 1 and sys.argv[1] == "toggle":
    new_state = "expanded" if state == "collapsed" else "collapsed"
    STATE_FILE.write_text(new_state)
    state = new_state

# Отображение
if state == "expanded":
    data = {"text": "▶", "class": "expanded"}
else:
    data = {"text": " ", "class": "collapsed"}

print(json.dumps(data))