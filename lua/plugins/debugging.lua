return {
  {
    "mfussenegger/nvim-dap",
    dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
    -- lazy = true,
    keys = {
      { "<Leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { '<F10>',      function() require('dap').step_over() end,         desc = "" },
      { '<F11>',      function() require('dap').step_into() end,         desc = "" },
      { "<F12>",      function() require("dap").step_out() end,          desc = "Step Out" },
      { "<Leader>du", function() require("dapui").toggle() end,          desc = "Dap UI Toggle" },
      { "<Leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
