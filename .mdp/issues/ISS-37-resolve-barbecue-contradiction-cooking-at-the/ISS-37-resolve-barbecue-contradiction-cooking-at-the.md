---
id: ISS-37
title: "Resolve barbecue contradiction: cooking-at-the-cottage vs the meal plan"
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
parent: ISS-31
relatedTo: []
checklist: []
log:
  - timestamp: 2026-09-03T02:03:53.043Z
    author: claude
    body: |-
      Closed 2026-09-02. This issue should never have been opened in the shape it was: the barbecue was already on the page when the issue was written.

      Commit bd783ae on 2026-08-18 added "A propane BBQ on the deck outside the kitchen (propane provided)" to cooking-at-the-cottage.md, and added the TODO comment above it in the same commit. The TODO says no barbecue is listed. The bullet three lines up lists one. The issue was created three days later from the TODO rather than from the file, so it inherited the wrong half.

      Ben confirmed the barbecue on 2026-09-02: propane, on the deck outside the kitchen, fuel supplied. That is exactly what the page already said, so nothing on the page needed correcting. The stale TODO comment was replaced with a source comment recording the history.

      This unblocks ISS-42. The meal plan's BBQ chicken and burgers are cookable, so the rewrite no longer waits on anything.

      Worth taking the lesson rather than only the fix: the TODO sweep that produced ISS-37 through ISS-45 read the comments and did not read the surrounding text. Any other issue in that batch could carry the same fault. ISS-38, ISS-40 and ISS-41 were re-read against their files today and are genuine.
createdAt: 2026-08-21T12:52:08.586Z
updatedAt: 2026-09-03T02:03:53.043Z
---

## Requirement

`one-week-cottage-meal-plan.md` suggests BBQ chicken and burgers; `cooking-at-the-cottage.md` lists no barbecue. One of the two is wrong, and guests plan meals around the answer. Confirm whether a barbecue is actually provided and correct whichever page is wrong.