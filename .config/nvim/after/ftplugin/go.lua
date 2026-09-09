local bufnr = vim.api.nvim_get_current_buf()
local group = vim.api.nvim_create_augroup("GoFormat", { clear = false })
vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  buffer = bufnr,
  callback = function()
    -- Build positions using each client's encoding before applying its edits.
    for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr, method = "textDocument/codeAction" })) do
      local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
      params.context = { only = { "source.organizeImports" } }
      -- Keep the save hook synchronous so edits are included in this write.
      local result = client:request_sync("textDocument/codeAction", params, 1000, bufnr)
      for _, r in ipairs(result and result.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        end
      end
    end
    vim.lsp.buf.format({ bufnr = bufnr, async = false })
  end,
})

local undo = "lua vim.api.nvim_clear_autocmds({ group = 'GoFormat', buffer = 0 })"
vim.b.undo_ftplugin = vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. " | " .. undo) or undo
