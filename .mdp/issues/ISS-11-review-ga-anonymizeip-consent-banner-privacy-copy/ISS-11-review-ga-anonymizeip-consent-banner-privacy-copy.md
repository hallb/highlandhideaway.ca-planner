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
    note: >-
      anonymizeIP = true is set. The consent and privacy-notice question is
      unresolved and now tracked in ISS-28: adopting cookieless Cloudflare Web
      Analytics would close it by removing what raises it, rather than
      answering it with a banner.
createdAt: 2026-03-25T03:01:36.484Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## Requirement

Reduce privacy surface of **Google Analytics** and document any remaining obligations (consent, policy pages).

### Intended implementation (reverted locally)

- Set `[params.analytics.google] anonymizeIP = true` (DoIt passes `anonymize_ip` into `gtag('config', …)`).

### Follow-up (still required)

- Decide if a **cookie/consent** banner is needed for your jurisdictions.
- Add or link a **privacy notice** describing analytics and retention.