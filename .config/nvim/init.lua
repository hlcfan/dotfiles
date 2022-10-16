require("_options")
require("_plugins")
require("_lsp")
require("_treesitter")
require("_telescope")
require("_whichkey")
require("_null-ls")
require("_terminal")
require("_autopairs")
require("diagnostic")

vim.cmd("set notermguicolors")
vim.cmd('colorscheme base16-rebecca')
-- vim.cmd([[colorscheme whimsical-vim]])
-- vim.cmd([[color whimsical-vim]])

vim.cmd([[hi DiffAdd      ctermfg=NONE          ctermbg=LightGray]])
vim.cmd([[hi DiffChange      ctermfg=NONE          ctermbg=LightGray]])
vim.cmd([[hi DiffText      ctermfg=NONE          ctermbg=LightGray]])

-- important to import after colorscheme
require("_statusline")
require("_gitsigns")
