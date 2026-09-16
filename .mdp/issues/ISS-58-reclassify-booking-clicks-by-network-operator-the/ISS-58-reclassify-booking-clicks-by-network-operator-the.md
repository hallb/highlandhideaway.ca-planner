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
    done: true
  - text: Extend classifyAgent to weigh request.cf.asOrganization
    done: true
  - text: Re-check that the click numerator no longer exceeds RUM visits
    done: true
  - text: "Decide whether to apply a CA/US country filter -- it is what actually closes the gap, and it is Ben's call"
    done: true
  - text: Deploy the Worker so new rows carry the better verdict
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
  - timestamp: 2026-09-16T02:39:36.000Z
    author: claude
    body: |-
      Both halves are now done, and the measurement says they are not enough.

      First, a correction to the entry above: I said the Grafana panels were in
      Grafana Cloud and that the edit was Ben's. That was wrong. Grafana is local
      and in this repo -- grafana/, a docker-compose stack with the dashboard
      provisioned from grafana/dashboards/booking-clicks.json. I searched the site
      repo, found nothing, and inferred the wrong answer instead of checking the
      planner repo. Ben caught it.

      Grafana side, done. All seven aggregate panels now carry a blob7 NOT ILIKE
      chain; "Recent clicks" is deliberately left unfiltered so the classifier stays
      auditable. Verified by running the "Clicks in range" query through Grafana's
      own /api/ds/query rather than by reading the JSON: 194 where it returned 314.

      Worker side, corrected. The first version of BOT_ASN was written from the
      three operators this issue named plus generic terms from memory, and querying
      the SQL API directly found it wrong in two ways. A word-boundary match on
      "server" misses "FINE GROUP SERVERS SOLUTIONS LLC", 16 clicks. "Blazing SEO,
      LLC" is 22 clicks and no generic term catches it -- a proxy seller, now
      Rayobyte. Also "colo" as a substring matches Colombia, so the term has to be
      "colocation". The list is now substrings chosen against the real rows, which
      also makes it identical to the SQL chain rather than merely equivalent to it.

      Now the number that matters. Over the window this issue was raised on,
      2026-08-18 to 2026-09-06:

      | Filter | Clicks |
      |---|---|
      | no filter | 707 |
      | blob5 = 'human' | 140 |
      | blob5 + operator | 121 |
      | blob5 + operator + CA/US | 23 |

      RUM saw 70 visits in that window. **The third acceptance criterion is not
      met**: at 121 the numerator still exceeds the denominator, and the conversion
      rate is still overstated. The operator filter removed 19 clicks from this
      window, not the hundred it would have needed to.

      What is left is not datacenters. It is scrapers on ordinary consumer ISPs,
      arriving one at a time from FR, GB, DE, VN, BR, KE, IN, ZA, PH, RU, ID and AR
      -- countries RUM records no visitors from at all. The operator cannot
      distinguish those from a person, because on the operator they are a person.

      The country filter is what closes it, and it takes the window to 23, which is
      the figure this issue estimated at "about 25" from the other direction. It is
      deliberately not applied. It would silently drop genuine overseas visitors the
      day the site has one, and the reason it looks free today -- no overseas
      visitors at all -- is a fact about a three-week-old site rather than about the
      business. This issue already said that should be a separate decision, and it
      is Ben's, so it is now a checklist item rather than a commit.

      Staying In Progress until that is decided. Everything else here is done, and
      the Worker change is still committed-not-deployed.
  - timestamp: 2026-09-16T05:42:18.000Z
    author: claude
    body: |-
      Ben asked what including the country filter costs versus leaving it out, then
      chose to apply it as a variable. Done 2026-09-15.

      The measurement that settled it -- CTA clicks with a placement since
      2026-08-20, against 60 RUM visits: 283 clicks and a 472% conversion rate on
      blob5 alone, 185 and 308% with the operator filter, 27 and 45% with CA/US as
      well. The country filter removes 85% of what survives everything else. It is
      not a refinement, it is the whole remaining correction.

      Its cost today is nothing measurable: RUM has recorded 80 visits across its
      full three-month retention, 50 CA and 30 US, and nothing else at all.

      But that evidence is circular for the EU, and it is worth writing down why.
      Web Analytics is set to exclude EU visitor data, so RUM cannot record an EU
      visitor -- "no visitors from France" describes the configuration, not France.
      52 of the 194 operator-filtered clicks are EU. Inspecting them rather than
      trusting the absence: 23 FR clicks (Private Customer) and 8 DE clicks (SIA
      BITE Latvija) carry the same byte-identical user agent, one client on two
      exits, and the tail sends Windows 98, Windows 95 and iPhone OS 4_3_5. Across
      all 194 survivors one exact UA accounts for 47 clicks in three countries, and
      128 distinct UA strings cover 194 clicks -- rotation, not a public.

      So it is applied, as a `country` template variable defaulting to CA,US rather
      than as hardcoded SQL, on all seven aggregate panels. The objection this issue
      raised stands, and the dropdown answers it instead of accepting it: visible,
      reversible without editing SQL, and paired with a new panel, "Excluded by the
      country filter", showing what it currently hides. Verified through
      /api/ds/query with the variable expanded -- 30 clicks kept, 164 excluded, 194
      total. The arithmetic reconciles, which is the point: nothing disappears
      unaccounted for.

      All three original acceptance criteria are now met, including the third: the
      numerator no longer exceeds the denominator.

      Two honest caveats. 45% is still not a believable conversion rate for a
      booking CTA -- single digits would be normal -- so this buys a usable number,
      not yet a trustworthy one; either bots remain or the RUM denominator
      undercounts. And a country-agnostic rule exists that I did not apply: exact-UA
      strings appearing in three or more countries would remove 56 clicks without
      ever touching a real overseas visitor. It helps and it does not close the gap
      (185 - 56 = 129, still double the denominator), so it is worth having only if
      the country default is ever widened.

      Still In Progress for one reason only: the Worker is committed and not
      deployed.
createdAt: 2026-09-07T04:28:25.863Z
updatedAt: 2026-09-16T05:42:18.000Z
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
