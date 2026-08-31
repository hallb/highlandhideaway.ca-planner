---
id: ISS-52
title: Flesh out the what is nearby page
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
checklist:
  - text: Check Search Console query data first; record in the log which queries steered the work
    done: false
  - text: Measure the drive times to Minden, Algonquin west gate, Dorset, Carnarvon, Eagle Lake, Sir Sam's
    done: false
  - text: Replace a handful of restaurants with three named recommendations
    done: false
  - text: Get seasonal closures -- also answers Q2 on ISS-45
    done: false
  - text: Verify or drop the 6 km Head Lake Loop figure and the Barnum Creek details
    done: false
  - text: Decide whether hidden-gems-nearby merges into this page or stays separate
    done: false
  - text: Link to Skyline Park in the fall colours post rather than rewriting it
    done: false
  - text: Build, run htmltest, and grep the whole build output for comment leakage
    done: false
log: []
createdAt: 2026-08-31T17:07:51.985Z
updatedAt: 2026-08-31T17:07:51.985Z
---

## Requirement

`content/posts/whats-nearby.md` carries **245 words** and is load-bearing:
every event post links to it, and it is the natural target for the "things to
do in Haliburton" family of queries.

## Where it stands

An opening on the boat launch across the road, then short sections on
Haliburton (two groceries, an LCBO, hardware, two pharmacies, "a handful of
restaurants, galleries, and thrift shops", with Foodland, Todd's Your
Independent Grocer and McFaddens named), Minden, Algonquin Park ("the west gate
is within a reasonable day trip"), groceries and supplies, and getting outside
(the Haliburton County Rail Trail, the Head Lake Loop at 6 km, Barnum Creek
Nature Reserve).

It is a decent skeleton. It is short on specifics, and specifics are the whole
value of a page like this.

## Why this one

A single rental cannot outrank Airbnb or the established directories on
accommodation queries. It can win on local specifics, because that is what the
directories get wrong and what a general-purpose answer cannot fake. This page
is where that advantage lives.

It is also the internal-linking hub. The Corduroy, watercross, Stanhope and
Thanksgiving posts all point here rather than repeat local geography, so
strengthening it improves several pages at once.

Unlike the home page (ISS-50), **this one should wait for query data.** ISS-27
is closed, and query data was estimated to become useful between 2 and 16
September. The queries already showing at position 8 to 15 are the cheap wins
and they should decide which sections here get expanded first. Check Search
Console before drafting.

## Interrogate Ben

Distances first, because the page currently uses "a little further" and "within
a reasonable day trip" where it should use numbers:

- **Measured drive times** to Minden, the Algonquin west gate, Dorset,
  Carnarvon, Eagle Lake, and Sir Sam's. Precedent: Gooderham sat in a brief as
  "30 minutes" and is 22. Measure or route them, do not round in the
  property's favour.
- **Which restaurants does he actually recommend?** "A handful of restaurants"
  is the weakest line on the page. Three named places with a reason beats a
  count.
- **Seasonal closures.** What shuts, and roughly when. This also answers Q2 on
  ISS-45.
- **Winter.** Sir Sam's, snowmobile trails, ice fishing, whether any of it is
  something he is comfortable pointing guests at.
- **The 6 km Head Lake Loop figure** and the Barnum Creek details (donation,
  hours, season) — are these his, or inherited from somewhere unverified?
- **Practical geography a guest may urgently need**: hospital, walk-in clinic,
  pharmacy hours, vet. Nobody searches for this until they need it, and then it
  matters a great deal.
- **Swimming and beaches** beyond the launch across the road.
- **Farmers market** days and season.
- **Fuel.** He declined to name fuel stations on the Corduroy page. Ask whether
  that was specific to that post or a general position, and respect the answer
  either way.

## Do not duplicate

- **Skyline Park** is now covered properly in `/posts/fall-colours/`, including
  directions, the free admission, the picnic tables and the AllTrails walk.
  Link to it, do not rewrite it.
- Groceries are already detailed here and in the pantry guide; the Corduroy page
  points here rather than repeating them. Keep that arrangement.
- `hidden-gems-nearby` (187 words) is the quieter-places page. Decide whether
  the two should stay separate or merge, and say which in the issue log.

## House rules that bite here

- **Voice.** Load the `writing-as-ben` skill. Plain, short declaratives,
  Canadian spelling, no idioms, no travel-brochure register.
- **No unverified figures**, and no business hours copied from a source that may
  be stale. Local business hours rot fast; prefer naming the place and letting
  the reader check.
- Owner-only facts go in HTML comments; stripped from pages and feeds since site
  commit 03269fd, but verify with a grep over the whole build output. See
  ISS-31.
- **Never state the Airbnb minimum stay.**
- **Check link targets exist and are not drafts** before publishing.
- **Build and run htmltest** before committing.

## Acceptance criteria

- Search Console query data was checked first, and the log says which queries
  steered the work.
- Vague distances are replaced with measured ones, or removed.
- Named recommendations replace counted ones.
- The page still functions as a hub: the event posts that link here still find
  what they point at.
- Every new claim is Ben's or sourced, and attributed in a comment with the date.
- Builds clean, htmltest passes, no comment text in the build output.
