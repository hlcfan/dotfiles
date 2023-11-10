local wezterm = require("wezterm")
local color_scheme = require("color_scheme")
local font = require("font")
local tab = require("tab")
-- local mappings = require("mappings")
local window = require("window")
local password = require("password")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- tab.setup(config)
window.update_config(config)
color_scheme.update_config(config)
font.update_config(config)
-- mappings.update_config(config)
password.update_config(config)

if wezterm.target_triple:find("windows") then
  config.default_prog = { "pwsh" }
  config.window_decorations = "RESIZE|TITLE"
  wezterm.on("gui-startup", function(cmd)
    local screen = wezterm.gui.screens().active
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    local gui = window:gui_window()
    local width = 0.7 * screen.width
    local height = 0.7 * screen.height
    gui:set_inner_size(width, height)
    gui:set_position((screen.width - width) / 2, (screen.height - height) / 2)
  end)
else
  config.term = "wezterm"
  config.window_decorations = "RESIZE"
end

-- Cursor
config.default_cursor_style = "BlinkingBar"
config.force_reverse_video_cursor = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }


return config
