# Format all files
fmt:
    treefmt

# Check formatting without modifying files
fmt-check:
    treefmt --fail-on-change

# Run all linters
lint:
    typos
    reuse lint

# Run everything as in CI
ci: fmt-check lint

# Show unreleased changes since the last tag
changelog:
    git log $(git describe --tags --abbrev=0)..HEAD --oneline
