local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local which_key = {
  setup = {
    -- win = {
    --   border = "none", -- none, single, double, shadow
    --   position = "bottom", -- bottom, top
    --   margin = { 1, 0, 1, 0 },
    --   padding = { 2, 2, 2, 2 },
    --   zindex = 1000,
    -- },
    -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = {"<leader>"},
    -- triggers_nowait = {
    --   -- marks
    --   "`",
    --   "'",
    --   "g`",
    --   "g'",
    --   -- registers
    --   '"',
    --   "<c-r>",
    --   -- spelling
    --   "z=",
    -- },
  },
  opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
  -- vopts = {
  --   mode = "v",
  --   prefix = "<leader>",
  --   buffer = nil,
  --   silent = true,
  --   noremap = true,
  --   nowait = true,
  -- },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {},
}

function SplitLineByDelimiter(delimiter)
    local line = vim.api.nvim_get_current_line()  -- Get current line

    -- Split the line, keeping the delimiter in the parts
    local parts = {}
    for part in string.gmatch(line, "([^" .. delimiter .. "]+)" .. delimiter .. "?") do
        table.insert(parts, part .. delimiter)
    end

    -- Remove the trailing delimiter from the last part
    parts[#parts] = string.gsub(parts[#parts], delimiter .. "$", "")

    -- Replace current line with the split parts joined by new lines
    vim.api.nvim_buf_set_lines(0, vim.fn.line('.') - 1, vim.fn.line('.'), false, parts)
end

utils.map("", "H", "^")
utils.map("", "L", "$")
utils.map("n", "<C-n>", ":tabnew<CR><Esc>")
utils.map("n", "<C-m>", ":tabclose!<CR><Esc>")
utils.map("n", "<C-w>c", "<C-w>c<C-w>p")
-- utils.map("n", "<tab>", ":tabnext<CR>")
-- utils.map("n", "<S-tab>", ":tabprevious<CR>")
-- utils.map("n", "<C-h>", ":wincmd h<CR>")
-- utils.map("n", "<C-j>", ":wincmd j<CR>")
-- utils.map("n", "<C-k>", ":wincmd k<CR>")
-- utils.map("n", "<C-l>", ":wincmd l<CR>")
utils.map("n", "<CR>", ":nohlsearch<CR>")
utils.map("n", "<F5>", ":NvimTreeToggle<CR>")
utils.map("n", "<F2>", ":%! fm<CR>")
utils.map("n", "<C-f>", ":Telescope live_grep<CR>")
utils.map("t", "<Esc>", "<C-\\><C-n>")
utils.map("n", "<leader>r", [[:lua SplitLineByDelimiter(vim.fn.input('Delimiter: '))<CR>]])

local wk = require("which-key")
wk.add({
  { "<leader>T", group = "Treesitter", nowait = true, remap = false },
  { "<leader>Ti", ":TSConfigInfo<cr>", desc = "Info", nowait = true, remap = false },
  { "<leader>b", group = "Buffers", nowait = true, remap = false },
  { "<leader>bb", ":b#<cr>", desc = "Previous", nowait = true, remap = false },
  { "<leader>bd", ":bd<cr>", desc = "Delete", nowait = true, remap = false },
  { "<leader>bf", ":Telescope buffers <cr>", desc = "Find", nowait = true, remap = false },
  { "<leader>bl", ":Telescope buffers<CR>", desc = "List Buffers", nowait = true, remap = false },
  { "<leader>bn", ":bn<cr>", desc = "Next", nowait = true, remap = false },
  { "<leader>bp", ":bp<cr>", desc = "Previous", nowait = true, remap = false },
  -- { "<leader>c", ":BufferClose!<CR>", desc = "Close Buffer", nowait = true, remap = false },
  { "<leader>f", ":Telescope find_files <CR>", desc = "Find File", nowait = true, remap = false },
  { "<leader>g", group = "Git", nowait = true, remap = false },
  { "<leader>gb", ":Gitsigns blame_line<CR>", desc = "Blame", nowait = true, remap = false },
  { "<leader>gd", ":tabe % <CR> :Gitsigns diffthis<CR>", desc = "Diff", nowait = true, remap = false },
  { "<leader>gv", ":DiffviewOpen<CR>", desc = "Diff View", nowait = true, remap = false },
  { "<leader>h", ":nohlsearch<CR>", desc = "No Highlight", nowait = true, remap = false },
  { "<leader>l", group = "LSP", nowait = true, remap = false },
  { "<leader>lI", ":LspInstallInfo<cr>", desc = "Installer Info", nowait = true, remap = false },
  { "<leader>la", ":Telescope lsp_code_actions<cr>", desc = "Code Action", nowait = true, remap = false },
  { "<leader>ld", ":Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics", nowait = true, remap = false },
  { "<leader>lf", ":lua vim.lsp.buf.format({ async = true })<cr>", desc = "Format", nowait = true, remap = false },
  { "<leader>li", ":LspInfo<cr>", desc = "Info", nowait = true, remap = false },
  { "<leader>lr", ":lua vim.lsp.buf.rename()<cr>", desc = "Rename", nowait = true, remap = false },
  { "<leader>lw", ":Telescope diagnostics<cr>", desc = "Workspace Diagnostics", nowait = true, remap = false },
  { "<leader>s", group = "Search", nowait = true, remap = false },
  { "<leader>sC", ":Telescope commands <cr>", desc = "Commands", nowait = true, remap = false },
  { "<leader>sM", ":Telescope man_pages <cr>", desc = "Man Pages", nowait = true, remap = false },
  { "<leader>sR", ":Telescope registers <cr>", desc = "Registers", nowait = true, remap = false },
  { "<leader>sb", ":Telescope git_branches <cr>", desc = "Checkout branch", nowait = true, remap = false },
  { "<leader>sc", ":Telescope colorscheme <cr>", desc = "Colorscheme", nowait = true, remap = false },
  { "<leader>sf", ":Telescope find_files <cr>", desc = "Find File", nowait = true, remap = false },
  { "<leader>sh", ":Telescope help_tags <cr>", desc = "Find Help", nowait = true, remap = false },
  { "<leader>sj", ":Telescope jumplist <cr>", desc = "Jumplist", nowait = true, remap = false },
  { "<leader>sk", ":Telescope keymaps <cr>", desc = "Keymaps", nowait = true, remap = false },
  { "<leader>sn", ":Telescope live_grep search_dirs={os.getenv('NOTES')} <cr>", desc = "Notes", nowait = true, remap = false },
  { "<leader>sp", ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>", desc = "Colorscheme with Preview", nowait = true, remap = false },
  { "<leader>sr", ":Telescope oldfiles <cr>", desc = "Open Recent File", nowait = true, remap = false },
  { "<leader>st", ":Telescope live_grep <cr>", desc = "Text", nowait = true, remap = false },
  { "<leader>t", group = "Diagnostics", nowait = true, remap = false },
  { "<leader>td", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "document", nowait = true, remap = false },
  { "<leader>tl", "<cmd>TroubleToggle loclist<cr>", desc = "loclist", nowait = true, remap = false },
  { "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", desc = "quickfix", nowait = true, remap = false },
  { "<leader>tr", "<cmd>TroubleToggle lsp_references<cr>", desc = "references", nowait = true, remap = false },
  { "<leader>tt", "<cmd>TroubleToggle<cr>", desc = "trouble", nowait = true, remap = false },
  { "<leader>tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "workspace", nowait = true, remap = false },
})

-- local opts = which_key.opts
-- local vopts = which_key.vopts

-- local mappings = which_key.mappings
-- local vmappings = which_key.vmappings

-- wk.register(mappings, opts)
-- wk.register(vmappings, vopts)

-- if which_key.on_config_done then
--   which_key.on_config_done(wk)
-- end

vim.api.nvim_command("autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>")
