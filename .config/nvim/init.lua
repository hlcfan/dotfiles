require("_options")
require("_plugins")
require("_lsp")
require("_treesitter")
require("_telescope")
require("_whichkey")
require("_null-ls")
require("_terminal")
require("_autopairs")

vim.cmd("set notermguicolors")
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[color gruvbox]])

-- important to import after colorscheme
require("_statusline")
require("_gitsigns")
