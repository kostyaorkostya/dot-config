vim.opt.background = 'dark' -- enable for dark terminals
vim.opt.termguicolors = true
vim.opt.scrolloff = 5       -- 2 lines above/below cursor when scrolling
vim.opt.showmatch = true    -- show matching bracket (briefly jump)
vim.opt.matchtime = 2       -- reduces matching paren blink time from the 5[00]ms def
vim.opt.showmode = true     -- show mode in status bar (insert/replace/...)
vim.opt.showcmd = true      -- show mode in status bar (insert/replace/...)
vim.opt.ruler = true        -- show cursor position in status bar
vim.opt.title = true        -- show file in titlebar
vim.opt.cursorline = true   -- highlights the current line
vim.opt.winaltkeys = 'no'   -- turns of the Alt key bindings to the gui menu

-- When you type the first tab, it will complete as much as possible, the second
-- tab hit will provide a list, the third and subsequent tabs will cycle through
-- completion options so you can complete the file without further keys
vim.opt.wildmode = { 'longest', 'list', 'full' }
vim.opt.wildmenu = true -- completion with menu
-- This changes the default display of tab and CR chars in list mode
vim.opt.listchars = { tab = '→→', trail = '·' }

-- The "longest" option makes completion insert the longest prefix of all
-- the possible matches; see :h completeopt
vim.opt.completeopt = { 'menu', 'menuone', 'longest' }
vim.opt.switchbuf = { 'useopen', 'usetab' }

-- EDITOR SETTINGS
vim.opt.ignorecase = true -- case insensitive searching
vim.opt.smartcase = true  --  but become case sensitive if you type uppercase characters
-- this can cause problems with other filetypes
-- see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
vim.opt.smartindent = true                       -- smart auto indenting
vim.opt.autoindent = true                        -- on new lines, match indent of previous line
vim.opt.copyindent = true                        -- copy the previous indentation on autoindenting
vim.opt.smarttab = true                          -- smart tab handling for indenting
vim.opt.magic = true                             -- change the way backslashes are used in search patterns
vim.opt.backspace = { 'indent', 'eol', 'start' } -- Allow backspacing over everything in insert mode
vim.opt.backup = false                           -- no backup~ files.

vim.opt.tabstop = 4                              -- number of spaces a tab counts for
vim.opt.shiftwidth = 4                           -- spaces for autoindents
vim.opt.softtabstop = 4
vim.opt.shiftround = true                        -- makes indenting a multiple of shiftwidth
vim.opt.expandtab = true                         -- turn a tab into spaces
vim.opt.laststatus = 2                           -- the statusline is now always shown
vim.opt.showmode = true                          -- don't show the mode ("-- INSERT --") at the bottom

-- misc settings
vim.opt.fileformat = 'unix'          -- file mode is unix
vim.opt.fileformats = 'unix,dos,mac' -- detects unix, dos, mac file formats in that order
vim.opt.shada = {
    "'20",                           -- Remember marks for last 20 files
    '"500',                          -- Remember up to 500 lines for each register
}
vim.opt.hidden = true                -- allows making buffers hidden even with unsaved changes
vim.opt.history = 1000               -- remember more commands and search history
vim.opt.undolevels = 1000            -- use many levels of undo
vim.opt.autoread = true              -- auto read when a file is changed from the outside
vim.opt.foldlevel = 99               -- all folds open by default

vim.opt.splitright = true
vim.opt.number = true
vim.opt.list = true

-- tries to avoid those annoying "hit enter to continue" messages
-- if it still doesn't help with certain commands, add a second <cr>
-- at the end of the map command
vim.opt.shortmess = 'a'

-- none of these should be word dividers, so make them not be
vim.opt.iskeyword = { '_', '$', '@', '%', '#' }

-- allow backspace and cursor keys to cross line boundaries
vim.opt.whichwrap:append({
    ["<"] = true,        -- Left arrow key in Normal/Visual mode
    [">"] = true,        -- Right arrow key in Normal/Visual mode
    h = true,            -- h key in Normal/Visual mode
    l = true,            -- l key in Normal/Visual mode
})
vim.opt.hlsearch = true  -- highlight all search results
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
