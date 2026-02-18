return {
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>fc", function() require("conform").format() end, desc = "Format Code" },
    },
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
        ["lua"] = { "stylua" },
      },
      default_format_opts = {
        stop_after_first = true,
      },
    },
  },
}
