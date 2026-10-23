-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = { current_line = true },
  underline = true,
  float = {
    source = true,
  },
  severity_sort = true,
  signs = true,
  update_in_insert = false,
})
