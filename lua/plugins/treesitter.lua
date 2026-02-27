return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "lua", "go", "typescript", "javascript", "tsx",
        "html", "css", "json", "yaml", "markdown",
        "bash", "nix", "vim", "vimdoc",
      },
      autoinstall = false,
      highlight = {
        enable = true, -- false will disable the whole extension
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    })
  end,
}
