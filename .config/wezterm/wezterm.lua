local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- General appearance and visuals
config.window_background_opacity = 0.95
config.font_size = 18
config.line_height = 1.1
config.font = wezterm.font('SauceCodePro Nerd Font Mono', { weight = 'Regular', italic = false })

-- Colors
config.color_scheme = 'UnderTheSea'

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
}

config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 500

-- Terminal emulation (no SSH check needed if you want to just always use wezterm)
config.term = "xterm-256color"

config.max_fps = 144
config.animation_fps = 30

-- Tab bar color matching your DWM colors
config.colors = {
  tab_bar = {
    background = "#00141d",  -- col_gray1

    active_tab = {
      bg_color = "#80bfff",  -- col_gray2 (bright blue tab)
      fg_color = "#00141d",  -- dark text on active tab
    },

    inactive_tab = {
      bg_color = "#1a1a1a",  -- col_gray4
      fg_color = "#FFFFFF",  -- col_gray3
    },

    new_tab = {
      bg_color = "#1a1a1a",
      fg_color = "#4fc3f7",  -- col_barbie (for the "+" button)
    },
  },
}

-- Keybindings using ALT for tabs & splits
config.keys = {
  -- Tab management
  { key = "t", mods = "ALT", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
  { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab { confirm = false } },
  { key = "Tab", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
  { key = "Tab", mods = "ALT|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

  -- Pane management
  { key = "v", mods = "ALT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
  { key = "h", mods = "ALT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
  { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentPane { confirm = false } },

  -- Pane navigation (move between panes with ALT + Arrows)
  { key = "LeftArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection "Left" },
  { key = "RightArrow", mods = "ALT", action = wezterm.action.ActivatePaneDirection "Right" },
  { key = "UpArrow",    mods = "ALT", action = wezterm.action.ActivatePaneDirection "Up" },
  { key = "DownArrow",  mods = "ALT", action = wezterm.action.ActivatePaneDirection "Down" },
}

-- Mouse bindings for quick actions
config.mouse_bindings = {
  -- Right-click to copy selection
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = wezterm.action.CopyTo("Clipboard"),
  },
  -- Middle-click to split horizontally
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "NONE",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- Shift+Middle-click to close the split (pane)
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}



return config
