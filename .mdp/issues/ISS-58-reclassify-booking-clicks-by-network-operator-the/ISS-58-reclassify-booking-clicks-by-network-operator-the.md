---
id: ISS-58
title: Reclassify booking clicks by network operator; the human verdict is 80% machines
type: task
status: In Progress
priority: High
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-36
  - ISS-29
  - ISS-27
checklist:
  - text: Exclude cloud and datacenter operators on blob7 in the Grafana conversion panels
    done: false
  - text: Extend classifyAgent to weigh request.cf.asOrganization
    done: true
  - text: Re-check that the click numerator no longer exceeds RUM visits
    done: false
log:
  - timestamp: 2026-09-16T02:19:23.000Z
    author: claude
    body: |-
      Ben asked on 2026-09-15 what action is actually available here. Three things,
      in cost order, and the first two are ours to do without his involvement.

      1. Grafana, today, retroactive. The panels filter on `blob7`, which already
         carries the network operator on every row written since 2026-08-20. Adding
         an exclusion for cloud and datacenter operators -- `Google LLC`,
         `Cloudflare, Inc.`, `Huawei-Cloud-SG` and the rest as they appear -- fixes
         history as well as new rows, because it is a query change over data already
         collected. No deploy, no code review, nothing to break. This is the whole
         fix for anybody reading the dashboard.

      2. `src/worker.js`, next deploy. `classifyAgent(ua)` takes only the user agent
         today, which is why a fetcher sending a Chrome string reads as human. Pass
         `request.cf.asOrganization` alongside it and return "bot" when the operator
         is a known cloud or datacenter network. That makes the stored verdict worth
         reading again. The blob rule from ISS-36 holds without exception: keep
         appending, never reinterpret `blob5`, because the existing panels read it
         positionally and a redefinition rewrites history silently.

      3. Re-check the numerator against RUM once both are in. The test is the one
         this issue was raised on -- clicks can no longer exceed visits.

      Not recommended: a country filter. It would work today only because the site
      is three weeks old and has no overseas visitors, which is a fact about the
      site's age rather than about the business. It should stay a separate decision.

      Worth stating plainly before any of it: no bookings are lost and nothing on
      the live site is broken. This is a measurement defect. Every conversion figure
      on the dashboard is overstated by roughly five times, so the cost of leaving
      it is making a pricing or channel decision on a number that is wrong by that
      much -- which is exactly the kind of decision ISS-61 is about to put in front
      of us.
  - timestamp: 2026-09-16T02:29:01.000Z
    author: claude
    body: |-
      Worker side done, 2026-09-15, site repo commit 401fd22. Not deployed yet --
      Actions deploys on push to main and that push has not happened, so the live
      Worker still carries the old rule.

      `classifyAgent` now takes the operator as a second argument and tests it
      against a new `BOT_ASN` regex: the three operators actually seen in the data
      (Google LLC, Cloudflare, Huawei-Cloud-SG) plus generic terms -- cloud,
      hosting, data centre, vps, colo, server -- so the long tail is caught without
      an entry per host. Either test is sufficient; neither vetoes the other. A
      declared bot on a consumer ISP stays a bot, and a missing operator leaves the
      user-agent verdict standing rather than promoting anything to human.

      ISS-36's blob rule is respected. blob5 keeps its position and still holds only
      "bot" or "human", so every existing panel reads it unchanged -- only its
      accuracy improves, and only from the deploy forward. That is recorded in
      wrangler.toml beside the column list, because a panel spanning the deploy date
      will show the rule getting better and could easily be misread as the traffic
      changing.

      26 operator cases added to script/test, 50 passing in total. They include the
      exact Android Chrome string the 13 Google LLC clicks sent -- the case the
      whole change exists for, since nothing about it is distinguishable from a real
      phone except where it came from. The Canadian consumer carriers are pinned as
      human on purpose: a false "bot" deletes a real booking click, which is the
      expensive direction to be wrong in.

      Two items still open, and the first is the one that actually repairs the
      dashboard.

      The Grafana panels are not in this repo -- they live in the Grafana Cloud
      dashboard, so that edit is Ben's. It is also the more valuable half, because
      it applies to rows already written and blob5 cannot be recomputed. The query
      is written out in wrangler.toml next to the column list; it filters blob7 with
      lower(...) NOT LIKE against the same short list BOT_ASN uses. That duplication
      is deliberate and it is the kind that rots, which is why the shared list is
      kept short and why both places say to change the other.

      Known residue, stated so it is not discovered later as a surprise: a scraper
      on a consumer ISP sending a browser string still reads as human. That is much
      smaller than what this removes, and blob6 and blob7 still carry the raw
      evidence, so a better rule can still be applied to this data.
createdAt: 2026-09-07T04:28:25.863Z
updatedAt: 2026-09-16T02:29:01.000Z
---

## Requirement

ISS-36 added the bot verdict and closed correctly: a click can be identified at
query time, the panels filter, and history is preserved. It also stated its own
limit plainly -- a scraper sending a browser string still reads as human -- and
recorded `blob6` (user agent) and `blob7` (network operator) precisely so a
better rule could be applied later to rows already written.

The search and traffic review of 2026-09-06 measured that limit. It dominates.

## The evidence

Over 2026-08-18 to 2026-09-06:

| Measure | Value |
|---|---|
| Rows labelled `human` | 141 |
| Real visits, Cloudflare RUM, same window | 70 |

A conversion numerator twice the size of its denominator is impossible.
Reclassifying the `human` rows by `blob7`:

- **13 clicks from `Google LLC`**, sending
  `Mozilla/5.0 (Linux; Android 10; K) ... Chrome/149.0.0.0 Mobile Safari/537.36`.
  Google's own fetcher wearing a browser string -- exactly the case ISS-36 named.
- The remainder scatter one click at a time across 40-plus countries -- BR, VN,
  IN, ID, TR, KE, EC, UA, PK -- plus `Huawei-Cloud-SG` and `Cloudflare, Inc.`
- Cloudflare RUM for the same window sees visitors from **Canada (210 page
  loads) and the United States (30) and nowhere else.** Those other countries
  have no visitors at all.

Filtering to CA/US and dropping `Google LLC` leaves about **25** plausibly real
clicks out of 141. ISS-36 estimated machines at 16% of all rows; on the rows
labelled human it is closer to 80%, and every conversion figure on the
dashboard is currently overstated by roughly five times.

## Options

The verdict is written at request time but the evidence is already in the row,
so this can be fixed in either place, and the two are not exclusive.

**Query side first.** The Grafana panels can exclude known cloud and datacenter
operators on `blob7` today, retroactively, over data already collected. This is
the cheaper half and it repairs history rather than only the future.

**Worker side second.** Extend `classifyAgent` to weigh `request.cf.asOrganization`
alongside the user agent so new rows carry a better verdict. Keep appending --
do not reinterpret `blob5`, which existing panels read positionally.

A country filter is a blunter instrument and should be a separate decision. It
would also drop genuine overseas visitors, of which there are currently none --
but that is an artefact of a three-week-old site, not a property of the
business.

## Acceptance

- The conversion panels exclude datacenter and cloud-operator clicks, over
  existing rows as well as new ones.
- `Google LLC` traffic sending a browser user agent is counted as a machine.
- The conversion rate is defensible against the RUM visit count: the numerator
  can no longer exceed the denominator.
- ISS-36's blob rule is respected -- append, never insert.
