return {
  -- Telescope and its dependencies
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("telescope").setup({})
    end,
    keys = {
      { "n", "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "Find Files" } },
      { "n", "<leader>sg", "<cmd>lua require('telescope.builtin').live_grep()<cr>",  { desc = "Live Grep" } },
      { "n", "<leader>fb", "<cmd>lua require('telescope.builtin').buffers()<cr>",    { desc = "Buffers" } },
      { "n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>",  { desc = "Help Tags" } },
    },
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
