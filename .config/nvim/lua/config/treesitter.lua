require("nvim-treesitter").install({
  "go",
  "lua",
  "rust",
  "zig",
  "query",
  "markdown",
  "markdown_inline",
  "elixir",
  "heex",
  "javascript",
  "html",
  "json",
  "tsx",
  "typescript",
  "yaml",
  "xml",
})

-- nvim-treesitter (main) no longer enables highlighting/indent by itself.
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
  callback = function(ev)
    if vim.b[ev.buf].bigfile then
      return
    end
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
