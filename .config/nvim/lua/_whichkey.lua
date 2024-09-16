local utils_ok, utils = pcall(require, "utils")
if not utils_ok then
  return
end

local which_key = {
  setup = {
    plugins = {
      marks = true,
      registers = true,
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
      spelling = { enabled = true, suggestions = 20 },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      zindex = 1000,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    show_help = true,
    triggers = {"<leader>"},
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",
      -- registers
      '"',
      "<c-r>",
      -- spelling
      "z=",
    },
  },

  opts = {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
  vopts = {
    mode = "v",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
  },
  -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
  -- see https://neovim.io/doc/user/map.html#:map-cmd
  vmappings = {},
  mappings = {
    ["c"] = { ":BufferClose!<CR>", "Close Buffer" },
    ["f"] = { ":Telescope find_files <CR>", "Find File" },
    ["h"] = { ":nohlsearch<CR>", "No Highlight" },
    -- a = {
    --   name = "AI",
    --   a = { ":AvanteAsk<cr>", "AvanteAsk" },
    -- },
    b = {
      name = "Buffers",
      l = { ":Telescope buffers<CR>", "List Buffers" },
      b = { ":b#<cr>", "Previous" },
      d = { ":bd<cr>", "Delete" },
      f = { ":Telescope buffers <cr>", "Find" },
      n = { ":bn<cr>", "Next" },
      p = { ":bp<cr>", "Previous" },
    },
    g = {
      name = "Git",
      d = { ":tabe % <CR> :Gitsigns diffthis<CR>", "Diff" },
      b = { ":Gitsigns blame_line<CR>", "Blame" },
      v = { ":DiffviewOpen<CR>", "Diff View" },
    },
    l = {
      name = "LSP",
      a = { ":Telescope lsp_code_actions<cr>", "Code Action" },
      d = {
        ":Telescope diagnostics bufnr=0<cr>",
        "Document Diagnostics",
      },
      w = {
        ":Telescope diagnostics<cr>",
        "Workspace Diagnostics",
      },
      f = { ":lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
      i = { ":LspInfo<cr>", "Info" },
      I = { ":LspInstallInfo<cr>", "Installer Info" },
      r = { ":lua vim.lsp.buf.rename()<cr>", "Rename" },
    },
    s = {
      name = "Search",
      b = { ":Telescope git_branches <cr>", "Checkout branch" },
      c = { ":Telescope colorscheme <cr>", "Colorscheme" },
      C = { ":Telescope commands <cr>", "Commands" },
      f = { ":Telescope find_files <cr>", "Find File" },
      h = { ":Telescope help_tags <cr>", "Find Help" },
      j = { ":Telescope jumplist <cr>", "Jumplist" },
      k = { ":Telescope keymaps <cr>", "Keymaps" },
      M = { ":Telescope man_pages <cr>", "Man Pages" },
      r = { ":Telescope oldfiles <cr>", "Open Recent File" },
      R = { ":Telescope registers <cr>", "Registers" },
      t = { ":Telescope live_grep <cr>", "Text" },
      n = { ":Telescope live_grep search_dirs={os.getenv('NOTES')} <cr>", "Notes" },
      p = {
        ":lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
        "Colorscheme with Preview",
      },
    },
    T = {
      name = "Treesitter",
      i = { ":TSConfigInfo<cr>", "Info" },
    },
    t = {
      name = "Diagnostics",
      t = { "<cmd>TroubleToggle<cr>", "trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
    },
  },
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
utils.map("n", "<F5>", ":Neotree toggle<CR>")
utils.map("n", "<F2>", ":%! fm<CR>")
utils.map("n", "<C-f>", ":Telescope live_grep<CR>")
utils.map("t", "<Esc>", "<C-\\><C-n>")
utils.map("n", "<leader>r", [[:lua SplitLineByDelimiter(vim.fn.input('Delimiter: '))<CR>]])

local wk = require("which-key")
wk.setup(which_key.setup)

local opts = which_key.opts
local vopts = which_key.vopts

local mappings = which_key.mappings
local vmappings = which_key.vmappings

wk.register(mappings, opts)
wk.register(vmappings, vopts)

if which_key.on_config_done then
  which_key.on_config_done(wk)
end

vim.api.nvim_command("autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>")
