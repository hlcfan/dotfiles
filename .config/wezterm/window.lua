local M = {}

function M.update_config(config)
  config.window_background_opacity = 1.0
  config.macos_window_background_blur = 30

  config.initial_rows = 28
  config.initial_cols = 130

  config.scrollback_lines = 10000
end

return M
