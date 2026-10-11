vim.opt.background = 'dark' -- enable for dark terminals
vim.opt.termguicolors = true
vim.opt.scrolloff = 5 -- 2 lines above/below cursor when scrolling
vim.opt.showmatch = true -- show matching bracket (briefly jump)
vim.opt.matchtime = 2 -- reduces matching paren blink time from the 5[00]ms def
vim.opt.title = true -- show file in titlebar
vim.opt.cursorline = true -- highlights the current line
vim.opt.winaltkeys = 'no' -- turns of the Alt key bindings to the gui menu
vim.opt.clipboard = 'unnamedplus' -- plain y/p go through the clipboard provider
-- inside tmux use its buffers (and OSC52 to the outer terminal) even where pbcopy/xclip exist
if vim.env.TMUX then
  vim.g.clipboard = 'tmux'
end

-- When you type the first tab, it will complete as much as possible, the second
-- tab hit will provide a list, the third and subsequent tabs will cycle through
-- completion options so you can complete the file without further keys
vim.opt.wildmode = { 'longest', 'list', 'full' }
-- This changes the default display of tab and CR chars in list mode
vim.opt.listchars = { tab = '→→', trail = '·' }

vim.opt.autocomplete = true
-- 'omnifunc' is the LSP's while one is attached; then words from this buffer, other windows, other buffers
vim.opt.complete = { 'o^10', '.^5', 'w^5', 'b^5' }
vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }
vim.opt.switchbuf = { 'useopen', 'usetab' }

-- EDITOR SETTINGS
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true --  but become case sensitive if you type uppercase characters
-- this can cause problems with other filetypes
-- see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
vim.opt.smartindent = true -- smart auto indenting
vim.opt.copyindent = true -- copy the previous indentation on autoindenting

vim.opt.tabstop = 4 -- number of spaces a tab counts for
vim.opt.shiftwidth = 4 -- spaces for autoindents
vim.opt.softtabstop = 4
vim.opt.shiftround = true -- makes indenting a multiple of shiftwidth
vim.opt.expandtab = true -- turn a tab into spaces

-- misc settings
vim.opt.fileformats = 'unix,dos,mac' -- detects unix, dos, mac file formats in that order
vim.opt.shada = {
  '!',
  "'20", -- Remember marks for last 20 files
  '<500', -- Remember up to 500 lines for each register
  's10',
  'h',
  'r/tmp/',
  'r/private/',
}
vim.opt.foldlevel = 99 -- all folds open by default
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.winborder = 'rounded'

vim.diagnostic.config({
  virtual_text = true,
  severity_sort = true,
})

vim.cmd.packadd('nvim.undotree')

vim.opt.splitright = true
vim.opt.number = true
vim.opt.list = true

-- tries to avoid those annoying "hit enter to continue" messages
-- if it still doesn't help with certain commands, add a second <cr>
-- at the end of the map command
vim.opt.shortmess:append('a')

-- none of these should be word dividers, so make them not be
vim.opt.iskeyword:append({ '$', '%', '#' })

-- allow backspace and cursor keys to cross line boundaries
vim.opt.whichwrap:append({
  ['<'] = true, -- Left arrow key in Normal/Visual mode
  ['>'] = true, -- Right arrow key in Normal/Visual mode
  h = true, -- h key in Normal/Visual mode
  l = true, -- l key in Normal/Visual mode
})
vim.opt.hlsearch = true -- highlight all search results
vim.opt.incsearch = true -- highlight-as-I-type the search string

-- enforces a specified line-length and auto inserts hard line breaks when we
-- reach the limit; in Normal mode, you can reformat the current paragraph with
-- gqap.
vim.opt.textwidth = 100

-- this makes the color after the textwidth column highlighted
vim.opt.colorcolumn = '+1'

-- options for formatting text; see :h formatoptions
vim.opt.formatoptions:append({
  t = true, -- Auto-wrap text using textwidth
  c = true, -- Auto-wrap comments using textwidth
  r = true, -- Continue comments when pressing Enter
  o = true, -- Continue comments with o/O
  q = true, -- Allow formatting comments with gq
  n = true, -- Recognize numbered lists
  j = true, -- Remove comment leader when joining lines
})
