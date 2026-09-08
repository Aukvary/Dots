#!/usr/bin/env python3
import subprocess
import json
import time
import sys

# Отключаем буферизацию
sys.stdout.reconfigure(line_buffering=True)

while True:
    try:
        result = subprocess.run(
            ["playerctl", "status"],
            capture_output=True,
            text=True,
            timeout=0.5
        )
        status = result.stdout.strip()
    except:
        status = "NoPlayer"
    
    if status == "Playing":
        data = {"text": "❚❚", "class": "playing"}
    elif status == "Paused":
        data = {"text": "▶", "class": "paused"}
    else:
        data = {"text": "⏹", "class": "stopped"}
    
    print(json.dumps(data), flush=True)
    time.sleep(0.1)