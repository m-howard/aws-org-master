
all: lint sec_scan build

.PHONY: lint
lint:
	@echo "Linting ran"

.PHONY: sec_scan
sec_scan:
	@echo "Scanning ran"

.PHONY: build
build:
	@mkdir -p dist
	@touch dist/test.txt
	@echo "Build ran"
