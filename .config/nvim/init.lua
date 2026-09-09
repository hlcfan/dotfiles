require("config.options")
-- Register large-file detection before plugins and filetype handling.
require("config.bigfile")
require("config.keymaps")
require("config.terminal")
require("config.diagnostics")

vim.filetype.add({ extension = { http = "http" } })

require("config.lazy")
