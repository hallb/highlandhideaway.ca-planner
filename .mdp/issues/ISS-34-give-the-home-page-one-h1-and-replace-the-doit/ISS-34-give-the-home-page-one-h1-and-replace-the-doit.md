---
id: ISS-34
title: Give the home page one h1 and replace the DoIt blogroll
type: task
status: Done
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
log:
  - timestamp: 2026-08-21T02:46:49.651Z
    author: claude
    body: |-
      Branched, not yet merged, 2026-08-21. Site repo branch `iss-32-34`, commit 3608c85, PR https://github.com/hallb/highlandhideaway.ca/pull/7. Status stays In Progress until that merges and deploys.

      One line of configuration: `params.home.posts.enable = false`. No `layouts/index.html` was added.

      That is the decision worth recording. An override would have been a copy of DoIt's home template, and a copy has to be kept in step with the theme forever -- the cost the note at the top of layouts/posts/single.html spells out, and the reason that file is a purpose-built replacement rather than a fork. The theme already has a flag for exactly this, and the flag is the whole of the change.

      Verified on the built site at 390x844: eleven h1s to one, 9585px to 2054px. The remaining h1 is the profile title, "Highland Hideaway". All three curated card groups render, all eleven cards resolve -- every internal link on the page was followed against the built output and the only miss is /go/airbnb, which is the Worker route and not an asset. No /page/2/ is generated any more.

      Not done here, and worth naming: the intro still renders inside DoIt's `.single .content`, so the home page does not get the editorial treatment the posts do. That is ISS-35's territory, which is where the home page hero belongs too.
  - timestamp: 2026-08-21T04:02:30.000Z
    author: claude
    body: |-
      Done, 2026-08-21. Merged as b1d8f8c (squash of PR 7) and deployed. Verified against the live site: the home page returns exactly one <h1>, no post summaries, and 12,047 bytes against 59,745 before. /page/2/ returns 404, so the paginated copies are gone from the published site as well as from the build.

      Superseded in part by ISS-35, which landed the layouts/index.html this issue argued against. That argument was right for this change and stopped being right when the home page needed a hero above the content -- the reasoning is in ISS-35's log. The params.home.posts.enable flag added here stays and is still load-bearing: baseof.html paginates the home page before any layout runs, so without it /page/1..3/ come back even with the new layout in place.
createdAt: 2026-08-20T21:10:18.755Z
updatedAt: 2026-08-21T03:32:23.114Z
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
