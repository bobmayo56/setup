[ -f ~/.exports ] && . ~/.exports
[ -f ~/.alias ] && . ~/.alias

PROMPT='%F{green}%B[%n@%m %1~]%(!.#.$)%b%f '

lgrep () { /usr/bin/find . -name "*$@*" ; }
rgrep () { /usr/bin/fgrep -R "$@" . ; }

[ -f ~/.localrc ] && . ~/.localrc
