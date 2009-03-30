-- Include awesome libraries, with lots of useful function!
require("awful")
require("beautiful")
require("naughty")

-- Load revelation
-- require("revelation")
require("wicked")
require('invaders')

config_path = os.getenv("XDG_CONFIG_HOME") .. "/awesome/"
icons_path = config_path .. "icons/"
cache_path = os.getenv("HOME") .. "/.cache/awesome/"

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = config_path .. "themes/subtle_hacker"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
terminal = "urxvtcd"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating
}


-- Table of clients that should be set floating. The index may be either
-- the application class or instance. The instance is useful when running
-- a console app in a terminal like (Music on Console)
--    xterm -name mocp -e mocp
floatapps =
{
    -- by class
    ["MPlayer"] = true,
    ["pinentry"] = true,
    ["gimp"] = true,
    -- by instance
    ["mocp"] = true,
    ["ncmpc"] = true,
    ["alsamixer"] = true,
    ["Cssh"] = true
}

-- Applications to be moved to a pre-defined tag by class or instance.
-- Use the screen and tags indices.
apptags =
{
    ["Navigator"] = { screen = screen.count(), tag=2},
    ["Claws-mail"] = { screen = screen.count(), tag = 3},
    ["weechat"] = {screen = 1, tag = 4},
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false
-- }}}

-- {{{ Tags
-- Define tags table.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = {}
    -- Create 9 tags per screen.
    for tagnumber = 1, 9 do
        tags[s][tagnumber] = tag(tagnumber)
        -- Add tags to screen one by one
        tags[s][tagnumber].screen = s
	awful.layout.set(layouts[1], tags[s][tagnumber])
    end
    -- I'm sure you want to see at least one tag.
    tags[s][1].selected = true
end
-- }}}

-- {{{ Wibox
-- Create a textbox widget
mytextbox = widget({ type = "textbox", align = "right" })
-- Set the default text in textbox
mytextbox.text = "<b><small> " .. AWESOME_RELEASE .. " </small></b>"

-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu.new({ items = {
				  { "awesome", myawesomemenu, beautiful.awesome_icon },
				  { "open terminal", terminal }
			       }
                            })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Create a systray
mysystray = widget({ type = "systray", align = "right" })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = { button({ }, 1, awful.tag.viewonly),
                      button({ modkey }, 1, awful.client.movetotag),
                      button({ }, 3, function (tag) tag.selected = not tag.selected end),
                      button({ modkey }, 3, awful.client.toggletag),
                      button({ }, 4, awful.tag.viewnext),
                      button({ }, 5, awful.tag.viewprev) }
mytasklist = {}
mytasklist.buttons = { button({ }, 1, function (c) client.focus = c; c:raise() end),
                       button({ }, 3, function () awful.menu.clients({ width=250 }) end),
                       button({ }, 4, function () awful.client.focus.byidx(1) end),
                       button({ }, 5, function () awful.client.focus.byidx(-1) end) }

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = widget({ type = "textbox", align = "left" })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = widget({ type = "imagebox", align = "right" })
    mylayoutbox[s]:buttons({ button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                             button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                             button({ }, 5, function () awful.layout.inc(layouts, -1) end) })
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                                                  return awful.widget.tasklist.label.currenttags(c, s)
                                              end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = wibox({ position = "top", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = { mylauncher,
                           mytaglist[s],
                           mytasklist[s],
                           mypromptbox[s],
                           mytextbox,
                           mylayoutbox[s],
                           s == 1 and mysystray or nil }
    mywibox[s].screen = s
end
-- }}}

-- {{{ BottomWibox

---COMMAND {
  get_volume = 'aumix -q|grep vol|awk \'{print $3}\''  
  get_battery = 'acpi | cut -f 2 -d ,'
  get_temp = 'acpi -t | grep Thermal\\ 0: | awk \'{print $4}\''
  get_music = 'mpc | grep -v %'
---}
--function image_un(image) return "<bg image='"..image.."' resize=\"false\"/>" end
-- Setup Org mode for awesome
require("org-awesome")
projects_file = os.getenv("HOME") .. "/org/projects.org"
home_file = os.getenv("HOME") .. "/org/home.org"
work_file = os.getenv("HOME") .. "/org/work.org"
vnx_file = os.getenv("HOME") .. "/org/vnx.org"
stage_file = os.getenv("HOME") .. "/org/stage.org"


org_widget = widget({ type = "textbox", name = "org_widget", align = "left"})
org_widget:buttons({
                         button({ }, 1, function () awful.util.spawn("emacs " .. projects_file) end),
                         button({ }, 3, function () org.update() end)
                  })
org_widget.mouse_enter = function () org.naughty_open() end
org_widget.mouse_leave = function () org.naughty_close() end
org.register(
	     org_widget, 
	     {projects_file, home_file, vnx_file, stage_file, work_file},
	     {width = 500, show_basename = true, position = 'bottom_left'}
	  )
awful.hooks.timer.register(600, function() org.update() end)

--VOLUME WIDGET {
  voliconbox = widget({ type = "imagebox", name = "voliconbox", align = "right" })
  voliconbox.image = image(icons_path.."sound.png")
  voliconbox:buttons({
			button({ }, 4, function ()awful.util.spawn("aumix -v +1") end),
			button({ }, 5, function ()awful.util.spawn("aumix -v -1") end),
			button({ }, 1, function ()awful.util.spawn("mute") end)
		     })
  volumew = widget({type = 'progressbar', name = 'volumew', align = 'right'})
  volumew.width = 37
  volumew.height = 0.50
  volumew.border_padding = 0
  volumew.border_width = 0
  volumew.ticks_count = 10
  volumew.vertical = false
  volumew:bar_properties_set('vol', {bg ='#000000',fg ='#ffffff',bordercolor = '#041F34',fg_off = '#484848',min_value = 0,max_value = 100})
  wicked.register(volumew, 'function', function (widget, args)
   local f = io.popen(get_volume)
   local l = f:read()
   f:close()
   return l
  end, 4,'vol')
  volumew:buttons({
		     button({ }, 1, function ()awful.util.spawn(terminal ..  " -geometry \"-1-173\" -name ncmpc -e ncmpc") end),
		     button({ }, 3, function ()awful.util.spawn(terminal ..  " -geometry \"-1-173\" -name alsamixer -e alsamixer") end),
		     button({ }, 4, function ()awful.util.spawn("aumix -v +1") end),
		     button({ }, 5, function ()awful.util.spawn("aumix -v -1") end)
		  })
-------------------
-------ICONE-------
-------------------
-- PATH
iplay_icon = icons_path.."play.png"
istop_icon = icons_path.."stop.png"
inext_icon = icons_path.."suivant.png"
iprev_icon = icons_path.."precendent.png"
ipau_icon = icons_path.."pause.png"

--PLAY
iplay = widget({ type = "imagebox", name = "iplay", align = "right"}) iplay.image = image(iplay_icon)
iplay:buttons({button({ }, 1, function () awful.util.spawn("mpc toggle > /dev/null") end)})
--STOP
istop = widget({ type = "imagebox", name = "istop", align = "right"}) istop.image = image(istop_icon)
istop:buttons({button({ }, 1, function () awful.util.spawn("mpc stop > /dev/null") end)})
--PREVIOUS
iprev = widget({ type = "imagebox", name = "iprev", align = "right"}) iprev.image = image(iprev_icon)
iprev:buttons({button({ }, 1, function () awful.util.spawn("mpc prev > /dev/null") end)})
--NEXT
inext = widget({ type = "imagebox", name = "inext", align = "right"}) inext.image = image(inext_icon)
inext:buttons({button({ }, 1, function () awful.util.spawn("mpc next > /dev/null") end)})
--PAUSE
ipau = widget({ type = "imagebox", name = "ipau", align = "right"}) ipau.image = image(ipau_icon)
ipau:buttons({button({ }, 1, function () awful.util.spawn("mpc toggle > /dev/null") end)})

---NET WIDGET {
netwidget = widget({
		      type = 'textbox',
		      name = 'netwidget',
		   })

wicked.register(netwidget, 'net', 
		' <span color="white">eth0</span>: ${eth0 down} / ${eth0 up} [ ${eth0 rx} //  ${eth0 tx} ]')

---}


---BATTERY WIDGET {
  baticonbox = widget({ type = "imagebox", name = "baticonbox", align = "right" })
  baticonbox.image = image(icons_path.."bat.png")
  battextw = widget({type = "textbox",name = "battextw",align = "right"})
  wicked.register(battextw, 'function', function (widget,args)
    local f = io.popen(get_battery)
    local l = f:read()
    f:close()
    return l
  end, 10)
---}
 
---TEMP WIDGET {
  tempiconbox = widget({ type = "imagebox", name = "tempiconbox",align = "right" })
  tempiconbox.image = image(icons_path.."cpuc.png")
  tempw = widget({type = 'textbox',name = 'tempw',align = "right"})
  
  wicked.register(tempw, 'function', function (widget,args)
    local f = io.popen(get_temp)
    local l = f:read()
    f:close()
    return ' '..l..'°'
  end, 4)
 
---}
 
---MEM WIDGET {
memiconbox = widget({ type = "imagebox", name = "memiconbox", align = "right" })
memiconbox.image = image(icons_path .."mem.png") 
membarw = widget({type = 'progressbar', name = 'membarw', align = 'right'})
membarw.width = 30
membarw.height = 0.50
membarw.gap = 0
membarw.border_padding = 0
membarw.border_width = 1
membarw.ticks_count = 0
membarw.ticks_gap = 0
membarw:bar_properties_set('mem', {border_color = '#dddddd',fg = '#ffffff',reverse = false,min_value = 0,max_value = 100})
wicked.register(membarw, 'mem', '$1',10,'mem')
---}

---CPU WIDGET {
  cpuiconbox = widget({ type = "imagebox", name = "cpuiconbox", align = "right" })
  cpuiconbox.image = image(icons_path.."cpu2.png")
  cpugraphwidget = widget({type = 'graph',name = 'cpugraphwidget',align = 'right'  })
  cpugraphwidget.height = "0.8"
  cpugraphwidget.width = "30"
  cpugraphwidget.border_color = '#041f34'
  cpugraphwidget.grow = 'left'
  cpugraphwidget:plot_properties_set('cpu',{fg = '#ffffff'})
  wicked.register(cpugraphwidget, 'cpu', '$1', 1, 'cpu')
---}

---MPD WIDGET {
 mpdiconbox = widget({ type = "imagebox", name = "mpdiconbox", align = "right" })
 mpdiconbox.image = image(icons_path.."moc.png")
 mpdw = widget({type = 'textbox', name = 'mpdw', align = "right"  })
 wicked.register(mpdw, 'function',function (widget,args)
   local f = io.popen(get_music)
   local l = f:read()
   f:close()
   if l == nil then
     l = " "
   else
   return ' '..l
 end
end, 3)
---}


bar = widget({type="textbox",name="bar",align="right"}) bar.text = " - "
space = widget({type="textbox",name="space",align="right"}) space.text = " "

bwibox = wibox({ position = "bottom", fg = beautiful.fg_normal, bg = beautiful.bg_normal })
bwibox.widgets = { 
   org_widget, 
   netwidget,
   mpdiconbox,  
   mpdw,
   --
   bar,
   cpuiconbox,
   space,
   cpugraphwidget,
   space,
   memiconbox,
   space,
   membarw,
   space,
   tempiconbox,
   tempw,
   space,
   baticonbox,
   battextw,
   bar,
   --
   iprev,
   ipau,
   istop,
   iplay,
   inext,
   --
   space,
   volumew, 
   space, 
   voliconbox  
}
bwibox.screen = 1

-- }}}

-- {{{ Mouse bindings
root.buttons({
    button({ }, 3, function () mymainmenu:toggle() end),
    button({ }, 4, awful.tag.viewnext),
    button({ }, 5, awful.tag.viewprev)
})
-- }}}

-- {{{ Key bindings
globalkeys =
{
    key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    key({ modkey,           }, "Escape", awful.tag.history.restore),

    key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),
    key({ modkey, "Control" }, "j", function () awful.screen.focus( 1)       end),
    key({ modkey, "Control" }, "k", function () awful.screen.focus(-1)       end),
    key({ modkey,           }, "u", awful.client.urgent.jumpto),
    key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    key({ modkey, "Control" }, "r", awesome.restart),
    key({ modkey, "Shift"   }, "q", awesome.quit),

    key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Prompt
    key({ modkey }, "F1",
        function ()
            awful.prompt.run({ prompt = "Run: " },
            mypromptbox[mouse.screen],
            awful.util.spawn, awful.completion.bash,
            awful.util.getdir("cache") .. "/history")
        end),

    key({ modkey }, "F4",
        function ()
            awful.prompt.run({ prompt = "Run Lua code: " },
            mypromptbox[mouse.screen],
            awful.util.eval, awful.prompt.bash,
            awful.util.getdir("cache") .. "/history_eval")
        end),
}

clientkeys =
{
    key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    key({ modkey }, "t", awful.client.togglemarked),
    key({ modkey,}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
}


-- Bind keyboard digits
-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end
tags_key = { "ampersand", "eacute","quotedbl","apostrophe","parenleft", "minus","egrave","underscore","ccedilla" }

for i, v in ipairs( tags_key ) do
    table.insert(globalkeys, key({ modkey }, v,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           awful.tag.viewonly(tags[screen][i])
                       end
		    end))
    table.insert(globalkeys, key({ modkey, "Control" }, v,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           tags[screen][i].selected = not tags[screen][i].selected
                       end
		    end))
    table.insert(globalkeys, key({ modkey, "Shift" }, v,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.movetotag(tags[client.focus.screen][i])
                           end
                       end
		    end))
    table.insert(globalkeys, key({ modkey, "Control", "Shift" }, v,
                   function ()
                       if client.focus then
                           if tags[client.focus.screen][i] then
                               awful.client.toggletag(tags[client.focus.screen][i])
                           end
                       end
		    end))
end

for i = 1, keynumber do
   table.insert(globalkeys, key({ modkey, "Shift" }, "F" .. i,
                   function ()
                       local screen = mouse.screen
                       if tags[screen][i] then
                           for k, c in pairs(awful.client.getmarked()) do
                               awful.client.movetotag(tags[screen][i], c)
                           end
                       end
                   end))
end
-- }}}

-- Set keys
root.keys(globalkeys)
-- }}}


-- {{{ Hooks
-- Hook function to execute when focusing a client.
awful.hooks.focus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
awful.hooks.unfocus.register(function (c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)

-- Hook function to execute when marking a client
awful.hooks.marked.register(function (c)
    c.border_color = beautiful.border_marked
end)

-- Hook function to execute when unmarking a client.
awful.hooks.unmarked.register(function (c)
    c.border_color = beautiful.border_focus
end)

-- Hook function to execute when the mouse enters a client.
awful.hooks.mouse_enter.register(function (c)
    -- Sloppy focus, but disabled for magnifier layout
    if awful.layout.get(c.screen) ~= "magnifier"
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

-- Hook function to execute when a new client appears.
awful.hooks.manage.register(function (c)
    -- If we are not managing this application at startup,
    -- move it to the screen where the mouse is.
    -- We only do it for filtered windows (i.e. no dock, etc).
    if not startup and awful.client.focus.filter(c) then
        c.screen = mouse.screen
    end

    if use_titlebar then
        -- Add a titlebar
        awful.titlebar.add(c, { modkey = modkey })
    end
    -- Add mouse bindings
    c:buttons({
        button({ }, 1, function (c) client.focus = c; c:raise() end),
        button({ modkey }, 1, awful.mouse.client.move),
        button({ modkey }, 3, awful.mouse.client.resize)
    })
    -- New client may not receive focus
    -- if they're not focusable, so set border anyway.
    c.border_width = beautiful.border_width
    c.border_color = beautiful.border_normal

    -- Check if the application should be floating.
    local cls = c.class
    local inst = c.instance
    if floatapps[cls] then
        awful.client.floating.set(c, floatapps[cls])
    elseif floatapps[inst] then
        awful.client.floating.set(c, floatapps[inst])
    end

    -- Check application->screen/tag mappings.
    local target
    if apptags[cls] then
        target = apptags[cls]
    elseif apptags[inst] then
        target = apptags[inst]
    end
    if target then
        c.screen = target.screen
        awful.client.movetotag(tags[target.screen][target.tag], c)
    end

    -- Do this after tag mapping, so you don't see it on the wrong tag for a split second.
    client.focus = c

    -- Set key bindings
    c:keys(clientkeys)

    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- awful.client.setslave(c)

    -- Honor size hints: if you want to drop the gaps between windows, set this to false.
    -- c.size_hints_honor = false
end)

-- Hook function to execute when arranging the screen.
-- (tag switch, new client, etc)
awful.hooks.arrange.register(function (screen)
    local layout = awful.layout.getname(awful.layout.get(screen))
    if layout then
        mylayoutbox[screen].image = image(beautiful["layout_" .. layout])
    else
        mylayoutbox[screen].image = nil
    end

    -- Give focus to the latest client in history if no window has focus
    -- or if the current window is a desktop or a dock one.
    if not client.focus then
        local c = awful.client.focus.history.get(screen, 0)
        if c then client.focus = c end
    end

    -- Uncomment if you want mouse warping
    --[[
    if client.focus then
        local c_c = client.focus:fullgeometry()
        local m_c = mouse.coords()

        if m_c.x < c_c.x or m_c.x >= c_c.x + c_c.width or
            m_c.y < c_c.y or m_c.y >= c_c.y + c_c.height then
            if table.maxn(m_c.buttons) == 0 then
                mouse.coords({ x = c_c.x + 5, y = c_c.y + 5})
            end
        end
    end
    ]]
end)

-- Hook called every second
awful.hooks.timer.register(1, function ()
    -- For unix time_t lovers
    -- mytextbox.text = " " .. os.time() .. " time_t "
    -- Otherwise use:
    mytextbox.text = " " .. os.date() .. " "
end)

-- }}}
