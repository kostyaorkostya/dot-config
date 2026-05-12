# oh-my-zsh configs

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="ys"

PLATFORM="$(uname)"
if [[ "${PLATFORM}" == *Darwin* ]]; then
    plugins=(git svn mercurial mosh pip vi-mode)
else
    plugins=(git svn mercurial mosh pip vi-mode)
fi

export DISABLE_AUTO_TITLE="true"

source $ZSH/oh-my-zsh.sh

# Personal configs

export LANG=C.UTF-8
export LC_TIME="en_DK.UTF-8"

# Vim -> NeoVim; probably only on MacOS, though

export EDITOR=/opt/homebrew/bin/nvim
export SVN_EDITOR=/opt/homebrew/bin/nvim
alias vim='/opt/homebrew/bin/nvim'
alias vi='/opt/homebrew/bin/nvim'

# Shell history size

export HISTSIZE=1000000

# Disable Homebrew analytics

export HOMEBREW_NO_ANALYTICS=1
export DO_NOT_TRACK=1

# Cleanup

unset PLATFORM
