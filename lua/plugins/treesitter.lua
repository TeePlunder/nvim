return {
	-- Other plugin configurations

	-- Tree-sitter configuration
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				autoinstall = true,
				highlight = {
					enable = true, -- false will disable the whole extension
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				},
				-- Add more configuration options as needed
			})
		end,
	},
}
