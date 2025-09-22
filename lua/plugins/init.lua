return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'black',
        'buf',
        'clang-format',
        'shellcheck',
        'shfmt',
        'stylua',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bzl',
          'clangd',
          'lua_ls',
        },
      })
      vim.lsp.enable('rust_analyzer')
    end,
  },
  {
    -- shows LSP progress
    'j-hui/fidget.nvim',
    opts = {
      -- options
    },
  },
}
