---
id: ISS-29
title: Confirm booking_clicks is actually recording
type: review
status: To Do
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
  - ISS-25
checklist:
  - text: Click a real Book now button and find the row in booking_clicks
    done: false
  - text: Confirm ?src= distinguishes the page the click came from
    done: false
  - text: Decide how the numbers get looked at, and how often
    done: false
log: []
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-18T21:40:00.000Z
---

## Requirement

The redirect is verified — 20/20 requests return 302 to the listing. What
is not yet verified is that `writeDataPoint` is landing rows in the
`booking_clicks` dataset.

The Worker swallows write failures on purpose, so that a broken binding can
never cost a booking. The cost of that choice is that a silently failing
write looks exactly like no traffic.

## Query shape

Analytics Engine is queried over its SQL API. `blob1` is the `src` page
path, `blob2` the referrer, `blob3` the country.

## Acceptance

- A click made by hand appears as a row.
- Two clicks from different pages are distinguishable by `blob1`.
