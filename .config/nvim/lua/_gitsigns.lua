require('gitsigns').setup({
  on_attach = function(buf)
    return not require("_bigfile").is_large(buf)
  end,
})
