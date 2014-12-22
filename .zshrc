### basic settings ###
autoload -U compinit
compinit
bindkey -v
#setopt auto_cd
setopt auto_pushd #memorize directories moved
setopt pushd_ignore_dups
setopt noautoremoveslash
setopt correct
setopt list_packed
export LANG=ja_JP.UTF-8

### tmux loading ###
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux ]]

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
setopt hist_ignore_dups
setopt hist_reduce_blanks
setopt auto_menu
setopt extended_glob
setopt share_history
setopt complete_aliases

### assign history search as <C-p>, <C-n> ###
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

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

