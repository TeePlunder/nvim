return {
  "filipdutescu/renamer.nvim",
  config = function()
    require("renamer").setup()

    local opts = { noremap = true, silent = true }
    vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', opts)
    vim.keymap.set({ "n", "v" }, "<leader>cr", '<cmd>lua require("renamer").rename()<cr>', opts)
  end,
}
