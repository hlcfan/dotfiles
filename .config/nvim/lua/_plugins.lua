local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "L3MON4D3/LuaSnip", lazy = true },
  -- A pretty diagnostics, references, telescope results, quickfix and location list
  "folke/trouble.nvim",
  "neovim/nvim-lspconfig",
  -- CMP
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  -- "hrsh7th/cmp-copilot",
  "jose-elias-alvarez/null-ls.nvim",
  "nvim-lua/lsp-status.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  -- A plugin for setting Neovim LSP with JSON files
  "tamago324/nlsp-settings.nvim",
  "onsails/lspkind.nvim",
  -- or nvim-lspconfig that allows you to seamlessly manage LSP servers locally
  "williamboman/nvim-lsp-installer",
  "tpope/vim-surround",
  "tpope/vim-rails",
  "windwp/nvim-autopairs",
  "b3nj5m1n/kommentary",
  "editorconfig/editorconfig-vim",
  "lukas-reineke/indent-blankline.nvim",
  {
    'tzachar/cmp-tabnine',
    build = './install.sh',
    dependencies = 'hrsh7th/nvim-cmp',
  },
  "RRethy/nvim-base16",
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end,
    lazy = true
  },
  {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  },
  {
    "folke/which-key.nvim",
    lazy = true,
    config = function()
      require("which-key").setup({})
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    lazy = true
  },
  {
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        -- lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'hyper' --  theme is doom and hyper default is hyper
      }
    end,
    dependencies = {"nvim-tree/nvim-web-devicons"}
  },
  { "rafamadriz/friendly-snippets", lazy = true },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" }
})

require("nvim-tree").setup()

require("luasnip/loaders/from_vscode").lazy_load()
