default: reindex

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST) | sort

reindex: ## Rebuild the chart index
	helm repo index --url https://request-yo-racks.github.io/charts .
