---
id: ISS-27
title: Set up Google Search Console on the apex
type: task
status: Done
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
  - text: Create the www->apex Redirect Rule in Cloudflare (301 preserving path and query)
    done: true
  - text: "Once the redirect is live: confirm www URLs show as Page with redirect in Coverage"
    done: true
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
  - timestamp: 2026-08-20T21:09:06.779Z
    author: claude
    body: |-
      The www->apex redirect is not actually in place. Found 2026-08-20 while verifying the DNS drain for ISS-26.

      https://www.highlandhideaway.ca/ returns 200 and serves the whole site, not a 301. Same for https://www.highlandhideaway.ca/posts/welcome/. Both hostnames are attached as custom domains on the Worker, so the Worker answers on both and nothing redirects between them. wrangler.toml lines 26-34 describe a 'www->apex Redirect Rule' firing at the edge and give that as the reason the www route must stay listed; that Redirect Rule was either never created in the dashboard or has since been removed. The wrangler comment is currently describing an intention, not the deployed state.

      This makes the third checklist item unanswerable as written. 'Page with redirect' will never appear for www URLs in Coverage, because there is no redirect — the risk is the opposite one, www URLs indexed as duplicates of the apex.

      Mitigated but not fixed: canonical tags are correct and absolute on both hostnames, so www pages carry <link rel=canonical href=https://highlandhideaway.ca/...>. Google usually consolidates on that, so this is unlikely to be actively costing rankings. It is still worth fixing properly, because canonicals are a hint and a 301 is not.

      The fix is a Redirect Rule in the Cloudflare dashboard (Rules -> Redirect Rules): hostname equals www.highlandhideaway.ca, dynamic redirect to concat('https://highlandhideaway.ca', http.request.uri.path), 301, preserve query string. That is account work needing Zone:Rules edit, which no token in this project has — same constraint as the DNS verification above.
  - timestamp: 2026-08-20T21:17:52.691Z
    author: claude
    body: "Amendment to the note above: hugo.toml carries the same claim. Its first line reads 'The apex is canonical: a Cloudflare Redirect Rule 301s www -> apex.' So two files in the site repo describe a redirect that is not deployed, not one. Both are worth correcting when the rule is created, or sooner if the rule is not going to be."
  - timestamp: 2026-08-20T21:53:24.756Z
    author: claude
    body: |-
      Evidence that the missing www redirect is costing something real, not just theoretically. Cloudflare RUM for the last three days, grouped by requestHost:

        highlandhideaway.ca        69 pageloads, 32 visits
        www.highlandhideaway.ca     4 pageloads,  3 visits

      So roughly 5 percent of page loads are arriving on www and staying there, because nothing redirects them. Those are real visitors on the non-canonical hostname, and Google can see the same pages on both. The canonical tags are doing their job, but this is exactly the duplicate-content surface the 301 is supposed to remove.

      Worth noting the number is a floor, not a ceiling. The Web Analytics site is set to exclude EU visitors, so nobody in the EU is counted on either hostname.

      Query, which works with the CF_AE_TOKEN already in grafana/.env:

        viewer { accounts(filter:{accountTag:...}) {
          rumPageloadEventsAdaptiveGroups(
            filter:{datetimeHour_geq:..., datetimeHour_leq:...}, limit:5000
          ) { count sum { visits } dimensions { siteTag requestHost } } } }

      Filter on siteTag d6c7d92c76644885840437e3fdf3b867 for this site. That is NOT the beacon token in page source -- the two identifiers differ, and filtering on the beacon token returns an empty result that reads like no data.
  - timestamp: 2026-08-21T12:20:00.000Z
    author: claude
    body: |-
      The www->apex Redirect Rule is created and verified live. Deployed as Cloudflare's built-in "Redirect from WWW to root [Template]": wildcard pattern https://www.* -> https://${1}, 301, preserve query string checked. The www DNS record is a Workers Custom Domain and therefore always proxied -- the dashboard's "this rule may not apply to your traffic" warning during setup was a false positive, not a real DNS gap.

      Verified by curl:

        http://www.highlandhideaway.ca/posts/welcome/  -> 301 https://www.highlandhideaway.ca/posts/welcome/
        https://www.highlandhideaway.ca/posts/welcome/ -> 301 https://highlandhideaway.ca/posts/welcome/

      Path and query both preserved, as required. Plain http://www takes two hops because SSL/TLS -> Edge Certificates -> "Always Use HTTTPS" was enabled the same session, and it fires before the rule can match -- the rule's wildcard pattern only matches an https:// request. https://www, which is what Search Console, the sitemap, and internal links all already use, gets a single hop straight to the apex. A scheme-independent custom filter expression (http.host eq "www.highlandhideaway.ca") would collapse this to one hop in every case; left as a polish item, not required for this issue.

      wrangler.toml and hugo.toml both corrected to describe the rule as created rather than missing.

      Fourth checklist item stays open: Coverage in Search Console has no crawl data for the www hostname yet, so "Page with redirect" cannot be confirmed until Google crawls it. Revisit once first data lands (~2026-08-21/22 per the earlier estimate).
  - timestamp: 2026-08-31T13:00:00.000Z
    author: claude
    body: |-
      Closed. Ben confirmed on 2026-08-31 that Coverage now reports the www URLs as "Page with redirect", which was the last open item and the check that the apex-canonical work in ISS-25 actually took. The Redirect Rule went live on 2026-08-21, so Google took roughly ten days to crawl the hostname and report it.

      That closes the loop on the whole issue. The property is verified, the sitemap is submitted and now serving 29 URLs rather than the 23 it carried in August, the redirect is deployed and confirmed, and the duplicate-content surface the canonical tags were papering over is gone.

      Ben also requested indexing on the two posts published on 2026-08-31, /posts/corduroy-enduro/ and /posts/fall-colours/, rather than waiting for a natural crawl. Both are date-sensitive: the Corduroy event runs 17-20 September, and fall colour searches start well before the mid-October peak. On a property Google has known for twelve days, a natural crawl was not going to arrive in time for either.

      What this issue was always for is now the live question. Query data was estimated to become useful between 2026-09-02 and 2026-09-16, so it is about to land. The queries sitting at position 8-15 are the cheap wins and they should decide which of the ISS-31 children get finished first. The audit's own finding still stands and no query data will overturn it: the pages are thin, and depth on the pages worth ranking is the work.
createdAt: 2026-08-18T21:40:00.000Z
updatedAt: 2026-08-31T13:00:00.000Z
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
