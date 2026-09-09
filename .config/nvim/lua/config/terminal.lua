local group = vim.api.nvim_create_augroup("TerminalOptions", { clear = true })

vim.api.nvim_create_autocmd("TermOpen", {
  group = group,
  callback = function()
    vim.wo.number = false
    vim.cmd.startinsert()
  end,
})

vim.api.nvim_create_autocmd("TermEnter", {
  group = group,
  callback = function()
    vim.wo.signcolumn = "no"
  end,
})
