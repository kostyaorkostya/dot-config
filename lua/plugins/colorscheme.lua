return  {
    'maxmx03/solarized.nvim',
    lazy = false,    -- make sure it's loaded on startup
    priority = 1000, -- make sure it's loaded before anythign else
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
        require('solarized').setup(opts)
        vim.cmd.colorscheme('solarized')
    end
}
