HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=1000000
setopt appendhistory autocd HIST_IGNORE_DUPS completealiases nohashdirs CORRECT
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "/home/spotlight/.zshrc"
zstyle ':completion:*' menu select
zstyle ':completion:*' use-ip true
zstyle ':completion:*' rehash true

bindkey -M vicmd '?' history-incremental-search-backward
bindkey "^R" history-incremental-search-backward
export TERMINFO="rxvt-unicode"

# 'less' colors for manpage
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;0m\e[48;5;246m' # begin standout-mode - info box ( black on gray)
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline

export LS_COLORS="$LS_COLORS:di=36:ln=31:or=31;1"
export YAOURT_COLORS='nb=1:pkg=0;33:installed=1:votes=1:popularity=1:orphan=0;35:od=1;31' # better readability
export QT_STYLE_OVERRIDE='gtk2' # needs qt5-styleplugins, qt5 apps should have gtk look ;)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR="nvim"
export PAGER="less"
export LESS="--RAW-CONTROL-CHARS"
export BROWSER="/usr/bin/chromium"
export SAGE_LOCAL="/usr"
export GUROBI_HOME="/opt/gurobi651/linux64"
export PATH=$PATH:$GUROBI_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GUROBI_HOME/lib
autoload -Uz compinit
compinit

# command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# PROMPT
autoload -U colors promptinit && colors
PS1="%(0!.%{$fg[red]%}.%{$fg[green]%})%c%{$reset_color%}> "
PRERPROMPT="%(0?..[%{$fg_no_bold[yellow]%}%?%{$reset_color%}])"

precmd() {
  RPROMPT="$PRERPROMPT"
}

asmdoc() {
    r2 -c "?d $@" -q --
}

zle-keymap-select() {
    RPROMPT="$PRERPROMPT"
    [[ $KEYMAP = vicmd ]] && RPROMPT="$PRERPROMPT%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
    () { return $__prompt_status }
        zle reset-prompt
}

zle-line-init() {
    typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

alias vi='nvim'
alias vim='nvim'
alias dmesg='dmesg --color=always'
alias ls='ls --color=auto'
alias ll='ls -ahl'

# GIT support
alias gs='git status'
alias gg='git commit'
alias gp='git push'
alias ga='git add'
alias gc='git clone'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias mt='make test'
alias mc='make clean'
alias m='make'

alias vi='nvim'
alias vim='nvim'

alias msfconsole="msfconsole --quiet -x \"db_connect spotlight@msf\""

# select the only device by default
alias kdeconnect-cli='kdeconnect-cli --device $(\kdeconnect-cli --list-available --id-only)'
alias con='kdeconnect-cli'

alias urldecode='python2.7 -c "import sys, urllib as ul; \
        print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python2.7 -c "import sys, urllib as ul; \
        print ul.quote_plus(sys.argv[1])"'

alias pip3update='sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo pip install -U'
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "^[OH" beginning-of-line
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line
bindkey "^[OF" end-of-line
bindkey "^[[3~" delete-char
bindkey '\e.' insert-last-word

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
