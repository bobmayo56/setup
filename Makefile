DOTFILES_SRC := $(CURDIR)/dotfiles
TOOLS_SRC    := $(CURDIR)/tools

DOTFILES := \
	.alias \
	.bash_interactive \
	.bash_logout \
	.bash_profile \
	.bashrc \
	.mkshrc \
	.mongorc.js \
	.npmrc \
	.profile \
	.vimrc \
	.zlogin \
	.zshrc

.PHONY: all install install-dotfiles install-tools

all: install

install: install-dotfiles install-tools

install-dotfiles:
	@echo "Installing dotfiles..."
	@for f in $(DOTFILES); do \
		cp $(DOTFILES_SRC)/$$f $(HOME)/$$f; \
		echo "  Copied $$f"; \
	done

install-tools:
	@echo "Installing tools to $(HOME)/bin..."
	@mkdir -p $(HOME)/bin
	@for f in $(TOOLS_SRC)/*; do \
		cp $$f $(HOME)/bin/$$(basename $$f); \
		chmod +x $(HOME)/bin/$$(basename $$f); \
		echo "  Copied $$(basename $$f)"; \
	done
