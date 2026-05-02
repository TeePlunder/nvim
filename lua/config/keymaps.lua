vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines (keep cursor)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up (centered)" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev match (centered)" })

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "Next quickfix" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "Prev quickfix" })

vim.keymap.set("n", "<leader>cR", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Rename with %s" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

vim.keymap.set("n", "<leader>svc", "<cmd>source ~/.config/nvim/init.lua<CR>", { desc = "Source nvim config" })

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
