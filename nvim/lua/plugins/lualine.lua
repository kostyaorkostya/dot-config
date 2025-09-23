return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'solarized',
    },
    sections = {
      lualine_c = {
        {
          'filename',
          path = 3, -- 3: Absolute path, with tilde as the home directory
        },
      },
      lualine_y = {
        {
          'lsp_status',
        },
      },
    },
  },
}
