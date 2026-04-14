return {
  "hkupty/iron.nvim",
  keys = { { "<Leader>iI", "<cmd>IronRepl<cr>", desc = "Iron REPL" } },
  config = function()
    local iron = require "iron.core"
    local view = require "iron.view"
    local python_format = require("iron.fts.common").bracketed_paste_python

    -- Bracketed paste for litecli: sends whole block at once
    local sql_bracketed = function(lines)
      local cleaned = {}
      for _, line in ipairs(lines) do
        local sql = line:gsub("%-%-.*$", ""):gsub("/%*.*%*/", "")
        if sql:match "%S" then table.insert(cleaned, vim.trim(sql)) end
      end
      return "\27[200~" .. table.concat(cleaned, "\n") .. "\27[201~\n"
    end

    iron.setup {
      config = {
        scratch_repl = true,
        buflisted = true,
        close_on_exit = true,
        focus_on_send = false,
        repl_auto_scroll = true,
        repl_open_cmd = function()
          vim.cmd "rightbelow vsplit"
          return vim.api.nvim_get_current_win()
        end,

        repl_definition = {
          sh = {
            command = { "zsh" },
          },
          sql = {
            command = function(meta)
              local cwd = vim.fn.getcwd()
              local db = vim.fn.input("SQLite DB: ", cwd .. "/", "file")
              if db == "" then db = ":memory:" end
              return { "litecli", db }
            end,
            format = sql_bracketed,
            block_dividers = { "-- %%", "# %%" },
          },
          python = {
            command = { "uv", "run", "--with", "ipython", "ipython", "--no-autoindent" },
            format = python_format,
            block_dividers = { "# %%", "#%%" },
          },
          quarto = {
            command = { "uv", "run", "--with", "ipython", "ipython", "--no-autoindent" },
            format = python_format,
            block_dividers = { "# %%", "#%%" },
          },
        },
      },
      keymaps = {
        restart_repl = "<leader>iR",
        toggle_repl = "<leader>ii",
        send_motion = "<leader>is",
        visual_send = "<leader>is",
        send_file = "<leader>if",
        send_line = "<leader>il",
        send_mark = "<leader>in",
        mark_motion = "<leader>im",
        mark_visual = "<leader>im",
        remove_mark = "<leader>iu",
        cr = "<leader>i<cr>",
        interrupt = "<leader>ix",
        exit = "<leader>iq",
        clear = "<leader>ic",
        send_code_block = "<leader>ib",
      },
      highlight = {
        italic = false,
      },
      ignore_blank_lines = true,
    }
  end,
}
