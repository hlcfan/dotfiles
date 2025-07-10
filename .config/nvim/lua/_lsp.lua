local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local win_ok, win = pcall(require, "lspconfig.ui.windows")
if not win_ok then
  return
end

local nlspsettings_ok, nlspsettings = pcall(require, "nlspsettings")
if not nlspsettings_ok then
  return
end

local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  return
end

local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

local ok, lua_snip = pcall(require, "luasnip")
if not ok then
  return
end

lspkind.init({
  symbol_map = {
    Copilot = "",
  },
})

local _default_opts = win.default_opts

nlspsettings.setup()

-- round some of the window borders
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "rounded"
  return opts
end

-- function to attach completion when setting up lsp
local base_on_attach = function(client, bufnr)
  utils.bufmap("n", "ga", "lua vim.lsp.buf.code_action()")
  utils.bufmap("n", "gD", "lua vim.lsp.buf.declaration()")
  utils.bufmap("n", "gd", "lua vim.lsp.buf.definition()")
  utils.bufmap("n", "ge", "lua vim.lsp.diagnostic.goto_next()")
  utils.bufmap("n", "gE", "lua vim.lsp.diagnostic.goto_prev()")
  utils.bufmap("n", "gI", "lua vim.lsp.buf.implementation()")
  utils.bufmap("n", "gr", "lua vim.lsp.buf.references()")
  utils.bufmap("n", "gR", "lua vim.lsp.buf.rename()")
  utils.bufmap("n", "K", "lua vim.lsp.buf.hover()")
  utils.bufmap("n", "gl", "lua vim.diagnostic.open_float()")
end

local lspconfig = require('lspconfig')
-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.config("*", {
    on_attach = base_on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
})

-- Go
-- local base_on_attach = vim.lsp.config.gopls.on_attach
vim.lsp.config('gopls', {
  on_attach = function(client, bufnr)
    base_on_attach(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true) end
  end,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      gofumpt = true,
      -- ["ui.inlayhint.hints"] = {
      --   compositeLiteralFields = true,
      --   constantValues = true,
      --   parameterNames = true,
      -- },
    },
  },
  init_options = {
    usePlaceholders = true,
  }
})

vim.lsp.config("eslint", {
  on_attach = function(client, bufnr)
    base_on_attach(client, bufnr)

    -- vim.api.nvim_create_autocmd("BufWritePre", {
    --   buffer = bufnr,
    --   command = "EslintFixAll",
    -- })
  end,
})

vim.lsp.config("elixirls", {
  cmd = { "/Users/hlcfan/elixir-ls/language_server.sh" },
  on_attach = base_on_attach,
  capabilities = capabilities,
  flags = { debounce_text_changes = 150 },
})

vim.lsp.config("rust_analyzer", {
  on_attach = function(client, bufnr)
    base_on_attach(client, bufnr)

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end,
  settings = {
    ["rust-analyzer"] = {
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
        enable = true
      },
    }
  }
})

-- require("copilot").setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })
