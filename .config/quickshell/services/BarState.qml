pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Networking
import Quickshell.Bluetooth
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Quickshell.Services.UPower

Singleton {
    id: root

    // Catppuccin Mocha palette & typography matching waybar/style.css
    readonly property string fontFamily: "JetBrainsMono Nerd Font"
    readonly property int fontSize: 16
    readonly property int iconFontSize: 20
    readonly property int barHeight: 37
    readonly property int pillHeight: 33

    readonly property color pillBg: Qt.rgba(24 / 255, 24 / 255, 37 / 255, 0.85)
    readonly property color popupBg: Qt.rgba(24 / 255, 24 / 255, 37 / 255, 0.95)
    readonly property color pillBorder: Qt.rgba(203 / 255, 166 / 255, 247 / 255, 0.3)
    readonly property color textDefault: "#cdd6f4"
    readonly property color accent: "#cba6f7"
    readonly property color hoverColor: "#b4befe"
    readonly property color inactiveWorkspace: "#a6adc8"
    readonly property color poweroffColor: "#f38ba8"
    readonly property color rebootColor: "#f9e2af"
    readonly property color criticalColor: "#f38ba8"
    readonly property color sliderTrough: Qt.rgba(1, 1, 1, 0.1)

    // --- Clock ---
    readonly property SystemClock clock: SystemClock {
        precision: SystemClock.Seconds
    }

    readonly property string timeText: Qt.formatDateTime(clock.date, "HH:mm")
    readonly property string dateText: Qt.formatDateTime(clock.date, "dd.MM")

    // --- Audio (PipeWire) ---
    readonly property PwNode defaultSink: Pipewire.defaultAudioSink

    readonly property PwObjectTracker _sinkTracker: PwObjectTracker {
        objects: root.defaultSink ? [root.defaultSink] : []
    }

    readonly property bool audioMuted: defaultSink && defaultSink.audio ? defaultSink.audio.muted : false
    readonly property real audioVolumeRaw: defaultSink && defaultSink.audio ? defaultSink.audio.volume : 0
    readonly property int audioVolumePct: Math.round(Math.max(0, Math.min(1.5, audioVolumeRaw)) * 100)

    function toggleMute(): void {
        if (defaultSink && defaultSink.audio) {
            defaultSink.audio.muted = !defaultSink.audio.muted;
        }
    }

    function setVolume(vol: real): void {
        if (defaultSink && defaultSink.audio) {
            defaultSink.audio.volume = Math.max(0, Math.min(1.0, vol));
        }
    }

    function stepVolume(delta: real): void {
        if (defaultSink && defaultSink.audio) {
            setVolume(defaultSink.audio.volume + delta);
        }
    }

    // --- Battery (UPower) ---
    readonly property UPowerDevice batteryDevice: UPower.displayDevice
    readonly property bool hasBattery: batteryDevice ? batteryDevice.isLaptopBattery : false
    readonly property int batteryPct: batteryDevice ? Math.round(batteryDevice.percentage * 100) : 0
    readonly property bool batteryCharging: batteryDevice
        ? (batteryDevice.state === UPowerDeviceState.Charging || batteryDevice.state === UPowerDeviceState.FullyCharged)
        : false
    readonly property bool batteryCritical: hasBattery && !batteryCharging && batteryPct <= 15

    // --- Keyboard Language (Hyprland) ---
    property string mainKeyboardName: ""
    property string shortLanguage: "en"

    function keymapToShort(keymap: string): string {
        if (!keymap) return "en";
        const k = keymap.toLowerCase();
        if (k.startsWith("english")) return "en";
        if (k.startsWith("russian")) return "ru";
        if (k.startsWith("ukrainian")) return "uk";
        if (k.startsWith("german")) return "de";
        if (k.startsWith("french")) return "fr";
        if (k.startsWith("spanish")) return "es";
        if (k.startsWith("polish")) return "pl";
        if (k.startsWith("italian")) return "it";
        if (k.startsWith("portuguese")) return "pt";
        if (k.startsWith("japanese")) return "ja";
        if (k.startsWith("korean")) return "ko";
        if (k.startsWith("chinese")) return "zh";
        return k.slice(0, 2);
    }

    function cycleLanguage(): void {
        Quickshell.execDetached(["hyprctl", "switchxkblayout", "all", "next"]);
    }

    readonly property Process _devicesProc: Process {
        command: ["hyprctl", "devices", "-j"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const data = JSON.parse(text);
                    const kbs = data.keyboards || [];
                    let mainKb = kbs.find(kb => kb.main === true);
                    if (!mainKb && kbs.length > 0) mainKb = kbs[0];
                    if (mainKb) {
                        root.mainKeyboardName = mainKb.name || "";
                        root.shortLanguage = root.keymapToShort(mainKb.active_keymap || "");
                    }
                } catch (e) {
                    console.warn("Failed to parse hyprctl devices:", e);
                }
            }
        }
    }

    readonly property Connections _hyprConn: Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                const idx = event.data.indexOf(",");
                if (idx !== -1) {
                    const kbName = event.data.slice(0, idx);
                    const layoutName = event.data.slice(idx + 1);
                    if (!root.mainKeyboardName || kbName === root.mainKeyboardName) {
                        root.shortLanguage = root.keymapToShort(layoutName);
                    }
                }
            } else if (event.name === "configreloaded") {
                root._devicesProc.running = true;
            }
        }
    }

    // --- Network (Quickshell.Networking, targeting wlan0 like waybar config) ---
    readonly property var targetNetworkDevice: {
        const devs = Networking.devices ? Networking.devices.values : [];
        let fallback = null;
        for (let i = 0; i < devs.length; i++) {
            const d = devs[i];
            if (d.name === "wlan0") return d;
            if (!fallback && d.connected) fallback = d;
        }
        return fallback;
    }

    readonly property bool networkConnected: targetNetworkDevice ? targetNetworkDevice.connected : false
    readonly property bool networkIsWifi: targetNetworkDevice ? (targetNetworkDevice.type === DeviceType.Wifi) : false
    readonly property bool networkIsWired: targetNetworkDevice ? (targetNetworkDevice.type === DeviceType.Wired) : false

    readonly property var activeWifiNetwork: {
        if (!targetNetworkDevice || !networkIsWifi || !targetNetworkDevice.networks) return null;
        const nets = targetNetworkDevice.networks.values;
        for (let i = 0; i < nets.length; i++) {
            if (nets[i].connected) return nets[i];
        }
        return null;
    }

    readonly property string networkEssid: activeWifiNetwork ? activeWifiNetwork.name : ""
    readonly property int networkSignalPct: {
        if (!activeWifiNetwork) return 0;
        const raw = activeWifiNetwork.signalStrength;
        return raw <= 1.0 ? Math.round(raw * 100) : Math.round(raw);
    }

    readonly property string networkDisplayName: {
        if (!networkConnected) return "Disconnected";
        if (networkIsWifi) return networkEssid || "Wi-Fi";
        if (targetNetworkDevice) return targetNetworkDevice.name;
        return "Disconnected";
    }

    // --- Bluetooth ---
    readonly property BluetoothAdapter btAdapter: Bluetooth.defaultAdapter
    readonly property bool btAvailable: btAdapter !== null
    readonly property bool btEnabled: btAdapter ? btAdapter.enabled : false
    readonly property string btConnectedDevice: {
        if (!btEnabled || !Bluetooth.devices) return "";
        const devs = Bluetooth.devices.values;
        for (let i = 0; i < devs.length; i++) {
            if (devs[i].connected) return devs[i].name || devs[i].deviceName || "Connected";
        }
        return "";
    }

    function toggleBluetooth(): void {
        if (btAdapter) {
            btAdapter.enabled = !btAdapter.enabled;
        }
    }

    // --- Media (MPRIS) ---
    readonly property MprisPlayer activePlayer: {
        const players = Mpris.players ? Mpris.players.values : [];
        let paused = null;
        let first = null;
        for (let i = 0; i < players.length; i++) {
            const p = players[i];
            if (!first) first = p;
            if (p.playbackState === MprisPlaybackState.Playing) return p;
            if (!paused && p.playbackState === MprisPlaybackState.Paused) paused = p;
        }
        return paused || first;
    }

    function truncateText(str: string, maxLen: int): string {
        if (!str) return "";
        if (str.length <= maxLen) return str;
        return str.slice(0, maxLen - 3) + "...";
    }

    readonly property string mediaTitle: {
        if (!activePlayer || !activePlayer.trackTitle) return "no music :(";
        return truncateText(activePlayer.trackTitle, 30);
    }

    readonly property string mediaFullTitle: {
        if (!activePlayer || !activePlayer.trackTitle) return "no music :(";
        return activePlayer.trackTitle;
    }

    readonly property string mediaArtist: {
        if (!activePlayer || !activePlayer.trackArtist) return "...";
        return truncateText(activePlayer.trackArtist, 30);
    }

    readonly property string mediaFullArtist: {
        if (!activePlayer) return "...";
        if (activePlayer.trackArtist) return activePlayer.trackArtist;
        if (activePlayer.trackArtists && activePlayer.trackArtists.length > 0) {
            return activePlayer.trackArtists.join(", ");
        }
        return "...";
    }

    readonly property string mediaArtUrl: activePlayer ? (activePlayer.trackArtUrl || "") : ""

    function formatDuration(sec: real): string {
        const s = Math.max(0, Math.floor(sec || 0));
        const hrs = Math.floor(s / 3600);
        const mins = Math.floor((s % 3600) / 60);
        const rem = s % 60;
        const mm = mins < 10 && hrs > 0 ? "0" + mins : String(mins).padStart(2, "0");
        const ss = String(rem).padStart(2, "0");
        return hrs > 0 ? `${hrs}:${mm}:${ss}` : `${mm}:${ss}`;
    }

    readonly property string mediaStatusIcon: {
        if (!activePlayer) return "⏹";
        if (activePlayer.playbackState === MprisPlaybackState.Playing) return "⏸";
        if (activePlayer.playbackState === MprisPlaybackState.Paused) return "▶";
        return "⏹";
    }
}
