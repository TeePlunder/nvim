return {
  "filipdutescu/renamer.nvim",
  config = function()
    require("renamer").setup()
  end,
  keys = {
    { "i", "<F2>",       '<cmd>lua require("renamer").rename()<cr>', { desc = "Rename in Insert Mode" } },
    { "n", "<leader>cr", '<cmd>lua require("renamer").rename()<cr>', { desc = "Rename" } },
  },
}
