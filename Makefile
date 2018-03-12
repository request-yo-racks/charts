# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

CHARTS = $(shell ls charts)
TOPTARGETS = ci-linters dist

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

default: setup

bootstrap: ## Install system tools
	@helm version -c || brew cask install kubernetes-helm

clean: ## Remove unwanted files in this project (!DESTRUCTIVE!)
	@cd $(TOPDIR) && git clean -ffdx && git reset --hard

publish: ## Publish the charts
	@bash $(TOPDIR)/tools/publish.sh

setup: ## Setup the full environment (default)

$(TOPTARGETS): $(CHARTS)

$(CHARTS):
	@$(MAKE) -C charts/$@ $(MAKECMDGOALS)

.PHONY: bootstrap clean publish setup $(CHARTS) $(TOPTARGETS)
