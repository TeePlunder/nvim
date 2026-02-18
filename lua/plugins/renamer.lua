return {
  "filipdutescu/renamer.nvim",
  config = function()
    require("renamer").setup()

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, noremap = true, silent = true }
        vim.keymap.set("i", "<F2>", '<cmd>lua require("renamer").rename()<cr>',
          vim.tbl_extend("force", opts, { desc = "Rename in Insert Mode" }))
        vim.keymap.set({ "n", "v" }, "<leader>cr", '<cmd>lua require("renamer").rename()<cr>',
          vim.tbl_extend("force", opts, { desc = "Rename" }))
      end,
    })
  end,
}
