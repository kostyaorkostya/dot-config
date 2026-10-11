local function open_in_new_tab(t)
  vim.cmd('tab split')
  if #t.items > 1 then
    vim.fn.setqflist({}, ' ', t)
    vim.cmd('botright copen')
    return
  end
  local item = t.items[1]
  local buf = item.bufnr or vim.fn.bufadd(item.filename)
  vim.bo[buf].buflisted = true
  vim.api.nvim_win_set_buf(0, buf)
  vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
  vim.cmd('normal! zv')
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = args.buf, desc = desc })
    end
    map('gd', function()
      vim.lsp.buf.declaration({ on_list = open_in_new_tab })
    end, 'LSP declaration (new tab)')
    map('gD', function()
      vim.lsp.buf.definition({ on_list = open_in_new_tab })
    end, 'LSP definition (new tab)')
    map('<leader>h', function()
      local filter = { bufnr = args.buf }
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
    end, 'Toggle inlay hints')
  end,
})
