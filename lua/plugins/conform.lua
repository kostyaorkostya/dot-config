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
    require('conform').setup({
      formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        python = { 'black' },
        cpp = { 'clang-format' },
      },
      format_on_save = {
        lsp_format = 'fallback',
        timeout_ms = 500,
      },
      log_level = vim.log.levels.ERROR,
      notify_no_formatters = true,
    })
  end,
}
