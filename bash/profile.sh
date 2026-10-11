PLATFORM="$(uname)"
if [[ "${PLATFORM}" == *Darwin* ]]; then
  PS1='me@yazevnul-mac:\W\$ '
else
  # shellcheck disable=SC2154
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi

export LANG=en_US.UTF-8
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="C"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"

if [[ "${PLATFORM}" == *Darwin* ]]; then
  # For Homebrew
  export PATH="/usr/local/bin:${PATH}"

  # For MacTeX
  export PATH="/usr/texbin:${PATH}"
fi

export EDITOR=vim
export SVN_EDITOR=vim
export HISTSIZE=100000

unset PLATFORM
