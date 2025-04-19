-- ~/.config/wezterm/wezterm.lua
-- Optimized WezTerm configuration for better performance
local wezterm = require "wezterm"
local act = wezterm.action

-- GitHub Dark inspired color palette (streamlined)
local colors = {
  fg = "#d0d7de",
  bg = "#0d1117",
  comment = "#8b949e",
  red = "#ff7b72",
  green = "#3fb950",
  yellow = "#d29922",
  blue = "#539bf5",
  magenta = "#bc8cff",
  cyan = "#39c5cf",
  selection = "#415555",
  caret = "#58a6ff",
  invisibles = "#2f363d",
}

-- Efficient keybinding helper function
local function key_binding(key_table)
  local result = {}
  for i, binding in ipairs(key_table) do
    table.insert(result, {
      mods = binding[1] or "ALT",
      key = binding[2],
      action = binding[3]
    })
  end
  return result
end

local config = wezterm.config_builder()

-- Key bindings configuration
config.keys = key_binding({
  -- Split and manage panes
  {"ALT", "`", act.SplitPane { direction = "Right", size = { Percent = 30 }}},
  {"ALT", "Tab", act.SplitPane { direction = "Down", size = { Percent = 30 }}},
  {"ALT", "Enter", act.SplitHorizontal { domain = 'CurrentPaneDomain' }},
  {"ALT", "\\", act.SplitVertical { domain = 'CurrentPaneDomain' }},
  {"ALT", "w", act.CloseCurrentPane { confirm = true }},
  {"ALT", "LeftArrow", act.ActivatePaneDirection 'Left'},
  {"ALT", "RightArrow", act.ActivatePaneDirection 'Right'},
  {"ALT", "UpArrow", act.ActivatePaneDirection 'Up'},
  {"ALT", "DownArrow", act.ActivatePaneDirection 'Down'},
  
  -- Tab creation, navigation and management
  {"ALT", "t", act.SpawnTab 'CurrentPaneDomain'},
  {"ALT", "q", act.CloseCurrentTab { confirm = true }},
  {"ALT", "1", act.ActivateTab(0)},
  {"ALT", "2", act.ActivateTab(1)},
  {"ALT", "3", act.ActivateTab(2)},
  {"ALT", "4", act.ActivateTab(3)},
  {"ALT", "5", act.ActivateTab(4)},
  {"ALT", "6", act.ActivateTab(5)},
  {"ALT", "7", act.ActivateTab(6)},
  {"ALT", "8", act.ActivateTab(7)},
  {"CTRL|ALT", "UpArrow", act.ActivateLastTab},
  {"CTRL|ALT", "DownArrow", act.ActivateLastTab},
  {"CTRL|ALT", "1", act.MoveTab(0)},
  {"CTRL|ALT", "2", act.MoveTab(1)},
  {"CTRL|ALT", "3", act.MoveTab(2)},
  {"CTRL|ALT", "4", act.MoveTab(3)},
  {"CTRL|ALT", "5", act.MoveTab(4)},
  {"CTRL|ALT", "6", act.MoveTab(5)},
  {"CTRL|ALT", "7", act.MoveTab(6)},
  {"CTRL|ALT", "8", act.MoveTab(7)},
  {"CTRL|ALT", "LeftArrow", act.MoveTabRelative(-1)},
  {"CTRL|ALT", "RightArrow", act.MoveTabRelative(1)},
  
  -- Copy and paste operations
  {"ALT", "c", act.CopyTo 'ClipboardAndPrimarySelection'},
  {"ALT", "v", act.PasteFrom 'PrimarySelection'},
  {"ALT", "v", act.PasteFrom 'Clipboard'},
  
  -- Font size adjustments
  {"ALT", "+", act.IncreaseFontSize},
  {"ALT", "-", act.DecreaseFontSize},
  {"ALT", "*", act.ResetFontSize},
})

-- Font configuration with minimal fallbacks for better performance
config.font = wezterm.font_with_fallback({
  { family = 'SauceCodePro Nerd Font Mono', weight = 'Regular' },
  { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
  { family = 'Symbols Nerd Font Mono', weight = 'Regular' },
})

-- Tab bar with FiraCode font
config.window_frame = {
  font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
  font_size = 12.0,
  active_titlebar_bg = colors.bg,
}

-- Performance optimizations
config.max_fps = 120
config.animation_fps = 1
config.line_height = 1.1
config.window_background_opacity = 0.95
config.enable_scroll_bar = false
config.use_fancy_tab_bar = true
config.font_size = 16
config.term = "xterm-256color"
config.warn_about_missing_glyphs = false

-- GitHub Dark inspired color scheme application
config.colors = {
  foreground = colors.fg,
  background = colors.bg,
  cursor_bg = colors.caret,
  cursor_fg = colors.bg,
  cursor_border = colors.caret,
  selection_fg = colors.fg,
  selection_bg = colors.selection,
  scrollbar_thumb = colors.invisibles,
  split = colors.invisibles,
  
  -- ANSI colors
  ansi = {
    colors.invisibles, colors.red, colors.green, colors.yellow,
    colors.blue, colors.magenta, colors.cyan, colors.fg,
  },
  -- Bright ANSI colors
  brights = {
    colors.comment, "#ff9790", "#6af28c", "#e3b341",
    "#79c0ff", "#d2a8ff", "#56d4dd", "#ffffff",
  },
  
  -- Tab bar styling
  tab_bar = {
    background = colors.bg,
    active_tab = { bg_color = colors.blue, fg_color = colors.bg, intensity = "Bold" },
    inactive_tab = { bg_color = colors.bg, fg_color = colors.comment },
    inactive_tab_hover = { bg_color = "#21262d", fg_color = colors.caret },
    new_tab = { bg_color = colors.bg, fg_color = colors.caret, intensity = "Bold" },
    new_tab_hover = { bg_color = "#21262d", fg_color = colors.red },
    inactive_tab_edge = colors.invisibles,
  },
}

-- Mouse interaction bindings
config.mouse_bindings = {
  -- Right-click to copy selection
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act.CopyTo("Clipboard"),
  },
  -- Middle-click to split horizontally
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "NONE",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- Shift+Middle-click to close pane
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "SHIFT",
    action = act.CloseCurrentPane { confirm = false },
  },
}

-- Uncomment for nvidia issues with wayland
-- Laggy/extra characters
-- 
-- -- function for nvidia_gpu
-- local function is_nvidia_gpu()
--   local handle = io.popen("lspci | grep -i nvidia")
--   local result = handle:read("*a")
--   handle:close()
--   return result ~= ""
-- end
-- 
-- -- NVIDIA optimization settings
-- config.enable_wayland = not is_nvidia_gpu() -- Disable Wayland if NVIDIA GPU is detected
-- config.front_end = "OpenGL"  -- More stable than WebGPU with NVIDIA
-- config.webgpu_power_preference = "HighPerformance"
-- config.prefer_egl = true
-- config.freetype_load_target = "Light"
-- config.freetype_render_target = "HorizontalLcd"

return config
