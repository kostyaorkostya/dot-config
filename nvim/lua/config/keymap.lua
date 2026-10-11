vim.keymap.set({ 'n', 'i' }, '<F8>', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set({ 'n', 'i' }, '<F7>', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- this makes vim's regex engine "not stupid"
-- see :h magic
vim.keymap.set({ 'n', 'x', 'o' }, '/', '/\\v')

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics under cursor' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'All diagnostics to location list' })
