vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('nvim-treesitter')
      end
      vim.cmd('TSUpdate')
    end
  end,
})

local function gh(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add({
  gh('maxmx03/solarized.nvim'),
  gh('nvim-tree/nvim-web-devicons'),
  { src = gh('nvim-treesitter/nvim-treesitter'), version = 'master' },
  gh('neovim/nvim-lspconfig'),
  gh('stevearc/conform.nvim'),
  gh('nvim-tree/nvim-tree.lua'),
  gh('preservim/tagbar'),
  gh('mhinz/vim-startify'),
  gh('rust-lang/rust.vim'),
  gh('folke/which-key.nvim'),
}, { confirm = false })

for _, name in ipairs({
  'colorscheme',
  'treesitter',
  'lsp',
  'conform',
  'tree',
  'tagbar',
  'which-key',
}) do
  require('plugins.' .. name)
end
