# Build and deploy

Satisfies **REQ-030**, **REQ-036**, **REQ-038**.

## Local build

From the `highlandhideaway.ca` repository root:

```bash
git submodule update --init --recursive
hugo --minify
```

Output is `public/`, a deployable static tree. Preview with `hugo server`.

Break-glass deploy from a local machine, if Actions is unavailable:

```bash
hugo --minify && npx wrangler deploy
```

## Continuous integration

Workflow: [`highlandhideaway.ca/.github/workflows/cloudflare.yml`](../../../highlandhideaway.ca/.github/workflows/cloudflare.yml)

### Build job — runs on every push and pull request

| Step | Detail |
|------|--------|
| Checkout | `actions/checkout@v4`, `submodules: recursive`, `fetch-depth: 0` |
| Hugo | `peaceiris/actions-hugo@v3`, version from `HUGO_VERSION`, `extended: true` |
| Build | `hugo --minify` |
| Link check | `htmltest` against `public/`, config in `.htmltest.yml` |
| Artifact | `actions/upload-artifact@v4`, `public/`, 7-day retention |

`htmltest` runs with `CheckExternal: false`, so it checks internal links and images only. External links are covered weekly by the monitor workflow instead — see [operations.md](operations.md). `/go/` is in `IgnoreURLs` because the Worker serves it and no file exists in `public/` for htmltest to resolve.

### Deploy job — `main` only

`needs: build`, so nothing reaches production unless htmltest passed. That gate is structural rather than a branch-protection setting maintained outside the repo, which is the main reason Cloudflare's Git integration is not used. See [ADR-0004](adr/0004-deploy-from-github-actions.md).

The job downloads the `site` artifact into `public/`, then runs `cloudflare/wrangler-action@v3` with `command: deploy --config wrangler.toml`. `wrangler.toml` points `[assets]` at `./public` and `main` at `src/worker.js`.

Secrets cannot be referenced in a job-level `if`, so a step checks for the Cloudflare credentials and gates the deploy step on its output. Without them the job skips cleanly with a notice rather than failing.

## Cloudflare configuration

`wrangler.toml` carries the parts that belong in version control:

- **Custom domains:** `highlandhideaway.ca` and `www.highlandhideaway.ca`, attached on deploy.
- **`[assets]`:** `directory = "./public"`, `binding = "ASSETS"`, `run_worker_first = ["/go/*"]` so the Worker runs only for the redirect, and `not_found_handling = "404-page"` to serve Hugo's `404.html`.
- **`[vars]`:** `BOOKING_URL`.
- **`[[analytics_engine_datasets]]`:** binding `CLICKS`, dataset `booking_clicks`.

One piece of configuration is not in version control and cannot be: the www→apex Redirect Rule, which lives in the Cloudflare dashboard. It is currently missing. See [domain-and-analytics.md](domain-and-analytics.md).

## Secrets

Held as GitHub repository secrets, not in repo content:

| Secret | Scope | Used by |
|--------|-------|---------|
| `CLOUDFLARE_API_TOKEN` | Workers Scripts:Edit | Deploy |
| `CLOUDFLARE_ACCOUNT_ID` | — | Deploy and monitoring |
| `CF_AE_TOKEN` | Account Analytics:Read | Monitor canary, Grafana |
| `HEARTBEAT_URL` | — | Monitor heartbeat |

`CF_AE_TOKEN` is separate from the deploy token because `CLOUDFLARE_API_TOKEN` returns 403 against the Analytics Engine SQL API.

Moving off GitHub Pages replaced OIDC deployment with long-lived tokens. That is a real reduction in the security posture and is recorded under REQ-038 rather than left implicit; each token is scoped as narrowly as the task allows.
