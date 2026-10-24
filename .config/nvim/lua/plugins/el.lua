return {
  {
    dir = vim.fn.expand("~/workspace/el-lang/editors/nvim"),
    name = "el.nvim",
    lazy = false,
    config = function()
      vim.lsp.config("el", {
        cmd = { vim.fn.expand("~/.local/bin/el"), "lsp" },
      })
      vim.lsp.enable("el")
    end,
  },
}
