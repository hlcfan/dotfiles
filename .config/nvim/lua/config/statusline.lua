local api = vim.api

local components = {
  buffers = { "buffers" },
  encoding = { "o:encoding", fmt = string.upper },
  filename = { "filename" },
  filetype = { "filetype" },
  location = { "location" },
  progress = { "progress" },
  tabs = { "tabs", mode = 0 },
  mode = {
    function()
      return " "
    end,
    padding = { left = 0, right = 0 },
  },
  diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    symbols = { error = "🚨", warn = "⚠️", info = "ℹ️", hint = "💡" },
  },
  treesitter = {
    function()
      local b = api.nvim_get_current_buf()
      if vim.treesitter.highlighter.active[b] then
        return ""
      end
      return ""
    end,
  },
}

local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  return
end

-- define how the statusline and tabline appear
lualine.setup({
  options = {
    theme = "auto",
    icons_enabled = false,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "Outline" },
  },
  sections = {
    lualine_a = {
      {
        "filename",
        file_status = true,
        path = 1,
      },
    },
    lualine_b = {
      components.location,
    },
    lualine_c = {
      "branch",
    },
    lualine_x = {
      components.diagnostics,
    },
    lualine_y = {
      "progress",
      components.treesitter,
    },
    lualine_z = {},
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {
      components.filename,
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- tabline = {
  --   lualine_a = {},
  --   lualine_b = { components.buffers },
  --   lualine_c = {},
  --   lualine_x = {},
  --   lualine_y = { components.tabs },
  --   lualine_z = {},
  -- },
})
