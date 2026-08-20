# ADR 0008: Remove Google Analytics; keep Cloudflare Web Analytics on automatic injection

## Status

**Accepted, 2026-08-20. Implementation pending** — the GA removal is on site repo branch `analytics/cloudflare-web-analytics` (commit `9cd661d`) and is not merged, so GA is still live in production. Cloudflare Web Analytics is already running. Tracked in ISS-28; the consent question it settles is ISS-11.

## Context

Google Analytics 4 was enabled with `anonymizeIP = true`. No consent banner and no privacy notice were published, which is the gap REQ-035 names. GA was the only reason that gap existed — nothing else on the site sets a cookie or stores an identifier that follows a visitor between sessions.

**Cloudflare Web Analytics was already enabled, with automatic injection**, and had been collecting for some time. An earlier check concluded it was not, and that conclusion was wrong: Cloudflare only injects the beacon for requests that look like a browser, and the check used a plain `curl`. With a browser User-Agent the beacon is present on `/` and on `/posts/welcome/`.

That also settles a question this ADR previously recorded as open. Edge injection does reach responses served from a Worker asset store, not only a classic proxied origin.

So the site had two analytics running at once, and the decision was never "which product" — it was only whether to keep paying the consent cost of GA.

Cloudflare Web Analytics is free and cookieless. It reports page views, referrers, paths and Core Web Vitals. It has no custom events, which costs nothing here: booking conversions are counted server-side by the Worker ([ADR-0006](0006-count-booking-clicks-in-the-worker.md)), not by any analytics product. Keeping conversion measurement out of the analytics vendor is what made this decision cheap.

What GA uniquely provided was session and engagement metrics, and continuity with the history already in the property.

## Decision

Remove Google Analytics. Keep Cloudflare Web Analytics on automatic injection.

`params.analytics.enable` goes to `false`, because with GA gone there is nothing left for the theme to render.

**Do not set `params.analytics.cloudflare.token`.** DoIt supports a manual beacon, and the token is public and visible in the dashboard, so adding it looks like an obvious improvement. It is not: the theme would render a second beacon alongside the injected one and double-count every view. The two mechanisms are mutually exclusive.

Manual installation was considered and rejected. It would put the beacon in version control, which is worth something — dashboard-only configuration is invisible to code review, and this project has already lost the www→apex Redirect Rule exactly that way ([ADR-0005](0005-make-the-apex-canonical.md)). But automatic injection was already working and already collecting, so switching would mean turning injection off and deploying the manual tag in close succession, with a gap or a period of double-counting if the two did not line up. That is real risk for a benefit that documentation can supply instead.

The mitigation is a dashboard-configuration list in `wrangler.toml`, naming Web Analytics injection alongside the missing Redirect Rule. The point of failure last time was not that the dashboard was used; it was that nothing in the repo recorded what the dashboard was meant to hold.

## Consequences

The site sets no cookie and needs no consent banner or privacy notice, so ISS-11 closes rather than acquiring one.

The GA property stops collecting but keeps its history; it is not deleted. Session and engagement metrics are gone, and nothing currently depends on them.

The beacon does not appear in `./public`, and it does not appear to a plain `curl`. Neither absence means anything is broken. Checking it requires a browser User-Agent:

```bash
curl -s https://highlandhideaway.ca/ -H "User-Agent: Mozilla/5.0 ..." \
  | grep -o "data-cf-beacon='[^']*'"
```

Bots and scripted requests are not beaconed, so Web Analytics counts closer to real visitors than a tag in the HTML would.

Web Analytics now has a dashboard dependency that no deploy will restore. If the site is ever moved off Cloudflare, or the Web Analytics site is deleted, page analytics stops silently and nothing in CI notices.
