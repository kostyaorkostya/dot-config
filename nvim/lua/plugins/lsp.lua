local tools = require('dotconfig.tools')
for server, exe in pairs(tools.lsp_servers) do
  if tools.present(exe) then
    vim.lsp.enable(server)
  end
end
