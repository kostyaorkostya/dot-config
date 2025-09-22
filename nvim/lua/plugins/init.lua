return {
    --    {
    --        "Tsuzat/NeoSolarized.nvim",
    --        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    --        priority = 1000, -- make sure to load this before all the other start plugins
    --        config = function()
    --            vim.cmd.colorscheme('NeoSolarized')
    --            require('NeoSolarized').setup({
    --                style = 'dark',
    --                transparent = false,
    --                enable_italics = false,
    --            })
    --        end
    --    },
    --{
    --    'shaunsingh/solarized.nvim',
    --   config = function()
    --      vim.cmd.colorscheme('solarized')
    -- end
    --},
    {
        'maxmx03/solarized.nvim',
        lazy = false,
        priority = 1000,
        ---@type solarized.config
        opts = {
            palette = 'selenized',
            error_lens = {
                text = true,
                symbol = true,
            },
            on_highlights = function(colors, color)
                local darken = color.darken
                local lighten = color.lighten
                local blend = color.blend
                local shade = color.shade
                local tint = color.tint

                ---@type solarized.highlights
                local groups = {
                    Visual = { bg = colors.base02, standout = true },
                    Function = { fg = colors.yellow },
                    IncSearch = { fg = colors.orange, bg = colors.mix_orange },
                    Search = { fg = colors.violet, bg = shade(colors.violet, 5) },
                    NormalFloat = { bg = darken(colors.base03, 25) }
                }

                return groups
            end
        },
        config = function(_, opts)
            vim.cmd.colorscheme 'solarized'
            require('solarized').setup(opts)
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                theme = 'solarized',
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        path = 3, -- 3: Absolute path, with tilde as the home directory
                    }
                },
                lualine_y = {
                    {
                        'lsp_status',
                    }
                }
            }
        },
    },
    {
        'akinsho/bufferline.nvim',
        opts = {
            options = {
                mode = 'tabs', -- Show tabs instead of buffers
            },
        },
    },
    { 'preservim/tagbar' },
    { 'mhinz/vim-startify' },
    { 'rust-lang/rust.vim' },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
        },
        config = function()
            require('mason').setup({
                ensure_installed = { 'rustfmt', 'clang-format', 'buf', 'shellcheck', 'stylua', 'black' }
            })
            require('mason-lspconfig').setup({
                ensure_installed = { 'rust_analyzer', 'clangd', 'bzl', 'lua_ls' }
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
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            })
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup({
                view = {
                    width = 30,
                    side = 'left',
                },
                renderer = {
                    group_empty = true, -- Compact empty folders
                    icons = {
                        show = {
                            git = true,
                            folder = true,
                            file = true,
                        },
                    },
                },
                filters = {
                    dotfiles = false, -- Show hidden files
                    custom = { '.git', 'node_modules', '.cache' },
                },
                actions = {
                    open_file = {
                        quit_on_open = true, -- Close tree when opening file
                    },
                },
            })

            -- Keymaps
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
        end,
    },
    {
        'stevearc/conform.nvim',
        config = function()
            require('conform').setup({
                formatters_by_ft = {
                    lua = { 'stylua' },
                    rust = { 'rustfmt' },
                    python = { 'black' },
                    cpp = { 'clang-format' },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    }
}
