return {
  {
    "neovim-treesitter/nvim-treesitter",
    config = function()
      require("config.treesitter")
    end,
    dependencies = { "neovim-treesitter/treesitter-parser-registry" },
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
    end,
    config = function()
      local move = require("nvim-treesitter-textobjects.move")

      require("nvim-treesitter-textobjects").setup({
        move = {
          set_jumps = true,
        },
      })

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]a", function()
        move.goto_next_start("@parameter.inner", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]F", function()
        move.goto_next_end("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]C", function()
        move.goto_next_end("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "]A", function()
        move.goto_next_end("@parameter.inner", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[a", function()
        move.goto_previous_start("@parameter.inner", "textobjects")
      end)

      vim.keymap.set({ "n", "x", "o" }, "[F", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[C", function()
        move.goto_previous_end("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[A", function()
        move.goto_previous_end("@parameter.inner", "textobjects")
      end)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "neovim-treesitter/nvim-treesitter" },
    opts = {
      max_lines = 1,
      multiline_threshold = 20,
      on_attach = function(buf)
        return not require("config.bigfile").is_large(buf)
      end,
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
}
