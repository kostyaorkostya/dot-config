#!/bin/bash
set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

printf 'Creating directory for old vimconfig...\n'
if [ -d $HOME/old-vim-config ]; then
    rm -rf $HOME/old-vim-config
fi
mkdir $HOME/old-vim-config
printf 'Creating directory for old vimconfig...DONE\n'
printf 'Old config will be stored in "%s"\n' "$HOME/old-vim-config"

printf 'Copying old config...\n'
if [ -a $HOME/.vimrc ]; then
    cp $HOME/.vimrc $HOME/old-vim-config
fi
if [ -d $HOME/.vim ]; then
    cp -r $HOME/.vim $HOME/old-vim-config
fi
printf 'Copying old config...DONE\n'

if [ -a $HOME/.vimrc ]; then
    printf 'Removing existing .vimrc \n'
    rm $HOME/.vimrc
    printf 'Removing existing .vimrc...DONE\n'
fi

if [ -d $HOME/.vim ]; then
    printf 'Removing existing .vim directory...\n'
    rm -rf $HOME/.vim
    printf 'Removing existing .vim directory...DONE\n'
fi

printf 'Copying new .vimrc...\n'
cp $DIR/vimrc.vim $HOME/.vimrc
printf 'Copying new .vimrc...DONE\n'

printf 'Installing plugins...\n'
# We put newline character into Vim, so we won't need to press ENTER during the installation.
echo | vim +PluginInstall +qall
printf 'Installing plugins...DONE\n'

printf 'Installing YouCompleteMe C-family completer...\n'
cd $HOME/.vim/bundle/YouCompleteMe/
./install.py --clang-completer --rust-completer
printf 'Installing YouCompleteMe C-family completer...DONE\n'

printf 'Copying default YouCompleteMe config...\n'
cp $DIR/ycm_default_conf.py $HOME/.vim
printf 'Copying default YouCompleteMe config...DONE\n'

unset DIR
