-- vim.api.nvim_create_autocmd("FileType", {
--     group = vim.api.nvim_create_augroup('XXCOrCxx', { clear = true }),
--     pattern = { "c", "cpp" },
--     callback = function()
--         vim.opt_local.cindent = true
--         vim.opt_local.cinoptions = {
--             "b1",   -- case labels
--             "g0",   -- C++ scope declarations
--             "N-s",  -- namespace contents
--             "t0",   -- function return type continuation
--             "W0",   -- unclosed parentheses
--         }
--     end,
-- })

-- Automatically delete trailing DOS-returns and whitespace on file open and
-- write.
-- vim.api.nvim_create_autocmd({'BufRead', 'BufWritePre', 'FileWritePre'}, {
--   group = vim.api.nvim_create_augroup('XXTrailingWhitespaces', { clear = true }),
--   pattern = '*',
--   callback = function()
--     -- Save cursor position
--     local save = vim.fn.winsaveview()
--     -- Remove trailing whitespace
--     vim.cmd([[keeppatterns %s/[\r \t]\+$//e]])
--     -- Restore cursor position
--     vim.fn.winrestview(save)
--   end,
-- })

-- Automatically close Quickfix window if it is the last one.
-- vim.api.nvim_create_autocmd('WinEnter', {
--   group = vim.api.nvim_create_augroup('XXQuickFixClose', { clear = true }),
--   pattern = '*',
--   callback = function()
--     -- Only one window left
--     if vim.fn.winnr('$') == 1 then
--       -- Check if it's a quickfix window
--       local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
--       if buftype == 'quickfix' then
--         vim.cmd('quit')
--       end
--     end
--   end,
-- })

-- vim.api.nvim_create_autocmd('FileType', {
--   group = vim.api.nvim_create_augroup('XXSpellcheckMarkdown', { clear = true }),
--   pattern = 'markdown',
--   callback = function()
--     vim.bo.spell = true
--     vim.bo.spelllang = 'en_us'
--   end,
-- })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gd', function()
      vim.cmd('tab split')
      vim.lsp.buf.declaration()
    end, opts)
    vim.keymap.set('n', 'gD', function()
      vim.cmd('tab split')
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  end,
})
