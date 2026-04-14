-- lua/plugins/blink.lua
return {
  "Saghen/blink.cmp",
  event = "InsertEnter",
  opts = {
    -- Custom keymaps based on your nvim-cmp configuration
    completion = {
      list = { selection = { preselect = true } },
      ghost_text = { enabled = false },
    },

    keymap = {
      preset = "none",
      -- Navigation
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
      ["<C-e>"] = { "show_documentation", "hide_documentation", "fallback" },
      -- Documentation scrolling
      ["<C-d>"] = { function(cmp) cmp.scroll_documentation_down(4) end, "fallback" },
      ["<C-u>"] = { function(cmp) cmp.scroll_documentation_up(4) end, "fallback" },
      -- Close completion menu
      ["<Esc>"] = { "hide", "fallback" },
      -- Enter key behavior
      ["<CR>"] = { "cancel", "fallback" },
      -- Tab key behavior - using blink.cmp functions
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.snippet_forward()
          else
            return cmp.select_and_accept()
          end
        end,
        "fallback",
      },
    },
    -- Configure your sources
    cmdline = {
      keymap = {
        preset = "inherit",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = {
          "accept",
          "fallback",
        },
      },
      completion = { menu = { auto_show = true }, ghost_text = { enabled = true } },
    },
    sources = {
      -- Add your sources to the default list
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        -- "omni",
      },
      providers = {},
    },
    --   -- For compatibility with any nvim-cmp sources you're using
    -- specs = {
    --   { "Saghen/blink.compat", version = "*", lazy = true, opts = {} },
    -- },
    -- -- Add dependencies for any non-blink sources
    -- dependencies = {
    --   "hrsh7th/cmp-nvim-lsp-signature-help",
    --   "hrsh7th/cmp-path",
    --   "hrsh7th/cmp-buffer",
    --   "hrsh7th/cmp-calc",
    --   "saadparwaiz1/cmp_luasnip",
    --   "kdheepak/cmp-latex-symbols",
    --   "hrsh7th/cmp-emoji",
    -- },
  },
}
