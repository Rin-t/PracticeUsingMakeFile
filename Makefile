
## PRODUCT_NAMEのxxxのところにプロジェクト名を入れてください
PRODUCT_NAME := xxx
WORKSPACE_NAME := ${PRODUCT_NAME}.xcworkspace

.PHONY: setup
setup: ## Set up all.
	$(MAKE) install-brew
	$(MAKE) install-cocoapods
	$(MAKE) install-ffi
	$(MAKE) pod-install
	$(MAKE) install-swiftlint
	$(MAKE) open

.PHONY: install-brew
install-brew: ## Run shell script to install Homebrew
	./installBrew.sh

.PHONY: install-cocoapods
install-pods: ## Install cocoapods for M1 Mac
	sudo arch -x86_64 gem install cocoapods -v 1.10.2

.PHONY: install-ffi
install-ffi: ## Install ffi
	sudo arch -x86_64 gem install ffi

.PHONY: pod-install
pod-install: ## Install library
	arch -x86_64 pod install

.PHONY: install-swiftlint
install-swiftlint: ## Install SwiftLint
	brew install swiftlint

.PHONY: open
open: ## Open workspace in Xcode
	open ./${WORKSPACE_NAME}


.PHONY: help
help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
