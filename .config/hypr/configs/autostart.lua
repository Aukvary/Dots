hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor mocu-white-right 28")
	hl.exec_cmd("foot --server")
	if host == "aukvary-laptop" then
		hl.exec_cmd("hyprpaper")
	else
		hl.exec_cmd("hyprpaper --config $HOME/.config/hypr/hyprpaper-desktop.conf")
		hl.exec_cmd("yandex-music")
	end
	hl.exec_cmd("waybar")
	hl.exec_cmd("Telegram")
end)
