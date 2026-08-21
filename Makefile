HUGO ?= hugo
BREW ?= brew

.DEFAULT_GOAL := help

.PHONY: help build build-cloudflare serve install-hugo check-hugo clean

help: ## Show this help message.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*##/ {printf "  %-16s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-hugo: ## Check whether Hugo is installed.
	@command -v $(HUGO) >/dev/null 2>&1 || { \
		echo "Hugo is not installed. Run: make install-hugo"; \
		exit 1; \
	}

build: check-hugo ## Build the static site into public/.
	$(HUGO) --gc --minify

build-cloudflare: check-hugo ## Build for Cloudflare Pages using its deployment URL.
	@base_url="$${CF_PAGES_URL:-https://juquiambiental.com/}"; \
	if [ "$${CF_PAGES_BRANCH:-main}" = "main" ]; then base_url="https://juquiambiental.com/"; fi; \
	$(HUGO) --gc --minify --baseURL "$${base_url}" --cacheDir "$${PWD}/.cache"

serve: check-hugo ## Start the local Hugo development server.
	$(HUGO) server --disableFastRender

install-hugo: ## Install Hugo on macOS using Homebrew.
	$(BREW) install hugo

clean: ## Remove generated Hugo output.
	rm -rf public resources .cache
