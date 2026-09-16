---
id: ISS-60
title: Clear two SEO defects found in the September search review
type: task
status: To Do
priority: Low
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-27
  - ISS-43
  - ISS-25
checklist:
  - text: Remove the site-wide noodp directive or record why it stays
    done: false
  - text: Leave exactly one robots meta tag on taxonomy pages
    done: false
  - text: Make /posts/haliburton-gallery-tour/ 301 or 404 deliberately
    done: false
  - text: Find out why a file the build does not produce survives in the asset store
    done: false
log:
  - timestamp: 2026-09-16T02:19:23.000Z
    author: claude
    body: |-
      Ben asked on 2026-09-15 which defects these are. Both re-checked against the
      live site the same day; both are still present, unchanged since 2026-09-06.

      One: taxonomy pages serve two competing robots tags. `https://highlandhideaway.ca/tags/`
      returns `<meta name=robots content="noodp">` and
      `<meta name=robots content="noindex, follow">` together. Behaviour is correct --
      Google takes the most restrictive, so the ADR-0007 taxonomy exclusion works --
      but `noodp` referred to the Open Directory Project, which shut down in 2017,
      and it ships site-wide from the DoIt theme, so it is on every page rather than
      only these. Tidiness, not rankings.

      Two: `https://highlandhideaway.ca/posts/haliburton-gallery-tour/` still returns
      HTTP 200 and serves a Hugo alias stub pointing at the studio tour. Nothing in
      the current source produces that file. It is surviving in the Cloudflare asset
      store from an earlier deploy, which is the part actually worth understanding:
      `wrangler deploy` with `[assets]` is supposed to replace the manifest, so an
      orphan means either a stale local `public/` was shipped at some point or an
      assumption about the upload does not hold. If that is happening it will not be
      the only orphan. Search Console has this one indexed at position 50.

      Note for whoever picks this up: the `worktree-seo-404-fix` branch in the site
      repo looks relevant and is not. It carries no commits beyond main and its tree
      is clean -- a leftover worktree from earlier work that was merged. Nothing on
      this issue has been written yet; start from scratch.
createdAt: 2026-09-07T04:29:08.897Z
updatedAt: 2026-09-16T02:19:23.000Z
---

## Requirement

Two small defects surfaced while verifying live pages during the search and
traffic review of 2026-09-06. Neither is urgent and neither is costing rankings
today, but both are cheaper to fix while the cause is known.

## Duplicate robots meta, and a directive dead since 2017

Taxonomy pages serve two competing tags:

```html
<meta name=robots content="noodp">
<meta name=robots content="noindex, follow">
```

Google combines multiple robots meta tags and takes the most restrictive, so
`noindex` still wins and the taxonomy exclusion in ADR-0007 is working as
intended. The problem is tidiness rather than behaviour -- but a page carrying
two robots directives is exactly the kind of thing that reads as a bug during
the next audit, and resolving it once is cheaper than re-deciding it.

`noodp` told search engines not to use the Open Directory Project description.
The ODP shut down in 2017 and Google dropped support the same year. It ships
site-wide from the DoIt theme, so it is on every page, not only the taxonomies.

## A stale URL still served from the asset store

`https://highlandhideaway.ca/posts/haliburton-gallery-tour/` returns **HTTP
200** and serves a Hugo alias stub -- a 694-byte page whose title and canonical
both point at `/posts/haliburton-studio-tour/`.

Nothing in the current source produces it. There is no `aliases` key anywhere
in `content/`, the URL is not in the sitemap, and the current draft at
`content/posts/haliburton-galleries.md` would build to
`/posts/haliburton-galleries/`, not this path.

That makes it a file surviving in the Cloudflare asset store from an earlier
deploy, which is worth understanding on its own account: `wrangler deploy` with
`[assets]` is expected to replace the manifest, so a leftover suggests either a
stale local `public/` shipped at some point or an assumption about the upload
that does not hold. If that is happening, this will not be the only orphan.

Search Console has it indexed -- 1 impression at position 50 -- so it is not
invisible.

Related to ISS-43, which decides the fate of the gallery and studio content
itself.

## Acceptance

- `noodp` no longer ships, or a note records why it stays.
- Taxonomy pages carry exactly one `<meta name=robots>` tag.
- `/posts/haliburton-gallery-tour/` either 301s to the studio tour post or
  returns 404, deliberately.
- The reason a file the build does not produce survived in the asset store is
  understood, and any other orphans are checked for.
