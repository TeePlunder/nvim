return {
	"echasnovski/mini.indentscope",
	version = false,
	event = "BufReadPre",
	config = function()
		require("mini.indentscope").setup()
	end,
}
