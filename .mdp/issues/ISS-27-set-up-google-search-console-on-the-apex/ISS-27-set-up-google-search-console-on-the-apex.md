---
id: ISS-27
title: Set up Google Search Console on the apex
type: task
status: In Progress
priority: High
labels: []
assignee: null
milestone: M-5
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-25
  - ISS-31
checklist:
  - text: Verify a Domain property by TXT record in Cloudflare DNS
    done: true
  - text: Submit https://highlandhideaway.ca/sitemap.xml
    done: true
  - text: Check Coverage for "Page with redirect" on any www URLs
    done: false
log:
  - timestamp: 2026-08-19T04:13:08.609Z
    author: claude
    body: |-
      Cleared the ground for this before it gets set up, since two of the things Search Console reports on were wrong.

      The sitemap advertised 73 URLs, 50 of them auto-generated tag and category pages — navigation outnumbering real content two to one, none of it anything a person searches for. Taxonomy pages now carry noindex, follow and are excluded from the sitemap, which is down to the 23 pages worth ranking. Expect Page indexing to show roughly 50 URLs under "Excluded by 'noindex' tag" once crawling catches up; that is this change working, not a fault.

      robots.txt was never being generated at all. Hugo does not emit one unless enableRobotsTXT is set, so production was serving Cloudflare's managed robots.txt, which blocks AI crawlers but carries no Sitemap line. The theme has always shipped a template containing one; nothing was rendering it. Now set, and the served file is the union of both: Cloudflare appends its content signals to the origin file rather than replacing it.

      Site repo commit 5c9d1f3, deployed and verified live — sitemap 23 URLs, noindex present on /tags/area/, Sitemap line in robots.txt, and the weekly crawl passed 23/23 with 0 errors.

      What is left here is the account work, which needs a person: create the Domain property, add the google-site-verification TXT at Cloudflare (Zone:DNS:Edit — neither token in this project has it), submit sitemap.xml, request indexing on the homepage and the best two or three posts, then import the property into Bing Webmaster Tools while there.

      Worth knowing before reading the first reports: data starts landing in 2-3 days, query data becomes useful at 2-4 weeks, and impressions will start near zero because the site is effectively new to Google. The point of the exercise is the position 8-15 queries — the cheap wins — which is also what should decide the content work in ISS-31.
  - timestamp: 2026-08-19T04:18:53.841Z
    author: claude
    body: |-
      Set up on 2026-08-19. The Domain property is verified — the TXT record answers from both 1.1.1.1 and 8.8.8.8 as google-site-verification=REJmogXc9ehvGCknOeAXo2sV8KJEg-j0oaHRnBdIjUw — and sitemap.xml is submitted. The live sitemap is serving 23 URLs.

      Left open on purpose. The third item, checking Coverage for "Page with redirect" on www URLs, cannot be done yet: Google has not crawled the property, so there is no coverage data to read. It is the check that the apex-canonical work in ISS-25 actually took, so it is worth keeping rather than closing early.

      When to come back: first data lands around 2026-08-21 or 22, and query data becomes useful somewhere between 2026-09-02 and 2026-09-16. Two things will look like faults in the first reports and are not — roughly 50 URLs under "Excluded by 'noindex' tag", which is the taxonomy change working, and impressions near zero, because the site is effectively new to Google.

      Then the content work in ISS-31 gets its brief: the queries already showing at position 8-15 are the cheap wins, and they should decide which content TODOs are worth finishing first.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-19T04:18:53.841Z
---

## Requirement

Search Console is the only tool that reports the queries people used to
find the site, which is what should decide the next posts. It is free and
has no privacy cost.

## Use the apex, not www

`baseURL` and every canonical tag now say the apex; www 301s to it. A
Domain property covers both hostnames and survives that redirect, so it is
the right choice here.

## Note

DNS is on Cloudflare, so the TXT verification is a two-minute job.
