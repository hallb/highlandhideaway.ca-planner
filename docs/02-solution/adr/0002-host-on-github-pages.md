# ADR 0002: Host on GitHub Pages

## Status

Superseded by [ADR-0003](0003-host-on-cloudflare-workers.md) on 2026-08-18. Recorded retroactively on 2026-08-20 so the history is legible.

## Context

The site is static, the source is on GitHub, and the budget is the domain registration. Pages builds and serves from the same place the code lives, at no cost.

## Decision

Host on GitHub Pages, deployed from `main` by GitHub Actions, with a `CNAME` file pointing at `www.highlandhideaway.ca`.

## Consequences

It worked, and cost nothing. Deployment used GitHub's OIDC flow, so no long-lived deploy tokens existed.

Two limits ended it. Pages serves files and will not run code, so there was nowhere to count a booking click except the client, where an ad blocker can suppress it. And the `CNAME` file said `www` while `baseURL` said the apex, a mismatch that had to be resolved somewhere.

One consequence outlived the decision. When Pages was retired, its last deployment kept serving anyone whose resolver still held its addresses — and that build's buttons linked straight to Airbnb, so those visitors converted while recording nothing. The fallback that looked like a safety net was undercounting invisibly. Pages was disabled ahead of the DNS drain for that reason: a hard 404 for a shrinking set of stale resolvers is the better failure, because it is visible.
