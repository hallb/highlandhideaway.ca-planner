# Tech stack

Satisfies **REQ-030**, **REQ-036**, and the technical items in [`../01-requirements/constraints.md`](../01-requirements/constraints.md).

## Core

| Layer | Choice | Notes |
|-------|--------|--------|
| Generator | **Hugo** extended | `hugo.toml` at the site repo root |
| Version | **0.159.0** | Pinned as `HUGO_VERSION` in `cloudflare.yml`; keep the local toolchain in step |
| Theme | **DoIt** | Submodule at `themes/DoIt` |
| Hosting | **Cloudflare Workers** | Static assets plus `src/worker.js`, config in `wrangler.toml` |
| Languages | **English only** | `defaultContentLanguage = "en"`, `languageCode = "en-us"` |

Other pinned versions, all in `cloudflare.yml`: `HTMLTEST_VERSION` 0.17.0, `WRANGLER_VERSION` 4.124.0. Wrangler is pinned because `wrangler-action` defaults to a 3.x wrangler, which silently drops `run_worker_first` and `not_found_handling` from `[assets]`. A silent drop is worse than a build failure, so the pin matters more than it looks.

## Notable `hugo.toml` settings

- **`baseURL`:** `https://highlandhideaway.ca/` — the apex, matching the canonical host.
- **`enableRobotsTXT = true`.** Hugo emits no `robots.txt` unless asked. Without this, production served Cloudflare's managed file, which carries no `Sitemap` line. Cloudflare appends its content signals to the origin file rather than replacing it, so the served result is the union of both.
- **Menu:** Guides → `/posts/`, The Property → `/photos/`, About → `/about/`.
- **Booking:** `params.booking` holds the destination URL, the button text, and the room counts, so the pitch is stated once and every CTA reads from it.
- **Analytics:** `params.analytics.google.id = "G-M21FZFQ5YJ"`, `anonymizeIP = true`. Whether this stays is open in ISS-28.
- **Module mounts:** `static/` is mounted twice, once as `static` and once as `assets`. Images are referenced as plain `/images/foo.jpg` from front matter and from several theme partials, so they must publish verbatim; mounting them as assets as well lets `resources.Get` resolve them for WebP srcsets. Declaring any mount replaces all of Hugo's defaults, which is why seven re-declarations precede the one doing the work.
- **Goldmark:** `unsafe = true` allows raw HTML in Markdown. See ISS-14 for what that implies if untrusted contributors are ever added.
- **Build:** `writeStats = true`; `noChmod` and `noTimes` set.

## Layout overrides

`layouts/` holds a small number of deliberate overrides rather than a forked theme:

- `posts/single.html` — a purpose-built editorial post layout, not a copy of DoIt's. See [ADR-0009](adr/0009-replace-the-post-layout.md).
- `partials/booking-cta.html`, `shortcodes/book.html`, `partials/booking-url.html` — the booking controls. Every outbound booking link is built by `booking-url.html`, so the destination and the tracking parameters cannot drift apart.
- `partials/head/meta.html` — adds `noindex, follow` to taxonomy pages.
- `sitemap.xml` — excludes taxonomy pages.
- `partials/init.html` — overrides DoIt's init to drop a `.Site.Author` check that Hugo 0.15x removed.

## Why static Hugo

Builds are fast, there is no runtime database, and the output is a directory of files that any static host can serve. Content in Git gives review and history for guest-facing copy. The 2026-08 move from GitHub Pages to Cloudflare changed the host and cost nothing in the generator, which is the property being relied on.
