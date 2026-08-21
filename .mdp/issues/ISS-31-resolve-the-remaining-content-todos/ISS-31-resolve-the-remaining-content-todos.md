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
  - ISS-27
checklist: []
log:
  - timestamp: 2026-08-19T04:18:54.074Z
    author: claude
    body: |-
      Sequencing note, 2026-08-19. Content work waits on Search Console data rather than starting from guesses: the property was verified today and query data is useful somewhere between 2026-09-02 and 2026-09-16 (see ISS-27).

      Worth knowing what the audit turned up while the technical SEO was being fixed. The pages are thin — the homepage runs about 218 words, /about/ about 177, and a representative post about 218. For a single rental competing against Airbnb's own listing pages and established Haliburton directories, that is the actual ceiling on ranking, well above anything else on the board. Whatever the queries say, depth on the pages worth ranking is the work.
  - timestamp: 2026-08-21T12:52:46.923Z
    author: claude
    body: |-
      Broken out into nine child issues today (ISS-37 through ISS-45), one per content item, so the backlog is orderable instead of one flat checklist. This tracking issue now stays open until all nine children close; the old seven-item checklist has been removed since its checklist field can't express blocking (ISS-42 depends on ISS-37) or per-item detail the way separate issues can.

      Two new items surfaced that weren't in the original checklist: ISS-44 (Fall Colours draft, six TODOs) and ISS-45 (American Thanksgiving draft, two TODOs). Both are draft:true posts with open briefs, same as the gallery tour (ISS-43) already noted here -- they'd been missed in the original TODO sweep because it only caught inline comments in already-published posts, not the drafts themselves.
createdAt: 2026-08-18T21:55:00.000Z
updatedAt: 2026-08-21T12:52:46.923Z
---

## Requirement

Content files carry TODO comments marking facts only the owner knows, or
sit as drafts with a brief only partly written. They are HTML comments, and
Hugo's minifier strips them, so nothing leaks to visitors — but the pages
are incomplete where they sit.

## Tracking issue

This is now a parent/tracking issue. The individual content gaps are
tracked as its children so each can be picked up, estimated, and closed on
its own:

- ISS-37 -- Resolve barbecue contradiction: cooking-at-the-cottage vs the meal plan
- ISS-38 -- Confirm which cell carriers get signal at the cottage
- ISS-39 -- State house rules: pets, smoking, visitors, quiet hours
- ISS-40 -- State weight or rider limit on the tree swing
- ISS-41 -- Decide and state the lake-ice policy for winter guests
- ISS-42 -- Rewrite the one-week meal plan with meals actually cooked here
- ISS-43 -- Finish or drop the Haliburton Gallery Tour draft
- ISS-44 -- Finish the Fall Colours draft post
- ISS-45 -- Finish the American Thanksgiving draft post

The first two (ISS-37, ISS-43) were the ones flagged as worth doing first:
guests plan meals around the barbecue answer, and the gallery tour publishes
with a heading over nothing.

## Caveat

If the `--minify` flag is ever dropped from the build, these comments become
visible in page source. Verified: 8 pages carry them without minify, zero with.
