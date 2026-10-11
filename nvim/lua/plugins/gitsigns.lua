local gitsigns = require('gitsigns')
gitsigns.setup({
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next')
      end
    end, 'Next hunk')
    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev')
      end
    end, 'Previous hunk')
    map('n', '<leader>gp', gitsigns.preview_hunk, 'Preview hunk')
    map('n', '<leader>gr', gitsigns.reset_hunk, 'Reset hunk')
    map('n', '<leader>gb', function()
      gitsigns.blame_line({ full = true })
    end, 'Blame line')
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk, 'Hunk')
  end,
})
