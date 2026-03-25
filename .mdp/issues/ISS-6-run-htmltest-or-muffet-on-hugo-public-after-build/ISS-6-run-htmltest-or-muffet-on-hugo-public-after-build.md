---
id: ISS-6
title: Run htmltest or muffet on Hugo ./public after build in CI
type: task
status: To Do
priority: High
labels: []
assignee: null
milestone: M-2
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:01:35.312Z
updatedAt: 2026-03-25T03:24:25.907Z
---

## Requirement

After every successful `hugo --minify`, validate generated HTML for **broken internal links** using **htmltest** (or equivalent) in CI.

### Intended implementation (reverted locally)

- Add repository root `.htmltest.yml` (e.g. `DirectoryPath: public`, `CheckExternal: false`, optional `IgnoreURLs` for assets not in repo yet).
- In the Hugo workflow, install a pinned htmltest binary (e.g. v0.17.0) and run `htmltest` against `./public` after the build.

### Notes

- First run may require fixing real dead links (e.g. `/about/`, `/posts/contact/`) or tuning ignores — track under separate content issues.
- Related: local **justfile** recipe + `.htmltest.yml` (see ISS-18).