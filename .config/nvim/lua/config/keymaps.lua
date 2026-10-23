local utils = require("utils")

utils.map("", "H", "^")
utils.map("", "L", "$")
utils.map("n", "<C-n>", ":tabnew<CR><Esc>")
utils.map("n", "<C-m>", ":tabclose!<CR><Esc>")
utils.map("n", "<C-w>c", "<C-w>c<C-w>p")
utils.map("n", "<CR>", ":nohlsearch<CR>")
utils.map("n", "<F2>", ":%! fm<CR>")
utils.map("t", "<Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickfixMappings", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})

-- Restore last cursor position (replaces nvim-lastplace).
vim.api.nvim_create_autocmd("BufReadPost", {
  group = vim.api.nvim_create_augroup("LastPlace", { clear = true }),
  callback = function(ev)
    if vim.bo[ev.buf].filetype:match("^git") or vim.bo[ev.buf].buftype ~= "" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(ev.buf, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(ev.buf) then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
