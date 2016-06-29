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

export LS_COLORS="$LS_COLORS:di=36:ln=31:or=31;1"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR="nvim"
export BROWSER="chromium"
export SAGE_LOCAL="/usr"
export GUROBI_HOME="/opt/gurobi651/linux64"
export PATH=$PATH:$GUROBI_HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GUROBI_HOME/lib
autoload -Uz compinit
compinit

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

alias vi='nvim'
alias vim='nvim'

alias msfconsole="msfconsole --quiet -x \"db_connect spotlight@msf\""

alias urldecode='python2.7 -c "import sys, urllib as ul; \
        print ul.unquote_plus(sys.argv[1])"'
alias urlencode='python2.7 -c "import sys, urllib as ul; \
        print ul.quote_plus(sys.argv[1])"'

alias pip3update='sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U'
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
