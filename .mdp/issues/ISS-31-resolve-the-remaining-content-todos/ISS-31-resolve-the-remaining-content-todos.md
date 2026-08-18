---
id: ISS-31
title: Resolve the remaining content TODOs
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
relatedTo:
  - ISS-30
checklist:
  - text: Is there a barbecue? The meal plan assumes one, the kitchen page lists none
    done: false
  - text: Which carriers get a signal at the cottage
    done: false
  - text: House rules -- pets, smoking, visitors, quiet hours
    done: false
  - text: Weight or rider limit on the swing
    done: false
  - text: Whether guests may walk on the lake ice
    done: false
  - text: Rewrite the one-week meal plan with meals actually cooked here
    done: false
  - text: Fill in the Haliburton gallery tour, or leave it draft
    done: false
log: []
createdAt: 2026-08-18T21:55:00.000Z
updatedAt: 2026-08-18T21:55:00.000Z
---

## Requirement

Six content files carry TODO comments marking facts only the owner knows.
They are HTML comments, and Hugo's minifier strips them, so nothing leaks to
visitors — but the pages are incomplete where they sit.

## Two worth doing first

**The barbecue.** `one-week-cottage-meal-plan.md` suggests BBQ chicken and
burgers; `cooking-at-the-cottage.md` lists no barbecue. One of the two is
wrong, and guests plan meals around the answer.

**The gallery tour.** `haliburton-gallery-tour.md` is `draft: true` because it
published with a "Galleries" heading and nothing beneath it, and no library
photo shows a gallery. It needs content and a picture, or it stays a draft.

## Caveat

If the `--minify` flag is ever dropped from the build, these comments become
visible in page source. Verified: 8 pages carry them without minify, zero with.
