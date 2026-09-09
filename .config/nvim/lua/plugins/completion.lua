return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    keys = {
      {
        "<c-k>",
        function()
          local ls = require("luasnip")
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          end
        end,
        mode = { "i", "s" },
        silent = true,
        desc = "Expand or jump snippet",
      },
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
    version = "v2.*",
    lazy = true,
    build = "make install_jsregexp",
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },

    version = "1.*",
    build = "cargo build --release",

    opts = {
      keymap = { preset = "super-tab" },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = { auto_show = true, window = { border = "single" } },
        ghost_text = {
          enabled = true,
        },
        menu = {
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
              },
            },
          },
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            opts = {
              global_snippets = {},
            },
          },
        },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
}
