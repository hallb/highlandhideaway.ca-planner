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
  - ISS-58
checklist:
  - text: Re-export the full ZIP on or after 2026-09-20 with the baseline settings
    done: false
  - text: Record the brand query average position against its baseline of 13
    done: false
  - text: Decide in writing whether query data can now order ISS-31
    done: false
  - text: While in the data, check whether the ISS-58 operator rule is reclassifying machines as intended
    done: false
log:
  - timestamp: 2026-09-16T11:40:00.000Z
    author: claude
    body: |-
      Two things to fold into this read when it happens, both dated 2026-09-15/16.

      First, the reason to expect movement. Highland Hideaway is now listed on My
      Haliburton Highlands and the entry links to the apex domain rather than to
      Airbnb (ISS-56, closed). That is the site's first independent citation from an
      established local directory, and the brand query is the number it should move:
      average position 13 with 26 impressions and zero clicks is the baseline to
      beat. Referral traffic from myhaliburtonhighlands.com should also start
      appearing in Cloudflare RUM, which has recorded no referrals from anywhere at
      all across its full retention.

      Second, a free ride-along. ISS-58 deployed on 2026-09-16 and its operator rule
      cannot be proven from here -- it needs machines arriving from datacenters to
      exercise it, which only time supplies. This read already opens the same window,
      so checking it costs nothing extra. What to look for: rows that would have
      landed as blob5='human' now landing as 'bot'. Added as a checklist item rather
      than left as an intention.

      Worth knowing before reading the numbers: the site had no organic search
      channel at all as of 2026-09-06, and both September event posts recorded zero
      impressions. A flat result here is a real possibility and is not by itself
      evidence that the directory listing failed -- a three-week-old domain and a
      citation that is days old are both still young.
createdAt: 2026-09-07T04:29:08.704Z
updatedAt: 2026-09-16T11:40:00.000Z
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
