SETUP_DIR := $(CURDIR)

.PHONY: laptop server docker \
        update packages bash zsh git ssh node aws

# --- profiles ---
laptop: ; bash $(SETUP_DIR)/profiles/laptop.sh
server: ; bash $(SETUP_DIR)/profiles/server.sh
docker: ; bash $(SETUP_DIR)/profiles/docker.sh

# --- individual modules ---
update:   ; bash $(SETUP_DIR)/modules/packages-update.sh
packages: ; bash $(SETUP_DIR)/modules/packages-common.sh
bash:     ; bash $(SETUP_DIR)/modules/bash-setup.sh
zsh:      ; bash $(SETUP_DIR)/modules/zsh-setup.sh
git:      ; bash $(SETUP_DIR)/modules/git-setup.sh
ssh:      ; bash $(SETUP_DIR)/modules/ssh-setup.sh
node:     ; bash $(SETUP_DIR)/modules/node-install.sh
aws:      ; bash $(SETUP_DIR)/modules/aws-install.sh
