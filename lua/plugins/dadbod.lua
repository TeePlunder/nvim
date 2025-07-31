return {
  -- Core Dadbod engine
  {
    "tpope/vim-dadbod",
  },

  -- Completion for :DB
  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "tpope/vim-dadbod" },
  },

  -- The UI itself
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod" },
    -- keymap to open UI in a new tab
    keys = {
      {
        "<leader>db",
        "<cmd>tabnew | DBUI<cr>",
        desc = "Open vim-dadbod-ui in a fresh tab",
      },
    },
    config = function()
      -- any extra UI configuration, e.g.:
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
}
