return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
    { "<space>-", function() require("oil").toggle_float() end, desc = "Open parent directory (float)" },
  },
  cmd = "Oil",
  opts = {
    columns = { "icon" },
    keymaps = {
      ["<C-h>"] = false,
      ["<M-h>"] = "actions.select_split",
    },
    viewoptions = {
      show_hidden = true,
    },
  },
}
