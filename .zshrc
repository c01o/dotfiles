### basic settings ###
export LANG=ja_JP.UTF-8
setopt print_eight_bit  #make Japanese characters available

export EDITOR=vim
bindkey -v  #bind key like vim
 
### antigen ###
if [ -f ~/.zsh/antigen/antigen.zsh ] ; then
    source ~/.zsh/.zshrc.antigen
fi

## auto change directory
#setopt auto_cd
## auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd
## duplication directory no pushd
setopt pushd_ignore_dups
## command correct edition before each completion attempt
setopt correct
## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume
 
### beep setting ###
setopt nobeep
# no beep sound when complete list displayed
setopt nolistbeep

### tmux loading ###
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux

### color ls and prompts  ###
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
alias ls="ls --color"
alias lo='ls -la --color'
alias la='ls -a --color'
alias ll='ls -l --color'

### enable command history ###
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_no_store        # history command no store
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt inc_append_history   # as soon as append history
setopt hist_reduce_blanks
setopt complete_aliases

### completion ###
autoload -U compinit
compinit
## 補完候補を一覧表示
setopt auto_list
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## カッコの対応などを自動的に補完
setopt auto_param_keys
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 補完候補を詰めて表示
setopt list_packed
## ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt mark_dirs
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## 単語途中で補完機能を有効にする
setopt complete_in_word
## カーソル位置を保持した状態でファイル名を表示
setopt always_last_prompt
## グロブ補完拡張
setopt extended_glob
## .ファイルもグロブマッチ有効
setopt globdots
## sudoでも補完する
if [[ $EUID != 0 ]]; then
  # -x: export SUDO_PATHも一緒に行う。
  # -T: SUDO_PATHとsudo_pathを連動する。
  typeset -xT SUDO_PATH sudo_path
  typeset -U sudo_path 
  sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))
  alias sudo="sudo env PATH=\"SUDO_PATH:$PATH\""
fi

### assign history search as <C-p>, <C-n> ###
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

##---------------------------------------
### Completing style Setting
##---------------------------------------
#eval `dircolors`
#export ZLS_COLORS=$LS_COLORS
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:default' menu select=2
#zstyle ':completion:*' verbose yes
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
#zstyle ':completion:*:messages' format '%F{YELLOW}%d'$DEFAULT
#zstyle ':completion:*:warnings' format '%F{RED}No matches for:''%F{YELLOW} %d'$DEFAULT
#zstyle ':completion:*:descriptions' format '%F{YELLOW}completing %B%d%b'$DEFAULT
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:descriptions' format '%F{yellow}Completing %B%d%b%f'$DEFAULT
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' list-separator '-->'
#zstyle ':completion:*:manuals' separate-sections true
#zstyle ':completion:*' use-cache true

### Prompt setting###
autoload -U promptinit
promptinit
### PROMPT INFORMATION SETTINGS ###
autoload colors
colors

case ${UID} in
0)
    PROMPT="
%{${fg[yellow]}%}[%d]%{${reset_color}%}
%B%n@%m%# %b "
    SPROMPT="%B%{[31m%}%r is correct? [n,y,a,e]:%{[m%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
*)
    PROMPT="
%{${fg[yellow]}%}[%d]%{${reset_color}%}
%n@%m%# "
    SPROMPT="%{[31m%}%r is correct? [n,y,a,e]:%{[m%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{[37m%}${HOST%%.*} ${PROMPT}"
    ;;
esac

### make Terminal title user@host:currentdir ###
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac 

### R-PROMPT vim INFORMATION ###

function zle-line-init zle-keymap-select {
    RPS1="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/-- INSERT --}"
    RPS2=$RPS1
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
setopt transient_rprompt

### Travis CI gem ###
# added by travis gem 
[ -f /home/miyako-u/.travis/travis.sh ] && source /home/miyako-u/.travis/travis.sh
