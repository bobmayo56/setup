SETUP_DIR := $(CURDIR)

.PHONY: home_dir install-node install-aws install-rclone install-uv install-packages install-developer update

home_dir:
	sh $(SETUP_DIR)/provision/install-home.sh

install-node:      ; bash $(SETUP_DIR)/modules/node-install.sh
install-aws:       ; bash $(SETUP_DIR)/modules/aws-install.sh
install-rclone:    ; bash $(SETUP_DIR)/modules/rclone-install.sh
install-uv:        ; bash $(SETUP_DIR)/modules/uv-install.sh
install-packages:  ; bash $(SETUP_DIR)/modules/packages-common.sh
install-developer: ; bash $(SETUP_DIR)/modules/packages-developer.sh
update:            ; bash $(SETUP_DIR)/modules/packages-update.sh
