-- diagnostics
vim.diagnostic.config({
  virtual_text = false,
  underline = true,
  float = {
    source = "always",
  },
  severity_sort = true,
  --[[ virtual_text = {
		prefix = "»",
		spacing = 4,
	}, ]]
  signs = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true }),
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})
