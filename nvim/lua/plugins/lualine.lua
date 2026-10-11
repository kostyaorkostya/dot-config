require('lualine').setup({
  options = {
    theme = 'solarized',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      },
    },
    lualine_y = {
      {
        'lsp_status',
      },
    },
  },
})
