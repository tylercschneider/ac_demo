# ac_demo

A simple Rails app demonstrating **acceptance criteria that live in the request
ticket (a GitHub Issue) and run in CI per PR** — no test files committed per PR.

A feature PR carries only a pointer (`.acceptance.yml` → `issue: N`). On every
PR, `bin/acceptance` fetches that issue, runs its declarative checks plus the
tier's finish-level checks against the booted app, posts a per-check comment,
and **fails — blocking the PR — if any check is unmet.**

## The three layers

1. **Base CI** — the repo's own `bin/rails test` (a separate job).
2. **Finish level** — `finish/T1|T2|T3.yml`, reusable per-tier checks, selected by the request's tier.
3. **Acceptance** — fetched from the request **issue's** ` ```acceptance ` block (tier + checks). Not in the repo.

## Where the criteria live (the ticket)

The request issue body holds them as declarative checks — an HTTP request + expectations the runner interprets, so nothing is hand-written as a test:

````md
```acceptance
tier: T2
checks:
  - id: ac-4
    text: "Returns 401 when no valid auth token is provided"
    request: { method: GET, path: /api/invoices/export }
    expect: { status: 401 }
```
````

## Run locally

```bash
RAILS_ENV=test bin/rails db:test:prepare
RAILS_ENV=test bin/rails db:seed
bin/acceptance          # uses your gh auth to read the issue
```

## How it fits

- `.acceptance.yml` — the PR's pointer to the request issue (and that's all it adds)
- `bin/acceptance` — fetches the issue via `gh`, boots Rails in-process, runs finish + acceptance checks, writes `acceptance-result.json`, exits non-zero on any unmet check
- `.github/workflows/acceptance.yml` — base job + finish/acceptance job; posts the results comment

The app under test is `GET /api/invoices/export` (token auth, CSV, scoped to the
caller). The repo also provides the **harness** the checks run against:
`db/seeds.rb` + the known test tokens.
