local M = {}
local size_limit = 1.5 * 1024 * 1024
local group = vim.api.nvim_create_augroup("LargeFile", { clear = true })

function M.is_large(buf)
  if vim.b[buf].bigfile then
    return true
  end
  local size = vim.fn.getfsize(vim.api.nvim_buf_get_name(buf))
  return size > size_limit
end

function M.apply(buf)
  vim.b[buf].bigfile = true
  vim.b[buf].completion = false
  vim.b[buf].snacks_indent = false
  vim.b[buf].snacks_scope = false
  vim.b[buf].snacks_words = false
  vim.b[buf].snacks_scroll = false
  vim.b[buf].minianimate_disable = true
  vim.b[buf].minihipatterns_disable = true
  vim.b[buf].minidiff_disable = true
  vim.bo[buf].matchpairs = ""
  vim.bo[buf].undofile = false
  vim.bo[buf].indentexpr = ""
  vim.bo[buf].syntax = ""
  -- A separate filetype prevents automatic language-server and ftplugin work.
  vim.bo[buf].filetype = "bigfile"
  vim.diagnostic.enable(false, { bufnr = buf })
end

vim.api.nvim_create_autocmd("BufReadPre", {
  group = group,
  callback = function(ev)
    if M.is_large(ev.buf) then
      M.apply(ev.buf)
    end
  end,
})

-- Registered before filetype detection; also catches smaller minified files.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(ev)
    local lines = vim.api.nvim_buf_line_count(ev.buf)
    local bytes = vim.api.nvim_buf_get_offset(ev.buf, lines)
    if M.is_large(ev.buf) or (bytes - lines) / lines > 1000 then
      M.apply(ev.buf)
    end
  end,
})

local window_options = {
  foldmethod = "manual",
  foldexpr = "0",
  wrap = false,
  statuscolumn = "",
  conceallevel = 0,
  cursorline = false,
  colorcolumn = "",
  list = false,
}

vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
  group = group,
  callback = function()
    if vim.b.bigfile then
      if not vim.w.large_file_options then
        local saved = {}
        for name in pairs(window_options) do
          saved[name] = vim.wo[name]
        end
        vim.w.large_file_options = saved
      end
      for name, value in pairs(window_options) do
        vim.wo[name] = value
      end
      vim.bo.syntax = "OFF"
    elseif vim.w.large_file_options then
      for name, value in pairs(vim.w.large_file_options) do
        vim.wo[name] = value
      end
      vim.w.large_file_options = nil
    end
  end,
})

return M
