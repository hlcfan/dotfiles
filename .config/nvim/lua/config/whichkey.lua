local wk = require("which-key")
wk.add({
  { "<leader>b", group = "Buffers", nowait = true, remap = false },
  { "<leader>bb", ":b#<cr>", desc = "Last used", nowait = true, remap = false },
  { "<leader>bc", ":cclose<cr>", desc = "Close quickfix", nowait = true, remap = false },
  { "<leader>bn", ":bn<cr>", desc = "Next", nowait = true, remap = false },
  { "<leader>bp", ":bp<cr>", desc = "Previous", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gm", ":Gitsigns blame_line<CR>", desc = "Blame", nowait = true, remap = false },
  { "<leader>gv", ":DiffviewOpen<CR>", desc = "Diff View", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>lI", ":Mason<cr>", desc = "Installer Info", nowait = true, remap = false },
  { "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>li", ":checkhealth vim.lsp<cr>", desc = "Info", nowait = true, remap = false },
  { "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
})
