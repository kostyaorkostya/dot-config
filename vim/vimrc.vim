"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                preamble                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible

" Needed for vundle, will be turned on after vundle inits
filetype off

" Setting up Vundle if there is none
if !filereadable(expand('$HOME/.vim/bundle/Vundle.vim/README.md'))
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone --quiet https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
endif

" Setup vundle
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                          Vundle configuration                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" These need to come before the configuration options for the plugins since
" vundle will add the plugin folders to the runtimepath only after it has seen
" the plugin's Plugin command.

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'
Plugin 'mhinz/vim-startify'
Plugin 'tpope/vim-commentary'

" {C,T}SV
Plugin 'chrisbra/csv.vim'

" Colors
Plugin 'flazz/vim-colorschemes'

Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" SVN and Git
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/vcscommand.vim'

" C++
Plugin 'derekwyatt/vim-fswitch'
Plugin 'octol/vim-cpp-enhanced-highlight'

" Python
Plugin 'andviro/flake8-vim'

" Tmux syntax support
Plugin 'whatyouhide/vim-tmux-syntax'

" Rust
Plugin 'rust-lang/rust.vim'

" TOML
Plugin 'cespare/vim-toml'

" FTL (FreeMarker Template Language)
Plugin 'chaquotay/ftl-vim-syntax'

" Ragel
Plugin 'jneen/ragel.vim'

call vundle#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           reset vimrc augroup                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
  autocmd!
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        turn on filetype plugins                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable detection, plugins and indenting in one step
" This needs to come AFTER the Plugin commands!
filetype plugin indent on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            General settings                             "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" DISPLAY SETTINGS
colorscheme solarized   " sets the colorscheme
set background=dark     " enable for dark terminals
set scrolloff=5         " 2 lines above/below cursor when scrolling
set showmatch           " show matching bracket (briefly jump)
set matchtime=2         " reduces matching paren blink time from the 5[00]ms def
set showmode            " show mode in status bar (insert/replace/...)
set showcmd             " show typed command in status bar
set ruler               " show cursor position in status bar
set title               " show file in titlebar
set cursorline          " highlights the current line
set winaltkeys=no       " turns of the Alt key bindings to the gui menu

" When you type the first tab, it will complete as much as possible, the second
" tab hit will provide a list, the third and subsequent tabs will cycle through
" completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu            " completion with menu
" This changes the default display of tab and CR chars in list mode
set listchars=tab:▸\ ,eol:¬

" The "longest" option makes completion insert the longest prefix of all
" the possible matches; see :h completeopt
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab

" EDITOR SETTINGS
set ignorecase          " case insensitive searching
set smartcase           " but become case sensitive if you type uppercase characters
" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,W0  " see :h cinoptions-values
set smarttab            " smart tab handling for indenting
set magic               " change the way backslashes are used in search patterns
set bs=indent,eol,start " Allow backspacing over everything in insert mode
set nobackup            " no backup~ files.

set tabstop=4           " number of spaces a tab counts for
set shiftwidth=4        " spaces for autoindents
set softtabstop=4
set shiftround          " makes indenting a multiple of shiftwidth
set expandtab           " turn a tab into spaces
set laststatus=2        " the statusline is now always shown
set noshowmode          " don't show the mode ("-- INSERT --") at the bottom

" misc settings
set fileformat=unix     " file mode is unix
set fileformats=unix,dos,mac   " detects unix, dos, mac file formats in that order

set viminfo='20,\"500   " remember copy registers after quitting in the .viminfo
                        " file -- 20 jump links, regs up to 500 lines'

set hidden              " allows making buffers hidden even with unsaved changes
set history=1000        " remember more commands and search history
set undolevels=1000     " use many levels of undo
set autoread            " auto read when a file is changed from the outside
set foldlevelstart=99   " all folds open by default

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix = 1

" tries to avoid those annoying "hit enter to continue" messages
" if it still doesn't help with certain commands, add a second <cr>
" at the end of the map command
set shortmess=a

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" none of these should be word dividers, so make them not be
set iskeyword+=_,$,@,%,#

" allow backspace and cursor keys to cross line boundaries
set whichwrap+=<,>,h,l
set hlsearch            " highlight all search results
set incsearch           " highlight-as-I-type the search string

" enforces a specified line-length and auto inserts hard line breaks when we
" reach the limit; in Normal mode, you can reformat the current paragraph with
" gqap.
set textwidth=100

" this makes the color after the textwidth column highlighted
set colorcolumn=+1

" options for formatting text; see :h formatoptions
set formatoptions=tcroqnj

if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif

" The alt (option) key on macs now behaves like the 'meta' key. This means we
" can now use <m-x> or similar as maps. This is buffer local, and it can easily
" be turned off when necessary (for instance, when we want to input special
" characters) with :set nomacmeta.
if has("gui_macvim")
  set macmeta
endif

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif


" The stupid python filetype plugin overrides our settings!
autocmd vimrc FileType python
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4

autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType json setlocal ts=2 sts=2 sw=2

autocmd vimrc FileType snippets set noexpandtab

autocmd BufNewFile,BufRead *.rl5 set filetype=ragel
autocmd BufNewFile,BufRead *.rl6 set filetype=ragel
autocmd BufNewFile,BufRead *.gztproto set filetype=proto
autocmd BufNewFile,BufRead *.pb.txt set filetype=proto

" Open splits to the right
set splitright

" Lines enumeration
set number
" Enabling this open will make Vim really slow!
" set relativenumber

" Highlight uwanted spaces, nice for tsv files viewing
set list
set listchars=trail:·
set listchars=tab:→→

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Explore mode settings                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F4> :Vexplore<CR>
let g:netrw_liststyle=3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           More involved tweaks                          "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unicode support (taken from http://vim.wikia.com/wiki/Working_with_Unicode)
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

augroup vimrc
  " Automatically delete trailing DOS-returns and whitespace on file open and
  " write.
  autocmd BufRead,BufWritePre,FileWritePre * silent! %s/[\r \t]\+$//
augroup END

" Sometimes, $MYVIMRC does not get set even though the vimrc is sourced
" properly. So far, I've only seen this on Linux machines on rare occasions.
if has("unix") && strlen($MYVIMRC) < 1
  let $MYVIMRC=$HOME . '/.vimrc'
endif

" Automatically close Quickfix window if it is the last one.
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

autocmd vimrc FileType markdown setlocal spell! spelllang=en_us

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            custom mappings                              "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Switch between tabs on F7 and F8
map <F8> :tabnext<CR>
map! <F8> <ESC>:tabnext<CR>i
map <F7> :tabprevious<CR>
map! <F7> <ESC>:tabprevious<CR>

" this makes vim's regex engine "not stupid"
" see :h magic
nnoremap / /\v
vnoremap / /\v


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       ***  HERE BE PLUGINS  ***                         "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Vundle                                   "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:vundle_default_git_proto = 'git'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Airline                                  "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2
let g:airline_theme='solarized'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.branch = '⎇'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                YouCompleteMe                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:ycm_server_python_interpreter = 'python3'
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_default_conf.py'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_error_symbol = '☓'
let g:ycm_warning_symbol = '☝'
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'csv' : 1,
    \ 'diff' : 1,
    \ 'gitcommit' : 1,
    \ 'help' : 1,
    \ 'infolog' : 1,
    \ 'mail' : 1,
    \ 'markdown' : 1,
    \ 'notes' : 1,
    \ 'pandoc' : 1,
    \ 'qf' : 1,
    \ 'svn' : 1,
    \ 'tagbar' : 1,
    \ 'text' : 1,
    \ 'unite' : 1,
    \ 'vimwiki' : 1
    \}
autocmd FileType c,cpp,python,rust nnoremap <buffer> gd :YcmCompleter GoToDeclaration<CR>
autocmd FileType c,cpp,python,rust nnoremap <buffer> gD :YcmCompleter GoToDefinition<CR>
autocmd FileType c,cpp,python,rust nnoremap <buffer> <F10> :YcmDiags<CR>
autocmd FileType c,cpp,python,rust nnoremap <buffer> <C-h> :YcmCompleter GetDoc<CR>
autocmd FileType c,cpp,python,rust nnoremap <buffer> [] :YcmCompleter GetType<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               UltiSnips                                 "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:UltiSnipsExpandTrigger = '<c-y>'
let g:UltiSnipsJumpForwardTrigger = '<c-j>'
let g:UltiSnipsJumpBackwardTrigger = '<c-k>'

let g:UltiSnipsEditSplit = 'horizontal'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             majutsushi/tagbar                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:tagbar_autofocus = 1
let g:tagbar_width = 50
nmap <F9> :TagbarToggle<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             chrisbra/csv.vim                            "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:csv_highlight_column = 'y' " unlet g:csv_highlight_column to disable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                            rust-lang/rust.vim                           "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:rustfmt_autosave = 1
