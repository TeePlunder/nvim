return {
	"filipdutescu/renamer.nvim",
	config = function()
		require("renamer").setup()
	end,
	keys = {
		{
			"i",
			"<F2>",
			'<cmd>lua require("renamer").rename()<cr>',
			{ noremap = true, silent = true, desc = "Rename in Insert Mode" },
		},
		{
			{ "n", "v" },
			"<leader>cr",
			'<cmd>lua require("renamer").rename()<cr>',
			{ noremap = true, silent = true, desc = "Rename in Normal/Visual Mode" },
		},
	},
}
