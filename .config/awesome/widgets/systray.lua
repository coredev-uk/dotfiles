local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi


local icons = {
	"",
	"",
}

local systray = function (s)
    if s ~= screen.primary then return end
	local widget = wibox.widget{	
        {
            {
                {
                    -- screen = s,
                    base_size = dpi(20),
                    widget = wibox.widget.systray,
                },
                widget = wibox.container.margin,
                top = dpi(2),
                right = dpi(8),
                left = dpi(8),
            },
            id = "systray",
            visible = false,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
            bg = beautiful.bg_systray,
            border_width = dpi(2),
            border_color = beautiful.bg_systray,
        },
        {
            {
                id = 'icon',
                widget = wibox.widget.textbox,
                markup = icons[2],
                align  = 'center',
                valign = 'center',
                font = 'Font Awesome 5 Brands 18'
            },
            left = dpi(4),
            top = dpi(4),
            bottom = dpi(4),
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal
	}

	

	local syswidget = widget:get_children_by_id('systray')[1]
	widget:get_children_by_id('icon')[1]:connect_signal("button::press", function(_, _, _, button)
        if (button == 1) then			
            syswidget.visible = not syswidget.visible
			widget:get_children_by_id('icon')[1].markup = icons[syswidget.visible and 1 or 2]
        end
    end)

	return widget
end

return systray