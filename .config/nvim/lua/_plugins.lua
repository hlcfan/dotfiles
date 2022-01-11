local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

local packer_ok, packer = pcall(require, "packer")
if not packer_ok then
  return
end
return packer.startup(function()
  use({
    -- Snippet Engine
    "L3MON4D3/LuaSnip",
    -- A pretty diagnostics, references, telescope results, quickfix and location list
    "folke/trouble.nvim",
    -- CMP
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "jose-elias-alvarez/null-ls.nvim",
    "neovim/nvim-lspconfig",
    "nvim-lua/lsp-status.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- CMP
    "saadparwaiz1/cmp_luasnip",
    -- A plugin for setting Neovim LSP with JSON files
    "tamago324/nlsp-settings.nvim",
    "wbthomason/packer.nvim",
    -- or nvim-lspconfig that allows you to seamlessly manage LSP servers locally
    "williamboman/nvim-lsp-installer",
    -- "rafamadriz/friendly-snippets",
    "tpope/vim-surround",
    "windwp/nvim-autopairs",
    "b3nj5m1n/kommentary",
    "editorconfig/editorconfig-vim",
  })
  -- A vim theme repo
  use {"morhetz/gruvbox"}
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    },
  })
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
  })
  use({
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({})
    end,
  })
  -- use({
  --   "terrortylor/nvim-comment",
  --   config = function()
  --     require("nvim_comment").setup({})
  --   end,
  -- })
  use({
    "lewis6991/gitsigns.nvim",
    requires = {
      'nvim-lua/plenary.nvim'
    },
  })
  use({
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        -- lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
