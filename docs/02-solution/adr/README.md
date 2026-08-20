# Architecture Decision Records (ADR)

Short documents capturing a significant decision about the Highland Hideaway stack or process: its context, the decision, and what follows from it.

- Background and community practice: [ADR GitHub organization](https://adr.github.io/)
- Requirements live in [`../../01-requirements/`](../../01-requirements/); link ADRs to `REQ-###` IDs where relevant.

## Records

| ADR | Title | Status |
|-----|-------|--------|
| [0001](0001-use-hugo-and-the-doit-theme.md) | Use Hugo with the DoIt theme | Accepted |
| [0002](0002-host-on-github-pages.md) | Host on GitHub Pages | Superseded by 0003 |
| [0003](0003-host-on-cloudflare-workers.md) | Host on Cloudflare Workers | Accepted |
| [0004](0004-deploy-from-github-actions.md) | Deploy from GitHub Actions, not Cloudflare's Git integration | Accepted |
| [0005](0005-make-the-apex-canonical.md) | Make the apex canonical | Accepted, partly implemented |
| [0006](0006-count-booking-clicks-in-the-worker.md) | Count booking clicks in the Worker | Accepted |
| [0007](0007-keep-taxonomies-out-of-the-index.md) | Keep taxonomy pages out of the index and the sitemap | Accepted |
| [0008](0008-page-analytics.md) | Remove Google Analytics; keep Cloudflare Web Analytics | Accepted, pending deploy |
| [0009](0009-replace-the-post-layout.md) | Replace the DoIt post layout rather than override it | Accepted |

0001 and 0002 were written retroactively on 2026-08-20, when this folder was backfilled. Everything from 0003 on was recorded within days of the decision.

## Naming

A four-digit prefix and a kebab-case slug: `0003-host-on-cloudflare-workers.md`.

## Template

Copy [template.md](template.md) for a new ADR.

Supersede rather than rewrite. When a decision is reversed, set the old record's status to "Superseded by ADR-XXXX" and leave its reasoning intact — 0002 is the worked example. The context that made a decision right at the time is the part worth keeping.
