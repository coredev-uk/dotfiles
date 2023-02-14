local awful = require("awful")
local gears = require("gears")
local configuration = config
--[[====================================================
Apps
====================================================]]--

local startup_apps_always = {
	"picom --config " .. os.getenv("HOME") .. "/.config/picom/picom.conf",
	"feh --bg-fill " .. os.getenv("HOME") .. "/OneDrive/Pictures/Ember_Mac.png",
}

local startup_apps = {
	"setxkbmap -layout" .. configuration.keymap,
	"liquidctl --match hydro set fan speed 20",
	"xidlehook --not-when-fullscreen --not-when-audio --timer " .. configuration.locktime .. " '" .. configuration.lockcmd .. "' '' --timer " .. configuration.sleeptime .. " 'systemctl suspend' '' ",
	"openrgb --startminimized -p" .. configuration.openrgb_profile .. " & disown",
	"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "steam -silent",
    configuration.browser .. " --no-startup-window"
}

--[[====================================================
Stuff
====================================================]]--

local spawn_once = function (cmd)
	-- print("Spawning: " .. cmd)
	-- print("With Command: " .. string.format('bash -c "pgrep -u $USER -x %s > /dev/null || (%s)"', gears.string.split(cmd, ' ')[1], cmd))
	awful.spawn.easy_async_with_shell(
	string.format('bash -c "pgrep -u $USER -x %s > /dev/null || (%s)"', gears.string.split(cmd, ' ')[1], cmd),
	function(_, stderr)
		if not stderr or stderr == '' then
			return
		end

	end
	)
end

for _, app in ipairs(startup_apps_always) do
	awful.spawn(string.format("killall '%s'", gears.string.split(app, ' ')[1]))
	awful.spawn(string.format("bash -c '%s'", app))
end

for _, app in ipairs(startup_apps) do
	spawn_once(app)
end
