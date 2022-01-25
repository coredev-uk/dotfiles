local watch = require("awful.widget.watch")
local naughty = require("naughty")
local awful = require("awful")

local current_volume = -1
local vol_notification
local mic_notification

function MicrophoneToggle()
    awful.util.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle", false)
    awful.spawn.easy_async_with_shell("pactl get-source-mute @DEFAULT_SOURCE@", function(state)
        state = string.find(state, "Mute: yes")
        local icon = (state) and "mic-off-line" or "mic-line"
        if mic_notification then
            mic_notification.icon = os.getenv("HOME") .. "/.config/awesome/icons/" .. icon .. ".png"
            mic_notification:reset_timeout()
        else
            mic_notification = naughty.notify({
                icon = os.getenv("HOME") .. "/.config/awesome/icons/" .. icon .. ".png",
                icon_size = 16,
                width = 50,
                height = 50
            })
            mic_notification:connect_signal("destroyed", function()
                mic_notification = nil
            end)
        end
    end)
end


watch([[pamixer --get-volume]], 0.1, function(_, volume)
	volume = tonumber(volume)
	if current_volume >= 0 and volume ~= current_volume then
		if vol_notification then
			vol_notification.text = volume .. '%'
			vol_notification:reset_timeout()
		else
			vol_notification = naughty.notify({
				text = volume .. '%',
			})
			vol_notification:connect_signal("destroyed", function()
				vol_notification = nil
			end)
		end

	end
	current_volume = tonumber(volume)
end)


return {
		MicrophoneToggle = MicrophoneToggle
}
