
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Mod+p for a simple .desktop thing, probably not going to use
local vicious = require("vicious")


local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


local menu_conf = {}

menu_conf.init = function(
    theme_dir, terminal, editor, editor_cmd)

    beautiful.init(theme_dir)

    -- {{{ Menu
    -- Create a launcher widget and a main menu
    myawesomemenu = {
        { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
        { "manual", terminal .. " -e man awesome" },
        { "edit config", editor_cmd .. " " .. awesome.conffile },
        { "restart", awesome.restart },
        -- { "quit", function() awesome.quit() end },
    }
    
    mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                        { "open terminal", terminal }
                                    }
                            })
    
    mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                        menu = mymainmenu })


    local function set_wallpaper(s)
        -- Wallpaper
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            -- If wallpaper is a function, call it with the screen
            if type(wallpaper) == "function" then
                wallpaper = wallpaper(s)
            end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end
    
    -- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
    screen.connect_signal("property::geometry", set_wallpaper)
    
    awful.screen.connect_for_each_screen(function(s)
        -- Wallpaper
        set_wallpaper(s)
    
        -- Each screen has its own tag table.
        awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
    
        -- Create a promptbox for each screen
        s.mypromptbox = awful.widget.prompt()
        -- Create an imagebox widget which will contain an icon indicating which layout we're using.
        -- We need one layoutbox per screen.
        s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
                                awful.button({ }, 1, function () awful.layout.inc( 1) end),
                                awful.button({ }, 3, function () awful.layout.inc(-1) end),
                                awful.button({ }, 4, function () awful.layout.inc( 1) end),
                                awful.button({ }, 5, function () awful.layout.inc(-1) end)))
        -- Create a taglist widget

    
    end)
    -- }}}
end 

return menu_conf