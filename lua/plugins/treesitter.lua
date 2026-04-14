-- Customize Treesitter
-- --------------------
-- Treesitter customizations are handled with AstroCore
-- as nvim-treesitter simply provides a download utility for parsers

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      highlight = true, -- enable/disable treesitter based highlighting
      indent = true, -- enable/disable treesitter based indentation
      auto_install = true, -- enable/disable automatic installation of detected languages
      ensure_installed = {
      "arduino",
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "csv",
      "dockerfile",
      "git_config",
      "html",
      "java",
      "javascript",
      "json",
      "latex",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "norg",
      "python",
      "r",
      "regex",
      "sql",
      "ssh_config",
      "toml",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
      },
    },
  },
}
