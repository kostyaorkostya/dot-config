local install = require('nvim-treesitter').install({
  'c',
  'cpp',
  'html',
  'javascript',
  'lalrpop',
  'lua',
  'ocaml',
  'python',
  'query',
  'rust',
  'starlark',
  'vim',
  'vimdoc',
})
if #vim.api.nvim_list_uis() == 0 then
  install:wait(300000)
end

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
    local function has_query(name)
      local ok, query = pcall(vim.treesitter.query.get, lang, name)
      return ok and query ~= nil
    end
    if not lang or not has_query('highlights') or not pcall(vim.treesitter.start, ev.buf, lang) then
      return
    end
    if has_query('indents') then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
