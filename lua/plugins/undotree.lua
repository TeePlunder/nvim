return {
  'mbbill/undotree',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  config = function()
    vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
  end
}
