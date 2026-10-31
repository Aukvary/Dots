local f = io.open("/etc/hostname")
local host = f and (f:read("*a"):gsub("%s+$", "")) or (os.getenv("HOSTNAME") or "")
if f then
	f:close()
end

if host == "aukvary-laptop" then
	hl.monitor({
		output = "eDP-1",
		mode = "1920x1200",
		position = "0x0",
		scale = 1,
	})
else
	hl.monitor({
		output = "DP-1",
		mode = "2560x1440@165",
		position = "0x768",
		scale = 1,
	})

	hl.monitor({
		output = "HDMI-A-2",
		mode = "1366x768@60",
		position = "597x0",
		scale = 1,
	})

	hl.monitor({
		output = "HDMI-A-1",
		mode = "1920x1080@75",
		position = "2560x768",
		scale = 1,
		ransform = 1,
	})
end
