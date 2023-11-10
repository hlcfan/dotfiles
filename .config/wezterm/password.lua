local wezterm = require 'wezterm';
local act = wezterm.action
local username = os.getenv("USER")

local M = {}

function M.update_config(config)
  wezterm.on('trigger-password-input', function(window, pane)
    local success, stdout, stderr = wezterm.run_child_process {
      'security', 'find-generic-password', '-w', '-a',
      username, '-s', 'sudopassword'
    }
    pane:send_text(stdout)
  end)

  config.keys = {
    {
      key = '.',
      mods = "CMD",
      action = act.EmitEvent 'trigger-password-input'
    }
  }
end

return M
