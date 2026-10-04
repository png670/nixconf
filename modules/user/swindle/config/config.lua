sloppy_focus               = true
bypass_surface_visibility  = false
log_level                  = "silent"  -- "silent", "error", "info", "debug"

appearance = {
    outer_border_px    = 0,
    inner_border_px    = 0,
    gaps         = 8,
    smart_gaps   = false,

    root_color   = 0x3366a3ff,
    border_color = 0x00000000,
    focus_color  = 0x00000000,
    urgent_color = 0xff0000ff,
    fullscreen_bg = 0x000000ff,
}


-- Note: the entire input section requires you to restart
-- the compositor once changed

input = {
    repeat_rate             = 30,
    repeat_delay            = 225,
    tap_to_click            = true,
    tap_and_drag            = true,
    drag_lock               = true,
    natural_scrolling       = false,
    disable_while_typing    = true,
    left_handed              = false,
    middle_button_emulation = false,
    scroll_method            = "2fg",
    click_method             = "button_areas",
    accel_profile            = "adaptive",
    accel_speed              = 0.0,
}

autostart = {
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_SESSION_TYPE XDG_CURRENT_DESKTOP",
    "swaybg -i @wallpaper@ &",
    "mako &",
    "waybar &",
}


rules = {
--   { app_id = "Gimp",    floating = true,  monitor = -1 },
--   { app_id = "firefox", tags = 1 << 8,    floating = false, monitor = -1 },
}

monitors = {
    { name = nil, mfact = 0.90, nmaster = 1, scale = 1,
      layout = "dwindle", x = -1, y = -1 },

    -- HiDPI laptop example:
    -- { name = "eDP-1", mfact = 0.5, nmaster = 1, scale = 2.0,
    --   layout = "dwindle", x = -1, y = -1 },
}

keybinds = {
    -- ===== Core Applications =====
    { mods = {"logo"},          key = "d", action = "spawn", args = {"sh", "-c", "rofi -show drun"} },
    { mods = {"logo", "shift"}, key = "d", action = "spawn", args = {"sh", "-c", "rofi -show run"} },

    { mods = {"logo"}, key = "Return", action = "spawn", args = {"foot"} },
    { mods = {"logo"}, key = "b",      action = "spawn", args = {"firefox"} },
    { mods = {"logo"}, key = "m",      action = "spawn", args = {"thunderbird"} },
    { mods = {"logo"}, key = "v",      action = "spawn", args = {"vesktop"} },

    -- ===== Terminal Applications =====
    { mods = {"logo", "shift"}, key = "w", action = "spawn", args = {"foot", "-e", "nmtui"} },
    { mods = {"logo"},          key = "n", action = "spawn", args = {"foot", "-e", "ranger"} },
    { mods = {"logo", "shift"}, key = "n", action = "spawn", args = {"foot", "-e", "rmpc"} },

    -- ===== Screenshot =====
    { mods = {"logo", "shift"}, key = "s", action = "spawn",
      args = {"sh", "-c", 'grim -g "$(slurp)" - | wl-copy -t image/png'} },

    -- ===== Notifications =====
    { mods = {"logo"}, key = "t", action = "spawn",
      args = {"sh", "-c", 'notify-send "$(date +%H:%M)"'} },

    -- ===== Audio Controls (wpctl) =====
    { mods = {}, key = "F10", action = "spawn", args = {"wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"} },
    { mods = {}, key = "F11", action = "spawn", args = {"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%-"} },
    { mods = {}, key = "F12", action = "spawn", args = {"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", "5%+"} },

    -- ===== Window Management (from your labwc config) =====
    { mods = {"logo"},          key = "q", action = "killclient" },
    { mods = {"logo", "shift"}, key = "q", action = "quit" },
    { mods = {"logo"},          key = "space",    action = "togglefloating" },
    { mods = {"logo"},          key = "f",        action = "togglefullscreen" },
    { mods = {"logo"},          key = "a",        action = "togglegaps" },
    { mods = {"logo"},          key = "h",        action = "focusdir", args = {"left"} },
    { mods = {"logo"},          key = "j",        action = "focusdir", args = {"down"} },
    { mods = {"logo"},          key = "k",        action = "focusdir", args = {"up"} },
    { mods = {"logo"},          key = "l",        action = "focusdir", args = {"right"} },
    { mods = {"logo", "shift"}, key = "H",        action = "swapdir",  args = {"left"} },
    { mods = {"logo", "shift"}, key = "J",        action = "swapdir",  args = {"down"} },
    { mods = {"logo", "shift"}, key = "K",        action = "swapdir",  args = {"up"} },
    { mods = {"logo", "shift"}, key = "L",        action = "swapdir",  args = {"right"} },
    { mods = {"logo"},          key = "Tab",      action = "view" },
    { mods = {"logo"},          key = "o",        action = "view",     args = {"all"} },
    { mods = {"logo"},          key = "comma",    action = "focusmon", args = {"left"} },
    { mods = {"logo"},          key = "period",   action = "focusmon", args = {"right"} },
    { mods = {"logo", "shift"}, key = "less",     action = "tagmon",   args = {"left"} },
    { mods = {"logo", "shift"}, key = "greater",  action = "tagmon",   args = {"right"} },
}

for i = 1, 9 do
    local key  = tostring(i)
    local mask = 1 << (i - 1)
    table.insert(keybinds, { mods = {"logo"},                    key = key, action = "view",      args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "ctrl"},            key = key, action = "toggleview", args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "shift"},           key = key, action = "tag",        args = {tostring(mask)} })
    table.insert(keybinds, { mods = {"logo", "ctrl", "shift"},   key = key, action = "toggletag",  args = {tostring(mask)} })
end

buttons = {
    { mods = {"logo"}, button = "left",   action = "moveresize",     args = {"move"} },
    { mods = {"logo"}, button = "middle", action = "togglefloating" },
    { mods = {"logo"}, button = "right",  action = "moveresize",     args = {"resize"} },
}
