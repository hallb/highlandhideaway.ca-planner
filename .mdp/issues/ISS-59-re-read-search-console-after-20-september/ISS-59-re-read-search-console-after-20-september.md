---
id: ISS-59
title: Re-read Search Console after 20 September, tracking the brand query
type: task
status: To Do
priority: Medium
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-27
  - ISS-31
  - ISS-56
checklist:
  - text: Re-export the full ZIP on or after 2026-09-20 with the baseline settings
    done: false
  - text: Record the brand query average position against its baseline of 13
    done: false
  - text: Decide in writing whether query data can now order ISS-31
    done: false
log: []
createdAt: 2026-09-07T04:29:08.704Z
updatedAt: 2026-09-07T04:29:08.704Z
---

## Requirement

ISS-27 closed with the expectation that query data would become useful between
2026-09-02 and 2026-09-16, and that the queries sitting at position 8-15 would
decide which ISS-31 children to finish first.

The export taken on 2026-09-06 does not support that. In short:

- **26 impressions and 0 clicks** across 19 days, 7 of them with no impressions
  at all.
- **5 queries disclosed**, accounting for 7 of the 26 impressions. The other 19
  are withheld under Google's rare-query anonymisation.
- The position 8-15 band contains **two queries, both the brand name**. Not one
  intent-bearing query appears -- nothing resembling "haliburton cottage
  rental" or any of the event content.
- Cloudflare RUM independently records **zero referrals from google.com** over
  240 page loads, which corroborates the zero clicks rather than restating them.

There is not enough here to order content work, and reading it as though there
were would be reading noise. The audit's own finding stands unchallenged: the
pages are thin, and depth on the pages worth ranking is the work.

## The one real signal

`highland hideaway` -- the site's own name -- sits at **average position 13**,
and `highlands hideaway` at 7. A brand query is the easiest ranking a site will
ever get, and this one is not being won. That single number is the cleanest
available measure of whether the site has enough substance and enough external
citation to be taken seriously, so it is worth tracking on its own rather than
inside a general impressions count.

Both levers are tracked elsewhere: depth on the pages worth ranking (ISS-31 and
its children) and external citations pointing at the apex (ISS-56).

## When, and with what settings

Re-export around **2026-09-20 to 2026-09-30**. Same settings as the baseline so
the two are comparable: Search results, search type Web, Domain property, no
filters, custom range starting 2026-08-19 so the whole history stays in one
frame. Take the full ZIP -- Queries and Pages decide the ordering, Dates lines
up against Cloudflare visits, and Pages cross-checks the click data.

Expect the headline impression count to **fall** before it rises. 18 of 38
page-level impressions currently go to tag and category pages carrying
`noindex, follow`; those will decay out as Google reprocesses them. That is
ADR-0007 working, not a regression, and the number should not be read alone.

## Acceptance

- A second export is taken on or after 2026-09-20 and compared against the
  2026-09-06 baseline.
- The brand query's average position is recorded against its baseline of 13.
- A decision is written down: either the query data is now good enough to order
  ISS-31, or it is not and the ordering stays on editorial judgement.
