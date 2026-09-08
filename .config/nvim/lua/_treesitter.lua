local treesitter_ok, treesitter = pcall(require, "nvim-treesitter")
if not treesitter_ok then
  return
end

local ok, treesitter_context = pcall(require, "treesitter-context")
if not ok then
  return
end

treesitter.install({
  "go", "lua", "rust", "zig", "query", "markdown", "markdown_inline",
                                                                                   "elixir", "heex", "javascript", "html", "json", "tsx", "typescript",
  "yaml", "xml",
})

-- vim.api.nvim_create_autocmd("FileType", {
--   callback = function(args)
--     -- vim.treesitter.start() errors if no parser is installed for this
--     -- filetype, so this only enables highlighting/indent where available.
--     local has_parser = pcall(vim.treesitter.start, args.buf)
--     if has_parser then
--       vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
--     end
--   end,
-- })

treesitter_context.setup({
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  multiwindow = false, -- Enable multiwindow support.
  max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = function(buf)
    return not require("_bigfile").is_large(buf)
  end,
})

require('kommentary.config').configure_language("default", {
  prefer_single_line_comments = true,
})
