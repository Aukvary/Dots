hl.on("hyprland.start", function()
	hl.exec_cmd("hyprctl setcursor Mocu-White-Right 24")
	hl.exec_cmd("foot --server")
	if host == "aukvary-laptop" then
		hl.exec_cmd("hyprpaper")
	else
		hl.exec_cmd("hyprpaper --config $HOME/.config/hypr/hyprpaper-desktop.conf")
	end
	hl.exec_cmd("waybar")
end)
