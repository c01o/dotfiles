#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

## basic settings ##
export EDITOR=vim
export TERM=screen-256color

## assign history search as <C-p>, <C-n> ##
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

## prompt crontab -r ##
alias crontab='crontab -i'

## prezto history module ##
HISTSIZE=100000
SAVEHIST=100000
setopt hist_no_store
setopt hist_reduce_blanks
setopt complete_aliases

## prezto completion ##
setopt list_types        # 補完候補一覧でファイルの種別をマーク表示
setopt auto_param_keys   # カッコの対応などを自動的に補完
setopt list_packed       # 補完候補を詰めて表示
setopt mark_dirs         # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt noautoremoveslash # 最後のスラッシュを自動的に削除しない
setopt globdots          # .ファイルもグロブマッチ有効

## zprof config
## comment out this and the head of .zshenv to use
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
