local parsers = {
  "lua",
  "go",
  "typescript",
  "javascript",
  "tsx",
  "html",
  "css",
  "json",
  "yaml",
  "markdown",
  "bash",
  "nix",
  "vim",
  "vimdoc",
}

local filetypes = {
  "lua",
  "go",
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "html",
  "css",
  "json",
  "yaml",
  "markdown",
  "sh",
  "bash",
  "nix",
  "vim",
  "help",
}

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter")

    treesitter.install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = filetypes,
      callback = function(args)
        if pcall(vim.treesitter.start, args.buf) then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
