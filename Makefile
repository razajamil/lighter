.PHONY: build nvim kitty reload help

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	  awk 'BEGIN{FS=":.*?## "}{printf "  make %-10s %s\n", $$1, $$2}'

build: ## Regenerate app configs (kitty, …) from the base palette
	@scripts/build.sh

nvim: ## Open Neovim with lighter active (make nvim FILE=path/to/file)
	@scripts/nvim-dev.sh $(FILE)

kitty: ## Build + open a fresh kitty window using the theme
	@scripts/kitty-preview.sh

reload: ## Build + live-apply to running kitty windows (needs remote control)
	@scripts/kitty-reload.sh
