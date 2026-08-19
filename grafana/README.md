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
