---
id: ISS-46
title: Finish the Corduroy Enduro post
type: task
status: In Progress
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: 2026-09-10
blockedBy: []
parent: null
relatedTo: []
checklist:
  - text: "CUT: the basecamp facts. The post no longer targets racers, so it makes them no promises"
    done: true
  - text: Measure the drive to Gooderham rather than repeating the 30 minute assertion -- 22 minutes, Ben
    done: true
  - text: Confirm availability for 17-20 Sept -- available; no minimum stay stated on the site
    done: true
  - text: Re-verify the 2026 dates and figures against corduroyenduro.ca
    done: true
  - text: Settle whether Friday GP and the Promation Prologue are the same event
    done: false
  - text: Write the spectator section in original wording; keep the warning that the walk in to Green's Mountain is hard
    done: true
  - text: "Nearest LCBO and full grocery -- done. Fuel and parts: CUT, no claims"
    done: true
  - text: "CUT: the CORD26 code. Airbnb does not make discount codes easy"
    done: true
  - text: Add spectator maps and the schedule once the event site publishes them
    done: false
log:
  - timestamp: 2026-08-31T13:00:00.000Z
    author: claude
    body: |-
      Written and published. Live at /posts/corduroy-enduro/, deployed and serving 200. Kept open for the two items still outstanding.

      The audience changed on the way, and it is the decision that shaped everything else. Ben's call: do not pitch hard to racers and crews. The post is for people coming to watch. If riders book off it, good, but it promises them nothing.

      That cut four things, and none go back without him: trailer and truck parking along with any claim about getting a trailer up the driveway; outdoor water for washing a bike down; anywhere for wet or dirty gear to dry, which he does not want in the cottage at all; and the 5am-start, 9pm-return framing of the kitchen. A disclaimer was drafted in place of the trailer section, saying the driveway is steep gravel and making no promises about towing, and that was cut too. Silence about trailers is the decision rather than an oversight.

      So the checklist item that was the hard blocker on this issue -- Ben supplying the basecamp facts -- is resolved by the section no longer existing. "Basecamp for the weekend" is now "Staying nearby", built only from facts already published elsewhere on the site, and it moved from third section to last, immediately before the booking call to action, so everything ahead of it is useful to somebody who never books.

      Facts from Ben on 2026-08-31: Gooderham is 22 minutes, replacing the 30 minutes the brief carried as an unverified client assertion; the cottage is available for the race weekend; there is an LCBO in both Gooderham and Haliburton with the Haliburton one better stocked; and full grocery is the two in Haliburton, Foodland and Todd's Your Independent Grocer, both already written up in what is nearby. No claims about fuel or parts suppliers, his call.

      No minimum stay on the page. He expects to keep tweaking the Airbnb minimum and does not want a number on the website that goes stale when he does. Same change applied to the American Thanksgiving draft.

      CORD26 is dropped: Airbnb does not make discount codes easy, so there is no code to issue. That costs less than the brief assumed. The Worker already counts booking clicks per page, so this page's contribution stays measurable at the click level; what is lost is attribution through to a completed booking.

      Two of the brief's source conflicts are handled by writing around them rather than picking a side. No day count appears anywhere, because the homepage says three days, lists a four-day range, and separately says racers ride two days plus a prologue and a final MX. And Friday is described as carrying "a Friday prologue" without naming either the Promation Prologue or the Friday GP, because the homepage still listed both as separate components when this was re-verified on 2026-08-31. That checklist item stays open.

      All seven spectator points are described in original wording, nothing lifted, and the warning that the walk in to Green's Mountain is hard is set in bold. The claim that the lakes are still swimmable in late September was cut as unverified.

      Still open: the Friday GP question, and the spectator maps and full schedule, which were still unpublished on the event site on 2026-08-31. The event runs 17-20 September, so the window for adding the maps is short.

      Site repo commits 409c312, db3e9ba and 8193ba3. Ben requested indexing in Search Console rather than waiting for a natural crawl, since a page crawled naturally in three weeks is worthless for 2026.
  - timestamp: 2026-09-03T02:13:42.336Z
    author: claude
    body: |-
      The post gained a Hike Haliburton paragraph on 2026-09-02, site repo commit 6c89b27, tracked on ISS-54.

      Hike Haliburton 2026 runs 17 to 20 September, the Cord weekend exactly. Ben found the festival page and asked for it to go in. It sits in "Making a weekend of it" rather than anywhere near the racing, so nothing about the spectator content or the audience decision changes.

      This does not touch the two items still open here. The Friday GP question and the spectator maps were both still unresolved on 2026-08-31, and the event is now fifteen days out, so the window for the maps is nearly gone.
createdAt: 2026-08-22T13:25:53.466Z
updatedAt: 2026-09-03T02:13:42.336Z
---

## Requirement

`content/posts/corduroy-enduro.md` is a `draft: true` outline. Section
order and the verified event facts are in the file; the prose and every
property fact are not.

Brief: `docs/corduroy_enduro_brief.md` in the site repo.

## Why it is dated

The 2026 Corduroy Enduro runs 17-20 September in Gooderham. Publishing
after that wastes the year. Early September, or hold for 2027.

The URL carries no year deliberately. Re-cut the dates each spring on
the same page.

## What blocks it

The property facts. Trailer parking, bike washing, gear drying,
capacity, connectivity and the fuel policy are what this audience books
on, and none of them can be guessed. An inaccurate claim about trailer
parking produces an angry guest.

Two pivots in the outline rest on assumptions that were invented in
conversation and never researched: that Gooderham has almost no lodging,
and that motels fill a year out. Verify or rewrite them.

The event site is not closely maintained -- its footer reads 2035 and it
still advertises a registration date from May -- so re-check every figure
before publishing.

## Constraints

No affiliation with the event, no logo, no use of "official" or
"partner". Do not copy text from the event site.
