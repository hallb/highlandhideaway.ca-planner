# Constraints

## Technical

- **Static site generator:** **Hugo** extended, pinned to **0.159.0** in CI and expected to match locally.
- **Theme:** **DoIt** (vendored as a git submodule under `themes/DoIt` in the site repo).
- **Hosting:** **Cloudflare Workers**, with the built site shipped as Worker static assets. See [ADR-0003](../02-solution/adr/0003-host-on-cloudflare-workers.md).
- **Build and deploy:** **GitHub Actions** (`.github/workflows/cloudflare.yml`), not Cloudflare's Git integration. See [ADR-0004](../02-solution/adr/0004-deploy-from-github-actions.md).
- **Domain:** DNS is on Cloudflare. The apex `highlandhideaway.ca` is canonical; `www` is expected to 301 to it. See [ADR-0005](../02-solution/adr/0005-make-the-apex-canonical.md), and the caveat in [`../02-solution/domain-and-analytics.md`](../02-solution/domain-and-analytics.md) — the redirect is documented but not currently deployed.

Hosting moved from GitHub Pages on 2026-08-18. Nothing in the site repo refers to Pages any more.

## Repository layout

- **Site source:** `highlandhideaway.ca/` (sibling to this planner repo).
- **Documentation and planning:** `highlandhideaway.ca-planner/docs/` (this tree). Issues and milestones live in `.mdp/`.

## Content ownership

- Property owners or designated editors maintain Markdown and images. No headless CMS in the current architecture.

## Legal and rental context

- Public copy should avoid unverifiable claims. The rental relationship remains with the booking platform and applicable local rules. Disclaimers are a content and legal task, not encoded here.

## Budget

- Domain registration is the only committed cost. Cloudflare Workers, Analytics Engine, Web Analytics and GitHub Actions all sit inside free tiers at this traffic level. Analytics Engine retains three months of data on the free plan, which bounds how far back the booking-click history can go.
