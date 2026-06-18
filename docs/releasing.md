# Releasing

Releases are automated via [release-please](https://github.com/googleapis/release-please).
The current version is tracked in [`version.txt`](../version.txt).

## How it works

1. Every merge to `main` triggers the `release` job in CI.
2. release-please analyzes commits since the last release using
   [Conventional Commits](https://www.conventionalcommits.org/).
3. If there are releasable changes (`feat`, `fix`, or `BREAKING CHANGE`),
   release-please opens or updates a **Release PR** that:
   - bumps `version.txt` and `.release-please-manifest.json`
   - updates `CHANGELOG.md`
4. Merging the Release PR creates a GitHub release and a git tag.

No releasable commits means no Release PR. `chore`, `ci`, `docs` commits
accumulate silently until a `feat` or `fix` lands.

## Version bumping rules

| Commit | Version bump |
|--------|--------------|
| `fix:` | patch (`0.0.x`) |
| `feat:` | patch until 1.0.0, then minor |
| `BREAKING CHANGE` | minor until 1.0.0, then major |

## Normal release flow

1. Merge a `feat:` or `fix:` commit to `main`
2. release-please opens a PR: `chore: release 0.1.0`
3. Review and merge the PR
4. GitHub release `v0.1.0` is created automatically

## Hotfix flow

When a fix is needed on a released version without pulling in unreleased changes from `main`:

1. Create a branch from the release tag: `git checkout -b hotfix/v0.1.1 v0.1.0`
2. Apply the fix: `git commit -m "fix: correct critical bug"`
3. Push and open a PR targeting the hotfix branch
4. After merge, manually create a GitHub release from that tag —
   release-please does not monitor non-main branches

## First release

The manifest starts at `0.0.0`. release-please will not create a Release PR
until the first releasable commit (`feat:` or `fix:`) lands on `main`.
To trigger the first Release PR immediately:

```bash
git commit --allow-empty -m "feat: initial release"
```
