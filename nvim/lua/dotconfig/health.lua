local M = {}

function M.check()
  local tools = require('dotconfig.tools')
  local health = vim.health

  health.start('LSP servers')
  for server, exe in pairs(tools.lsp_servers) do
    if vim.fn.executable(exe) == 1 then
      health.ok(('%s: %s on PATH'):format(server, exe))
    else
      health.warn(('%s: %s missing -- server will not attach'):format(server, exe))
    end
  end

  health.start('Formatters (conform)')
  for ft, spec in pairs(tools.formatters) do
    if vim.fn.executable(spec.exe) == 1 then
      health.ok(('%s -> %s on PATH'):format(ft, spec.exe))
    else
      health.warn(('%s -> %s missing -- falling back to LSP format on save'):format(ft, spec.exe))
    end
  end
end

return M
