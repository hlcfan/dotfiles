local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "black" },
  {
    exe = "prettier",
    args = { "--print-width", "100" },
    filetypes = { "typescript", "typescriptreact" },
  },
}

