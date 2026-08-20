# ADR 0009: Replace the DoIt post layout rather than override it

## Status

Accepted, 2026-08-20. Recorded against ISS-5.

## Context

The editorial post design could not be reached by adjusting DoIt's `posts/single.html`. It wants a full-bleed hero, a wide measure, and a sticky booking rail. The theme's layout assumes a `.page.single` container and a `.content` body, and its CSS is written against those classes.

There was a specific collision. DoIt's `.dark .single .content a` has specificity (0,3,1), which beats the design's link colours in dark mode. Keeping the theme's classes on the markup means fighting that selector on every element.

## Decision

`layouts/posts/single.html` is a purpose-built replacement, not a copy of the theme file with edits.

Its markup is a contract with `assets/css/_hh.scss`, which styles `.hh-post`, `.hh-hero`, `.hh-grid`, `.hh-body` and `.hh-book`, and never touches DoIt's `.page`, `.single` or `.content`. Keeping the theme classes off the markup is what avoids the specificity fight.

## Consequences

The design's CSS wins without `!important` anywhere, in both themes.

The usual rule for overrides, re-diffing against the theme file after a submodule bump, does not apply to this file, and diffing it against DoIt's version would be noise. What to check after a theme update is instead the list of partials it calls, and the class contract.

Several theme features are deliberately not rendered. Recorded in the file's header comment with the reason for each: the TOC and `#toc-dialog` are inert because no `[params.page]` block exists; the series nav has no post using `series`; `single/sponsor.html` is unconfigured; the post-meta line is replaced by the hero eyebrow; and `single/footer.html`, which holds tags, share buttons and prev/next links, is styled for a context this layout no longer provides. Dropping the tag links costs no SEO, since taxonomy pages already carry `noindex` ([ADR-0007](0007-keep-taxonomies-out-of-the-index.md)).

Two theme integrations are preserved by keeping their hooks: `id="content"` for `initLightGallery()`, which binds by id, and `data-pagefind-body` for the search index.

This approach suits one heavily designed template. It does not scale to replacing the theme piece by piece — at that point the honest move is a fork, or a different theme.
