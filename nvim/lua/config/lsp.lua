vim.lsp.config('lua_ls', {
  -- Override the default cmd so the server writes its log/cache under
  -- $XDG_CACHE_HOME, not next to its (read-only) install dir under /opt.
  cmd = {
    'lua-language-server',
    '--logpath',
    vim.fn.stdpath('cache') .. '/lua-language-server',
  },
  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }, -- Recognize vim global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true), -- Neovim runtime files
        checkThirdParty = false, -- Disable annoying prompts
      },
    },
  },
})

vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        allFeatures = true,
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})
