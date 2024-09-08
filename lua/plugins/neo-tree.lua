return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  opts = {
    window = {
      position = "right", -- This should correctly set the Neo-tree to open on the right side
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)

    -- Keymaps
    vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>f', ':Neotree focus<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<leader>r', ':Neotree refresh<CR>', { noremap = true, silent = true })

    -- Navigation and File Operations
    -- vim.api.nvim_set_keymap('n', '<leader>n', ':Neotree reveal<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '<CR>', ':Neotree open<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 's', ':Neotree split<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'v', ':Neotree vsplit<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'q', ':Neotree close<CR>', { noremap = true, silent = true })
  end,
}
