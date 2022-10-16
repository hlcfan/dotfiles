-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
local ls_ok, ls = pcall(require, "luasnip")

if not ls_ok then
  print("Too bad!")
  return
else
  print("OK!")
end

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
