return {
  -- Other plugin configurations

  -- Tree-sitter configuration
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {"lua", "markdown", "markdown_inline", "javascript"}, -- Install all parsers (or specify a list like {"lua", "python", "javascript"})
        highlight = {
          enable = true,              -- false will disable the whole extension
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true
        },
        -- Add more configuration options as needed
      }
    end
  }
}

