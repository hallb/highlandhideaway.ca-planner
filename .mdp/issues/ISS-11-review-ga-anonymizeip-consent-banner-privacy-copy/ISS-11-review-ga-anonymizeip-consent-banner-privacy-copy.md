---
id: ISS-11
title: "Review GA: anonymizeIP, consent banner, privacy copy for jurisdiction"
type: task
status: Done
priority: Medium
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log:
  - date: 2026-08-18
    note: "anonymizeIP = true is set. The consent and privacy-notice question is unresolved and now tracked in ISS-28: adopting cookieless Cloudflare Web Analytics would close it by removing what raises it, rather than answering it with a banner."
  - timestamp: 2026-08-20T21:36:19.536Z
    author: claude
    body: |-
      Resolution is in flight. ISS-28 decided on 2026-08-20 to drop Google Analytics for Cloudflare Web Analytics, which is cookieless. That removes what raised the consent question rather than answering it, so this issue closes rather than acquiring a banner and a privacy page.

      The remaining obligation after the swap is close to nothing. Cloudflare Web Analytics sets no cookie and stores no identifier that follows a visitor between sessions. The booking-click counter in src/worker.js is server-side and cookieless too, and records the page, the referer and a country -- nothing that identifies a person.

      Do not close this yet. The change is on site repo branch analytics/cloudflare-web-analytics with an empty beacon token and is not merged, so Google Analytics is still live in production right now. Close this once the beacon is confirmed live and gtag is confirmed gone from the served HTML.
  - timestamp: 2026-08-21T12:53:09.774Z
    author: claude
    body: |-
      Closed 2026-08-21. Verified against the live site rather than the branch: site repo main has Google Analytics removed (commit 898eb0a, deployed, hugo.toml params.analytics.enable = false), and the served homepage has no gtag or googletagmanager.com in it under a browser User-Agent. The consent question this issue tracked no longer applies -- there's no GA, and Cloudflare Web Analytics is cookieless regardless of whether its beacon is currently firing.

      Note the distinction: while verifying this, found the Cloudflare beacon is not actually injecting right now (regression, tracked in ISS-28). That's a traffic-visibility bug, not a reason to keep this open -- it doesn't reintroduce any cookie or consent obligation. Closing per explicit request; the earlier 'do not close until beacon confirmed live' note was a stricter bar than what this issue was actually scoped to answer.
createdAt: 2026-03-25T03:01:36.484Z
updatedAt: 2026-08-21T12:53:09.774Z
---

## Requirement

Reduce privacy surface of **Google Analytics** and document any remaining obligations (consent, policy pages).

### Intended implementation (reverted locally)

- Set `[params.analytics.google] anonymizeIP = true` (DoIt passes `anonymize_ip` into `gtag('config', …)`).

### Follow-up (still required)

- Decide if a **cookie/consent** banner is needed for your jurisdictions.
- Add or link a **privacy notice** describing analytics and retention.