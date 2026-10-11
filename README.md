Configs for Zsh, Vim, Tmux and other.
=======================================

TL;DR
-----

```bash
bash -c "$(curl -fSs https://raw.githubusercontent.com/kostyaorkostya/dot-config/main/remote_deploy.sh)"
```

Deployment
----------

Deploy all.

```bash
./deploy.sh
```

Only Zsh.

```bash
./zsh/deploy.sh
```

Only Tmux.

```bash
./tmux/deploy.sh
```

Only Python.

```bash
./python/deploy.sh
```

Only Vim. This might take some time, especially with slow network connection.

```bash
./vim/deploy.sh
```


Details
-------

[Solarized][solarized] colorscheme is used everywhere, so you will need
to change you terminal colorscheme in order to make everything look really good.

Here are some tips on how to achieve it:

- [Mac OS X][solarized-mac-os-terminal]
- [iTerm 2][solarized-mac-os-iterm2]
- [Gnome terminal][solarized-gnome-terminal]
- [PuTTY][solarized-putty]

Vim plugins:

- [Vundle][vim-vundle]
- [vim-airline][vim-vim-airline]
- [vim-airline-themes][vim-vim-airline-themes]
- [YouCompleteMe][vim-youcompleteme]
- [vim-fugitive][vim-vim-fugitive]
- [vcscommand.vim][vim-vcscommand]
- [vim-fswitch][vim-vim-fswitch]
- [vim-startify][vim-vim-startify]
- [tagbar][vim-tagbar]
- [flake8-vim][vim-flake8-vim]
- [csv.vim][vim-csv]
- [vim-cpp-enhanced-highlight][vim-vim-cpp-enhanced-highlight]
- [rust.vim][vim-rust-vim]
- [vim-toml][vim-toml]
- [vim-commentary][vim-vim-commentary]
- [UltiSnips][vim-ultisnips]
- [vim-snippets][vim-vim-snippets]

Custom Vim key mappings:

- <kbd>F4</kbd> — show directory tree
- <kbd>F7</kbd> — move to the next tab
- <kbd>F8</kbd> — move to the previous tab
- <kbd>F9</kbd> — show/close tagbar
- <kbd>F10</kbd> — show compiler diagnostics (only for c,cpp and python file types)
- <kbd>Ctrl</kbd> + <kbd>\]</kbd> — goto declaration (only for c,cpp and python file types)
- <kbd>Ctrl</kbd> + <kbd>h</kbd> — show documentation with quick info
- <kbd>Ctrl</kbd> + <kbd>y</kbd> — expand snippet
- <kbd>Ctrl</kbd> + <kbd>j</kbd> — jump forward withing snippet
- <kbd>Ctrl</kbd> + <kbd>k</kbd> — jump backward withing snippet

That is how it looks like on Mac OS X in Terminal.app.
![Demonstration](http://i.imgur.com/xoJOSoV.png)
[![asciicast](https://asciinema.org/a/4a15jzq0zomdowfro7shk2d7u.png)](https://asciinema.org/a/4a15jzq0zomdowfro7shk2d7u?theme=solarized-dark)

[solarized]: http://ethanschoonover.com/solarized
[solarized-mac-os-terminal]: https://github.com/tomislav/osx-terminal.app-colors-solarized
[solarized-mac-os-iterm2]: https://github.com/altercation/solarized/tree/master/iterm2-colors-solarized
[solarized-gnome-terminal]: https://github.com/Anthony25/gnome-terminal-colors-solarized
[solarized-putty]: https://github.com/altercation/solarized/tree/master/putty-colors-solarized
[vim-vundle]: https://github.com/VundleVim/Vundle.vim
[vim-vim-airline]: https://github.com/vim-airline/vim-airline
[vim-vim-airline-themes]: https://github.com/vim-airline/vim-airline-themes
[vim-youcompleteme]: https://github.com/Valloric/YouCompleteMe
[vim-vim-fugitive]: https://github.com/tpope/vim-fugitive
[vim-vcscommand]: https://github.com/vim-scripts/vcscommand.vim
[vim-vim-fswitch]: https://github.com/derekwyatt/vim-fswitch
[vim-vim-startify]: https://github.com/mhinz/vim-startify
[vim-tagbar]: https://github.com/majutsushi/tagbar
[vim-flake8-vim]: https://github.com/andviro/flake8-vim
[vim-csv]: https://github.com/chrisbra/csv.vim
[vim-vim-cpp-enhanced-highlight]: https://github.com/octol/vim-cpp-enhanced-highlight
[vim-rust-vim]: https://github.com/rust-lang/rust.vim
[vim-toml]: https://github.com/cespare/vim-toml
[vim-vim-commentary]: https://github.com/tpope/vim-commentary
[vim-ultisnips]: https://github.com/sirver/UltiSnips
[vim-vim-snippets]: https://github.com/honza/vim-snippets
