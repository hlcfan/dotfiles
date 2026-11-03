-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  float = {
    source = true,
    border = "rounded",
    focusable = true,
  },
  severity_sort = true,
  signs = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { scope = "cursor", focus = false })
  end,
})
