# Grafana for `booking_clicks`

Local Grafana that reads the Cloudflare **Workers Analytics Engine** dataset
the booking redirect writes to. Analytics Engine has no UI of its own — its
[SQL API](https://developers.cloudflare.com/analytics/analytics-engine/sql-api/)
is the only way to see the rows — so this is a saved-query front end over that
API, not a second source of truth.

The Worker that writes the rows lives in the sibling site repo at
`highlandhideaway.ca/src/worker.js`; the binding is declared in its
`wrangler.toml` as `CLICKS` → `booking_clicks`.

## Run it

```bash
cp .env.example .env      # then fill in both values
docker compose up -d      # or: just grafana
```

Open <http://localhost:3000> (`admin` / `admin`) → Dashboards → **Highland
Hideaway** → **Booking clicks**. Stop with `docker compose down`; the volume
keeps your edits between runs.

`.env` needs an Account ID and an API token with **Account · Account Analytics
· Read**. The `CLOUDFLARE_API_TOKEN` in GitHub secrets is Workers Scripts:Edit
and will not work here.

### Reaching it from Windows

The container publishes on `0.0.0.0` (`GRAFANA_BIND` in `.env`), because under
WSL2 a `127.0.0.1` publish binds the WSL VM's loopback and a Windows browser
gets nothing at `localhost:3000`. With `0.0.0.0` both work:

```
http://localhost:3000        via WSL2's localhost relay
http://<wsl-ip>:3000         ip -4 addr show eth0 — changes on restart
```

If `localhost` still fails, the relay is the usual suspect — use the WSL IP, or
`wsl --shutdown` from Windows and start the container again. Check the Linux
side first with `curl -s localhost:3000/api/health`: a 200 there means Grafana
is healthy and the problem is purely the hop from Windows.

## What is provisioned

| File | Purpose |
| --- | --- |
| `docker-compose.yml` | Grafana 13.2.0 on :3000, published per `GRAFANA_BIND` (0.0.0.0 by default, for WSL2), plugin preinstalled |
| `provisioning/datasources/cloudflare-analytics-engine.yml` | The SQL API as a data source, credentials interpolated from the environment |
| `provisioning/dashboards/booking.yml` | Loads `dashboards/` into a folder |
| `dashboards/booking-clicks.json` | Four panels: total, per-page time series, per-page table, raw recent rows |

The data source is the **Altinity ClickHouse plugin**
(`vertamedia-clickhouse-datasource`), which is the one
[Cloudflare documents](https://developers.cloudflare.com/analytics/analytics-engine/grafana/).
Grafana's own ClickHouse data source is the wrong choice: it speaks the native
binary protocol, and the SQL API only serves HTTP.

## Conversion rate

The **Conversion** row joins booking clicks against Web Analytics visits, which
is the number neither tool shows on its own: Cloudflare has the page views,
Analytics Engine has the clicks, and the ratio is the thing worth watching.

It needs a second data source, because the two numbers live behind different
APIs. Booking clicks come from the Analytics Engine SQL API; visits come from
Web Analytics, which is reachable only over the GraphQL Analytics API. The
Infinity plugin talks to the second one. The same `CF_AE_TOKEN` works for both
-- Account Analytics: Read covers the RUM datasets, so no new token is needed.

Four things about the numbers, all of which will otherwise look like faults:

**The click counts differ from the panels above.** The conversion panels count
only clicks whose `blob4` carries a placement (`inline`, `rail`, and `bar`,
the mobile strip added by ISS-33 on 2026-08-20). Everything else was a direct call to `/go/airbnb` -- a probe, the
daily canary, a DNS drain check -- or predates the placement parameter. Over
the fourteen days to 2026-08-20 that is the difference between about 180 rows
and 6. The older panels exclude only the canary, so they are counting mostly
test traffic. Worth fixing, and not yet fixed.

**The series starts on 2026-08-20**, because that is when the placements
shipped. There is no earlier conversion history to recover.

**Bots are filtered out of visits with `bot: 0`**, matching the "Exclude bots"
default in Cloudflare's own UI. This is not cosmetic: on 2026-08-20 it took
visits from 19 to 9. Leaving it out halves the reported conversion rate.

**Bots are filtered out of clicks twice, and it is still not enough.** The
first filter is `blob5`, the Worker's verdict (ISS-36). The second is a chain
of `blob7 NOT ILIKE` on every aggregate panel, excluding cloud and datacenter
operators (ISS-58); it is applied at query time so it covers rows written
before the Worker learned the same rule on 2026-09-15, which `blob5` cannot.

Neither closes the gap. Measured over 2026-08-18 to 2026-09-06:

| Filter | Clicks |
| --- | --- |
| no filter | 707 |
| `blob5 = 'human'` | 140 |
| `blob5` + operator | 121 |
| `blob5` + operator + `blob3 IN ('CA','US')` | 23 |

RUM saw **70 visits** in that window. So the numerator still exceeds the
denominator at 121, and the conversion rate on this dashboard is still
overstated. What remains is scrapers on consumer ISPs, arriving one at a time
from FR, GB, DE, VN, BR, KE, IN, ZA, PH, RU, ID and AR — countries RUM records
no visitors from at all.

The country filter is what actually closes it, and it **is** applied — as the
**Countries** dropdown at the top of the dashboard, defaulting to `CA,US`,
which is every country RUM has ever recorded a visitor from. With it on, the
conversion panels read 27 clicks against 60 visits: the numerator is below the
denominator for the first time.

It is a variable rather than a hardcoded `AND blob3 IN (...)` for a reason. The
objection to a country filter is real — it would drop a genuine overseas
visitor the day the site has one, and today's zero is a fact about a
three-week-old site rather than about the business. A dropdown answers that
objection instead of accepting it: the correction is visible, it is reversible
without editing SQL, and **Excluded by the country filter** shows exactly what
it is currently hiding, so widening it is a decision someone can actually make.

Check that panel before trusting the default. What to look for is a country
with varied user agents, a referer and more than one page — that is a person.
What is there today is not: one byte-identical user agent accounts for 47
clicks across three countries, and the tail sends strings like `Windows 98`
and `iPhone OS 4_3_5`.

The EU deserves particular care here, because the evidence is weaker than it
looks. Web Analytics is set to exclude EU visitor data, so RUM *cannot* record
an EU visitor — "RUM sees nobody from France" is a statement about the
configuration, not about France. 52 of the 194 operator-filtered clicks are
EU. They look like machines on inspection (23 FR and 8 DE share one user agent
string), but that panel is the only evidence there will ever be for them.

The term list is duplicated in the site repo at `src/worker.js`
(`BOT_ASN_TERMS`) because the Worker cannot read a panel and a panel cannot
call the Worker. Change one, change the other. Note that Analytics Engine has
no `match` and no `positionCaseInsensitive` — both return `unknown function
call` — so the chain uses `ILIKE`.

**EU visitors are absent entirely**, not undercounted. The Web Analytics site is
set to "Enable, excluding visitor data in the EU", so nobody in the EU is
beaconed and neither the numerator nor the denominator includes them.

### The ClickHouse plugin cannot draw a table

The Altinity plugin pivots any result containing a DateTime column into one
series per row, and returns **no frames at all** when the result has no numeric
column. Both are right for a graph and wrong for a table, and neither reports an
error -- the panel is simply empty, with `status: 200` and `frames: []`.

That is why "Recent clicks" showed nothing from the day it was written. It reads
the Analytics Engine SQL API through **Infinity** instead, which gives full
control over the shape:

```
url          .../accounts/__CF_ACCOUNT_ID__/analytics_engine/sql
method       POST, body_type raw, content type text/plain
body         the SQL, ending FORMAT JSON
root_selector  data
```

Two constraints on the SQL, both learned by trying:

- Analytics Engine has no `toString`. Its dialect is a subset.
- Comparing a DateTime to a string literal is rejected. Wrap the Grafana macro:
  `timestamp >= toDateTime('${__from:date:YYYY-MM-DD HH:mm:ss}')`, and that
  format exactly -- ISO with `T` and `Z` is refused.
- `ORDER BY` only works on a column that appears in the `SELECT`.

Infinity emits columns alphabetically whatever order you declare them in. The
column names in that panel are chosen so the alphabetical order reads correctly,
rather than being reordered afterwards with a transformation.

### The maths runs server-side, deliberately

The rate is a Grafana **expression** (`$A / $B`), not a transformation.

Transformations run in the browser, which means they cannot be tested from a
terminal — you change the JSON, reload the page, and squint. Expressions run in
the backend, so the whole chain can be checked with a request:

```bash
curl -s -u admin:$GRAFANA_ADMIN_PASSWORD -H 'Content-Type: application/json' \
  -X POST http://localhost:3000/api/ds/query --data @query.json
```

The first version of these panels used `joinByField` plus `calculateField` and
looked fine in the JSON while rendering nothing. Prefer expressions here.

Note that a query feeding an expression returns a field named after its refId,
not its column — the visits series arrives as `B`, not `visits` — so the panels
carry `displayName` overrides to relabel them.

### The account ID, and why a render step exists

`docker-compose.yml` has a `dashboard-render` service that copies
`dashboards/` into a volume, substituting `__CF_ACCOUNT_ID__`. Grafana reads
the rendered copy, so **edit `dashboards/` and restart** -- editing the volume
directly will be overwritten.

It exists because the RUM datasets are account-scoped and the account has to be
named inside the GraphQL body. Asking for `accounts` unfiltered returns "not
authorized for that account", since the token reads one account and the user
belongs to more. Neither tidy route works: Grafana interpolates `$VARS` in
provisioning YAML but not in dashboard JSON, and Infinity's global queries --
which would have carried the body from the provisioning file -- are resolved in
the browser, not by the backend parser these panels use. So the value has to
reach the JSON some other way, and `CF_ACCOUNT_ID` is kept out of git in both
repos.

### siteTag is not the beacon token

Two identifiers for the same site, and mixing them up produces an empty result
that reads like "no data":

| | |
| --- | --- |
| Beacon token, in page source | `2e7e343f80d04a2d9f9d49013c3c2d92` |
| GraphQL `siteTag`, for queries | `d6c7d92c76644885840437e3fdf3b867` |

The account holds other sites, so the `siteTag` filter is not optional.

## Things that will trip you up

- **Write raw SQL; ignore the query builder.** Analytics Engine supports
  `SELECT`, `SHOW TABLES` and little else — no `DESCRIBE`, no system tables —
  so the plugin cannot introspect columns to populate its dropdowns. Set
  *Column:DateTime* to `timestamp` and type the dataset name yourself.
- **Count with `SUM(_sample_interval)`, never `COUNT(*)`.** Analytics Engine
  samples under load and `_sample_interval` is how you weight rows back up.
- **`$timeFilter` and `$timeSeries`** are plugin macros for the dashboard's
  time range and its zoom-appropriate bucket. They only work once
  *Column:DateTime* is set.
- **No `JOIN` or `UNION`** — one dataset per query. Subqueries in `FROM` are
  fine.
- **Retention is three months**, rolling. This is a window, not an archive.
- **`/canary/` is not a visitor.** The monitoring workflow in the site repo
  (`.github/workflows/monitor.yml`) clicks the button itself once a day to
  prove the write path still works, and those rows would otherwise inflate
  every total. The three aggregate panels filter them out; **Recent clicks**
  deliberately does not, so the daily heartbeat stays visible in the raw feed.
- **Refresh is off by default, deliberately.** The free plan includes 10,000
  read queries a day and four panels on a 1-minute refresh would spend ~5,700
  of them watching a handful of clicks.
- **`unknown table booking_clicks`** is not a query bug — it means nothing has
  ever been written, which is exactly what ISS-29 is trying to find out.
- If the data source health check fails, the first thing to try is flipping
  `usePOST` to `false` in the provisioning file. Cloudflare's docs imply the
  default GET works; the POST body is what their curl examples use.
  (`usePOST: true` is verified working against the SQL API.)
- **`Invalid username or password` with the password from `.env`.** Grafana
  applies `GF_SECURITY_ADMIN_PASSWORD` when it first creates the admin user
  and stores it in the volume; changing the variable afterwards does not
  update what is stored. Reset it in place:

  ```bash
  docker exec hh-grafana grafana cli --homepath /usr/share/grafana \
    admin reset-admin-password admin
  ```
