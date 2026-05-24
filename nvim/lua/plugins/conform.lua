return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true })
      end,
    },
  },
  config = function()
    local tools = require('dotconfig.tools')
    local formatters_by_ft = {}
    for ft, spec in pairs(tools.formatters) do
      if tools.present(spec.exe, 'conform') then
        formatters_by_ft[ft] = { spec.name }
      end
    end

    require('conform').setup({
      formatters_by_ft = formatters_by_ft,
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      log_level = vim.log.levels.ERROR,
      notify_no_formatters = true,
    })
  end,
}
