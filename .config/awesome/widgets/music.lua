local wibox = require("wibox")  -- Provides the widgets
local awful = require("awful")
local watch = require("awful.widget.watch")
local naughty = require("naughty")
local beautiful = require("beautiful")

local paused_cmd = [[playerctl -p cider2 status]]
local song_cmd = [[playerctl -p cider2 metadata title]]
local artist_cmd = [[playerctl -p cider2 metadata artist]]


local music_widget = {}
local function worker(args)
	music_widget = wibox.widget {
		{
			widget = wibox.container.margin,
			left = 5,
			top = 0,
            bottom = 4,
			{
				layout = wibox.layout.fixed.horizontal,
                {
                    widget = wibox.container.margin,
                    top = 4,                    
                    {
                        id = 'icon',
                        widget = wibox.widget.textbox,
                        markup = string.format('<span color="%s">  </span> ', beautiful.fg_accent),
                        align  = 'center',
                        valign = 'center',
                        font = 'Font Awesome 5 Brands 12'
                    },
                },
				{
					id = 'artist',
					widget = wibox.widget.textbox
				},
				{
					layout = wibox.container.scroll.horizontal,
					max_size = 150,
					step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
					speed = 40,
					{
						id = 'song_name',
						widget = wibox.widget.textbox
					}
				},
				{
					id = 'end_bracket',
					widget = wibox.widget.textbox,
					markup = string.format('<span color="%s"> ] </span>', beautiful.fg_accent)
				},
			}
		},
		layout = wibox.layout.fixed.horizontal,
		set_song = function(self, song)
			self:get_children_by_id('song_name')[1]:set_text(' ' .. song:gsub('\n', '') .. ' ')
		end,
		set_artist = function(self, artist)
            -- if string.find(artist, '&')
			self:get_children_by_id('artist')[1]:set_markup('<span color="#5865F2">' .. artist:gsub('\n', ''):gsub('&', 'and') .. ' [ </span>')
		end,
		set_paused = function(self, is_paused)
			is_paused = is_paused:gsub('\n', '')
			if is_paused ~= "Playing" then
				self:set_visible(false)
			else
				self:set_visible(true)
			end
		end,
	}

	watch(song_cmd, 1, function(widget, song)
		widget:set_song(song)
	end, music_widget)

	watch(artist_cmd, 1, function(widget, artist)
		widget:set_artist(artist)
	end, music_widget)

	watch(paused_cmd, 1, function(widget, is_paused)
		widget:set_paused(is_paused)
	end, music_widget)

	return music_widget
end


return worker(...)

