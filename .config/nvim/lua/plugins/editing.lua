return {
  {
    "tpope/vim-surround",
  },
  {
    "tpope/vim-rails",
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },
  {
    "b3nj5m1n/kommentary",
    config = function()
      require("kommentary.config").configure_language("default", { prefer_single_line_comments = true })
    end,
  },
  {
    "editorconfig/editorconfig-vim",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    lazy = true,
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "MagicDuck/grug-far.nvim",
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
    "kevinhwang91/nvim-hlslens",
    keys = {
      { "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], silent = true },
      { "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], silent = true },
      { "*", [[*<Cmd>lua require('hlslens').start()<CR>]], silent = true },
      { "#", [[#<Cmd>lua require('hlslens').start()<CR>]], silent = true },
      { "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], silent = true },
      { "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], silent = true },
    },
    opts = {},
  },
  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Rs", desc = "Send request" },
      { "<leader>Ra", desc = "Send all requests" },
      { "<leader>Rb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
  },
}
