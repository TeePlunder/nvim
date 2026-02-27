vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- Auto-stop LSP after losing focus (e.g. switching zellij sessions)
local lsp_idle_timer = nil
local lsp_stopped = false

vim.api.nvim_create_autocmd("FocusLost", {
  callback = function()
    if lsp_idle_timer then
      lsp_idle_timer:stop()
    end
    lsp_idle_timer = vim.defer_fn(function()
      local clients = vim.lsp.get_clients()
      if #clients > 0 then
        vim.cmd("LspStop")
        lsp_stopped = true
      end
    end, 5 * 60 * 1000) -- 5 minutes
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    if lsp_idle_timer then
      lsp_idle_timer:stop()
      lsp_idle_timer = nil
    end
    if lsp_stopped then
      vim.cmd("LspStart")
      lsp_stopped = false
    end
  end,
})
