local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Go
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  },
})

vim.lsp.config("elixirls", {
  cmd = { vim.fn.expand("~/bin/expert_darwin_arm64") },
})

vim.lsp.config("rust_analyzer", {
  on_attach = function(client, bufnr)
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  settings = {
    ["rust-analyzer"] = {
      check = { command = "clippy" },
      diagnostics = {
        disabled = { "unlinked-file" },
        experimental = {
          enable = true, -- Often required for certain diagnostics settings
        },
      },
      imports = {
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})
