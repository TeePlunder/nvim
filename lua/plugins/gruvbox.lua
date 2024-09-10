return {
  {
    "morhetz/gruvbox",
    priority = 1000,
    config = function()
      vim.g.gruvbox_contrast_dark = 'soft' -- Options: 'soft', 'medium', 'hard'
      vim.g.gruvbox_invert_selection = '0'
      vim.cmd("colorscheme gruvbox")       -- Set Gruvbox as the default color scheme
    end
  }
}
