### enable zsh's man  ###
export MANPATH=$HOME/Documents/man:
path=($HOME/.cask/bin(N-/) $HOME/go/bin(N-/) $HOME/bin(N-/) $HOME/.cabal/bin(N-/) /opt/cabal/1.20/bin(N-/) /opt/ghc/7.8.4/bin(N-/) $HOME/.nodebrew/current/bin(N-/) $HOME/.rbenv/bin(N-/) $HOME/anaconda2/bin(N-/) /usr/local/heroku/bin(N-/) $path)
fpath=(${HOME}/.zsh/zsh-completions/src(N-/) $HOME/.zsh/functions(N-/) $fpath)

### use system-default sqlite3 prior to anaconda2's one or the others ###
alias sqlite3="/usr/bin/sqlite3"
