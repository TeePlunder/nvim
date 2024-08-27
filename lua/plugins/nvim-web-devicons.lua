return {
    -- Other plugin configurations
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup {
                -- globally enable different icon highlights (optional)
                -- default is true
                color_icons = true;
                -- globally enable default icons (default to false)
                default = true;
            }
        end
    },
    -- Your other plugins here
}

