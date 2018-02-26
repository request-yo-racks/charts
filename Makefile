# General.
SHELL = /bin/bash
TOPDIR = $(shell git rev-parse --show-toplevel)

default: reindex

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

publish: reindex
	git add .
	FILES=$$(git status -s) && git commit -am "Publish charts" -m "$$FILES"
	git push origin gh-pages

reindex: ## Rebuild the chart index
	helm repo index --url https://request-yo-racks.github.io/charts .

.PHONY: publish reindex
