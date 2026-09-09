return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    cmd = "Gitsigns",
    opts = {
      on_attach = function(buf)
        return not require("config.bigfile").is_large(buf)
      end,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
    dependencies = "nvim-lua/plenary.nvim",
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "NeogitOrg/neogit",
    cmd = "Neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "folke/snacks.nvim",
    },
  },
}
