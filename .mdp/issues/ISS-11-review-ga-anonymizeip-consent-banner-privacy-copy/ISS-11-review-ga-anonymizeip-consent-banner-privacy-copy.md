---
id: ISS-11
title: "Review GA: anonymizeIP, consent banner, privacy copy for jurisdiction"
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
createdAt: 2026-03-25T03:01:36.484Z
updatedAt: 2026-08-20T21:36:19.536Z
---

## Requirement

Reduce privacy surface of **Google Analytics** and document any remaining obligations (consent, policy pages).

### Intended implementation (reverted locally)

- Set `[params.analytics.google] anonymizeIP = true` (DoIt passes `anonymize_ip` into `gtag('config', …)`).

### Follow-up (still required)

- Decide if a **cookie/consent** banner is needed for your jurisdictions.
- Add or link a **privacy notice** describing analytics and retention.