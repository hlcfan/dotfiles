return {
  {
    "mason-org/mason.nvim",
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function(_, opts)
      require("config.lsp")
      require("mason-lspconfig").setup(opts)
    end,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
      "tamago324/nlsp-settings.nvim",
      "onsails/lspkind.nvim",
      "saghen/blink.cmp",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls_ok, null_ls = pcall(require, "null-ls")
      if not null_ls_ok then
        return
      end

      local sources = {
        require("null-ls").builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }

      null_ls.setup({
        sources = sources,
        should_attach = function(buf)
          return not require("config.bigfile").is_large(buf)
        end,
      })
    end,
  },
  {
    "tamago324/nlsp-settings.nvim",
  },
  {
    "onsails/lspkind.nvim",
  },
}
