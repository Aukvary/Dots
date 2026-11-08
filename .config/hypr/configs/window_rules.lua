-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

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

if host ~= "aukvary-laptop" then
	hl.window_rule({
		name = "tty blur",
		match = {
			class = "^foot(client)?$",
		},
	})
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
