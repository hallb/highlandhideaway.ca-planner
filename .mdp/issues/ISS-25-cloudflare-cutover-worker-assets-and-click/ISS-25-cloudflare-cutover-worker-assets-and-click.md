---
id: ISS-25
title: "Cloudflare cutover: Worker + assets, and click tracking"
type: milestone-task
status: Done
priority: High
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-1
  - ISS-3
  - ISS-11
checklist:
  - text: Export registrar DNS before changing anything
    done: true
  - text: Add zone to Cloudflare, review imported records
    done: true
  - text: Change nameservers at the registrar
    done: true
  - text: Create API token (Workers Scripts:Edit) and copy Account ID
    done: true
  - text: Add CLOUDFLARE_API_TOKEN and CLOUDFLARE_ACCOUNT_ID as GitHub secrets
    done: true
  - text: Enable Analytics Engine on the account
    done: true
  - text: First deploy creates the Worker; verify on workers.dev
    done: true
  - text: Delete GitHub Pages DNS records, attach apex + www custom domains
    done: true
  - text: Redirect rule www -> apex, 301, path and query preserved
    done: true
  - text: SSL/TLS set to Full (strict)
    done: true
  - text: Switch baseURL to the apex so canonical/sitemap match what serves
    done: true
  - text: Point booking CTAs at /go/airbnb
    done: true
  - text: Stop the GitHub Pages workflow updating (delete hugo.yml)
    done: true
log:
  - date: 2026-08-18
    note: >-
      Live and verified: 20/20 consecutive requests to /go/airbnb return 302
      to the listing, all ten CTA pages carry ?src= with their own page path,
      www 301s to apex with path and query intact, and unknown paths serve
      Hugo's 404. Repo commits 3760091, c974ae6, 36b6d92, 2e656e1, 62e46c3,
      bdd40d2.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## What shipped

- `wrangler.toml` — Worker name, `[assets]` with `run_worker_first = ["/go/*"]`
  and `not_found_handling = "404-page"`, both custom domains as
  `custom_domain` routes, `BOOKING_URL` var, and the `CLICKS` Analytics
  Engine binding.
- `src/worker.js` — intercepts `/go/airbnb`, writes a data point to
  `booking_clicks`, 302s to the listing with `Cache-Control: no-store`.
  Everything else passes through to `env.ASSETS`.
- `.github/workflows/cloudflare.yml` — builds, runs htmltest, deploys.
  Deploy is gated on the build job, and skips cleanly when secrets are absent.
- `layouts/shortcodes/book.html` — appends `?src=` when the configured URL
  is local, giving per-page attribution.

## Gotchas worth not rediscovering

Four things cost real time, none of them obvious from a passing check:

1. **`wrangler-action` installs wrangler 3.x by default.** That version does
   not understand `run_worker_first`; it warns "Unexpected fields found in
   assets field" and drops it. Pin `wranglerVersion` — the workflow pins
   4.124.0 alongside the Hugo and htmltest pins.

2. **Cloudflare's pre-canned redirect templates.** The first one matched only
   `/`, so deep paths on the apex served duplicate content. The replacement
   used `contains` instead of `equals`, matching both hostnames and producing
   an infinite loop that took the site down. Then both templates ended up
   enabled at once, pointing at each other. Build the rule by hand:
   `http.host eq "<apex>"` with a dynamic `concat(...)` target.

3. **Stale DNS looks exactly like a broken deploy.** Intermittent 404s on
   `/go/airbnb` were requests reaching GitHub Pages directly from a resolver
   still holding its addresses. The giveaway is a response with no `cf-ray`
   header — it never went through Cloudflare. Test with
   `curl --resolve <host>:443:<cloudflare-ip>` before believing an outage.

4. **htmltest cannot resolve a Worker route.** `/go/*` has no file in
   `public/`, so it needs an `IgnoreURLs` entry. This is unlike the old
   `^/images/` ignore, which was concealing genuinely missing files.

## Deliberate divergence from tools-portfolio

That repo uses Cloudflare's Git integration and gates on branch protection.
This one deploys from Actions so the htmltest gate is structural. Two
repo-specific reasons reinforce it: the DoIt theme is a git submodule
Cloudflare's builder would have to init, and there is no `package.json`, so
Hugo and htmltest would both need installing inside a build command. The
reasoning is recorded in the `wrangler.toml` header comment.
