# Source system-wide config if present
[ -f /etc/bashrc ] && . /etc/bashrc

[ -f ~/.exports ] && . ~/.exports
[ -f ~/.bash_interactive ] && . ~/.bash_interactive
[ -f ~/.localrc ] && . ~/.localrc
