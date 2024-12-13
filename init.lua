require("config.lazy")
require("config.options")
require("config.keymaps")
require("config.autocmds")

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
