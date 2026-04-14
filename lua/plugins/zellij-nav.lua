-- Zellij navigation integration (like vim-tmux-navigator)
-- Allows seamless Ctrl+hjkl navigation between nvim windows and zellij panes

---@type LazySpec
return {
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    -- Normal mode navigation
    { "<C-h>", "<cmd>ZellijNavigateLeft<cr>", mode = { "n" }, desc = "Navigate left (zellij aware)" },
    { "<C-j>", "<cmd>ZellijNavigateDown<cr>", mode = { "n" }, desc = "Navigate down (zellij aware)" },
    { "<C-k>", "<cmd>ZellijNavigateUp<cr>", mode = { "n" }, desc = "Navigate up (zellij aware)" },
    { "<C-l>", "<cmd>ZellijNavigateRight<cr>", mode = { "n" }, desc = "Navigate right (zellij aware)" },
    -- Terminal mode navigation (escape first, then navigate)
    { "<C-h>", "<cmd>ZellijNavigateLeft<cr>", mode = { "t" }, desc = "Navigate left (zellij aware)" },
    { "<C-j>", "<cmd>ZellijNavigateDown<cr>", mode = { "t" }, desc = "Navigate down (zellij aware)" },
    { "<C-k>", "<cmd>ZellijNavigateUp<cr>", mode = { "t" }, desc = "Navigate up (zellij aware)" },
    { "<C-l>", "<cmd>ZellijNavigateRight<cr>", mode = { "t" }, desc = "Navigate right (zellij aware)" },
  },
  opts = {},
}
