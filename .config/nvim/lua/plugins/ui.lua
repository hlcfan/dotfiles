return {
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols (Trouble)" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/... (Trouble)" },
      { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { "neovim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    opts = {},
  },
  {
    "lukas-reineke/indent-blankline.nvim",
  },
  {
    "RRethy/nvim-base16",
  },
  {
    "catppuccin/nvim",
    lazy = false,
    config = function()
      require("catppuccin").setup({ auto_integrations = true })
      vim.cmd.colorscheme("catppuccin-mocha")
      vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
    end,
    name = "catppuccin",
    priority = 1000,
  },
  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      { "<F4>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
      { "<F3>", "<cmd>NvimTreeFindFile<cr>", desc = "Find file in NvimTree" },
    },
    version = "*",
    cmd = { "NvimTreeToggle", "NvimTreeFindFile", "NvimTreeOpen" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        filters = {
          dotfiles = true,
        },
      })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("config.statusline")
    end,
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
  },
  {
    "folke/which-key.nvim",
    config = function(_, opts)
      require("which-key").setup(opts)
      require("config.whichkey")
    end,
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
    "ethanholz/nvim-lastplace",
    event = "BufRead",
    config = function()
      require("nvim-lastplace").setup({
        lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
        lastplace_open_folds = true,
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("alpha").setup(require("alpha.themes.startify").config)
    end,
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "MunifTanjim/nui.nvim",
    lazy = true,
  },
  {
    "rmagatti/auto-session",
    lazy = false,

    opts = {
      suppressed_dirs = { "~/", "~/Downloads", "/" },
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      exclude_buffer = function(buf)
        return vim.b[buf].bigfile == true
      end,
    },
  },
}
