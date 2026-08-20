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
    done: false
  - text: Decide whether to keep Google Analytics
    done: true
  - text: Swap the google block for the cloudflare block in hugo.toml
    done: true
  - text: Create the Web Analytics site and copy the beacon token
    done: false
  - text: Fill the token into hugo.toml and merge the branch
    done: false
  - text: Confirm the beacon is live and close ISS-11
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
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-20T21:36:19.342Z
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
