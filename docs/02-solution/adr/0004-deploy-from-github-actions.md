# ADR 0004: Deploy from GitHub Actions, not Cloudflare's Git integration

## Status

Accepted, 2026-08-18.

## Context

Cloudflare can build and deploy directly from a connected Git repository. That is the default path and needs no workflow file.

The build must be gated on `htmltest` — a broken internal link should not reach production.

## Decision

Keep building and deploying from GitHub Actions (`.github/workflows/cloudflare.yml`), and leave Cloudflare's Git integration disconnected.

The workflow has a build job and a deploy job, with `needs: build` between them.

## Consequences

The quality gate is structural. The deploy job cannot start unless the build job passed, and that fact lives in a file in the repository. With Git integration the deploy does not wait for CI, and only a branch-protection setting maintained outside the repo stands in front of production.

Two repo-specific facts reinforce this. The DoIt theme is a git submodule, which Cloudflare's builder would have to initialise. And there is no `package.json`, so Hugo and htmltest would both need installing inside the build command.

The cost is a workflow to maintain, and a wrangler version to keep pinned. That pin is not cosmetic: `wrangler-action` defaults to a 3.x wrangler, which silently drops `run_worker_first` and `not_found_handling` from `[assets]`. A silent drop of the first one would stop counting booking clicks while leaving the site apparently fine.
