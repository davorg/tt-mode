# Maintenance

## Releasing a New Version

When you are ready to release a new version:

1. Update the `Version:` header in `tt-mode.el` to the new version number
   (e.g. `1.3.0`).
2. Commit that change to the `master` branch.
3. Create and push a git tag whose name matches the version prefixed with `v`
   (e.g. `v1.3.0`):

   ```sh
   git tag v1.3.0
   git push origin v1.3.0
   ```

Pushing the tag triggers the [Release workflow](.github/workflows/release.yml),
which runs the test suite and then creates a GitHub Release automatically.

**MELPA is updated automatically.** MELPA polls this repository and picks up
new versions by reading the `Version:` header from `tt-mode.el` and the
corresponding git tag. No manual notification or pull request to MELPA is
required.
