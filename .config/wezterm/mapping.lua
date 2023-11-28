local wezterm = require("wezterm")
local action = wezterm.action

local M = {}

-- Keys
-- 1. Pane and tab management
-- 2. Window and font

-- Key tables
-- 1. Search mode

function M.update_config(config)
  config.keys = {
    -----------------------------
    -- Pane and tab management --
    -----------------------------
    -- { key = "d", mods = "CMD", action = action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    -- { key = "e", mods = "CMD", action = action.SplitVertical { domain = "CurrentPaneDomain" } },
    -- { key = "l", mods = "CMD", action = action.ActivatePaneDirection("Right") },
    -- { key = "h", mods = "CMD", action = action.ActivatePaneDirection("Left") },
    -- { key = "k", mods = "CMD", action = action.ActivatePaneDirection("Up") },
    -- { key = "j", mods = "CMD", action = action.ActivatePaneDirection("Down") },
    -- { key = "w", mods = "CMD", action = action.CloseCurrentPane { confirm = false } },
    -- { key = "w", mods = "CMD|SHIFT", action = action.CloseCurrentTab { confirm = true } },
    -- { key = "]", mods = "CMD", action = action.ActivateTabRelative(1) },
    -- { key = "[", mods = "CMD", action = action.ActivateTabRelative(-1) },

    -----------------------------
    ------ Window and font ------
    -----------------------------
    { key = "f", mods = "SHIFT|CMD", action = action.ToggleFullScreen },
    { key = "+", mods = "CMD", action = action.IncreaseFontSize },
    { key = "-", mods = "CMD", action = action.DecreaseFontSize },
    {
      key = "k",
      mods = "CMD|SHIFT",
      action = action.Multiple({
        action.ClearScrollback "ScrollbackAndViewport",
        action.SendKey { key = "L", mods = "CTRL" },
      })
    },
    {
      key = '.',
      mods = "CMD",
      action = action.EmitEvent 'trigger-password-input'
    }
  }

  config.key_tables = {
    -----------------------------
    ------- Search mode ---------
    -----------------------------
    search_mode = {
      { key = "Enter", mods = "NONE", action = action.CopyMode "PriorMatch" },
      { key = "Enter", mods = "SHIFT", action = action.CopyMode "NextMatch" },
      { key = "u", mods = "CTRL", action = action.CopyMode "ClearPattern" },
      {
        key = "Escape",
        mods = "NONE",
        action = action.Multiple {
          action.CopyMode "ClearPattern",
          action.CopyMode "Close"
        }
      },
    }
  }
end

return M
