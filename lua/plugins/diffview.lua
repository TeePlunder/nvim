return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewRefresh",
    "DiffviewFileHistory",
  },
  keys = {
    { "<leader>dvo", "<cmd>DiffviewOpen<cr>", desc = "Diffview open" },
    { "<leader>dvc", "<cmd>DiffviewClose<cr>", desc = "Diffview close" },
    { "<leader>dvh", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview file history" },
    { "<leader>dvf", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview current file history" },
  },
}
