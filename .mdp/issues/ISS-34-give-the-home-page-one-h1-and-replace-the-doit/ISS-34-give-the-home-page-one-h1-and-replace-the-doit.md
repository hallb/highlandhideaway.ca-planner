---
id: ISS-34
title: Give the home page one h1 and replace the DoIt blogroll
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: ISS-32
relatedTo:
  - ISS-27
checklist: []
log: []
createdAt: 2026-08-20T21:10:18.755Z
updatedAt: 2026-08-20T21:10:18.755Z
---

## Requirement

The home page carries eleven `<h1>` elements. Split from ISS-32.

There is no `layouts/index.html`, so DoIt's default home layout renders
`content/_index.md` and then its own post list beneath it. The styled guide
cards stop around 900px; the theme blogroll runs for the remaining ~8300px,
rendering the opening paragraphs of ten posts, each under its own `<h1>`.

This predates the editorial restyle and is not a regression from it. Two
things changed the priority:

- The join between the styled cards and the theme default is now obvious,
  because the cards look designed and the blogroll does not.
- Search Console was verified 2026-08-19 and Google has not crawled the
  property yet (ISS-27). Eleven h1s on the page most likely to rank for the
  brand is worth fixing *before* the first real crawl rather than after.

The guide cards in `content/_index.md` already cover every post worth linking
from the home page, in three curated groups. The blogroll duplicates that
badly and at ten times the height.

## Acceptance

- The home page has exactly one `<h1>`.
- The auto-generated post list no longer renders on the home page.
- The curated card sections still render, and every card still resolves.
- The page is a reasonable length — roughly the cards plus the intro, not 9585px.
