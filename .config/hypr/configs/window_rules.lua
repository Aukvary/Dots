local suppressMaximizeRule = hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "hyprland-share-picker",
	match = {
		class = "^hyprland-share-picker$",
	},
	float = true,
})

if host == "aukvary-laptop" then
	hl.window_rule({
		name = "tg start up",
		match = {
			class = "^org.telegram.desktop$",
		},
		workspace = "2",
		focus_on_activate = false,
	})
else
	hl.window_rule({
		name = "tg start up",
		match = {
			class = "^org.telegram.desktop$",
		},
		monitor = "HDMI-A-1",
	})

	hl.window_rule({
		name = "tg viewer",
		match = {
			class = "^org.telegram.desktop$",
			title = "Media viewer",
		},
	})

	hl.window_rule({
		name = "ds start up",
		match = {
			class = "^vesktop$",
		},
		monitor = "HDMI-A-1",
	})

	hl.window_rule({
		name = "yandex music start up",
		match = {
			class = "YandexMusic$",
		},
		monitor = "HDMI-A-2",
	})
end
