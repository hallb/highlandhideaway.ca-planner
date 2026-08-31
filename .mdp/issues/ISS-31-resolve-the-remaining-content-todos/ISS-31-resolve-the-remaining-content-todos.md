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
  - timestamp: 2026-08-31T05:10:00.000Z
    author: claude
    body: |-
      The caveat on this issue was wrong, and the RSS feeds had been publishing the comments. Corrected above.

      Found on 2026-08-31 while publishing the Corduroy post, by grepping the whole build output rather than the HTML. The exposure was real and live: /posts/index.xml and /index.xml carried the comments verbatim inside CDATA, and every per-tag and per-category feed carried them escaped. Among what was readable: the note listing which claims Ben declined to make on the Corduroy page, the sourcing notes and Pexels credit reasoning on the Stanhope post, and the still-open barbecue (ISS-37) and lake-ice (ISS-41) questions.

      Two templates were involved, and the first fix only covered one. DoIt's rss/item.html builds the description from .Page.Content or .Page.Summary; stripping comments at the end fixed the .Content path only, because Hugo derives .Summary by stripping tags, which removes the <!-- --> markers and leaves the text behind, so there is no comment left to match by the time the partial runs. Both paths now build from a cleaned copy of .Content. Separately, the per-tag and per-category feeds never reached that partial at all: DoIt's taxonomy/rss.xml does not match the layout lookup for those kinds on Hugo 0.159, so they fell through to Hugo's internal RSS template. layouts/_default/rss.xml now routes them through the same partial.

      Fixed in site repo commit 03269fd, deployed 2026-08-31. Verified on a full build: no comment text and no comment markers in any of the 68 feeds or any page, all 68 feeds still generated, htmltest passes 163 documents.

      Treat the previously published comments as already out. The feeds were live and feed readers and crawlers may hold cached copies. Nothing in them is credential-shaped -- it is editorial reasoning and unresolved questions -- but it was public, and it should not be assumed otherwise.

      This does not change the decision to keep using HTML comments for owner-only facts. It changes how the claim that they are private gets verified: grep the whole build output, not the HTML.
createdAt: 2026-08-18T21:55:00.000Z
updatedAt: 2026-08-31T05:10:00.000Z
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

The comments have leaked once, and the original wording of this section is
why nobody looked for it.

That wording said the comments were safe because `--minify` strips them, and
named dropping `--minify` as the only risk. Both halves were true and the
conclusion was still wrong: the verification only ever covered the built
HTML, and the RSS feeds are a separate output format that never went near the
minifier. They carried the comments in full until 2026-08-31. See the log
entry for that date.

So there are two ways out, not one:

- **Page source.** If `--minify` is ever dropped, the comments become visible.
  Verified: 8 pages carry them without minify, zero with.
- **Any other output format.** The feeds were fixed in site repo commit
  03269fd, which strips comments in `layouts/partials/rss/item.html` and
  routes the per-tag and per-category feeds through it via
  `layouts/_default/rss.xml`. Anything new that renders `.Page.Content` or
  `.Page.Summary` needs the same treatment, and a JSON search index would be
  the obvious next one.

Check output rather than reasoning about the pipeline. The command is cheap:

```bash
hugo --gc --minify --destination /tmp/pub
grep -rl "TODO" /tmp/pub | grep -v '\.js$'
```

That greps every generated file rather than the HTML alone, which is the
check that was missing.
