vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>cR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename with %s" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>svc", "<cmd>source ~/.config/nvim/init.lua<CR>")

-- Buffers
vim.keymap.set("n", "<leader>bb", "<cmd>b#<CR>", { desc = "To last Buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>bd<CR>", { desc = "Delete current Buffer" })

-- Terminal
vim.keymap.set(
  "n",
  "<leader>t",
  "<cmd>belowright split | terminal fish<CR>",
  { noremap = true, silent = true, desc = "Open a Terminal" }
)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over selection without yanking" })
