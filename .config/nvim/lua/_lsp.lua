local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then
  return
end

local lsp_status_ok, lsp_status = pcall(require, "lsp-status")
if not lsp_status_ok then
  return
end

local win_ok, win = pcall(require, "lspconfig.ui.windows")
if not win_ok then
  return
end

local lsp_installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_ok then
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

lspkind.init()

local _default_opts = win.default_opts

nlspsettings.setup()

-- round some of the window borders
win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = "rounded"
  return opts
end

-- statusline progress setup
lsp_status.config({
  current_function = false,
  show_filename = false,
  diagnostics = false,
  status_symbol = "",
  select_symbol = nil,
  update_interval = 200,
})

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TabNine]",
  path = "[Path]",
}

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- completion setup
cmp.setup({
  snippet = {
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body)
      require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      -- vim.fn["UltiSnips#Anon"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
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
    { name = "nvim_lsp" },
    { name = 'cmp_tabnine' },
    { name = "luasnip" },
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

cmp.setup.cmdline('/', {
  view = {
    entries = {name = 'wildmenu', separator = '|' }
  },
})

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()) --nvim-cmp
capabilities.textDocument.completion.completionItem.snippetSupport = true

local nvim_lsp = require('lspconfig')

-- setup languages
-- GoLang
nvim_lsp['gopls'].setup{
  cmd = {'gopls'},
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  capabilities = capabilities,
  settings = {
    gopls = {
      experimentalPostfixCompletions = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
    },
  },
  init_options = {
    usePlaceholders = true,
  }
}

-- function to attach completion when setting up lsp
local on_attach = function(client)
  lsp_status.register_progress()
  lsp_status.on_attach(client)
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

nvim_lsp.ruby_ls.setup({})

-- Provide settings first!
lsp_installer.settings({
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    -- capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    flags = { debounce_text_changes = 150 },
  }
  server:setup(opts)
end)

