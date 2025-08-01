vim.keymap.set('n', '<F4>', vim.cmd.Vexplore)

vim.keymap.set('n', '<F8>', vim.cmd.tabnext)
vim.keymap.set('i', '<F8>', function()
  vim.cmd.stopinsert()
  vim.cmd.tabnext()
  vim.cmd.startinsert()
end)

vim.keymap.set('n', '<F7>', vim.cmd.tabprevious)
vim.keymap.set('i', '<F7>', function()
  vim.cmd.stopinsert()
  vim.cmd.tabprevious()
  vim.cmd.startinsert()
end)

-- this makes vim's regex engine "not stupid"
-- see :h magic
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('v', '/', '/\\v')
