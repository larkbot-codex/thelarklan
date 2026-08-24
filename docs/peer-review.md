# Peer review between agent accounts

This repository is set up so that AI agent accounts open pull requests,
review each other's work, and merge automatically once approvals land. A
human stays in the loop only where it matters.

This document describes how that arrangement works, what each piece is
actually doing, and where the sharp edges are.

## The participants

| Account          | Role  | Part it plays                                    |
| ---------------- | ----- | ------------------------------------------------ |
| `@thelarklan`    | Admin | Human owner. Sole owner of the guardrail paths.  |
| `@thelarkbot`    | Write | Agent. Opens PRs, reviews the others'.           |
| `@thelarkdoodle` | Write | Agent. Opens PRs, reviews the others'.           |

The agents hold **Write**, deliberately not Admin. Admin would let an agent
edit the ruleset described below and remove its own constraints.

A third agent account is planned but does not exist yet. Adding it means a
pull request against `.github/CODEOWNERS`, which is a guardrail path — so
it needs human approval. Agents cannot onboard each other.

## How reviewers get chosen

`.github/CODEOWNERS` lists all three accounts as owners of everything:

```
*                       @thelarkbot @thelarkdoodle @thelarklan
```

The mechanism that turns this into *peer* review is a GitHub rule that is
easy to miss: **GitHub never requests a review from the author of a pull
request.** Whoever opens the PR drops out of the owner list automatically,
and review is requested from the remaining owners. No routing logic, no
assignment step — the author excludes themselves by writing the PR.

Two conditions have to hold or this silently does nothing:

- CODEOWNERS is read **only from the default branch**. If the default
  branch is not the branch carrying this file, no review is ever requested.
- An owner must have **write access**. An entry naming an account without
  it is ignored with no error and no warning — a pending collaborator
  invitation looks identical to a working setup until you notice reviews
  are never requested.

## The guardrail paths

Two paths override the global rule (last match wins) and are owned by the
human alone:

```
/.github/workflows/     @thelarklan
/.github/CODEOWNERS     @thelarklan
```

These are the paths that control the merge gate itself. CI defines what
"passing" means; CODEOWNERS defines who gets to approve. An agent that
could change either could widen its own permissions in a single PR — and
with auto-merge enabled, do it without anyone watching. Keeping them
human-owned means that particular move always stops for a person.

## The merge gate

A branch ruleset named `main protection` targets the default branch:

- Require a pull request before merging
  - 2 required approvals
  - Dismiss stale approvals when new commits are pushed
  - Require review from Code Owners
  - Require approval of the most recent reviewable push
- Restrict deletions
- Block force pushes
- Bypass: Repository admin

Status checks are **not** required, because no CI exists yet. When CI is
added, that rule should be turned on — and note that adding it means
touching `/.github/workflows/`, a guardrail path.

"Dismiss stale approvals" and "require approval of the most recent
reviewable push" exist together for a reason: without them, an agent could
collect approvals on a harmless diff and then push something else before
the merge fires.

Combined with auto-merge, the normal path for an agent PR is: open it,
collect two approvals, merge with no human involved.

## Known sharp edges

**A guardrail PR opened by the human has no eligible approver.** On
`/.github/workflows/` or `/.github/CODEOWNERS`, `@thelarklan` is the only
code owner — and is excluded as the author. "Require review from Code
Owners" cannot be satisfied by any normal route. Such a PR merges only via
admin bypass. This is a consequence of author-exclusion meeting a
single-owner path, not a misconfiguration, but it does mean every change to
CI or ownership is a deliberate bypass.

**Two approvals out of three accounts is a tight quorum.** Any PR the human
opens needs *both* agents to review it. If one agent is idle, the PR
stalls. If routine bypassing starts happening, the required-approval count
is too high for a repository this size, and 1 is the honest number.

**Admin bypass is always available.** The human can merge anything. The
ruleset is a guardrail against unattended agent behaviour, not a lock
against the owner. Bypasses are recorded, which is most of their value —
they should stay rare enough to be worth reading.

**Write access without the ruleset is worse than no setup.** Collaborators
should be added only once the ruleset is active. In the window between the
two, an agent can push straight to the default branch and skip review
entirely.
