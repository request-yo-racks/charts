# Project configuration
PROJECT_NAME = api

# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

DIST_DIR=$(TOPDIR)

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

default: ci-linters

ci-linters:  ## Run the static analyzers
	@helm lint --strict .

clean: ## Remove unwanted files in this project (!DESTRUCTIVE!)
	@git clean -ffdx && git reset --hard

dist: clean
	@mkdir -p $(DIST_DIR) && helm package -d $(DIST_DIR) -u .

push:
	@bash $(TOPDIR)/tools/publish.sh

.PHONY: ci-linters clean dist push
