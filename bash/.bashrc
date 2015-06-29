

# perl install
eval `perl -I ~/perl5/lib/perl5 -Mlocal::lib`


# colored command prompt

set_prompt()
{
    local last_cmd=$?
    PS1=""
    RED='\[\e[01;31m\]'
    BLUE='\[\e[01;34m\]'
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

    PS1+=" $BLUE\w "
    PS1+="\$$RESET "
}

#PROMPT_COMMAND='set_prompt'
function _update_ps1() {
    export PS1="$(/home/spotlight/powerline-shell.py --cwd-only $? 2> /dev/null)"
}

export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"

# auto "cd" when entering just a path
shopt -s autocd


export TZ='Europe/Berlin';


## modified commands ##
alias diff='colordiff'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -n -c 5'
alias dmesg='dmesg -HL'


## new commands ##
alias du1='du --max-depth=1'
alias hist='history | grep'
alias openport='ss --all --numeric --processes --ipv4 --ipv6'
alias ..='cd ..'
alias qmake='qmake-qt4'
## privileged access ##
if [ $UID -ne 0 ]; then
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias shutdown='sudo systemctl poweroff'
    alias poweroff='sudo systemctl poweroff'
    alias update='yaourt -Syua'
fi

## ls ##
alias ls='ls -hF --color=auto'
alias ll='ls -al'

# clears screen
alias cls='echo -ne "\033c"' 

## make bash error tolerant ##
alias :q='exit'
alias :Q='exit'
alias :x='exit'
alias cd..='cd ..'


alias gs='git status'
alias gg='git commit'
alias gd='git diff'
alias ga='git add'
alias gp='git push'

# bash options
export PAGER=most
export EDITOR=vi
export SUDO_EDITOR=rvim
export HISTSIZE=500000
export HISTFILESIZE=200000

# Compile and execute a C source on the fly
csource() {
        [[ $1 ]]    || { echo "Missing operand" >&2; return 1; }
        [[ -r $1 ]] || { printf "File %s does not exist or is not readable\n" "$1" >&2; return 1; }
	local output_path=${TMPDIR:-/tmp}/${1##*/};
	gcc "$1" -o "$output_path" && "$output_path";
	rm "$output_path";
	return 0;
}


note () {
    # if file doesn't exist, create it
    if [[ ! -f $HOME/.notes ]]; then
        touch "$HOME/.notes"
    fi

    if ! (($#)); then
        # no arguments, print file
        cat "$HOME/.notes"
    elif [[ "$1" == "-c" ]]; then
        # clear file
        > "$HOME/.notes"
    else
        # add all arguments to file
        printf "%s\n" "$*" >> "$HOME/.notes"
    fi
}

todo() {
    if [[ ! -f $HOME/.todo ]]; then
        touch "$HOME/.todo"
    fi

    if ! (($#)); then
        cat "$HOME/.todo"
    elif [[ "$1" == "-l" ]]; then
        nl -b a "$HOME/.todo"
    elif [[ "$1" == "-c" ]]; then
        > $HOME/.todo
    elif [[ "$1" == "-r" ]]; then
        nl -b a "$HOME/.todo"
        echo "----------------------------"
        read -p "Type a number to remove: " number
        sed -i "$number d" "$HOME/.todo"
    else
        printf "%s\n" "$*" >> "$HOME/.todo"
    fi
}


calc() {
    echo "scale=3;$@" | bc -l
}

