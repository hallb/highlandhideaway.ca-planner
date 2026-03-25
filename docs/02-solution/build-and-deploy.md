# Build and deploy

Satisfies **REQ-030**, **REQ-036**, **REQ-038**.

## Local build

From the `highlandhideaway.ca` repository root (with submodules initialized):

```bash
git submodule update --init --recursive
hugo --minify
```

Output: **`public/`** (deployable static tree).

## Continuous integration

Workflow: [`highlandhideaway.ca/.github/workflows/hugo.yml`](../../../highlandhideaway.ca/.github/workflows/hugo.yml)

| Step | Detail |
|------|--------|
| Trigger | Push to **`main`**, or **`workflow_dispatch`** |
| Checkout | `actions/checkout@v4` with **`submodules: recursive`**, **`fetch-depth: 0`** |
| Hugo | `peaceiris/actions-hugo@v2`, **`hugo-version: latest`**, **`extended: true`** |
| Build | `hugo --minify` |
| Artifact | `actions/upload-pages-artifact@v3` with **`path: ./public`** |
| Deploy | `actions/deploy-pages@v4`, environment **`github-pages`** |

## Permissions

Workflow uses **`contents: read`**, **`pages: write`**, **`id-token: write`** for OIDC deployment to Pages.

## Secrets

No repository secrets required for standard Hugo→Pages flow; deploy uses GitHub-provided OIDC (**REQ-038**).
