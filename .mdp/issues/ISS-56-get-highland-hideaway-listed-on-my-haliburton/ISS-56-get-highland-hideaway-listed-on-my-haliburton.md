---
id: ISS-56
title: Get Highland Hideaway listed on My Haliburton Highlands
type: task
status: Done
priority: High
labels: []
assignee: null
milestone: M-3
estimate: null
spent: null
dueDate: null
blockedBy: []
parent: null
relatedTo:
  - ISS-55
  - ISS-27
  - ISS-52
  - ISS-57
  - ISS-59
checklist:
  - text: Ask Sobia whether she objects to the listing
    done: true
  - text: Confirm which municipality licenses the cottage and whether Highland Hideaway is registered
    done: true
  - text: Confirm the accommodation tax position -- whether Airbnb collects and remits it
    done: true
  - text: Decide what owner contact to publish on the site
    done: true
  - text: Publish the owner contact on the site
    done: true
  - text: Publish a line on the site about adherence to local regulations
    done: true
  - text: Reply to Eric with proof of registration and the site URL copying info@myhaliburtonhighlands.com
    done: true
  - text: Verify the published entry and that it links to the apex domain rather than Airbnb
    done: true
log:
  - timestamp: 2026-09-03T13:07:10.549Z
    author: claude
    body: |-
      Registration answered by Ben on 2026-09-03: registered with Dysart et al, holds an STR licence, accommodation tax remitted and current. Body updated and both checklist items ticked. The application now turns on the two website gaps and on Sobia.

      Contact route, open on Ben's call. He does not want to publish a personal email or phone -- spam, and he already ignores unrecognised numbers -- and asked whether a Cloudflare Worker form would be better, or whether to lean on Airbnb messaging.

      Recommended a role alias on the domain through Cloudflare Email Routing, keeping Airbnb as the preferred route on the page. Free, inbound only, forwards to his existing inbox so notification needs no code. The zone carries no MX records today, only the Search Console TXT, so Email Routing can claim it without conflict. The spam mitigation is that an alias is disposable: if stay@ is harvested, publish book@ and delete stay@, one line on the contact page, personal address never exposed and never moved.

      Argued against Airbnb alone. Their criteria list the standalone-site requirement and the owner-contact requirement separately, and the standalone clause contrasts explicitly with a listing on Airbnb or VRBO, so routing contact through Airbnb is the item likeliest to come back as committee feedback. The six owner-managed entries on the directory each show a phone number.

      Argued against the form on cost, at the point Ben was unsure about. A Worker cannot send mail by itself. MailChannels ended the free Workers path on 2024-08-31; the routes now are a third-party API such as Resend with a token in a Worker secret, or Cloudflare's own Email sending, in public beta since April 2026 at 0.35 USD per thousand and not GA. That is a Worker route, Turnstile, a provider and SPF/DKIM to reach the same inbox the alias reaches. Form spam is bots too, so it does not solve what he is worried about. Revisit if enquiry volume ever justifies it.

      No phone in round one. Their criteria do not require one -- the numbers on that page are mostly the four agencies. If MHH asks for a number for the entry, get a separate voicemail-only line rather than publishing the personal one, which is the one that cannot be rotated.

      Caveat recorded: Email Routing is inbound only, so replies go out from his personal address unless send-as is configured through a provider. Not worth doing. The risk is a harvestable address on a public page, not a reply to one person who already wrote in.
  - timestamp: 2026-09-04T03:21:27.874Z
    author: claude
    body: |-
      Ben chose stay@highlandhideaway.ca on 2026-09-03. Contact page change written, not yet deployed and the alias does not exist yet, so the publish item stays open.

      content/posts/contact.md now carries one line after the Airbnb CTA: "If you would rather email, that is stay@highlandhideaway.ca." Airbnb stays first and stays the recommended route for a booking question. The guest paragraph below it said "message us the same way", which had two possible antecedents once an email address existed, so it now says "through Airbnb" outright. Renders as a mailto link; hugo build clean.

      Also added Email Routing to the dashboard-configuration list in wrangler.toml, which that file asks for by name -- configuration living only in the dashboard is invisible to code review and this project has lost one item that way already. The entry records the rotation procedure, that enabling it adds three MX records and an SPF TXT to a zone that had no MX before, that the catch-all stays off, and that Email Routing is inbound only.

      Still open on the website side: the line about adherence to local regulations. That one needs the licence number from Dysart et al, which is not on this board.
  - timestamp: 2026-09-04T03:23:41.964Z
    author: claude
    body: |-
      Regulatory line written 2026-09-03, on /about/ rather than the contact page, since that is the page describing the property and it sits in the main menu. One sentence appended to the existing "We rent it through Airbnb" paragraph: "The cottage is licensed as a short-term rental by the Municipality of Dysart et al."

      The licence number is deliberately not on the site. Ben's call. It costs nothing to withhold, because their criteria ask for proof of registration by email, not on the page -- the number and the accommodation tax standing go to the committee in the application message instead. What the website requirement asks for is information about adherence to local regulations, and a licence statement is that.

      Both website changes are written and build clean. Neither is deployed and the alias does not exist yet, so both publish items stay open until the change is live and stay@ delivers.
  - timestamp: 2026-09-04T03:47:32.874Z
    author: claude
    body: |-
      Both website requirements are live as of 2026-09-04, site repo commit 0079415, deployed clean through the Cloudflare workflow. https://highlandhideaway.ca/posts/contact/ carries stay@highlandhideaway.ca as a mailto link and https://highlandhideaway.ca/about/ carries the licence sentence. Verified against the live pages, not the build.

      Email Routing was enabled the same evening and delivery is confirmed end to end: a message from a Yahoo account reached the destination inbox. The earlier test looked like a failure only because it was sent from the destination Gmail account to a plus-address of itself, which Gmail collapses into the sent thread rather than showing as new inbox mail.

      That clears everything on this issue except three things: Sobia, the DMARC record, and the application email itself. Sobia is the one that gates sending, and it is still the first item on the list.

      DMARC is not a listing requirement and does not block the application. It is worth adding because the domain now publishes SPF and DKIM and sends no mail of its own, so a strict policy costs nothing and stops the domain being spoofed. Record to add by hand: TXT, _dmarc, v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s -- no reporting address, because the aggregate XML would forward into the same inbox as the enquiries.
  - timestamp: 2026-09-04T03:54:11.844Z
    author: claude
    body: |-
      Ben is joining the Haliburton Highlands Land Trust Partners in Conservation programme, prompted by the sustainability clause in the MHH criteria, and started that conversation on 2026-09-04. Tracked separately as ISS-57, which covers the page he expects to write about it.

      It does not gate this issue. Their clause gives priority to properties showing a commitment to sustainability, which is a tiebreaker rather than a criterion, and their process allows reapplying. Sending the application now and joining PIC later costs nothing. Waiting on PIC costs the season.
  - timestamp: 2026-09-04T04:16:00.662Z
    author: claude
    body: |-
      Sobia agreed to the listing, 2026-09-04. That was the item gating the application.

      Email drafted the same day for Ben to send from his own address, replying in Eric Casper's thread with info@myhaliburtonhighlands.com copied, STR certificate attached. It states the licence with Dysart et al, good standing and accommodation tax currency, names the site and the four website items their criteria ask for, offers a description for the entry so the wording is ours rather than theirs, and asks two questions: whether the committee needs anything further, and whether an email address is acceptable in place of the phone number every other entry on that page carries.

      Everything on this issue is now Ben's to do: send it, then verify the published entry links to the apex domain rather than to Airbnb.
  - timestamp: 2026-09-07T04:29:53.448Z
    author: claude
    body: |-
      Search data from 2026-09-06 strengthens the case for this issue and argues for raising its priority.

      The site currently ranks at average position 13 for "highland hideaway" -- its own name. A brand query is the easiest ranking a site will ever get, and this one is not being won, which is the clearest symptom of a three-week-old domain carrying almost no external citation. Search Console records 26 impressions and zero clicks over nineteen days, and Cloudflare RUM independently records zero referrals from google.com across 240 page loads. There is no organic search channel yet at all.

      That makes the last open checklist item here -- verifying the published entry links to the apex domain rather than to Airbnb -- the SEO-bearing half of this issue rather than a detail. A link from an established local directory does two things the site cannot do for itself: it sends referral traffic from people already looking for Haliburton accommodation, and it is exactly the kind of independent citation that helps Google resolve the brand query to this domain. A link pointing at the Airbnb listing instead carries neither benefit to highlandhideaway.ca, which is why that item is worth insisting on rather than accepting whatever the committee publishes.

      Priority raised Medium -> High on that basis. Nothing about the work itself changes: the two remaining items are still Ben's -- send the drafted reply to Eric copying info@myhaliburtonhighlands.com, then verify the entry once it is published.

      Related to ISS-59, which re-reads Search Console after 20 September. The brand query position is the number that should move if this lands.
  - timestamp: 2026-09-16T02:19:23.000Z
    author: claude
    body: |-
      Listed, and verified against the live page on 2026-09-15. Ben reported the
      entry is up; https://myhaliburtonhighlands.com/where-to-stay/cottage-rentals/
      now carries Highland Hideaway.

      The last open item was the one that mattered for SEO and it landed the right
      way: the entry links to https://highlandhideaway.ca/ -- the apex domain, not
      the Airbnb listing. That is the independent citation this issue was raised to
      get, and the referral path it was worth insisting on.

      Contact shows as stay@highlandhideaway.ca with no phone number, so the
      committee accepted an email address in place of the number every other entry
      on that page carries. The alias strategy held: nothing personal is published,
      and stay@ stays rotatable if it is harvested.

      Listing text as published: "A cottage on 23 acres of forest near Haliburton,
      with boat launch on Drag Lake directly across the road. Wood stove, screened
      deck, canoe and paddleboard." Offering our own description was worth doing --
      the wording is ours.

      Closing this. What happens next is measurement, not work: ISS-59 re-reads
      Search Console after 20 September, and the brand query position (average 13
      on 2026-09-06, zero clicks) is the number that should move if this citation
      does what it is supposed to do. Referral traffic from myhaliburtonhighlands.com
      should also start appearing in Cloudflare RUM, which recorded no google.com
      referrals at all over 240 page loads.
createdAt: 2026-09-03T12:53:07.775Z
updatedAt: 2026-09-16T02:19:23.000Z
---

-