local utils = require("utils")

function SplitLineByDelimiter(delimiter)
  local line = vim.api.nvim_get_current_line() -- Get current line

  local parts = {}
  for part in string.gmatch(line, "([^" .. delimiter .. "]+)" .. delimiter .. "?") do
    table.insert(parts, part .. delimiter)
  end

  parts[#parts] = string.gsub(parts[#parts], delimiter .. "$", "")

  vim.api.nvim_buf_set_lines(0, vim.fn.line(".") - 1, vim.fn.line("."), false, parts)
end

utils.map("", "H", "^")
utils.map("", "L", "$")
utils.map("n", "<C-n>", ":tabnew<CR><Esc>")
utils.map("n", "<C-m>", ":tabclose!<CR><Esc>")
utils.map("n", "<C-w>c", "<C-w>c<C-w>p")
utils.map("n", "<CR>", ":nohlsearch<CR>")
utils.map("n", "<F2>", ":%! fm<CR>")
utils.map("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>l", "<cmd>noh<cr>", { silent = true })

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("QuickfixMappings", { clear = true }),
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = true })
  end,
})
