#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Editors
#

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'

#
# Language
#

if [[ -z "$LANG" ]]; then
  export LANG='en_US.UTF-8'
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set GOPATH
export GOPATH=$HOME/go

# Set the list of directories that Zsh searches for programs.
path=(
  # env
  $HOME/.cask/bin(N-/)
  $HOME/go/bin(N-/)
  $HOME/.cabal/bin(N-/)
  /opt/cabal/1.20/bin(N-/)
  $HOME/.anyenv/bin(N-/)
  $HOME/anaconda2/bin(N-/)
  $HOME/.nodebrew/current/bin(N-/)
  # indivisual programs
  /opt/ghc/7.8.4/bin(N-/)
  /usr/local/heroku/bin(N-/)
  # user's binary
  /usr/local/{bin,sbin}
  $HOME/bin(N-/)
  $path
)

# use system-default sqlite3 prior to anaconda2's one or the others ###
alias sqlite3="/usr/bin/sqlite3"

## indivisual settings

### Travis CI gem ###
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

### anyenv ###
[ -d $HOME/.anyenv ] && eval $(anyenv init -)

### cool-peco ###
[ -f ~/cool-peco/cool-peco ] && source ~/cool-peco/cool-peco

### fuck ###
[[ -x `whence -p thefuck` ]] && eval $(thefuck --alias)

### ghq ###
alias g='cd $(ghq root)/$(ghq list | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

### OPAM ###
. ~/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#
# Less
#

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

#
# Temporary Files
#

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
