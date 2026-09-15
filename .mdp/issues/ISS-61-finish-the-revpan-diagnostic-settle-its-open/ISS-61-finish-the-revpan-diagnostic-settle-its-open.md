---
id: ISS-61
title: "Finish the RevPAN diagnostic: settle its open questions, then re-run"
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: null
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist:
  - text: Ask Ben when the Airbnb minimum stay changed and whether per-date exceptions existed
    done: false
  - text: Ask Ben whether the Jul-Sep 2025 raw Airbnb export in the airbnb/2025 folder may be used; if yes copy it into the earnings folder
    done: false
  - text: Ask Ben whether Available Days already counts nights blocked for off-platform guests
    done: false
  - text: Ask Ben whether the Airbnb listing was live and visible from Oct 2025 to Apr 2026
    done: false
  - text: Ask Ben whether the zero-availability months (Jan-Mar and Jun 2026) were closure or owner use
    done: false
  - text: Re-run just revpan and rewrite Section 5 findings and the hand-written open questions
    done: false
  - text: Extend the window past Jun 2026 once Available Days and a raw export cover it
    done: false
log: []
createdAt: 2026-09-15T10:53:49.559Z
updatedAt: 2026-09-15T10:53:49.559Z
---

## Requirement

Decide whether Highland Hideaway is rate-constrained or occupancy-constrained,
month by month, so pricing, minimum-stay and second-channel decisions rest on
evidence. This is a revenue diagnostic, not website work: no site content,
templates or copy.

## Hard rules (from Ben, still in force)

- The source folders are read-only.
- **No revenue data enters this repo.** Reports go to `docs/revpan-diagnostic-*`,
  which `.gitignore` excludes; the script refuses to write anywhere in a git work
  tree that is not ignored. Commit scripts, never output. This issue therefore
  carries no figures — read them from the local report.
- Every number in a report carries a tag: verified, inferred, assumption,
  conflict or missing. No silent gap-filling; an ambiguity that could change a
  conclusion goes in Open questions rather than being decided.
- No guest names, emails or bank details in any output.

## State at handoff (2026-09-15)

- `script/revpan-diagnostic` (uv script, openpyxl) and `just revpan` are on main.
  Source paths come from `REVPAN_EARNINGS_DIR` and `REVPAN_OFF_PLATFORM`; they
  are deliberately not in the repo. The local machine's agent memory records them.
- The first report is local only: `docs/revpan-diagnostic-20260915.md`, window
  2024-10 to 2026-06. Its Section 5 (findings) and the hand-written block in
  Section 6 were written by hand after generation. **Re-running on the same date
  overwrites that file**; run on a later date or copy those sections first.

## What the first run concluded (qualitative)

1. Occupancy, not rate, is the constraint in essentially every month with a
   usable base; no case for raising base rates.
2. Airbnb bookings fell sharply between the 2024-25 and 2025-26 seasons on
   matched months; two off-platform stays carried 2026. Points at a second
   channel or direct booking.
3. Demand is weekend-shaped; two-night Friday stays were the most common short
   booking and have not recurred since Sep 2025. Points at minimum-stay rules.

Findings 2 and 3 can swap levers depending on the first open question below.

## Open questions blocking a confident answer

- **Minimum-stay history.** Not in the data. An earlier session recorded the
  Airbnb minimum dropping 4 to 3 nights on 2026-08-25. If a 4-night minimum began
  around Oct 2025, the Airbnb drop is a rules effect, not demand. A 3-night stay
  booked Apr 2026 argues against that. Need the dates of every change.
- **Ledger `Total` basis for Jun-Sep 2025.** The MAT ledger's rows without a
  per-night rate have no raw export in the earnings folder; the script reads
  them as Airbnb payouts (`--ledger-basis payout`) and reports the other two
  readings. A raw export for Jul-Sep 2025 sits in the `airbnb/2025` folder,
  outside the scope Ben gave, and was not read. It would also settle a
  duplicated July reservation and a July/August stay with no revenue — the
  latter flips two months' classification.
- **Meaning of Available Days.** Read as Airbnb-open nights excluding nights
  blocked for off-platform guests (Jun 2026 shows none open yet had an
  off-platform stay). If wrong, May 2026 changes class.
- **Zero-availability months** — closure, delisting or owner use? Decides how to
  read the cost of blocked nights.

## Known script limits

- The off-platform workbook is a freeform pricing sheet. The parser relies on
  its layout: trip dates in the 'Specific Dates' table (columns L-W), agreed
  price in column F of each section's 'Finalized' row. Sections with a price but
  no dates are reported as undated stays, not allocated.
- Minimum-stay rules are not modelled; lead time only exists for stays with a
  raw export row.

## Acceptance

- Each open question above is answered or explicitly recorded as unanswerable.
- A fresh dated report is generated with those answers applied (new parameters
  or source files, not hand edits to numbers), and its Top 3 findings each cite
  a table number and name a lever.
- Nothing under `docs/revpan-diagnostic-*` or any source data is committed.
