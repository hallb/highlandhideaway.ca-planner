---
id: ISS-39
title: "State house rules: pets, smoking, visitors, quiet hours"
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
  - timestamp: 2026-09-02T02:41:10.885Z
    author: claude
    body: |-
      Requirement rewritten 2026-09-01; it had gone stale and was hiding a contradiction.

      The old wording said visitor and quiet-hours policy were "not stated anywhere on the site". Half of that stopped being true on 2026-08-31, when the home page rewrite (ISS-50) added a Before you book section with no smoking and 10pm to 7am quiet hours, both Ben's and attributed in a dated source comment. The comment in content/_index.md asks by name for this issue to be updated rather than closed, which is what this is.

      The audit turned up something the original wording did not anticipate. Ben's instruction the same day was that pets are not to be mentioned on the site in either direction, because the rule lives in the Airbnb listing. The home page follows it. what-to-bring.md line 60 still ends with "No pets, no smoking", written before the instruction existed, and it is live. That is a one-line fix but not one to make unasked: the instruction was about the home page, and whether it extends to a guide page is Ben's call. Flagged rather than fixed.

      So this issue is now two open questions and a decision: the visitor policy, the pets line in what-to-bring, and whether the rules consolidate onto the home page section or earn their own page.
  - timestamp: 2026-09-03T02:04:13.988Z
    author: claude
    body: |-
      Closed 2026-09-02. All three open questions got an answer, and two of the answers are decisions not to say anything.

      Visitors. Ben passed, explicitly: he does not want to say one way or the other. So the site states no visitor policy, deliberately, and this is the record of that being a decision rather than an omission. Anybody who finds the gap later and helpfully fills it will be undoing his call.

      The pets line. what-to-bring.md ends "No pets, no smoking", which looked like it contradicted his 2026-08-31 instruction that pets are not to be mentioned on the site in either direction. Asked directly: he is fine with the existing line where it is. So the instruction was about the home page, not the whole site, and the line stays. Nothing was changed.

      Smoking and quiet hours were already stated on the home page from 2026-08-31 (ISS-50), which is what made the original requirement stale.

      Consolidation was the fourth item and it is being dropped rather than done. The rules now sit in two places, the home page Before you book section and what-to-bring's Leave at home, and they do not conflict. A rules page for four sentences, one of which is deliberately unwritten, is not worth a URL. Reopen if the list grows.
createdAt: 2026-08-21T12:52:08.606Z
updatedAt: 2026-09-03T02:04:13.988Z
---

## Requirement

House rules are scattered and partly unstated, and one page contradicts an
explicit instruction from Ben. Audit them, settle what is left open, and
consolidate into one place guests will read before booking.

## Where it stands, 2026-09-01

Two of the four are now stated. `content/_index.md` gained a **Before you
book** section on 2026-08-31 (ISS-50) carrying "No smoking. Quiet hours are
10pm to 7am", both Ben's, given that day and attributed in a source comment.

## What is still open

- **Visitors.** Not stated anywhere on the site. Can guests have people over,
  and is there a headcount or a time it stops.
- **Pets, and a live contradiction.** Ben's instruction on 2026-08-31 was that
  pets are not to be mentioned on the site in either direction -- the rule is
  in the Airbnb listing and he does not want it restated. The home page
  respects that. `content/posts/what-to-bring.md` does not: its closing line
  still reads "No pets, no smoking." Either the line comes out or the
  instruction changes, and it is Ben's call which.
- **Consolidation.** The rules now sit in two places with different wording.
  Decide whether the home page section is the single source and the others
  point at it, or whether a rules page is worth its own URL.