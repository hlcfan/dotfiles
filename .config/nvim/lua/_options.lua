local g = vim.g
local opt = vim.opt
local fn = vim.fn

g.mapleader = ","

g.border_style = "rounded"
g.markdown_fenced_languages = {
  "bash=sh",
}

opt.backup = false -- creates a backup file
opt.textwidth = 80
opt.clipboard = "" -- don't use clipboard
opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
opt.colorcolumn = "80"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.conceallevel = 0 -- so that `` is visible in markdown files
opt.cursorline = true -- highlight the current line
opt.expandtab = true -- convert tabs to spaces
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.foldenable = false
opt.foldmethod = "expr" -- folding set to "expr" for treesitter based folding
opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
opt.foldlevel = 20
opt.hidden = true -- required to keep multiple buffers and open multiple buffers
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.laststatus = 2 -- hide statusline
opt.listchars = "trail:·,precedes:«,extends:»,tab:▸-"
opt.list = true
opt.mouse = ""
opt.number = true -- set numbered lines
opt.numberwidth = 1 -- set number column width to 2 {default 4}
opt.pumheight = 10 -- pop up menu height
opt.relativenumber = false -- set relative numbered lines
opt.scrolloff = 4 -- is one of my fav
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2 -- always show tabs
opt.sidescrolloff = 4
opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
opt.smartcase = true -- smart case
opt.smartindent = true -- make indenting smarter again
opt.spell = false -- disable spell checking
opt.spelllang = "en" -- language for spell checking
opt.splitbelow = true -- force all horizontal splits to go below current window
opt.splitright = true -- force all vertical splits to go to the right of current window
opt.swapfile = false -- creates a swapfile
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.termguicolors = false -- set term gui colors (most terminals support this)
opt.timeoutlen = 500 -- timeout length
opt.titlestring = "%<%F - nvim" -- what the title of the window will be set to
opt.title = true -- set the title of window to the value of the titlestring
opt.undodir = fn.stdpath("cache") .. "/undo"
opt.undofile = true -- enable persistent undo
opt.updatetime = 300 -- faster completion
opt.wrap = true -- display lines as one long line
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
--
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
