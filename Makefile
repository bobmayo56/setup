
DOTFILES=${HOME}/.setuptestrc

all: ${DOTFILES}

${HOME}/.setuptestrc: dotfiles/.setuptestrc
	cp dotfiles/.setuptestrc ${HOME}/.setuptestrc

.PHONY: all
