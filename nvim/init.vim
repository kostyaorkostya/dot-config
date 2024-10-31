set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" https://neovim.io/doc/user/provider.html
"
" $ brew install pyenv pyenv-virtualenv
" $ pyenv install 3.13
" $ pyenv virtualenv 3.13 py3nvim
" $ pyenv activate py3nvim
" $ python3 -m pip install --upgrade pip
" $ python3 -m pip install pynvim
" $ pyenv which python
let g:python3_host_prog = '/Users/kostya/.pyenv/versions/py3nvim/bin/python'

source ~/.vimrc
