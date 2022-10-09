local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
  return
end

local trouble_ok, trouble = pcall(require, "trouble")
if not trouble_ok then
  return
end

telescope.setup({
  defaults = {
    border = true,
    layout_strategy = "bottom_pane",
    layout_config = {
      height = 0.30,
      width = 1.00,
    },
    -- path_display = { "shorten" },
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "node_modules",
      "^_build"
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
})

require('telescope').load_extension('fzf')

trouble.setup({
  icons = false,
})


-- require('cmp').setup {
--   sources = {
--     { name = 'copilot' }
--   }
-- }
