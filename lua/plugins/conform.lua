return {
  {
    "stevearc/conform.nvim",
    opts = {
      format = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
      },
      formatters_by_ft = {
        ["javascript"] = { { "prettierd", "prettier" } },
        ["typescript"] = { { "prettierd", "prettier" } },
      },
    },
  },
}
