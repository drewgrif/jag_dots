-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.window_background_opacity = 0.90  -- Adjust the value between 0 (fully transparent) and 1 (fully opaque)

-- config.front_end = "OpenGL"
config.enable_wayland = false
config.max_fps = 144
config.default_cursor_style = "BlinkingUnderline"
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color" -- Set the terminal type

-- For example, changing the color scheme:
config.color_scheme = 'nightfox'

config.use_fancy_tab_bar = true

-- Changing the fontsize makes the windows launch in non-maximized mode.
config.font_size = 16
-- Font for terminal.
config.font = wezterm.font('SauceCodePro Nerd Font Mono', { weight = 'Regular', italic = false })
-- Font for the tabs
config.window_frame = {
 font = wezterm.font { family = 'JetBrainsMono Nerd Font Mono', weight = 'Regular' },
}

-- and finally, return the configuration to wezterm
return config
