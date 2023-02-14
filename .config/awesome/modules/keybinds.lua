local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
local media = require("modules.volume")
local configuration = config

--[[====================================================
    Group: tag (Tag/Workspace Navigation)
====================================================]]--
local navigation = gears.table.join(
    awful.key({modkey}, "Escape", awful.tag.history.restore, {
        description = "go back",
        group = "tag"
    })
)

--[[====================================================
    Group: media (Media Keys)
====================================================]]--
local media = gears.table.join(
    -- Volume Keys
    awful.key({}, "XF86AudioLowerVolume", function ()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +2%", false) 
    end),

    awful.key({}, "XF86AudioRaiseVolume", function ()
        awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -2%", false) 
    end),

    -- awful.key({}, "XF86AudioMute", function ()
    --     awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) 
    -- end),

    -- Media Keys
    awful.key({}, "XF86AudioPlay", function()
        awful.util.spawn("playerctl play-pause", false) 
    end),

    awful.key({}, "XF86AudioNext", function()
        awful.util.spawn("playerctl next", false) 
    end),

    awful.key({}, "XF86AudioPrev", function()
        awful.util.spawn("playerctl previous", false) 
    end),


    awful.key({}, "XF86AudioMute", media.MicrophoneToggle),
    
    awful.key({}, "XF86AudioMicMute", media.MicrophoneToggle)
)

--[[====================================================
    Group: Screen (Layout Manipulation)
====================================================]]--
local screen = gears.table.join(
    awful.key({modkey}, "Right", function()
        awful.screen.focus_relative(1)
    end, {
        description = "focus the next screen",
        group = "screen"
    }),

    awful.key({modkey}, "Left", function()
        awful.screen.focus_relative(-1)
    end, {
        description = "focus the previous screen",
        group = "screen"
    }),

    awful.key({modkey}, "u", awful.client.urgent.jumpto, {
        description = "jump to urgent client",
        group = "client"
    }),
    
    awful.key({modkey}, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, {
        description = "go back",
        group = "client"
    })
)

--[[====================================================
    Group: Layout
====================================================]]--
local layout = gears.table.join(

    awful.key({modkey}, "w", function()
            awful.layout.set(awful.layout.suit.max)
        end, {
        description = "max layout",
        group = "layout"
    }),

    awful.key({modkey}, "e", function()
            awful.layout.set(awful.layout.suit.tile)
        end, {
        description = "max layout",
        group = "layout"
    }),


    awful.key({modkey}, "k", function()
            awful.tag.incmwfact(0.05)
        end, {
        description = "increase master width factor",
        group = "layout"
    }), 

    awful.key({modkey}, "j", function()
            awful.tag.incmwfact(-0.05)
        end, {
        description = "decrease master width factor",
        group = "layout"
    }),

    awful.key({modkey, "Shift"}, "]", function()
            awful.tag.incnmaster(1, nil, true)
        end, {
        description = "increase the number of master clients",
        group = "layout"
    }), 

    awful.key({modkey, "Shift"}, "[", function()
            awful.tag.incnmaster(-1, nil, true)
        end, {
        description = "decrease the number of master clients",
        group = "layout"
    }), 

    awful.key({modkey}, "]", function()
        awful.tag.incncol(1, nil, true)
    end, {
        description = "increase the number of columns",
        group = "layout"
    }),

    awful.key({modkey}, "[", function()
            awful.tag.incncol(-1, nil, true)
        end, {
        description = "decrease the number of columns",
        group = "layout"
    }),

    awful.key({modkey, "Control"}, "Right", function()
            awful.client.focus.byidx(1)
        end, {
        description = "select next",
        group = "layout"
    }),

    awful.key({modkey, "Control"}, "Left", function()
            awful.client.focus.byidx(-1)
        end, {
        description = "select previous",
        group = "layout"
    })
)

--[[====================================================
    Group: Launchers
====================================================]]--
local launchers = gears.table.join(
    awful.key({modkey}, "Return", function()
            awful.spawn(configuration.terminal)
        end, {
        description = "open a terminal",
        group = "launcher"
    }),

    awful.key({modkey}, "b", function()
            awful.spawn(configuration.browser)
        end, {
        description = "open browser",
        group = "launcher"
    }),

    awful.key({modkey, 'Shift'}, "b", function()
            awful.spawn(configuration.browser)
        end, {
        description = "open browser",
        group = "launcher"
    }),

    awful.key({modkey}, "space", function()
            awful.spawn.with_shell(configuration.launcher)
        end, {
        description = "run rofi",
        group = "launcher"
    }),

    awful.key({"Control"}, "Print", function()
            awful.spawn(configuration.screenshot)
        end, {
        description = "screenshot",
        group = "launcher"
    }),

    awful.key({"Mod4"}, "l", function()
            awful.spawn(configuration.lock)
        end, {
        description = "lock pc",
        group = "launcher"
    }),

    awful.key({modkey}, "p", function()
            awful.spawn("bwmenu -- -theme ~/.config/rofi/launchers/text/style_3")
        end, {
        description = "open bitwarden context menu",
        group = "launcher"
    }),

    awful.key({modkey, "Shift"}, "p", function()
            awful.spawn("bitwarden-desktop")
        end, {
        description = "open bitwarden desktop",
        group = "launcher"
    })
)

--[[====================================================
    Group: Awesome
====================================================]]--
local awesome = gears.table.join(
    awful.key({modkey}, "s", hotkeys_popup.show_help, {
        description = "show help",
        group = "awesome"
    }),

    awful.key({modkey}, "h", function()
        mymainmenu:show()
    end, {
        description = "show main menu",
        group = "awesome"
    }),

    awful.key({modkey, "Shift"}, "r", awesome.restart, {
        description = "reload awesome",
        group = "awesome"
    }),

    awful.key({modkey, "Shift"}, "e", awesome.quit, {
        description = "quit awesome",
        group = "awesome"
    })
)

--[[====================================================
    Group: Client
====================================================]]--
local client = gears.table.join(
    awful.key({modkey}, "f", function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {
        description = "toggle fullscreen",
        group = "client"
    }),

    awful.key({modkey, "Control"}, "n", function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {
                    raise = true
                })
            end
        end, {
        description = "restore minimized",
        group = "client"
    }),


    awful.key({modkey}, "n", function(c)
            c.minimized = true
        end, {
        description = "minimize",
        group = "client"
    }), 

    awful.key({modkey}, "q", function(c)
            c:kill()
        end, {
        description = "close",
        group = "client"
    }), 

    awful.key({modkey, "Shift"}, "space", awful.client.floating.toggle, {
        description = "toggle floating",
        group = "client"
    }), 

    awful.key({modkey, "Control"}, "Return", function(c)
            c:swap(awful.client.getmaster())
        end, {
        description = "move to master",
        group = "client"
    }), 

    awful.key({modkey, "Shift"}, "Right", function(c)
            c:move_to_screen()
        end, {
        description = "move to screen",
        group = "client"
    }), 

    awful.key({modkey, "Shift"}, "Left", function(c)
            c:move_to_screen()
        end, {
        description = "move to screen",
        group = "client"
    }), 

    awful.key({modkey}, "t", function(c)
            c.ontop = not c.ontop
        end, {
        description = "toggle keep on top",
        group = "client"
    }), 


    awful.key({modkey}, "m", function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {
        description = "(un)maximize",
        group = "client"
    }), 

    awful.key({modkey, "Control"}, "m", function(c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end, {
        description = "(un)maximize vertically",
        group = "client"
    }), 

    awful.key({modkey, "Shift"}, "m", function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end, {
        description = "(un)maximize horizontally",
        group = "client"
    })
)

return {global = gears.table.join(navigation, media, screen, launchers, awesome, layout), client = client}
