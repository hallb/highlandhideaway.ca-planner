# ADR 0008: Page analytics — keep Google Analytics, or move to Cloudflare

## Status

**Proposed.** Open as of 2026-08-20. Tracked in ISS-28; the consent question it settles is ISS-11.

## Context

Google Analytics 4 is enabled with `anonymizeIP = true`. No consent banner and no privacy notice are published, which is the gap REQ-035 names.

Cloudflare Web Analytics is free, cookieless, and needs no script tag on a proxied zone. It reports page views, referrers, paths and Core Web Vitals. It has no custom events.

The absence of custom events does not matter here. Conversions go through the Worker ([ADR-0006](0006-count-booking-clicks-in-the-worker.md)), not through any analytics product, which was chosen partly to keep this decision cheap to reverse.

What GA uniquely provides is session and engagement metrics, and continuity with whatever history the property already holds.

Against that, GA is the only reason the consent question exists. Dropping it would close ISS-11 by removing what raises it, rather than answering it with a banner and a privacy page.

## Decision

Not yet made. The shape under consideration:

1. Enable Cloudflare Web Analytics for the zone.
2. Run both for two to four weeks, alongside the Search Console ramp.
3. If nothing in GA is being used, set `params.analytics.enable = false` and close ISS-11.

## Consequences

To be recorded when the decision is made.

Two facts that bear on it, both checked 2026-08-20:

- Cloudflare Web Analytics is **not** enabled. The live homepage carries `gtag` and no Cloudflare beacon, so there is no CF page data to compare against yet. Nothing can be decided on evidence until that is turned on and has accumulated some.
- Search Console was verified 2026-08-19 and query data is not useful before roughly 2026-09-02. The traffic picture is thin in every tool right now, which argues for enabling Cloudflare and waiting rather than deciding on the current numbers.

Cloudflare's zone-level edge analytics is unaffected either way. It needs no beacon, but counts requests rather than sessions, so it does not substitute for either option.
