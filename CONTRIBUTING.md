# Contributing

## Prerequisites

- [Nix](https://nixos.org/download/) with flakes enabled
- [direnv](https://direnv.net/)

## Getting started

```bash
git clone https://github.com/SeveraTheDuck/templates-lang-cpp
cd templates-lang-cpp
direnv allow   # activates the devenv shell automatically
just           # list available recipes
```

## Development workflow

```bash
just fmt       # format all files
just lint      # run all linters
just ci        # run everything as in CI
```

## Commit convention

This project follows [Conventional Commits](https://www.conventionalcommits.org/).
Commit messages are linted automatically on commit via a git hook.

```
<type>(<scope>): <description>

Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
```

Breaking changes: add `BREAKING CHANGE:` in the commit footer.

## Pull requests

1. Open an issue first for non-trivial changes
2. Fork the repo and create a branch from `main`
3. Make sure `just ci` passes
4. Open a PR — fill in the PR template
5. A maintainer will review and merge

## Reporting issues

Use [GitHub Issues](https://github.com/SeveraTheDuck/templates-lang-cpp/issues).
For security vulnerabilities see [SECURITY.md](SECURITY.md).
