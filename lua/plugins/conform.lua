return {
  {
    "stevearc/conform.nvim",
    keys = {
      { "<leader>fc", function() require("conform").format() end, desc = "Format Code" },
    },
    event = "BufWritePre",
    opts = {
      format_on_save = {
        timeout_ms = 3000,
      },
      formatters_by_ft = {
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["lua"] = { "stylua" },
      },
      default_format_opts = {
        stop_after_first = true,
      },
    },
  },
}
