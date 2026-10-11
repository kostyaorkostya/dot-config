require('solarized').setup({
  palette = 'solarized',
  error_lens = {
    text = true,
    symbol = true,
  },
  on_highlights = function(colors, color)
    local darken = color.darken
    local shade = color.shade

    local groups = {
      Visual = { bg = colors.base02, standout = true },
      Function = { fg = colors.yellow },
      IncSearch = { fg = colors.orange, bg = colors.mix_orange },
      Search = { fg = colors.violet, bg = shade(colors.violet, 5) },
      NormalFloat = { bg = darken(colors.base03, 25) },
    }

    return groups
  end,
})
vim.cmd.colorscheme('solarized')
