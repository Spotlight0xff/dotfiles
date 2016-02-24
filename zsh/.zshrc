# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=100000
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


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR="vim"
export BROWSER="chromium"
export SAGE_LOCAL="/usr"
autoload -Uz compinit
compinit

source /etc/profile.d/autojump.zsh

# command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

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

alias dmesg='dmesg --color=always'
alias ls='ls --color=auto'
alias ll='ls -al'

# GIT support
alias gs='git status'
alias gg='git commit'
alias gp='git push'
alias ga='git add'
alias gc='git clone'
alias gd='git diff'
alias gdc='git diff --cached'

alias less='most'

alias msfconsole="msfconsole --quiet -x \"db_connect spotlight@msf\""

alias urldecode='python2.7 -c "import sys, urllib as ul; \
        print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python2.7 -c "import sys, urllib as ul; \
        print ul.quote_plus(sys.argv[1])"'

alias pip3update='sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
bindkey -a 'gg' beginning-of-buffer-or-history
bindkey -a 'g~' vi-oper-swap-case
bindkey -a G end-of-buffer-or-history
