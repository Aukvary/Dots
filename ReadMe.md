# Setup

One repo, two machines. Configs are symlinked into `~/.config`
(relative links: `~/.config/nvim -> ../dots/.config/nvim`).

## Machines

|            | Main PC                 | Laptop (minimal)            |
|------------|-------------------------|-----------------------------|
| WM         | niri (`.config/niri/`)  | sway (`.config/sway/`)      |
| Bar        | waybar                  | swaybar + custom status.sh  |

Each machine reads only its own WM section; everything below is shared.

## Shared

- OS: CachyOS
- Terminal: foot (`foot --server` + `footclient`)
- Shell: fish
- Editor: nvim (native LSP config, Mason, fzf-lua)
- Multiplexer: zellij
- App launcher: fuzzel
- File manager: Nautilus / yazi
- Wallpapers: `wallpapers/` (single source; `~/wallpapers` is a symlink)
