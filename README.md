# ac_demo

A simple Rails app demonstrating **per-PR acceptance criteria run in CI**.

Each pull request carries its acceptance criteria in `acceptance/spec.yml`. On
every PR, `bin/acceptance` runs the test mapped to each *testable* criterion,
flags *fuzzy* ones for judged review, posts a per-criterion comment, and **fails
the check — blocking the PR — if any testable criterion is unmet.**

## Run locally

```bash
bin/rails db:test:prepare
bin/acceptance
```

## How it works

- `acceptance/spec.yml` — the criteria for this request (text + `kind` + the test each maps to)
- `bin/acceptance` — runs them, prints a per-criterion table, writes `acceptance-result.json`, exits non-zero if any testable criterion fails
- `.github/workflows/acceptance.yml` — runs the above on every PR and posts the results comment

The app under test is `GET /api/invoices/export` (token auth, CSV, scoped to the
caller) — see `app/controllers/invoices_controller.rb`.
