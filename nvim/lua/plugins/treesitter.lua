return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master',
  build = ':TSUpdate',
  config = function()
    local configs = require('nvim-treesitter.configs')

    configs.setup({
      ensure_installed = {
        'c',
        'cpp',
        'html',
        'javascript',
        'lalrpop',
        'lua',
        'ocaml',
        'python',
        'query',
        'rust',
        'starlark',
        'tmux',
        'vim',
        'vimdoc',
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
