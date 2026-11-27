//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import "services"

ShellRoot {
    IpcHandler {
        target: "bar"

        function status(): string {
            const ws = Hyprland.workspaces ? Hyprland.workspaces.values.map(w => `${w.id}:${w.monitor ? w.monitor.name : "?"}:${w.active}`) : [];
            const tray = SystemTray.items ? SystemTray.items.values.map(i => i.id || i.title) : [];
            return JSON.stringify({
                time: BarState.timeText,
                date: BarState.dateText,
                lang: BarState.shortLanguage,
                audioPct: BarState.audioVolumePct,
                audioMuted: BarState.audioMuted,
                hasBattery: BarState.hasBattery,
                netConnected: BarState.networkConnected,
                netWifi: BarState.networkIsWifi,
                netEssid: BarState.networkDisplayName,
                netSignal: BarState.networkSignalPct,
                btAvailable: BarState.btAvailable,
                btEnabled: BarState.btEnabled,
                btDevice: BarState.btConnectedDevice,
                mediaTitle: BarState.mediaFullTitle,
                mediaArtist: BarState.mediaFullArtist,
                mediaArt: BarState.mediaArtUrl,
                mediaPos: BarState.activePlayer ? BarState.activePlayer.position : 0,
                mediaLen: BarState.activePlayer ? BarState.activePlayer.length : 0,
                mediaPosFmt: BarState.formatDuration(BarState.activePlayer ? BarState.activePlayer.position : 0),
                mediaLenFmt: BarState.formatDuration(BarState.activePlayer ? BarState.activePlayer.length : 0),
                mediaStatus: BarState.mediaStatusIcon,
                tray: tray,
                workspaces: ws
            }, null, 2);
        }
    }

    Variants {
        model: Quickshell.screens

        BarWindow {
            required property ShellScreen modelData
            screen: modelData
        }
    }
}
