return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      local tools = require('dotconfig.tools')
      for server, exe in pairs(tools.lsp_servers) do
        if tools.present(exe, 'lsp') then
          vim.lsp.enable(server)
        end
      end
    end,
  },
  {
    -- shows LSP progress
    'j-hui/fidget.nvim',
    opts = {},
  },
}
