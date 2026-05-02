SETUP_DIR := $(CURDIR)

.PHONY: home_dir install-node install-aws install-packages update

home_dir:
	sh $(SETUP_DIR)/provision/install-home.sh

install-node:     ; bash $(SETUP_DIR)/modules/node-install.sh
install-aws:      ; bash $(SETUP_DIR)/modules/aws-install.sh
install-packages: ; bash $(SETUP_DIR)/modules/packages-common.sh
update:           ; bash $(SETUP_DIR)/modules/packages-update.sh
