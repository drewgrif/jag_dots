-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/theme.lua")

--!Run autostart.sh
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- This is used later as the default terminal and editor to run.
terminal = "tilix"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   -- awful.layout.suit.floating,
   -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- awful.layout.suit.max,
   --  awful.layout.suit.max.fullscreen,
   -- awful.layout.suit.magnifier,
   --  awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
    mymainmenu = freedesktop.menu.build({
        before = { menu_awesome },
        after =  { menu_terminal }
    })
else
    mymainmenu = awful.menu({
        items = {
                  menu_awesome,
                  { "Debian", debian.menu.Debian_menu.Debian },
                  menu_terminal,
                }
    })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- Define custom colors
local label_color = "#d791a8"
local info_color = "#ffffff"

-- Create the date widget
local date_widget = wibox.widget.textclock("<span foreground='" .. label_color .. "'>  %a %b %-d </span>", 60)

-- Create the time widget
local time_widget = wibox.widget.textclock("<span foreground='" .. info_color .. "'>%l:%M %p  </span>", 1)

-- Combine the date and time widgets
local date_time_widget = wibox.widget {
	date_widget,
	time_widget,
	layout = wibox.layout.fixed.horizontal,
}

-- Distro and kernel
-- Function to get kernel version
local function get_kernel_version(callback)
    awful.spawn.easy_async_with_shell("uname -r", function(stdout)
        callback(stdout)
    end)
end

-- Create and update the kernel widget
local kernel_widget = wibox.widget.textbox()
get_kernel_version(function(kernel)
    kernel_widget:set_markup(string.format("<span foreground='%s'>  Debian</span> <span foreground='%s'>%s</span>", label_color, info_color, kernel))
end) 

-- Create CPU widget
local cpu_widget = wibox.widget.textbox()

-- Register the widget with Vicious
vicious.register(cpu_widget, vicious.widgets.cpu, function (widget, args)
	return string.format("<span foreground='%s'> CPU:</span> <span foreground='%s'>%d%%</span>", label_color, info_color, args[1]) end, 2) --Updates every 2 seconds

-- Create Memory widget
local mem_widget = wibox.widget.textbox()

-- Register the widget with Vicious
vicious.register(mem_widget, vicious.widgets.mem, function (widget, args)
	return string.format("<span foreground='%s'> RAM:</span> <span foreground='%s'>%d%%</span>", label_color, info_color, args[1]) end, 15) --Updates every 15 seconds
	
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

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
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" }, s, awful.layout.layouts[1])

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
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        layout = {
			spacing = 12,
			layout = wibox.layout.fixed.horizontal
        },
        buttons = taglist_buttons
    }

local function only_focused_clients(c, screen)
	return c == client.focus
end

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = only_focused_clients,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
          --  mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
         --   mykeyboardlayout,
                        cpu_widget,
            mem_widget,
           -- kernel_widget,
            date_time_widget,
            s.mylayoutbox,
            wibox.widget.systray(),
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "h",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    -- awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
    --          {description = "view previous", group = "tag"}),
  --  awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
  --            {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
   -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
   --           {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "Left", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "Right", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    --awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
     --         {description = "focus the next screen", group = "screen"}),
    --awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    --          {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,  "Control"  }, "Right",     function () awful.tag.incmwfact( 0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,  "Control"  }, "Left",     function () awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey,  "Control"  }, "Down",     function () awful.client.incwfact( 0.05) end,
              {description = "increase client height", group = "layout"}),
    awful.key({ modkey,  "Control"  }, "Up",     function () awful.client.incwfact(-0.05)  end,
              {description = "decrease client height", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "Tab", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),       
    awful.key({ modkey, "Shift"   }, "Tab", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),
              
-- start application keybinds
   
awful.key({ modkey }, "b",     function () awful.util.spawn("firefox-esr") end,
              {description = "open firefox", group = "launcher"}),
              
awful.key({ modkey }, "f",     function () awful.util.spawn("thunar") end,
              {description = "open thunar", group = "launcher"}), 
              
awful.key({ modkey }, "d",     function () awful.util.spawn("Discord") end,
              {description = "open discord", group = "launcher"}),
              
awful.key({ modkey }, "o", function ()
    -- Switch to tag 9
    local tag = awful.screen.focused().tags[9]
    if tag then
        tag:view_only()
    end

    -- Launch OBS
    awful.util.spawn("obs")
end, {description = "open obs", group = "launcher"}),

              
awful.key({ modkey }, "e",     function () awful.util.spawn("geany") end,
              {description = "open geany", group = "launcher"}),  
              
awful.key({ modkey }, "space",     function () awful.util.spawn("rofi -show drun -modi drun -line-padding 4 -hide-scrollbar -show-icons") end,
              {description = "rofi menu", group = "launcher"}),
              
awful.key({ }, "Print",      function () awful.util.spawn("flameshot screen") end,
              {description = "screenshot", group = "launcher"}), 
              
awful.key({ modkey }, "Print",     function () awful.util.spawn("flameshot gui") end,
              {description = "select screenshot", group = "launcher"}), 
              
awful.key({ modkey }, "v", function()
	awful.util.spawn("st -c pulsemixer -e pulsemixer")
end,
{description = "change volume", group = "launcher"}), 
   
-- end application keybinds

    -- Prompt
   -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
  --            {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "r",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,  "Control"  }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,  		  }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Shift" }, "space",  
			function (c)
			    c.floating = not c.floating
				  if c.floating then
				    awful.placement.centered(c, {honor_workarea = true})
				  end
			end,	    
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)
-- Key bindings for tags 1 to 12
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
               -- View tag only.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
					if client.focus then
						local tag =  client.focus.screen.tags[i]
                        if tag then
							client.focus:move_to_tag(tag)
                           tag:view_only()
                        end
                     end
                  end,
                  {description = "move focused client to tag #"..i.." + follow", group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

-- Explicit keybindings for tags 10, 11, and 12
globalkeys = gears.table.join(globalkeys,
    awful.key({ modkey }, "0",
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[10]
            if tag then
                tag:view_only()
            end
        end,
        {description = "view tag #10", group = "tag"}),
    awful.key({ modkey }, "-",
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[11]
            if tag then
                tag:view_only()
            end
        end,
        {description = "view tag #11", group = "tag"}),
    awful.key({ modkey }, "=",
        function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[12]
            if tag then
                tag:view_only()
            end
        end,
        {description = "view tag #12", group = "tag"}),
        
    awful.key({ modkey, "Control" }, "0",
        function ()
        	if client.focus then
				local tag =  client.focus.screen.tags[10]
                if tag then
					client.focus:move_to_tag(tag)
                    tag:view_only()
                 end
            end
        end,
        {description = "move focused client to tag #10 + follow", group = "tag"}),
   awful.key({ modkey, "Control" }, "-",
        function ()
        	if client.focus then
				local tag =  client.focus.screen.tags[11]
                if tag then
					client.focus:move_to_tag(tag)
                    tag:view_only()
                 end
            end
        end,
        {description = "move focused client to tag #11 + follow", group = "tag"}),
   awful.key({ modkey, "Control" }, "=",
        function ()
        	if client.focus then
				local tag =  client.focus.screen.tags[12]
                if tag then
					client.focus:move_to_tag(tag)
                    tag:view_only()
                 end
            end
        end,
        {description = "move focused client to tag #12 + follow", group = "tag"}),     
   
    awful.key({ modkey, "Shift" }, "0",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[10]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        {description = "move focused client to tag #10", group = "tag"}),
    awful.key({ modkey, "Shift" }, "-",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[11]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        {description = "move focused client to tag #11", group = "tag"}),
    awful.key({ modkey, "Shift" }, "=",
        function ()
            if client.focus then
                local tag = client.focus.screen.tags[12]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
        {description = "move focused client to tag #12", group = "tag"})
)

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
-- local pulsemixer_rule = {instance = "pulsemixer"}
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.centered + awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "qimgv",
          "mpv",
          "st",
          "pulsemixer",
          "Galculator",
          "Lxappearance",
          "Pavucontrol",
          "Terminator"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false --[[default = true]] }
    },

    -- Set Gimp to always map on the tag named "7" on screen 1.
    { rule = { class = "Gimp" },
    properties = { screen = 1, tag = "7" } },
    
        -- Set discord to always map on the tag named "8" on screen 1.
    { rule = { class = "discord" },
    properties = { screen = 1, tag = "8" } },
    
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
