-- AstroLSP allows you to customize the features in AstroNvim's LSP configuration engine
-- Configuration documentation can be found with `:h astrolsp`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Configuration table of features provided by AstroLSP
    features = {
      codelens = true, -- enable/disable codelens refresh on start
      inlay_hints = true, -- enable/disable inlay hints on start
      semantic_tokens = true, -- enable/disable semantic token highlighting
    },
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
          "python",
          "html",
          "md",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 3000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- customize language server configuration passed to `vim.lsp.config`
    -- client specific configuration can also go in `lsp/` in your configuration root (see `:h lsp-config`)
    config = {
      -- ["*"] = { capabilities = {} }, -- modify default LSP client settings such as capabilities

      arduino_language_server = {
        cmd = {
          "arduino-language-server",
          "-cli-config",
          vim.fn.expand "~/.arduino15/arduino-cli.yaml", -- Expands ~ to your home dir
          "-fqbn",
          "arduino:avr:mega:cpu=atmega2560",
          "-cli",
          "arduino-cli", -- Optional: if not in PATH, put full path here
          "-clangd",
          "clangd", -- Optional: if not in PATH, put full path here
        },
        capabilities = {
          textDocument = {
            semanticTokens = vim.NIL,
          },
          offsetEncoding = { "utf-8" },
          workspace = {
            semanticTokens = vim.NIL,
          },
        },
      },
      sqls = {
        filetypes = { "sql" },
      },

      ruff = {
        init_options = { -- 不是必须要用setting
          settings = {
            logLevel = "warn",
            lineLength = 110,
            organizeImports = true,
            fixAll = true,
            lint = {
              select = {
                "E", -- pycodestyle errors
                "F", -- pyflakes（未使用变量/import）
                "UP", -- pyupgrade（自动升级旧语法）
                "I", -- isort（import 排序）
                "N", -- pep8-naming
                "B", -- flake8-bugbear（常见 bug 模式）
                "SIM", -- flake8-simplify（简化冗余代码）
                "RUF", -- ruff 专属规则
                "ARG", -- Unused arguments
                "PL", -- pylink
                "ANN", -- Type check
              },
            },
            format = { preview = false }, -- 只有 preview/backend 是 LSP 直接选项
            -- ruff 工具配置（等价于 ruff.toml 内容）放在 configuration 下，kebab-case
            configuration = {
              ["indent-width"] = 4, -- 顶层，不在 format 下
              format = {
                ["quote-style"] = "double",
                ["indent-style"] = "space", -- tab
                ["line-ending"] = "auto",
              },
            },
          },
        },
      },
      ty = {
        cmd = { "ty", "server" },
        filetypes = { "python" },
        root_markers = { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
        settings = {
          showSyntaxErrors = true,
          diagnosticMode = "openFilesOnly",
          configuration = {},
        },
        init_options = { logLevel = "warn" },
      },

      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              jedi = {
                environment = (function()
                  local cwd = vim.fn.getcwd()
                  local venv_python = cwd .. "/.venv/bin/python"
                  print(venv_python)
                  if vim.fn.executable(venv_python) == 1 then return venv_python end
                  return nil
                end)(),
              },
              jedi_completion = {
                include_class_objects = true,
                include_function_objects = true,
                fuzzy = true,
              },
              jedi_definition = {
                enabled = true,
                follow_imports = true,
                follow_builtin_imports = true,
              },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = true },
              jedi_signature_help = { enabled = true },
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
            },
          },
        },
      },
    },
    --
    -- customize how language servers are attached
    handlers = {
      pylsp = false,
      -- ty = false,
      -- ruff = false,
      -- a function with the key `*` modifies the default handler, functions takes the server name as the parameter
      -- ["*"] = function(server) vim.lsp.enable(server) end

      -- the key is the server that is being setup with `vim.lsp.config`
      -- rust_analyzer = false, -- setting a handler to false will disable the set up of that language server
    },
    -- A custom `on_attach` function to be run after the default `on_attach` function
    -- takes two parameters `client` and `bufnr`  (`:h lsp-attach`)
    on_attach = function(client, bufnr)
      -- this would disable semanticTokensProvider for all clients
      -- client.server_capabilities.semanticTokensProvider = nil
      if client.name == "ty" then client.server_capabilities.signatureHelpProvider = nil end
      if client.name == "ruff" then client.server_capabilities.hoverProvider = false end
    end,
  },
}
