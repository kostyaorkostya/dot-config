local wk = require('which-key')
wk.setup({})
wk.add({
  { '<leader>s', group = 'Search' },
  { '<leader>g', group = 'Git' },
  { '<leader>r', group = 'Rust' },
})
