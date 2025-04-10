-- ~/.wezterm.lua
local wezterm = require "wezterm"
local act = wezterm.action

--------------------------------------------------------------------------------
-- 1) Define the GitHub Dark palette
--------------------------------------------------------------------------------
local gh = {
  gh_fg         = "#d0d7de",
  gh_bg         = "#0d1117",
  gh_comment    = "#8b949e",
  gh_red        = "#ff7b72",
  gh_green      = "#3fb950",
  gh_yellow     = "#d29922",
  gh_blue       = "#539bf5",
  gh_magenta    = "#bc8cff",
  gh_cyan       = "#39c5cf",
  gh_selection  = "#415555",
  gh_highlight  = "#4DFFDA",
  gh_caret      = "#58a6ff",
  gh_invisibles = "#2f363d",
}

--------------------------------------------------------------------------------
-- 2) Tab bar styling that matches GitHub Dark
--------------------------------------------------------------------------------
local tab_bar = {
  background = gh.gh_bg,

  active_tab = {
    bg_color = "#161b22",
    fg_color = gh.gh_fg,
    intensity = "Bold",
  },

  inactive_tab = {
    bg_color = gh.gh_bg,
    fg_color = gh.gh_comment,
  },

  inactive_tab_hover = {
    bg_color = "#21262d",
    fg_color = gh.gh_caret,
  },

  new_tab = {
    bg_color = gh.gh_bg,
    fg_color = gh.gh_caret,
    intensity = "Bold",
  },

  new_tab_hover = {
    bg_color = "#21262d",
    fg_color = gh.gh_red,  -- accent color on hover
  },

  -- The angled "edge" between tabs
  inactive_tab_edge = gh.gh_invisibles,
}

--------------------------------------------------------------------------------
-- 3) Define your custom keybinding snippet
--------------------------------------------------------------------------------
local define_binding = function(define_key, define_action)
  return {
    mods = "ALT",
    key = define_key,
    action = define_action
  }
end

local define_binding_with_mod = function(define_mod, define_key, define_action)
  return {
    mods = define_mod,
    key = define_key,
    action = define_action
  }
end

local binds = {

  ------------------------------------------
  -- Panes
  ------------------------------------------

  -- Split Panes
  define_binding("`", act.SplitPane {
    direction = "Right",
    size = { Percent = 30 },
  }),
  define_binding("Tab", act.SplitPane {
    direction = "Down",
    size = { Percent = 30 },
  }),
  define_binding("Enter", act.SplitHorizontal { domain = 'CurrentPaneDomain' }),
  define_binding("\\", act.SplitVertical { domain = 'CurrentPaneDomain' }),
  define_binding("w", act.CloseCurrentPane { confirm = true }),

  -- Focus on pane by direction
  define_binding("LeftArrow", act.ActivatePaneDirection 'Left'),
  define_binding("RightArrow", act.ActivatePaneDirection 'Right'),
  define_binding("UpArrow", act.ActivatePaneDirection 'Up'),
  define_binding("DownArrow", act.ActivatePaneDirection 'Down'),

  -----------------------------------------
  -- Tabs
  -----------------------------------------
  define_binding("t", act.SpawnTab 'CurrentPaneDomain'),
  define_binding("q", act.CloseCurrentTab { confirm = true }),

  -- Focus on Tabs by index
  define_binding("1", act.ActivateTab(0)),
  define_binding("2", act.ActivateTab(1)),
  define_binding("3", act.ActivateTab(2)),
  define_binding("4", act.ActivateTab(3)),
  define_binding("5", act.ActivateTab(4)),
  define_binding("6", act.ActivateTab(5)),
  define_binding("7", act.ActivateTab(6)),
  define_binding("8", act.ActivateTab(7)),

  -- Activate last tab
  define_binding_with_mod("CTRL|ALT", "UpArrow", act.ActivateLastTab),
  define_binding_with_mod("CTRL|ALT", "DownArrow", act.ActivateLastTab),

  -- Move tab to index
  define_binding_with_mod("CTRL|ALT", "1", act.MoveTab(0)),
  define_binding_with_mod("CTRL|ALT", "2", act.MoveTab(1)),
  define_binding_with_mod("CTRL|ALT", "3", act.MoveTab(2)),
  define_binding_with_mod("CTRL|ALT", "4", act.MoveTab(3)),
  define_binding_with_mod("CTRL|ALT", "5", act.MoveTab(4)),
  define_binding_with_mod("CTRL|ALT", "6", act.MoveTab(5)),
  define_binding_with_mod("CTRL|ALT", "7", act.MoveTab(6)),
  define_binding_with_mod("CTRL|ALT", "8", act.MoveTab(7)),

  define_binding_with_mod("CTRL|ALT", "LeftArrow", act.MoveTabRelative(-1)),
  define_binding_with_mod("CTRL|ALT", "RightArrow", act.MoveTabRelative(1)),

  ----------------------------------------
  -- Copy/Paste
  ----------------------------------------
  define_binding("c", act.CopyTo 'ClipboardAndPrimarySelection'),
  define_binding("v", act.PasteFrom 'PrimarySelection'),
  define_binding("v", act.PasteFrom 'Clipboard'),

  -----------------------------------------
  -- Font Size
  -----------------------------------------
  define_binding("+", act.IncreaseFontSize),
  define_binding("-", act.DecreaseFontSize),
  define_binding("*", act.ResetFontSize),
}

--------------------------------------------------------------------------------
-- 4) Build the WezTerm config
--------------------------------------------------------------------------------
local config = wezterm.config_builder()

-- Window appearance
config.window_background_opacity = 0.95
config.font_size = 18
config.line_height = 1.1
config.font = wezterm.font('SauceCodePro Nerd Font Mono', { weight = 'Regular', italic = false })

-- If you want a custom color scheme rather than color_scheme = "NameHere"
config.colors = {
  foreground = gh.gh_fg,
  background = gh.gh_bg,

  cursor_bg = gh.gh_caret,
  cursor_fg = gh.gh_bg,
  cursor_border = gh.gh_caret,

  selection_fg = gh.gh_fg,
  selection_bg = gh.gh_selection,

  scrollbar_thumb = gh.gh_invisibles,
  split = gh.gh_invisibles,

  ansi = {
    gh.gh_invisibles, -- black
    gh.gh_red,        -- red
    gh.gh_green,      -- green
    gh.gh_yellow,     -- yellow
    gh.gh_blue,       -- blue
    gh.gh_magenta,    -- magenta
    gh.gh_cyan,       -- cyan
    gh.gh_fg,         -- white
  },
  brights = {
    gh.gh_comment,    -- bright black (gray)
    "#ff9790",        -- bright red (tweak if desired)
    "#6af28c",        -- bright green
    "#e3b341",        -- bright yellow
    "#79c0ff",        -- bright blue
    "#d2a8ff",        -- bright magenta
    "#56d4dd",        -- bright cyan
    "#ffffff",        -- bright white
  },

  tab_bar = tab_bar,
}

-- Tab bar settings
config.use_fancy_tab_bar = true
config.window_frame = {
  font = wezterm.font { family = 'FiraCode Nerd Font Mono', weight = 'Regular' },
  font_size = 12.0,
  active_titlebar_bg = gh.gh_bg,
}

-- Terminal emulation
config.term = "xterm-256color"

-- Performance
config.max_fps = 144
config.animation_fps = 30
-- config.default_cursor_style = "BlinkingUnderline"
-- config.cursor_blink_rate = 500

-- Key and mouse bindings
config.keys = binds
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
  -- Shift+Middle-click to close the current pane
  {
    event = { Down = { streak = 1, button = "Middle" } },
    mods = "SHIFT",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

config.warn_about_missing_glyphs = false

return config
