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
  - timestamp: 2026-09-02T02:42:07.254Z
    author: claude
    body: |-
      Re-counted the pages on 2026-09-01, because the thinness figures in the 2026-08-19 entry above are being cited elsewhere and one of them is now wrong. Tracking list rewritten above with each child's status.

      Method, so the numbers stay comparable: source prose only, front matter, HTML comments and shortcode markup removed. It is the same method ISS-50, ISS-51 and ISS-52 used, which is why their figures reproduce.

      What changed. The home page was 218 words in that audit and is 566 now -- ISS-50 closed on 2026-08-31 and did the work. Do not quote the 218 again.

      What did not change. /about/ is 110 words and has not been touched since 2026-08-18. welcome.md, the "representative post" in that audit, is 215 against the 218 recorded. The audit's conclusion therefore still holds everywhere except the home page: depth on the pages worth ranking is the work.

      The two flesh-out issues opened on 2026-08-31 still describe their pages accurately, re-verified today against git rather than trusted: sleeping-arrangements.md is 129 words against the 125 in ISS-51, whats-nearby.md is 249 against the 245 in ISS-52, hidden-gems-nearby.md is 196 against the 187 in ISS-52. None of the three files has been committed to since 2026-08-20, so nothing has silently been fixed underneath those issues.

      Thinnest published pages, for ordering: contact 68, minden-pride 125, sleeping-arrangements 129, getting-here-and-parking 153, cottage-pantry-guide 185, guest-access 190, hidden-gems-nearby 196, one-week-cottage-meal-plan 205, welcome 215. The two thinnest files in the repo are both drafts and both are tracked: haliburton-galleries at 68 words with four TODOs (ISS-43) and haliburton-christmas-market at 39 (ISS-49).

      Eight TODO comments remain in content, across seven files. Seven of them map to an open child: the meal plan (ISS-42), winter-at-the-hideaway (ISS-41), the christmas market (ISS-49), welcome (ISS-38), the-grounds (ISS-40), cooking-at-the-cottage (ISS-37), and four in haliburton-galleries (ISS-43). The eighth does not, deliberately: fall-colours.md line 168 asks for a photograph from the Skyline lookout in the first half of October, and the ISS-44 log records the decision not to track it, because it depends on somebody being in the right place with a camera. Worth knowing it exists, since the window is six weeks out and closes with the leaves.
  - timestamp: 2026-09-03T02:05:42.704Z
    author: claude
    body: |-
      Five of the nine children closed on 2026-09-02, in one pass, off a single round of questions to Ben. ISS-37 barbecue, ISS-38 carriers, ISS-39 house rules, ISS-40 swing, ISS-41 lake ice. ISS-44 was already closed. Three remain: ISS-42 the meal plan, ISS-43 the gallery tour draft, ISS-45 the American Thanksgiving draft.

      Two of the five closed by deciding to say nothing, and that is worth keeping straight, because a page with a deliberate silence looks identical to a page with a gap. The visitor policy is unstated at Ben's explicit pass. The swing has no stated limit because nobody knows what it is, so the page says that rather than inventing a number. Both decisions are recorded on their issues.

      One of the five, ISS-37, was never real. The barbecue had been on the cooking page since 2026-08-18, added in the same commit as the TODO that said it was missing. The issue was written three days later from the comment rather than from the file. That is a fault in the sweep that produced this whole batch, not in the issue: it read the TODO comments and did not read the text around them. ISS-38, ISS-40 and ISS-41 were re-read against their files before being closed today and were genuine. ISS-42, ISS-43 and ISS-45 should get the same read before anybody works them.

      Content TODOs after today: four left, from eight. The meal plan (ISS-42), the christmas market (ISS-49), four in haliburton-galleries (ISS-43), and the untracked fall-colours photograph. Two new ones were added deliberately on sleeping-arrangements.md, for the hot water figure Ben does not have and the noise and door-lock questions he did not answer. Both are on ISS-51.
createdAt: 2026-08-18T21:55:00.000Z
updatedAt: 2026-09-03T02:05:42.704Z
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

Status as of 2026-09-01:

- ISS-37 -- To Do -- Resolve barbecue contradiction: cooking-at-the-cottage vs the meal plan
- ISS-38 -- To Do -- Confirm which cell carriers get signal at the cottage
- ISS-39 -- To Do -- State house rules: pets, smoking, visitors, quiet hours (half answered on the home page; requirement rewritten 2026-09-01)
- ISS-40 -- To Do -- State weight or rider limit on the tree swing
- ISS-41 -- To Do -- Decide and state the lake-ice policy for winter guests
- ISS-42 -- To Do -- Rewrite the one-week meal plan with meals actually cooked here (blocked by ISS-37)
- ISS-43 -- To Do -- Finish or drop the Haliburton Gallery Tour draft
- ISS-44 -- **Done** -- Finish the Fall Colours draft post (published 2026-08-31)
- ISS-45 -- To Do -- Finish the American Thanksgiving draft post (written and parked in draft; twelve questions Q1-Q12 open)

Six of the nine are one answer from Ben each: the barbecue, the carriers, the
swing limit, the lake ice, the visitor policy, and the pets line. None of them
needs research and none needs writing. They are cheap to close in a batch and
they have sat open since 2026-08-21.

ISS-37 and ISS-43 were flagged as worth doing first: guests plan meals around
the barbecue answer, and the gallery tour publishes with a heading over
nothing. That still holds -- haliburton-galleries.md is 68 words and carries
four TODOs, the most of any file in the repo.

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