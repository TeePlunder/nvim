return {
  "filipdutescu/renamer.nvim",
  config = function()
    local function getOpts(desc)
      return { noremap = true, silent = true, desc = desc }
    end

    require("renamer").setup()

    -- Keymaps
    vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>', getOpts("Rename in Insert Mode"))
    vim.keymap.set({ "n", "v" }, "<leader>cr", '<cmd>lua require("renamer").rename()<cr>', getOpts("Rename"))
  end,
}
