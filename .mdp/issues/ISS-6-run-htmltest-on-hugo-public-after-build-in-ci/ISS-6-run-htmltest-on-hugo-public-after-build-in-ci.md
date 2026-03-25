---
id: ISS-6
title: Run htmltest on Hugo ./public after build in CI
type: task
status: Done
priority: High
labels: []
assignee: null
milestone: M-2
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-24
checklist: []
log:
  - date: 2026-03-25
    note: >-
      Implementation complete. Added .htmltest.yml, htmltest step in
      .github/workflows/hugo.yml, content/about.md, content/posts/contact.md,
      and .gitignore entry for tmp/.htmltest/. Two DoIt theme overrides were
      required for Hugo 0.159 compatibility:
      (1) layouts/partials/init.html — removed .Site.Author check (field
      deleted in Hugo 0.159, causes errorf in theme);
      (2) layouts/partials/function/resource.html — added guard to skip
      resources.Get when the destination path is "/" or empty, which otherwise
      causes "Failed to publish Resource: open .../public: is a directory"
      when any markdown content contains a link to the site root [text](/).
      htmltest config: CheckExternal false, IgnoreEmptyHref true (theme
      generates blank href attrs for empty series/category links).
createdAt: 2026-03-25T03:01:35.312Z
updatedAt: 2026-03-25T04:10:03.941Z
---

## Requirement

After every successful `hugo --minify`, validate generated HTML for **broken internal links** using **[htmltest](https://github.com/wjdp/htmltest)** in CI.

### Intended implementation (reverted locally)

- Add repository root `.htmltest.yml` (e.g. `DirectoryPath: public`, `CheckExternal: false`, optional `IgnoreURLs` for assets not in repo yet).
- In the Hugo workflow, install a pinned htmltest binary (e.g. v0.17.0) and run `htmltest` against `./public` after the build.

### Notes

- First run may require fixing real dead links (e.g. `/about/`, `/posts/contact/`) or tuning ignores — track under separate content issues.
- Related: local **justfile** recipe + `.htmltest.yml` (see ISS-18).
- **Production** link checks (e.g. crawlers such as Muffet) are out of scope here; see **ISS-24**.