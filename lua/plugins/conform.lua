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
        ["javascript"] = { "prettierd", "prettier" },
        ["javascriptreact"] = { "prettierd", "prettier" },
        ["typescript"] = { "prettierd", "prettier" },
        ["typescriptreact"] = { "prettierd", "prettier" },
      },
      default_format_opts = {
        stop_after_first = true,
      },
    },
  },
}
