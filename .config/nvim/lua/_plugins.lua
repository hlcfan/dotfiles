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
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    lazy = true,
    build = "make install_jsregexp"
  },
  "neovim/nvim-lspconfig",
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },
  -- CMP
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/nvim-cmp",
  "saadparwaiz1/cmp_luasnip",
  "nvimtools/none-ls.nvim",
  "nvim-treesitter/nvim-treesitter",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/nvim-treesitter-context",
  "tamago324/nlsp-settings.nvim",
  "onsails/lspkind.nvim",
  "tpope/vim-surround",
  "tpope/vim-rails",
  "windwp/nvim-autopairs",
  "b3nj5m1n/kommentary",
  "editorconfig/editorconfig-vim",
  "lukas-reineke/indent-blankline.nvim",
  -- {
  --   'tzachar/cmp-tabnine',
  --   build = './install.sh',
  --   dependencies = 'hrsh7th/nvim-cmp',
  -- },
  "RRethy/nvim-base16",
  "folke/tokyonight.nvim",
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        filters = {
          dotfiles = true,
        },
      }
    end,
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
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    lazy = true,
    opts = {
      plugins = {
        marks = true,
        registers = true,
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
        spelling = { enabled = true, suggestions = 20 },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },
      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 3,
      },
      show_help = true,
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
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
    'goolord/alpha-nvim',
    event = "VimEnter",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  { "rafamadriz/friendly-snippets", lazy = true },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    lazy = true,
    ---@type Flash.Config
    -- opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
        desc = "Flash",
      },
      -- {
      --   "S",
      --   mode = { "n", "o", "x" },
      --   function()
      --     require("flash").treesitter()
      --   end,
      --   desc = "Flash Treesitter",
      -- },
      -- {
      --   "r",
      --   mode = "o",
      --   function()
      --     require("flash").remote()
      --   end,
      --   desc = "Remote Flash",
      -- },
    },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "Avante" },
        ignore_buftypes = {},
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      disabled_tools = { "python" },
      provider = "claude",
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-7-sonnet-20250219", -- "claude-sonnet-4-20250514", -- your desired model (or use gpt-4o, etc.)
        -- timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        -- max_tokens = 4096,
        -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
    }
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  'mfussenegger/nvim-dap',
  'leoluz/nvim-dap-go',
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"
    }
  },
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Downloads', '/' },
      -- log_level = 'debug',
    }
  },
  'subnut/nvim-ghost.nvim'
})

require("luasnip/loaders/from_vscode").lazy_load()

-- require('leap').add_default_mappings()
require'alpha'.setup(require'alpha.themes.startify'.config)

require('dap-go').setup({
  dap_configurations = {
		{
			type = "go",
			name = "Debug main.go",
			request = "launch",
			program = "${workspaceFolder}/main.go"
		},
	},
})