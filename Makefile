
all: lint scan build

.PHONY: lint
lint:
    @echo "Linting ran"

.PHONY: scan
scan:
    @echo "Scanning ran"

.PHONY: build
build:
    @mkdir -p dist
    @touch dist/test.txt
    @echo "Build ran"
