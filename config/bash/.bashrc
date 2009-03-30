export HISTCONTROL=ignoredups

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias mtr='sudo mtr --curses'
alias pm='pacman-color'
alias pms='sudo pacman-color'
ROUGE=31
VERT=32
JAUNE=33
BLEU=34
VIOLET=35
CYAN=36
BLANC=37

# set a fancy prompt (non-color, unless we know we "want" color)
if [ "$USER" == "root" ] 
    then
    PSCOLOR=${ROUGE} #en rouge
else
    PSCOLOR=${VERT} #en vert
fi

TIMECOLOR=${BLANC}
ERRORCOLOR=${ROUGE}
PATHCOLOR=${CYAN}

case "$TERM" in
    dumb)
        PS1='\u@\h:\w\$ '
        ;;
    *)
        PS1='\[\033[01;${TIMECOLOR}m\]\A,\! \[\033[01;${PSCOLOR}m\]\u@\h\[\033[00m\]:$(__git_ps1 "\[\033[01;${JAUNE}m\]%s\[\033[01;${BLANC}m\]:")\[\033[01;${PATHCOLOR}m\]\w\[\033[01;${PATHCOLOR}m\]:\[\033[01;34m\](\[\033[${ERRORCOLOR}m\]$?\[\033[01;34m\])\[\033[00m\]\$ '
        ;;
esac

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion

fi

#
if [ -d ~/.bash.d/ ]; then
     for file in ~/.bash.d/*.sh; do
         . $file
     done
fi



