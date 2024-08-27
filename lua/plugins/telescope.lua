return {
    -- Telescope and its dependencies
    {
        'nvim-telescope/telescope.nvim', 
        branch = '0.1.x',
        dependencies = { 
            'nvim-lua/plenary.nvim', 
            'nvim-treesitter/nvim-treesitter', 
        },
	config = function()
	    -- Default key mappings for Telescope
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
            vim.keymap.set('n', '<leader>sg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
        end,

    }
}
