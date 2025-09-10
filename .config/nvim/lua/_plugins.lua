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
  -- better diagnostics list and others
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
    "OXY2DEV/markview.nvim",
    lazy = false,
    opts = {
      preview = {
        filetypes = { "markdown", "Avante" },
        ignore_buftypes = {},
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = function()
  --     ---@class PluginLspOpts
  --     local ret = {
  --       -- options for vim.diagnostic.config()
  --       ---@type vim.diagnostic.Opts
  --       diagnostics = {
  --         underline = true,
  --         update_in_insert = false,
  --         virtual_text = {
  --           spacing = 4,
  --           source = "if_many",
  --           prefix = "●",
  --           -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
  --           -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
  --           -- prefix = "icons",
  --         },
  --         severity_sort = true,
  --         signs = {
  --           text = {
  --             [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error,
  --             [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn,
  --             [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint,
  --             [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info,
  --           },
  --         },
  --       },
  --       -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
  --       -- Be aware that you also will need to properly configure your LSP server to
  --       -- provide the inlay hints.
  --       inlay_hints = {
  --         enabled = true,
  --         exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
  --       },
  --       -- Enable this to enable the builtin LSP code lenses on Neovim >= 0.10.0
  --       -- Be aware that you also will need to properly configure your LSP server to
  --       -- provide the code lenses.
  --       codelens = {
  --         enabled = false,
  --       },
  --       -- add any global capabilities here
  --       capabilities = {
  --         workspace = {
  --           fileOperations = {
  --             didRename = true,
  --             willRename = true,
  --           },
  --         },
  --       },
  --       -- options for vim.lsp.buf.format
  --       -- `bufnr` and `filter` is handled by the LazyVim formatter,
  --       -- but can be also overridden when specified
  --       format = {
  --         formatting_options = nil,
  --         timeout_ms = nil,
  --       },
  --       -- LSP Server Settings
  --       ---@type lspconfig.options
  --       servers = {
  --         lua_ls = {
  --           -- mason = false, -- set to false if you don't want this server to be installed with mason
  --           -- Use this to add any additional keymaps
  --           -- for specific lsp servers
  --           -- ---@type LazyKeysSpec[]
  --           -- keys = {},
  --           settings = {
  --             Lua = {
  --               workspace = {
  --                 checkThirdParty = false,
  --               },
  --               codeLens = {
  --                 enable = true,
  --               },
  --               completion = {
  --                 callSnippet = "Replace",
  --               },
  --               doc = {
  --                 privateName = { "^_" },
  --               },
  --               hint = {
  --                 enable = true,
  --                 setType = false,
  --                 paramType = true,
  --                 paramName = "Disable",
  --                 semicolon = "Disable",
  --                 arrayIndex = "Disable",
  --               },
  --             },
  --           },
  --         },
  --       },
  --       -- you can do any additional lsp server setup here
  --       -- return true if you don't want this server to be setup with lspconfig
  --       ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  --       setup = {
  --         -- example to setup with typescript.nvim
  --         -- tsserver = function(_, opts)
  --           --   require("typescript").setup({ server = opts })
  --           --   return true
  --           -- end,
  --           -- Specify * to use this function as a fallback for any server
  --           -- ["*"] = function(server, opts) end,
  --         },
  --       }
  --       return ret
  --     end
  -- },
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
  -- "hrsh7th/cmp-nvim-lsp",
  -- "hrsh7th/cmp-buffer",
  -- "hrsh7th/cmp-path",
  -- "hrsh7th/cmp-cmdline",
  -- "saadparwaiz1/cmp_luasnip",
  "nvimtools/none-ls.nvim",
  "nvim-treesitter/nvim-treesitter",
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    -- event = "VeryLazy",
    -- enabled = true,
    -- config = function()
    --   -- When in diff mode, we want to use the default
    --   -- vim text objects c & C instead of the treesitter ones.
    --   local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
    --   local configs = require("nvim-treesitter.configs")
    --   for name, fn in pairs(move) do
    --     if name:find("goto") == 1 then
    --       move[name] = function(q, ...)
    --         if vim.wo.diff then
    --           local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
    --           for key, query in pairs(config or {}) do
    --             if q == query and key:find("[%]%[][cC]") then
    --               vim.cmd("normal! " .. key)
    --               return
    --             end
    --           end
    --         end
    --         return fn(q, ...)
    --       end
    --     end
    --   end
    -- end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  "tamago324/nlsp-settings.nvim",
  "onsails/lspkind.nvim",
  "tpope/vim-surround",
  "tpope/vim-rails",
  "windwp/nvim-autopairs",
  "b3nj5m1n/kommentary",
  "editorconfig/editorconfig-vim",
  "lukas-reineke/indent-blankline.nvim",
  "RRethy/nvim-base16",
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- {
  --   "folke/tokyonight.nvim",
  --   name = "tokyonight",
  --   config = function()
  --     vim.cmd("colorscheme tokyonight-night")
  --   end
  -- },
  -- {
  --   "rose-pine/neovim",
  --   name = "rose-pine",
  --   config = function()
  --     vim.cmd("colorscheme rose-pine-moon")
  --   end
  -- },
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
  -- {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --   },
  -- },
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
  { -- optional cmp completion source for require statements and module annotations
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      table.insert(opts.sources, {
        name = "lazydev",
        group_index = 0, -- set group index to 0 to skip loading LuaLS completions
      })
    end,
  },
  {
    'MagicDuck/grug-far.nvim',
    -- opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { preset = 'super-tab' },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = {
        documentation = { auto_show = true, window = { border = 'single' } },
        ghost_text = {
          enabled = true
        },
        menu = {
          -- border = 'single',
          draw = {
            components = {
              kind_icon = {
                text = function(ctx)
                  local icon = ctx.kind_icon
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      icon = dev_icon
                    end
                  else
                    icon = require("lspkind").symbolic(ctx.kind, {
                      mode = "symbol",
                    })
                  end

                  return icon .. ctx.icon_gap
                end,

                -- Optionally, use the highlight groups from nvim-web-devicons
                -- You can also add the same function for `kind.highlight` if you want to
                -- keep the highlight groups in sync with the icons.
                highlight = function(ctx)
                  local hl = ctx.kind_hl
                  if vim.tbl_contains({ "Path" }, ctx.source_name) then
                    local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                    if dev_icon then
                      hl = dev_hl
                    end
                  end
                  return hl
                end,
              }
            }
          }
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
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

  -- UI components
  { "MunifTanjim/nui.nvim", lazy = true },
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
  'subnut/nvim-ghost.nvim',
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      "folke/snacks.nvim",
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
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
      -- routes = {
      --   {
      --     filter = {
      --       event = "msg_show",
      --       any = {
      --         { find = "%d+L, %d+B" },
      --         { find = "; after #%d+" },
      --         { find = "; before #%d+" },
      --       },
      --     },
      --     view = "mini",
      --   },
      --   -- {
      --   --   filter = { event = "msg_show", kind = "search_count" },
      --   --   opts = { skip = true },
      --   -- },
      -- },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    }
  },
  -- { 'nvim-mini/mini.nvim', version = '*' },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        }
      }
    },
    keys = {
      -- Top Pickers & Explorer
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- Grep
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
      -- search
      { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
      { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- LSP
      { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
      { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
      { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
      { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
      { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      -- Other
      { "<leader>z",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
      { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>n",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
      { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
      { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
      { "<c-/>",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
      { "<c-_>",      function() Snacks.terminal() end, desc = "which_key_ignore" },
      { "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
      { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
    }
  },
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

require("catppuccin").setup({
  auto_integrations = true,
})
