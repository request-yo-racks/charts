# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

default: setup

ci-linters:  ## Run the static analyzers
	@helm lint --strict charts/*

clean: ## Remove unwanted files in this project (!DESTRUCTIVE!)
	@cd $(TOPDIR) && git clean -ffdx && git reset --hard

setup: ## Setup the full environment (default)
	@helm version -c || brew cask install kubernetes-helm
