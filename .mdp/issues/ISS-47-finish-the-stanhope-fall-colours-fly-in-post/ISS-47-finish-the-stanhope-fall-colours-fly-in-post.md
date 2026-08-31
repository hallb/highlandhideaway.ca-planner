---
id: ISS-47
title: Finish the Stanhope Fall Colours Fly-In post
type: task
status: Done
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: 2026-09-08
blockedBy: []
parent: null
relatedTo:
  - ISS-48
checklist:
  - text: Confirm the supplied flyer is the 2026 edition -- it prints no year
    done: true
  - text: "Feature line-up: resolved by following the flyer, not the township's 2024 write-ups"
    done: true
  - text: "Camping: CUT. Pilots-only on the flyer, and this page's audience is not pilots"
    done: true
  - text: "NOT ANSWERED: parking arrangements. Not published anywhere, so not on the page"
    done: false
  - text: "NOT ANSWERED: scenic flight pricing. Not published anywhere, so not on the page"
    done: false
  - text: Measure the drive to 1168 Stanhope Airport Road -- 20 minutes via Highway 118
    done: true
  - text: Check availability for 25-26 Sept -- the property is free that weekend
    done: true
  - text: "NOT ANSWERED: rain date or weather cancellation policy"
    done: false
  - text: Add Event schema markup
    done: true
  - text: "AFTER THE EVENT: convert the page on 27 Sept -- recap or the 2027 date"
    done: false
log:
  - timestamp: 2026-08-31T14:00:00.000Z
    author: claude
    body: |-
      Closed at Ben's direction on 2026-08-31. The post is live at /posts/stanhope-fall-colours-fly-in/ and has been since 2026-08-24, with Event schema. Site repo commit 39d6875.

      Closing this does not mean the checklist was finished, so the items above now say which they are. Four were resolved, two were resolved by a decision rather than an answer, and three were never answered.

      Resolved: the flyer is the 2026 edition, the drive is 20 minutes via Highway 118, the property is free that weekend, and the Event schema is in.

      Resolved by decision: the feature line-up follows the flyer rather than the township's 2024 write-ups, so the 2024 beer garden, aviation careers booth and firefighting displays are deliberately absent and must not be added without a current source. Camping is cut entirely, being pilots-only on the flyer.

      Never answered, and therefore absent from the page rather than guessed at: parking arrangements, scenic flight pricing, and whether there is a rain date or a weather cancellation policy. None of it is published anywhere. Do not fill these in from memory if the page is edited later.

      One item is a future task rather than an unfinished one. The page needs converting after 27 September, either to a recap or to the 2027 date, and closing this issue does not do that. The event is 26 September 2026, four weeks out at time of closing, so anything that does get published between now and then is still worth folding in.
createdAt: 2026-08-22T13:26:29.911Z
updatedAt: 2026-08-31T14:00:00.000Z
---

## Requirement

`content/posts/stanhope-fall-colours-fly-in.md` is a `draft: true`
outline. The township-verified facts are in the file; everything read
off the client-supplied flyer is marked and unconfirmed for 2026.

Brief: `docs/stanhope_fly_in_brief.md` in the site repo.

## Why it is dated

Saturday 26 September 2026, 10am to 3pm. Search traffic for a named
event climbs through the fortnight before it, and a page published
inside the final week rarely indexes in time. Publish in early
September.

The URL carries no year. On 27 September the page stops being useful, so
either cut it back to a recap with a "2027 date not yet announced" line
or put the 2027 date on it once the township announces one. Do not leave
a stale 2026 date on a permanent URL.

## What blocks it

The feature list. The flyer lists an aviation author, artists and
artisans, and face painting. The township's prior-year write-ups instead
list a beer garden, an aviation careers booth, and firefighting
equipment displays. The two lists do not overlap at all, so at most one
of them describes 2026 and prior-year features must not be carried
forward.

Camping is the highest-risk detail after the date. The flyer restricts
it to pilots. Telling readers they can camp when they cannot is the
thing most likely to strand somebody.

## Constraints

Do not publish the airport coordinator's phone number. Two different
numbers circulate for the same named person. Link the township contact
page instead.

Do not conflate the airport address (1168 Stanhope Airport Road, K0M
1J1) with the township office (1123 North Shore Road, K0M 1S0).

No affiliation with the township, the airport, or the advisory
committee.
