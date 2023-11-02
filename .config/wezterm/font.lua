local wezterm = require("wezterm")

local M = {}

function M.update_config(config)
  config.line_height = 1.2
  config.cell_width = 0.95
  config.font = wezterm.font_with_fallback {
    { family = "ComicCode Nerd Font", weight = "Regular" },
    { family = "FiraCode Nerd Font", weight = "Regular" },
  }
  config.font_size = 18.0
end

return M
