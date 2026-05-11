SETUP_DIR := $(CURDIR)

.PHONY: home_dir install-packages install-developer update

home_dir:
	sh $(SETUP_DIR)/provision/install-home.sh

install-packages:  ; bash $(SETUP_DIR)/modules/packages-common.sh

install-developer: install-packages
	bash $(SETUP_DIR)/modules/packages-developer.sh

update:            ; bash $(SETUP_DIR)/modules/packages-update.sh
