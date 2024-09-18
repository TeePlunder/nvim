return {
  -- Telescope and its dependencies
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local keymap = vim.keymap

      telescope.setup({
        defaults = {
          file_ignore_patterns = { "node_modules" },
          mappings = {
            n = {
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<C-S-d>"] = actions.delete_buffer,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true
          }
        }
      })

      telescope.load_extension("live_grep_args")

      keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        { desc = "Live Grep" })
      keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
      keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
      keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Find Keymaps" })
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
    end,
  },
}
