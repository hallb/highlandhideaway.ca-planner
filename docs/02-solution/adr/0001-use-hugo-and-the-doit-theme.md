# ADR 0001: Use Hugo with the DoIt theme

## Status

Accepted. Recorded retroactively on 2026-08-20; the decision predates this record.

## Context

The site is a marketing and guest-information site for one rental property. Content changes a few times a year. It has no accounts, no payments, and no server-side state — booking happens on an external platform.

The people editing it are the property owners, not developers.

## Decision

Build with Hugo, using the DoIt theme vendored as a git submodule at `themes/DoIt`.

## Consequences

Builds are fast and the output is a directory of files, so any static host will serve it. That property was tested in 2026-08 when hosting moved from GitHub Pages to Cloudflare: the host changed and the generator did not.

Content lives in Git, so guest-facing copy gets review and history.

A submodule theme costs an extra step on clone (`git submodule update --init --recursive`) and needs a process for updates, which is ISS-5.

Taking a third-party theme means inheriting its markup, including its defects. Two have needed work: the mobile menu has no button semantics or keyboard support (ISS-13), and Hugo 0.15x broke DoIt's init partial, which now has a local override. Where the theme's output was wrong for this site rather than merely different, the answer has been a targeted override, not a fork — see [ADR-0009](0009-replace-the-post-layout.md).
