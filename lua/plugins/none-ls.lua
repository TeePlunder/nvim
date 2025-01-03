return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,
        -- TODO: try it for code actions
        -- null_ls.builtins.code_actions.eslint_d,
        require("none-ls.diagnostics.eslint_d"),
        -- TODO: try if something is not working
        null_ls.builtins.formatting.prettier.with({
          extra_args = { "--config-precedence", "prefer-file" },
        }),
        -- null_ls.builtins.formatting.prettierd,
      },
    })

    vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, { desc = "Format Code" })
  end,
}
