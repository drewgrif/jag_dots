-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.window_background_opacity = 0.85  -- Adjust the value between 0 (fully transparent) and 1 (fully opaque)

-- For example, changing the color scheme:
config.color_scheme = 'UnderTheSea'

-- Changing the fontsize makes the windows launch in non-maximized mode.
config.font_size = 16
-- Font for terminal.
config.font = wezterm.font('SauceCodePro Nerd Font Mono', { weight = 'Regular', italic = false })
-- Font for the tabs
config.window_frame = {
 font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Bold' },
}

-- and finally, return the configuration to wezterm
return config
