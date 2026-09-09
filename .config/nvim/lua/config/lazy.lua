local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Could not install lazy.nvim at " .. lazypath .. ". Check your Git/network access and restart Neovim.")
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
