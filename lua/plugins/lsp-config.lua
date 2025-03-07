return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      automatic_installation = true,
      ensure_installed = { "lua_ls", "gopls" },
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
      })
      -- Add border to hover
      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover, {
          border = "rounded" -- You can use "single", "double", "rounded", etc.
        }
      )

      -- keymaps

      local function filter(arr, fn)
        if type(arr) ~= "table" then
          return arr
        end

        local filtered = {}
        for k, v in pairs(arr) do
          if fn(v, k, arr) then
            table.insert(filtered, v)
          end
        end

        return filtered
      end

      local function filterReactDTS(value)
        return string.match(value.filename, "react/index.d.ts") == nil
      end

      local function on_list(options)
        local items = options.items
        if #items > 1 then
          items = filter(items, filterReactDTS)
        end

        vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })
        vim.api.nvim_command("cfirst") -- or maybe you want 'copen' instead of 'cfirst'
      end

      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

      vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition({ on_list = on_list })
      end, { desc = "Go to Definition" })
      -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    end,
  },
}
