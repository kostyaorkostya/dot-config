return {
    { 'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = {
                'black',
                'buf',
                'clang-format',
                'shellcheck',
                'shfmt',
                'stylua',
            }
        }
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup()
            require('mason-lspconfig').setup({
            ensure_installed = {
                'bzl',
                'clangd',
                'lua_ls',
                'rust_analyzer',
            }
            })
        end
    },
    {
        -- shows LSP progress
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
{
    'stevearc/conform.nvim',
--    event = { 'BufWritePre' },
    otps = {
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
        log_level = vim.log.levels.DEBUG,
      notify_no_formatters = true,
    },
    config = function(_, opts)
        require('conform').setup(opts)
    end
},
}
