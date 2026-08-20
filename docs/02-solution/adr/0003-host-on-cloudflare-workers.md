# ADR 0003: Host on Cloudflare Workers

## Status

Accepted, 2026-08-18. Supersedes [ADR-0002](0002-host-on-github-pages.md).

## Context

Booking clicks needed to be counted server-side (see [ADR-0006](0006-count-booking-clicks-in-the-worker.md)), and GitHub Pages will not run code. DNS was already on Cloudflare.

Two Cloudflare shapes were available: classic Pages with `wrangler pages deploy`, or a Worker with a static asset store.

## Decision

Deploy the built site as Cloudflare Worker static assets — `wrangler deploy` with an `[assets]` block — rather than as a Pages project. Configuration lives in `wrangler.toml` in the site repo.

`run_worker_first = ["/go/*"]` means the Worker executes only for the booking redirect. Every other request is served straight from the asset store without invoking code.

## Consequences

One deployment holds both the site and the redirect, so they cannot drift apart or be versioned separately.

Static requests do not pay for Worker invocation, and the code path that runs on a booking click is small enough to reason about in one screen.

Traffic at this level sits inside the free tier. Analytics Engine retains three months, which bounds the click history.

The cost is the loss of OIDC. Deployment now uses a long-lived Cloudflare API token held as a GitHub secret. That is a real reduction in the security posture, scoped as narrowly as the task allows (Workers Scripts:Edit) and recorded under REQ-038 rather than left implicit.

Some configuration cannot live in `wrangler.toml` and must be set in the dashboard. The www→apex Redirect Rule is the current example, and it is currently missing — the failure mode of this split is that a repo file describes a rule nobody deployed. See [domain-and-analytics.md](../domain-and-analytics.md).
