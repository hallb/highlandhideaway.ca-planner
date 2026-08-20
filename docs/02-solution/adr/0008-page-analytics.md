# ADR 0008: Replace Google Analytics with Cloudflare Web Analytics

## Status

**Accepted, 2026-08-20. Implementation pending** — the change is on site repo branch `analytics/cloudflare-web-analytics` (commit `ff71fba`) and is not merged, so Google Analytics is still live in production. Tracked in ISS-28; the consent question it settles is ISS-11.

## Context

Google Analytics 4 was enabled with `anonymizeIP = true`. No consent banner and no privacy notice were published, which is the gap REQ-035 names.

GA was the only reason that gap existed. Nothing else on the site sets a cookie or stores an identifier that follows a visitor between sessions.

Cloudflare Web Analytics is free and cookieless. It reports page views, referrers, paths and Core Web Vitals. It has no custom events, which costs nothing here: booking conversions are counted server-side by the Worker ([ADR-0006](0006-count-booking-clicks-in-the-worker.md)), not by any analytics product. Keeping conversion measurement out of the analytics vendor was part of why that design was chosen, and it is what made this decision cheap.

What GA uniquely provided was session and engagement metrics, and continuity with the history already in the property.

## Decision

Drop Google Analytics. Adopt Cloudflare Web Analytics.

`params.analytics.enable` stays `true` — it now gates Cloudflare rather than Google. The `[params.analytics.google]` block is removed and `[params.analytics.cloudflare]` takes its place.

**Install the beacon manually, not with Cloudflare's automatic injection.** DoIt already renders the beacon from `params.analytics.cloudflare.token`, so this is a configuration change rather than a layout override.

Automatic injection is a dashboard switch that leaves no trace in the repository. This project has already lost one piece of configuration exactly that way: `wrangler.toml` and the header of `hugo.toml` both describe a www→apex Redirect Rule that was never created ([ADR-0005](0005-make-the-apex-canonical.md)). A token in version control is a thing code review can see.

The manual route also sidesteps a question the Cloudflare documentation does not answer: whether edge injection fires for responses served from a Worker asset store rather than a classic proxied origin. A tag in the HTML does not depend on the answer.

## Consequences

The site sets no cookie and needs no consent banner or privacy notice, so ISS-11 closes rather than acquiring one.

Traffic reporting moves to the Cloudflare dashboard, alongside the zone-level edge analytics already there. The GA property stops collecting but keeps its history; it is not deleted.

Session and engagement metrics are gone. Nothing currently depends on them.

The beacon token is not a secret — it ships in page source by design — which is why it belongs in `hugo.toml` and not in GitHub secrets.

An empty token renders no beacon at all, because the theme guards the tag with `with`. Verified both directions on a local build: `token = ""` renders nothing, a filled value renders the script. The failure mode of an unfinished merge is therefore no page analytics rather than a broken tag, which is why the branch is safe to leave sitting unmerged, and also why merging it before the token is filled would quietly leave the site with no analytics at all.

Creating the Web Analytics site needs an API token with **Account Settings: Edit**; the existing `CF_AE_TOKEN` is Account Analytics: Read and returns an authentication error against `/accounts/{id}/rum/site_info`. Doing it in the dashboard needs no new token, which is the cheaper path for a one-time setup.
