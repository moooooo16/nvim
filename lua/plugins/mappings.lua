return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      -- Mappings can be configured through AstroCore as well.
      -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
      mappings = {
        -- first key is the mode
        t = {
          ["<esc>"] = { [[<C-\><C-n>]], desc = "Exit terminal mode" },
          ["jk"] = { [[<C-\><C-n>]], desc = "Exit terminal mode" },
          ["<D-i>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
          ["<C-'>"] = { "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        },
        i = {
          ["jk"] = { "<ESC>", desc = "Escape insert mode" },
          ["<C-h>"] = { "<Left>", desc = "move left", noremap = true },
          ["<C-l>"] = { "<Right>", desc = "move right", noremap = true },
          ["<C-j>"] = { "<Down>", desc = "move down", noremap = true },
          ["<C-k>"] = { "<Up>", desc = "move up", noremap = true },
          ["<D-i>"] = { "<Esc><Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        },
        n = {
          ["<Leader>Q"] = false,
          -- ["<Leader>q"] = false,
          ["<Leader>h"] = false,
          ["<Leader>w"] = false,
          ["<Leader>R"] = false,
          ["<Leader>n"] = false,
          ["<Leader>o"] = false,
          -- second key is the lefthand side of the map
          ["<D-i>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
          ["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
          -- ["<Leader>q"] = { desc = "Quarto", noremap = true },

          -- ["<Leader>q"] = { "<Nop>", desc = "Quarto", noremap = true },
          -- ["<Leader>i"] = { "<Nop>", desc = "Iron", noremap = true },

          -- ["<Leader>qp"] = { "<cmd>QuartoPreview<cr>", desc = "Quarto Preview", silent = true },
          -- ["<Leader>qq"] = { "<cmd>QuartoClosePreview<cr>", desc = "Close Quarto Preview", silent = true },
          -- ["<Leader>qh"] = { "<cmd>QuartoHelp<cr>", desc = "Quarto Help", silent = true },
          -- ["<Leader>qd"] = { "<cmd>QuartoDiagnostics<cr>", desc = "Quarto Diagnostics", silent = true },
          -- Quarto code execution
          -- ["<Leader>qs"] = { "<cmd>QuartoSend<cr>", desc = "Run cell", silent = true },
          -- ["<Leader>qa"] = { "<cmd>QuartoSendAbove<cr>", desc = "Run cell and above", silent = true },
          -- ["<Leader>qb"] = { "<cmd>QuartoSendBelow<cr>", desc = "Run cell and below", silent = true },
          -- ["<Leader>qA"] = { "<cmd>QuartoSendAll<cr>", desc = "Run all cells", silent = true },
          -- ["<Leader>ql"] = { "<cmd>QuartoSendLine<cr>", desc = "Run line", silent = true },
          -- -- navigate buffer tabs
          ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

          -- tables with just a `desc` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { desc = "Buffers" },
          ["<Leader>bd"] = false,
          ["<Leader>bc"] = false,
          ["<Leader>c"] = false,
          ["<Leader>C"] = false,
          ["<Leader>bq"] = {
            function() require("astrocore.buffer").close() end,
            desc = "Close buffer from tabline",
          },
          ["<Leader>bo"] = {
            function() require("astrocore.buffer").close_all(true) end,
            desc = "Close buffer from tabline",
          },
          -- setting a mapping to false will disable it
          -- ["<C-S>"] = false,
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      -- mappings to be set up on attaching of a language server
      mappings = {
        n = {
          -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
          -- gD = {
          --   function() vim.lsp.buf.declaration() end,
          --   desc = "Declaration of current symbol",
          --   cond = "textDocument/declaration",
          -- },
          ["<Leader>lY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
          -- Use a decalared symbol
          ["<leader>lr"] = {
            function() vim.lsp.buf.rename() end,
            desc = "LSP Rename",
            cond = "textDocument/rename",
          },
          -- ["<leader>lt"] = {
          --   function() vim.lsp.buf.type_definition() end,
          --   desc = "LSP Type Definition",
          --   cond = "textDocument/typeDefinition",
          -- },
          -- ["<leader>la"] = {
          --   function() vim.lsp.buf.code_action() end,
          --   desc = "LSP Code Action",
          --   cond = "textDocument/codeAction",
          -- },
          --  Declaration is first define a symbol
          ["<leader>lD"] = {
            function() vim.lsp.buf.declaration() end,
            desc = "LSP Declaration",
            cond = "textDocument/declaration",
          },
          --  Definition is you define a value for a symbol
          ["<leader>ld"] = {
            function() vim.lsp.buf.definition() end,
            desc = "LSP Definition",
            cond = "textDocument/definition",
          },
          -- ["<leader>lm"] = {
          --   function() vim.lsp.buf.implementation() end,
          --   desc = "LSP Implementation",
          --   cond = "textDocument/implementation",
          -- },
          ["<leader>lR"] = {
            function() vim.lsp.buf.references() end,
            desc = "LSP References",
            cond = "textDocument/references",
          },
        },
      },
    },
  },
}
