---
id: ISS-5
title: Document process for updating DoIt theme submodule
type: task
status: To Do
priority: Low
labels: []
assignee: null
milestone: M-1
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo: []
checklist: []
log: []
createdAt: 2026-03-25T03:01:30.985Z
updatedAt: 2026-08-20T00:00:00.000Z
---

## Files in the site repo that shadow the theme

Hugo replaces a partial or layout wholesale, so each of these has to be
re-checked after a `themes/DoIt` submodule bump.

Verbatim copies — diff against the theme's version and re-apply the delta:

- `layouts/partials/head/meta.html` — plus `noindex` on taxonomy/term kinds
- `layouts/partials/init.html` — minus the `.Site.Author` check (Hugo 0.159)
- `layouts/partials/function/resource.html`
- `layouts/sitemap.xml` — taxonomy/term pages excluded

Purpose-built replacements — do NOT diff these against the theme, they were
never copies. Check instead that the theme partials they call still exist and
that the CSS class contract still holds:

- `layouts/posts/single.html` — the editorial post layout. Calls
  `single/outdatedArticleReminder.html`, `function/content.html`,
  `plugin/image.html`, `related.html`, `comment.html`. Deliberately does not
  render the TOC, series nav, sponsor, `.post-meta`, or `single/footer.html`;
  the reasons are in the file's header comment.
- `assets/css/_custom.scss` and `assets/css/_hh.scss` — `_hh.scss` is the design
  file from Claude Design and is meant to be overwritable; the integration rules
  in `_custom.scss` are keyed to DoIt selectors and specificities
  (`.dark a`, `.single .content figure .image-caption:not(:empty)`,
  `#header-mobile .header-container .header-wrapper .header-title`) that a theme
  update could move.
