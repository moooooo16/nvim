return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    handlers = {
      python = function(source_name)
        local dap = require "dap"

        local cwd = vim.fn.getcwd()
        local venv_python = cwd .. "/.venv/bin/python"
        dap.adapters.python = {
          type = "executable",
          command = venv_python,
          args = {
            "-m",
            "debugpy.adapter",
          },
        }

        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}", -- This configuration will launch the current file if used.
          },
        }
      end,
    },
  },
}
