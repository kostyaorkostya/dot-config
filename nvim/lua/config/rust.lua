local function line_diagnostics()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  return vim.diagnostic.get(0, { lnum = lnum })
end

local function show(lines, filetype, id)
  if #lines == 0 then
    vim.notify('Nothing to show', vim.log.levels.INFO)
    return
  end
  vim.lsp.util.open_floating_preview(lines, filetype, { focus_id = id })
end

local function rendered_error()
  local lines = {}
  for _, d in ipairs(line_diagnostics()) do
    local rendered = vim.tbl_get(d, 'user_data', 'lsp', 'data', 'rendered')
    if rendered then
      vim.list_extend(lines, vim.split(rendered, '\n', { trimempty = true }))
      table.insert(lines, '')
    end
  end
  show(lines, '', 'rust-rendered')
end

local function explain_error()
  for _, d in ipairs(line_diagnostics()) do
    local code = type(d.code) == 'string' and d.code:match('^E%d%d%d%d$')
    if code then
      vim.system({ 'rustc', '--explain', code }, { text = true }, function(out)
        vim.schedule(function()
          show(vim.split(out.stdout or out.stderr or '', '\n'), 'markdown', 'rust-explain')
        end)
      end)
      return
    end
  end
  vim.notify('No rustc error code on this line', vim.log.levels.INFO)
end

local function expand_macro(client)
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:request('rust-analyzer/expandMacro', params, function(err, result)
    if err or not result then
      vim.notify('No macro under cursor', vim.log.levels.INFO)
      return
    end
    vim.cmd('vnew')
    local buf = vim.api.nvim_get_current_buf()
    vim.bo[buf].buftype = 'nofile'
    vim.bo[buf].bufhidden = 'wipe'
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(('// %s\n%s'):format(result.name, result.expansion), '\n'))
    vim.bo[buf].filetype = 'rust'
  end)
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client or client.name ~= 'rust_analyzer' then
      return
    end
    local function map(lhs, rhs, desc)
      vim.keymap.set('n', lhs, rhs, { buffer = args.buf, desc = desc })
    end
    map('<leader>rd', rendered_error, 'Full rustc error')
    map('<leader>re', explain_error, 'rustc --explain')
    map('<leader>rm', function()
      expand_macro(client)
    end, 'Expand macro')
  end,
})
