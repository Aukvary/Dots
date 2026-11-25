hl.env("XCURSOR_THEME", "Mocu-Black-Right")
hl.env("XCURSOR_SIZE", "36")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("MOZ_USE_XINPUT2", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

local f = io.open("/etc/hostname")
host = f and (f:read("*a"):gsub("%s+$", "")) or (os.getenv("HOSTNAME") or "")
if f then
	f:close()
end
