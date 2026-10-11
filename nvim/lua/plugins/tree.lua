require('nvim-tree').setup({
  -- set up at startup, so without these it would take over netrw for `nvim <dir>`
  hijack_netrw = false,
  hijack_directories = { enable = false },
  view = {
    width = 30,
    side = 'left',
  },
  renderer = {
    group_empty = true, -- Compact empty folders
    icons = {
      show = {
        git = true,
        folder = true,
        file = true,
      },
    },
  },
  filters = {
    dotfiles = false, -- Show hidden files
    custom = { '.git', 'node_modules', '.cache' },
  },
  actions = {
    open_file = {
      quit_on_open = true, -- Close tree when opening file
    },
  },
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<cr>', { desc = 'File tree' })
