[ -f ~/.exports ] && . ~/.exports
[ -f ~/.alias ] && . ~/.alias

if [ "$USER" = "bobmayo56" ]; then
  PROMPT='%F{green}%B[%n@%m %1~]%(!.#.$)%b%f '
else
  PROMPT='%F{cyan}%B[%n@%m %1~]%(!.#.$)%b%f '
fi

lgrep () { /usr/bin/find . -name "*$@*" ; }
rgrep () { /usr/bin/fgrep -R "$@" . ; }

[ -f ~/.localrc ] && . ~/.localrc
