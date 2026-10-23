local utils = {}
local api = vim.api
local fn = vim.fn

function utils.map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.extract_highlight_colors(color_group, scope, cterm_color)
  if fn.hlexists(color_group) == 0 then
    return cterm_color
  end
  local color = api.nvim_get_hl(0, { name = color_group, link = false })
  if color.bg ~= nil then
    color.bg = string.format("#%06x", color.bg)
  else
    return cterm_color
  end

  if color.fg ~= nil then
    color.fg = string.format("#%06x", color.fg)
  else
    return cterm_color
  end

  if color.reverse then
    if scope == "bg" then
      scope = "fg"
    else
      scope = "bg"
    end
  end
  if scope then
    return color[scope]
  end
  return color
end

return utils
