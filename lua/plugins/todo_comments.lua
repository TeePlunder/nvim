return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup()

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
  end,
  event = "BufRead",
  keys = {
    {
      "<leader>ft",
      "<CMD>TodoTelescope<CR>",
      desc = "Find Todo",
    },
    {
      "<leader>xt",
      "<CMD>TodoTrouble<CR>",
      desc = "Todo (Troube)",
    },
    {
      "<leader>xt",
      "<CMD>TodoTrouble<CR>",
      desc = "Todo (Troube)",
    },
  },
}
