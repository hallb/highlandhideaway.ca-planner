# ADR 0007: Keep taxonomy pages out of the index and the sitemap

## Status

Accepted, 2026-08-19. Satisfies REQ-039.

## Context

Hugo generates a page for every tag and every category. Before Search Console was set up, the sitemap advertised 73 URLs. Fifty of them were auto-generated tag and category pages — navigation outnumbering real content two to one.

None of those pages is something a person searches for. Each holds a heading and a list of links, and many list one post. For a single rental competing against Airbnb's own listing pages and established Haliburton directories, spending crawl budget on them is a straightforward loss.

`robots.txt` was a related problem: Hugo emits none unless `enableRobotsTXT` is set, so production was serving Cloudflare's managed file, which blocks AI crawlers but carries no `Sitemap` line.

## Decision

Taxonomy pages get `noindex, follow` via an override in `partials/head/meta.html`, and are excluded from `layouts/sitemap.xml`.

`enableRobotsTXT = true`, so Hugo generates the file and the `Sitemap` line it has always had a template for.

`follow` rather than `nofollow` is deliberate: the pages should still pass link equity to the posts they list. The intent is to stop them ranking, not to cut them out of the crawl graph.

## Consequences

The sitemap is down to 23 URLs, all of them pages worth ranking.

Search Console will show roughly 50 URLs under "Excluded by 'noindex' tag" once crawling catches up. That is this decision working, and it should not be read as a fault.

The served `robots.txt` is the union of Hugo's file and Cloudflare's managed content signals — Cloudflare appends rather than replaces.

Taxonomy pages remain useful as on-site navigation and are still crawled for their links. They are no longer a search-discovery path, so anything that needs to be findable requires a real page and a real link to it (REQ-026).

Verified live: sitemap 23 URLs, `noindex` present on `/tags/area/`, `Sitemap` line in `robots.txt`, weekly crawl 23/23 with 0 errors. Site repo commit `5c9d1f3`.
