-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Function to set file format to CRLF
local function set_fileformat_to_crlf()
  vim.bo.fileformat = "dos"
end

-- Auto command to set file format to CRLF on file save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = set_fileformat_to_crlf,
})
