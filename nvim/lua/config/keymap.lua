vim.keymap.set({ 'n', 'i' }, '<F8>', '<Cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set({ 'n', 'i' }, '<F7>', '<Cmd>tabprevious<CR>', { desc = 'Previous tab' })

-- these replace nvim's default <Tab>/<S-Tab> snippet-jump maps, so they must jump too
local function menu_or_snippet(key, menu_key, direction)
  return function()
    if vim.fn.pumvisible() == 1 then
      return menu_key
    end
    if vim.snippet.active({ direction = direction }) then
      return ('<Cmd>lua vim.snippet.jump(%d)<CR>'):format(direction)
    end
    return key
  end
end
vim.keymap.set({ 'i', 's' }, '<Tab>', menu_or_snippet('<Tab>', '<C-n>', 1), { expr = true, desc = 'Next completion' })
vim.keymap.set(
  { 'i', 's' },
  '<S-Tab>',
  menu_or_snippet('<S-Tab>', '<C-p>', -1),
  { expr = true, desc = 'Previous completion' }
)
vim.keymap.set('i', '<CR>', function()
  return vim.fn.complete_info({ 'selected' }).selected ~= -1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Accept completion' })

-- this makes vim's regex engine "not stupid"
-- see :h magic
vim.keymap.set({ 'n', 'x', 'o' }, '/', '/\\v')

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics under cursor' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'All diagnostics to location list' })
vim.keymap.set('n', '<leader>u', '<Cmd>Undotree<CR>', { desc = 'Undo tree' })
