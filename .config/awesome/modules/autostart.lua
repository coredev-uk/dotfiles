local awful = require("awful")
local gears = require("gears")

local configuration = {
	terminal = "alacritty",
	editor = os.getenv("EDITOR") or "nvim",
	lockcmd = "betterlockscreen -l dimblur --display 1",
	lockwallpaper = "$HOME/Pictures/gradient.png"
}

--[[====================================================
Apps
====================================================]]--

local startup_apps_always = {
	'picom --config ~/.config/picom/picom.conf --experimental-backends --glx-fshader-win "$(cat ~/.config/picom/shader.glsl)"',
	'feh --bg-fill ~/Pictures/background.png',
}

local startup_apps = {
	'setxkbmap -layout gb',
	'numlockx',
	"xss-lock --transfer-sleep-lock -- '" .. configuration.lockcmd .. "' --nofork",
	'liquidctl --match hydro set fan speed 20',
	'ssh-add ~/.ssh/aur',
	'betterlockscreen -u ' .. configuration.lockwallpaper,
	"xidlehook --not-when-fullscreen --not-when-audio --timer 300 '" .. configuration.lockcmd .. "' '' --timer 120 'systemctl suspend' '' ",
	'openrgb --startminimized -p orange-night & disown',
	'/usr/lib/geoclue-2.0/demos/agent',
	'redshift-gtk',
	'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1'
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
