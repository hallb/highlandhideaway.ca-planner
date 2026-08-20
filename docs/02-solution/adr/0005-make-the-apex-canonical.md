# ADR 0005: Make the apex canonical

## Status

Accepted, 2026-08-18. Partially implemented — see Consequences.

## Context

The site had been inconsistent about its hostname for as long as it existed. The `CNAME` file said `www.highlandhideaway.ca`; `baseURL` in `hugo.toml` said the apex. Canonical tags, the sitemap, RSS and Open Graph URLs all follow `baseURL`, so they pointed at a host that was not the one DNS was set up for.

REQ-034 requires the strategy to be documented and enforced. Either host would satisfy it. The choice had to be made and then made true everywhere.

## Decision

`https://highlandhideaway.ca/` is canonical. `www` redirects to it with a 301.

Both hostnames stay attached to the Worker as custom domains, so `www` continues to resolve — a redirect needs the name to answer before it can redirect anything.

Search Console uses a Domain property, which covers both hostnames and survives the redirect.

## Consequences

`baseURL`, canonical tags, the sitemap and the Open Graph URLs now agree, and they name the host that serves.

The apex is the shorter name and the one people type.

**The redirect half is not deployed.** Checked 2026-08-20: `https://www.highlandhideaway.ca/` returns 200 and serves the site. `wrangler.toml` and the header comment in `hugo.toml` both describe the Redirect Rule as though it exists, which makes them misleading.

The exposure is bounded, because canonical tags are correct and absolute on both hostnames and search engines usually consolidate on them. But a canonical tag is a hint and a 301 is not, so `www` URLs can still be indexed as duplicates. The fix is a Redirect Rule in the Cloudflare dashboard, tracked in ISS-27.

This is the predictable failure of splitting configuration between a repo and a dashboard: nothing in CI can tell you the dashboard half was never done.
