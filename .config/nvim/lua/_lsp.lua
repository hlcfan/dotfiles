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

local source_mapping = {
  luasnip = "[Snip]",
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  -- cmp_tabnine = "[TabNine]",
  path = "[Path]",
  Copilot = "[Copilot]",
}

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
end

-- completion setup
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      lua_snip.lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif cmp.visible() then
        cmp.select_next_item()
      -- elseif lua_snip.expand_or_jumpable() then
      --   lua_snip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
  }),
  window = {
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    -- { name = 'copilot' },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    -- { name = 'cmp_tabnine' },
    { name = "buffer" },
    { name = "path" },
    -- { name = "ultisnips" },
    -- { name = "vsnip" },
  }),
  formatting = {
    format = function(entry, vim_item)
      -- if you have lspkind installed, you can use it like
      -- in the following line:
      vim_item.kind = lspkind.symbolic(vim_item.kind, {mode = "symbol"})
      vim_item.menu = source_mapping[entry.source.name]
      if entry.source.name == "cmp_tabnine" then
        local detail = (entry.completion_item.data or {}).detail
        vim_item.kind = ""
        if detail and detail:find('.*%%.*') then
          vim_item.kind = vim_item.kind .. ' ' .. detail
        end

        if (entry.completion_item.data or {}).multiline then
          vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
        end
      end
      local maxwidth = 80
      vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
      return vim_item
    end,
  },
})

-- cmp.setup.cmdline('/', {
--   view = {
--     entries = {name = 'wildmenu', separator = '|' }
--   },
-- })

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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

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

    if client.server_capabilities.inlayHintProvider then vim.lsp.inlay_hint.enable(true) end
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
      ["ui.inlayhint.hints"] = {
        compositeLiteralFields = true,
        constantValues = true,
        parameterNames = true,
      },
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
-- require'lspconfig'.elixirls.setup{}

-- require("copilot").setup({
--   suggestion = { enabled = false },
--   panel = { enabled = false },
-- })
