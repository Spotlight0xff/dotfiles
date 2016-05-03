# my .bashrc - spotlight0xff

export HISTCONTROL=ignoredups:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTFILE=~/.histfile
shopt -s histappend

# colored command prompt
set_prompt()
{
    local last_cmd=$?
    PS1=""
    RED='\[\e[02;31m\]'
    BLUE='\[\e[01;34m\]'
    CYAN='\[\e[01;36m\]'
    WHITE='\[\e[01;37m\]'
    GREEN='\[\e[01;32m\]'
    RESET='\[\e[00m\]'
    YELLOW='\[\e[01;33m\]'
    ORANGE='\[\e[38;5;208m\]'

    if [[ $last_cmd != 0 && $last_cmd != 127 ]]; then
        PS1+="$RED\342\234\227[$YELLOW$last_cmd$RED] "
    fi

    # if root, print the user in red, other in green
    if [[ $EUID == 0 ]]; then
        PS1+="$RED\u"
    else
        PS1+="$GREEN\u"
    fi

    #PS1+=" $BLUE\w "
    PS1+=" $CYAN\w "
    PS1+="\$$RESET "
}

PROMPT_COMMAND='history -a; history -c; history -r; set_prompt'

export TZ='Europe/Berlin';
export QT_SELECT=5;
export TERM=xterm
export LS_COLORS="$LS_COLORS:di=36:ln=31:or=31;1"


# beauty commands
alias diff='colordiff'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias dmesg='dmesg -HL'
alias ls='ls -hF --color=auto'


# lazy commands
alias du1='du --max-depth=1'
alias hist='history | grep'
alias oport='ss --all --numeric --processes --ipv4 --ipv6'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..' # jeez...
alias cls='echo -ne "\033c"' # if you *really* want to clear screen ;)
alias ll='ls -al'
alias :q='exit'
alias :Q='exit'
alias :x='exit'
alias cd..='cd ..'

# git shortcuts
alias gs='git status'
alias gg='git commit'
alias gd='git diff'
alias gdc='git diff --cached'
alias ga='git add'
alias gp='git push'
alias gc='git clone'

# make shortcuts
alias m='make'
alias mc='make clean'
alias ma='make all'

# without root
if [ $UID -ne 0 ]; then
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias shutdown='sudo systemctl poweroff'
    alias poweroff='sudo systemctl poweroff'
    alias update='yaourt -Syua'
fi

# bash options
export PAGER=less
export EDITOR=vim
export SUDO_EDITOR=rvim
export HISTSIZE=500000
export HISTFILESIZE=200000
export SAGE_LOCAL="/usr"
export PATH="/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin"

# add CUDA binaries, if available
if [ -d /opt/cuda/bin ]; then
    export PATH="$PATH:/opt/cuda/bin"
fi

# add ruby bin directory, if available
RUBYDIR=$(ruby -e 'print Gem.user_dir')
if [ -d "$RUBYDIR/bin" ]; then
    export PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
fi

# packages modules (pacman...)
if [ -d /usr/lib/perl5/vendor_perl ]; then
    export PATH="$PATH:/usr/lib/perl5/vendor_perl"
fi

# modules included in core perl distribution
if [ -d /usr/bin/core_perl ]; then
    export PATH="$PATH:/usr/bin/core_perl"
fi

# if local perl5 lib is there, install
if [ -d ~/perl5/ ]; then
    eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`
    export PATH="$PATH:~/perl5/bin"
fi

calc() {
    echo "scale=3;$@" | bc -l
}

# asmdoc
asmdoc()
{
    r2 -c "?d $@" -q --
}
