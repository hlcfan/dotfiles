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
    prompt_prefix = '🔍 ',
    layout_strategy = 'flex',
    buffer_previewer_maker = new_maker,
    -- path_display = { "smart" },
    path_display = { shorten = { len = 3, exclude = { 1, -1, -2 } } },
    preview = {
      timeout = 100,
      filesize_limit = 2,
      filesize_hook = function(filepath, bufnr, opts)
        local path = require('plenary.path'):new(filepath)
        -- opts exposes winid
        local height = vim.api.nvim_win_get_height(opts.winid) * 3 / 2
        local lines = vim.split(path:head(height), '[\r]?\n')
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(bufnr, 'ft', opts.ft)
      end,
      timeout_hook = function(filepath, bufnr, opts)
        local path = require('plenary.path'):new(filepath)
        -- opts exposes winid
        local height = vim.api.nvim_win_get_height(opts.winid) * 3 / 2
        local lines = vim.split(path:head(height), '[\r]?\n')
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        vim.api.nvim_buf_set_option(bufnr, 'ft', opts.ft)
      end,
    },
    layout_config = {
      prompt_position = 'top',
      width = 0.9,
      horizontal = {
        -- width_padding = 0.1,
        -- height_padding = 0.1,
        -- preview_cutoff = 60,
        -- width = width_for_nopreview,
        preview_width = horizontal_preview_width,
      },
      vertical = {
        -- width_padding = 0.05,
        -- height_padding = 1,
        width = 0.75,
        height = 0.85,
        preview_height = 0.4,
        mirror = true,
      },
      flex = {
        -- change to horizontal after 120 cols
        flip_columns = 160,
      },
    },
    -- path_display = { "shorten" },
    sorting_strategy = "ascending",
    file_ignore_patterns = {
      "node_modules",
      "^_build"
    },
    border = true,
    borderchars = {
      { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
      results = { '─', '│', '─', '│', '├', '┬', '┴', '╰' },
      preview = { '─', '│', '─', '│', '╭', '┤', '╯', '╰' },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    file_browser = {
      theme = "base16-rebecca",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
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
