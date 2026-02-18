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
        require("none-ls.diagnostics.eslint_d"),
      },
    })

		vim.keymap.set("n", "<leader>fc", vim.lsp.buf.format, { desc = "Format Code" })
	end,
}
