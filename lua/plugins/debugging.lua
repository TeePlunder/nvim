local js_based_languages = {
  "typescript",
  "javascript",
  "typescriptreact",
  "javascriptreact",
  "vue",
}

local function get_pkg_path(pkg, subpath)
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  return root .. "/packages/" .. pkg .. "/" .. subpath
end


return {
  {
    "mfussenegger/nvim-dap",
    -- lazy = true,
    keys = {
      { "<Leader>dc", function() require("dap").continue() end,          desc = "Continue" },
      { '<Leader>do', function() require('dap').step_over() end,         desc = "Step Over" },
      { '<Leader>di', function() require('dap').step_into() end,         desc = "Step Into" },
      { "<Leader>dO", function() require("dap").step_out() end,          desc = "Step Out" },
      { "<Leader>du", function() require("dapui").toggle() end,          desc = "Dap UI Toggle" },
      { "<Leader>dt", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      {
        "<leader>da",
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Run with Args",
      },
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("mason-nvim-dap").setup({
        automatic_installation = true
      })

      dap.listeners.before.attach.dapui_config           = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config           = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config     = function()
        ui.close()
      end

      dap.adapters['pwa-node']                           = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            get_pkg_path('js-debug-adapter', '/js-debug/src/dapDebugServer.js'),
            '${port}',
          },
        },
      }

      local function list_subdirs(path)
        local scan = vim.loop.fs_scandir(path)
        if not scan then return {} end
        local names = {}
        while true do
          local name, t = vim.loop.fs_scandir_next(scan)
          if not name then break end
          if t == "directory" then
            table.insert(names, name)
          end
        end
        return names
      end

      local workspace_root          = vim.fn.getcwd()
      local apps_dir                = workspace_root .. "/apps"
      local libs_dir                = workspace_root .. "/libs"

      -- collect all app-names (subfolders of /apps)
      local app_names               = list_subdirs(apps_dir)

      -- collect all lib-names (subfolders of /libs)
      local lib_names               = list_subdirs(libs_dir)

      -- prepare the configurations table
      dap.configurations.typescript = {}
      dap.configurations.javascript = {} -- mirror for JS if needed

      for _, app_name in ipairs(app_names) do
        -- each app lives in /apps/<app_name>
        local app_root          = apps_dir .. "/" .. app_name

        -- outFiles should include:
        --  • this app’s dist/**/*.js
        --  • every lib’s dist/**/*.js
        local app_dist_glob     = app_root .. "/dist/**/*.js"
        local all_libs_globs    = vim.tbl_map(function(lib_name)
          return libs_dir .. "/" .. lib_name .. "/dist/**/*.js"
        end, lib_names)

        -- combine them into one array: { "<app>/dist/**/*.js", "libs/lib1/dist/**/*.js", ... }
        local combined_outfiles = { app_dist_glob }
        for _, lib_glob in ipairs(all_libs_globs) do
          table.insert(combined_outfiles, lib_glob)
        end

        -- insert the “Attach” config for this app:
        table.insert(dap.configurations.typescript, {
          name       = app_name .. ": Attach (apps + libs)",
          type       = "pwa-node",
          request    = "attach",
          -- IMPORTANT: run the adapter from inside the app’s folder
          cwd        = app_root,
          address    = "localhost",
          port       = 9229, -- assumes each app is (externally) started with --inspect=9229
          sourceMaps = true,
          outFiles   = combined_outfiles,
          skipFiles  = { "<node_internals>/**/*.js" },
        })

        -- mirror for plain-JS if you ever have .js entry points
        table.insert(dap.configurations.javascript, {
          name       = app_name .. ": Attach (apps + libs)",
          type       = "pwa-node",
          request    = "attach",
          cwd        = app_root,
          address    = "localhost",
          port       = 9229,
          sourceMaps = true,
          outFiles   = combined_outfiles,
          skipFiles  = { "<node_internals>/**/*.js" },
        })
      end
    end,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      -- Install the vscode-js-debug adapter
      {
        "microsoft/vscode-js-debug",
        -- After install, build it and rename the dist directory to out
        build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
        version = "1.*",
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
  },
}
