# templates-lang-cpp

Opinionated template for production-ready C++ pet-projects.

<!-- === templates-base badges === -->
[![CI](https://github.com/SeveraTheDuck/templates-lang-cpp/actions/workflows/ci.yaml/badge.svg)](https://github.com/SeveraTheDuck/templates-lang-cpp/actions/workflows/ci.yaml)
[![Release](https://img.shields.io/github/v/release/SeveraTheDuck/templates-lang-cpp)](https://github.com/SeveraTheDuck/templates-lang-cpp/releases)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSES/MIT.txt)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com)
<!-- === end templates-base badges === -->

A [Copier](https://copier.readthedocs.io) template that layers a complete C++
toolchain on top of [`templates-base`](https://github.com/SeveraTheDuck/templates-base).
It is applied as a second layer: `templates-base` provides the language-agnostic
scaffolding (Nix dev environment, CI, release automation, REUSE compliance), and
this template adds everything specific to building, testing, and shipping C++.

## What you get

- **Pinned toolchain via Nix** — GCC and/or Clang, CMake, Ninja; no system
  compilers required. Per-compiler dev shells selected through direnv.
- **CMake presets** — `dev`, `release` (LTO), and optional sanitizer
  (`dev-asan`, `dev-tsan`), `coverage`, and `profile` presets.
- **Testing** — GoogleTest via FetchContent, a `tests/pipelines/` model that
  declares which suites run on which presets, and a `just` task interface.
- **Coverage** — source-based (llvm-cov) for Clang, arc-based (gcovr) for GCC,
  with optional Codecov upload on pull requests.
- **Profiling** — perf-based workloads and flamegraph generation (Linux).
- **Static analysis & formatting** — clang-tidy and clang-format / cmake-format
  wired through `nix flake check` and pre-commit hooks.
- **Install & distribution** — `install(EXPORT)` for `find_package` consumers
  plus a Nix flake `packages.default` output, both from one install path.
- **CI** — a per-compiler build/test matrix, coverage on pull requests, and a
  C/C++ CodeQL analysis, all built on composite actions.

## Requirements

- [Nix](https://nixos.org/download) with flakes enabled
- [Copier](https://copier.readthedocs.io) (run via `nix run nixpkgs#copier`)

## Usage

This template is applied **on top of** a `templates-base` project. Generate the
base layer first, commit it, then apply this layer:

```bash
# 1. base layer
copier copy --trust gh:SeveraTheDuck/templates-base .
git init -q && git add -A && git commit -qm "chore: base scaffolding"

# 2. C++ layer
copier copy --trust gh:SeveraTheDuck/templates-lang-cpp .
git add -A    # required: flakes ignore untracked files
```

Both layers are answered interactively. `--trust` is required because the
templates declare migrations.

## Questions

| Question            | Choices / default            | Purpose                                          |
| ------------------- | ---------------------------- | ------------------------------------------------ |
| `cpp_standard`      | 17 / 20 / 23 / 26 (20)       | C++ standard to target                           |
| `compiler_matrix`   | both / gcc / clang (both)    | Compilers to build and test against              |
| `gcc_version`       | 16                           | GCC major version (maps to `pkgs.gcc<N>Stdenv`)  |
| `clang_version`     | 22                           | LLVM/Clang major version                         |
| `primary_compiler`  | gcc / clang (gcc)            | Default dev shell when building for both         |
| `cmake_namespace`   | `<github_owner>`             | CMake export namespace (`name::target`)          |
| `enable_sanitizers` | true                         | ASan/UBSan and TSan presets                      |
| `enable_coverage`   | true                         | Coverage preset, `just coverage`, Codecov upload |
| `enable_profiling`  | false                        | perf workloads and flamegraph scripts (Linux)    |

## Updating

```bash
copier update --trust -a .copier/answers.cpp.yaml
```

<!--
TODO: centralized template entry point via a dedicated orchestrator repository.
A single tool will wrap per-layer copier copy/update behind a uniform interface,
so consumers do not invoke copier directly:

  just setup-base  <path>   # copier copy  templates-base  into <path>
  just update-base <path>   # copier update for the base layer
  just setup-cpp   <path>   # copier copy  templates-lang-cpp on top
  just update-cpp  <path>   # copier update for the cpp layer

The orchestrator owns layer ordering, --trust, and the per-layer answers files
(.copier/answers.base.yaml / .copier/answers.cpp.yaml), removing the manual
two-step copier flow documented above.
-->

## Developing this template

The generated project lives under `template/`. Layout:

- `template/` — the rendered project tree (Jinja-templated where needed)
- `template/nix/cpp/` — the C++ Nix modules (shells, package, toolchain, hooks)
- `template/cmake/` — CMake modules (options, warnings, sanitizers, coverage,
  install helpers)
- `copier.yaml` — questions and template configuration

### Smoke test

Generate both layers into a scratch directory and exercise the result:

```bash
SCRATCH=$(mktemp -d); cd "$SCRATCH"
copier copy --trust gh:SeveraTheDuck/templates-base .
git init -q && git add -A && git commit -qm base
copier copy --trust /path/to/templates-lang-cpp .
git add -A
just build && just test
```

Notes when working on the generated project:

- `git add -A` after generation is mandatory — flakes ignore untracked files,
  so the C++ Nix modules are invisible until staged.
- Build through the pinned shells (`nix develop .#gcc` / `.#clang`), not a bare
  `nix develop`; the default shell is a tooling shell.
- Run `rm -rf build` when switching compilers — preset build directories are
  keyed by preset name, so a compiler can otherwise stick in the CMake cache.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSES/MIT.txt) © Alexander Antipov
