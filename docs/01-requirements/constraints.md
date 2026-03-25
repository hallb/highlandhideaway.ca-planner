# Constraints

## Technical

- **Static site generator:** **Hugo** (extended build in CI for theme/tooling compatibility).
- **Theme:** **DoIt** (vendored as git submodule under `themes/DoIt` in the site repo).
- **Hosting:** **GitHub Pages** with **GitHub Actions** build/deploy pipeline.
- **Domain:** Customer DNS points to GitHub Pages; **`CNAME`** file in repo uses **`www.highlandhideaway.ca`** while **`baseURL`** in config may use apex **`https://highlandhideaway.ca/`**—this mismatch must be resolved in DNS and config (see solution doc).

## Repository layout

- **Site source:** `highlandhideaway.ca/` (sibling to this planner repo).
- **Documentation / planning:** `highlandhideaway.ca-planner/docs/` (this tree).

## Content ownership

- Property owners or designated editors maintain Markdown and images; no headless CMS in current architecture.

## Legal and rental context

- Public copy should avoid unverifiable claims; rental relationship remains with the booking platform and applicable local rules. Disclaimers as needed are a content/legal task, not encoded here.

## Budget

- No paid hosting requirement beyond domain registration and optional analytics; GitHub Pages within free tier assumptions unless usage grows.
