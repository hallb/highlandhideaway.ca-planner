---
id: ISS-28
title: Cloudflare Web Analytics, and decide on Google Analytics
type: task
status: In Progress
priority: Medium
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-11
  - ISS-25
checklist:
  - text: Enable Cloudflare Web Analytics for the zone
    done: true
  - text: Decide whether to keep Google Analytics
    done: true
  - text: Remove the google block from hugo.toml (no cloudflare block -- edge injects)
    done: true
  - text: Record the dashboard dependency in wrangler.toml
    done: true
  - text: Merge the branch and deploy
    done: true
  - text: Confirm the Cloudflare Web Analytics beacon is actually injecting -- regressed as of 2026-08-21, see log
    done: false
log:
  - timestamp: 2026-08-20T21:35:32.897Z
    author: claude
    body: |-
      Decision made 2026-08-20: drop Google Analytics, adopt Cloudflare Web Analytics. Site repo branch analytics/cloudflare-web-analytics, commit ff71fba, pushed and NOT merged.

      The install turned out to be simpler than this issue assumed. DoIt already supports the Cloudflare beacon natively -- themes/DoIt/layouts/partials/plugin/analytics.html renders it from params.analytics.cloudflare.token -- so this is a config change in hugo.toml, not a layout override. The Google block is gone and the Cloudflare block is in its place; params.analytics.enable stays true, since it now gates Cloudflare rather than Google.

      Chose the manual beacon over Cloudflare's automatic injection on purpose. Automatic setup is a dashboard switch that leaves no trace in the repo, and this project has already lost one piece of configuration exactly that way -- the www->apex Redirect Rule that wrangler.toml and hugo.toml both describe and nobody created (ISS-27). It also sidesteps an open question I could not answer from the docs: whether edge injection fires for responses served by a Worker asset store rather than a classic proxied origin. The manual tag does not care.

      Verified both directions on a local build. token = "" renders nothing at all, because the theme guards the tag with `with`; a filled value renders the beacon script. So the branch in its current state means no page analytics, not a broken tag -- an acceptable thing to have sitting on a branch, and not something to merge.

      Blocked on one value: the beacon token, which needs the Web Analytics site to exist. That token is not a secret; it ships in page source by design.
  - timestamp: 2026-08-20T21:46:28.764Z
    author: claude
    body: |-
      Correction, and a change of plan. Cloudflare Web Analytics was already enabled, with automatic injection, and had been collecting for some time. The earlier check in this issue that said otherwise was wrong: Cloudflare only injects the beacon for requests that look like a browser, and that check used a plain curl. With a browser User-Agent the beacon is on / and on /posts/welcome/, token 2e7e343f80d04a2d9f9d49013c3c2d92.

      Two things follow. The site has been running two analytics products at once, not one. And the open question about whether edge injection reaches a Worker asset store rather than a classic proxied origin is answered: it does.

      So there is no beacon to install, only GA to remove. Reworked the branch accordingly (site repo 9cd661d, force-pushed over ff71fba, which described the manual install that is no longer the plan). params.analytics.enable goes to false, since with GA gone the theme has nothing left to render.

      Deliberately NOT setting params.analytics.cloudflare.token. The theme supports a manual beacon and the token is public, so adding it looks like an improvement -- but it would render a second beacon alongside the injected one and double-count every view. Said so in the hugo.toml comment, because the next person to read that config will have the same idea.

      Rejected the manual install after considering it. It would put the beacon in version control, which is worth something. But injection was already working, so switching means turning it off and deploying the tag in close succession, with a gap or a spell of double-counting if they do not line up. That is real risk buying a benefit documentation can supply instead: wrangler.toml now carries a dashboard-configuration list naming Web Analytics injection alongside the missing Redirect Rule. The failure last time was not that the dashboard was used, it was that nothing in the repo recorded what the dashboard was meant to hold.

      Also corrected the header of hugo.toml, which asserted the www->apex Redirect Rule exists (ISS-27).

      Verified: no gtag and no beacon in ./public; beacon present at the edge under a browser User-Agent. Branch is ready to merge -- no token needed, nothing outstanding.
  - timestamp: 2026-08-21T12:53:09.349Z
    author: claude
    body: |-
      Correcting the planner against actual repo state, checked 2026-08-21.

      The branch was merged. git log on the site repo main shows 898eb0a 'Merge the Google Analytics removal' already on main, ahead of today's ISS-27 commit. hugo.toml on main has params.analytics.enable = false with the removal comment dated 2026-08-20. The GitHub Actions deploy for the current main HEAD (24bc5f2) ran and succeeded at 2026-08-21T12:25 UTC. Fetching the live homepage with a browser User-Agent shows no gtag, no googletagmanager.com, nothing GA-related in the served HTML. So 'Merge the branch and deploy' is done -- it happened days ago, the planner just never caught up. Checked off.

      New problem found while verifying the other half of that checklist item. The Cloudflare Web Analytics beacon is NOT currently injecting. Tested / and /posts/welcome/ with three different browser User-Agents (desktop Chrome, Safari, mobile Safari), cache-busting query strings, and Cache-Control: no-cache -- zero matches for cloudflareinsights or cf-beacon in any response. This directly contradicts the 2026-08-20 21:46 log entry above, which confirmed injection working with token 2e7e343f80d04a2d9f9d49013c3c2d92 on the same two pages. Something changed in the four days since -- possibly the Web Analytics site's automatic-setup toggle got flipped off, possibly something else. No token in this project has Analytics dashboard access to check directly.

      Net effect: the site currently has no analytics running at all. GA is gone (good, correctly so) but nothing replaced it in practice, even though the config says it should have. Leaving status as In Progress rather than Done, because the acceptance criterion 'traffic is visible without a consent banner' is not actually met right now -- traffic isn't visible, period. Checklist item split: the old combined 'confirm beacon is live and close ISS-11' item is gone, replaced with a standalone beacon-injection item reflecting the regression.

      ISS-11 is being closed anyway, on explicit instruction, and I think that's correct despite this: ISS-11 was scoped to the GA consent question specifically, and that's resolved regardless of whether Cloudflare's beacon happens to be firing right now, because Cloudflare Web Analytics is cookieless whether it's working or not -- it was never the thing that could raise a consent obligation. The beacon regression is a traffic-visibility problem, tracked here, not a privacy problem.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-21T12:53:09.349Z
---

## Requirement

Traffic numbers to sit alongside the conversion counts the Worker already
records. Cloudflare Web Analytics is free, cookieless, and needs no script
tag on a proxied zone.

## The Google Analytics decision

GA is still enabled with `anonymizeIP = true`. Cookieless analytics covers
what this site actually needs, so removing GA would close the consent
question in ISS-11 by removing the thing that raises it, rather than
answering it with a banner and a privacy page.

Cloudflare Web Analytics reports page views, referrers, paths and Core Web
Vitals. It has no custom events — which is why conversions go through the
Worker rather than through any analytics product.

## Acceptance

- Traffic is visible without a consent banner.
- ISS-11 can be closed or narrowed to whatever obligation remains.
