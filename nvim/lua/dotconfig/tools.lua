local M = {}

M.lsp_servers = {
  lua_ls = 'lua-language-server',
  clangd = 'clangd',
  rust_analyzer = 'rust-analyzer',
  starpls = 'starpls',
  ruff = 'ruff',
}

M.formatters = {
  lua = { name = 'stylua', exe = 'stylua' },
  rust = { name = 'rustfmt', exe = 'rustfmt' },
  python = { name = 'ruff_format', exe = 'ruff' },
  cpp = { name = 'clang-format', exe = 'clang-format' },
}

function M.present(exe, where)
  if vim.fn.executable(exe) == 1 then
    return true
  end
  vim.notify(('%s: skipping (executable %q not on PATH)'):format(where, exe), vim.log.levels.INFO)
  return false
end

return M
