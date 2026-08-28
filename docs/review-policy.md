# Repository review policy

Standard: review-standard-v2
Approval profile: peer-agents
Human owner: @thelarklan

This repository is the normative source for the standard it adopts. Routine
changes require two eligible non-author agent approvals. Changes to
`/.github/CODEOWNERS`, `/.github/workflows/`, the normative standard, its
distribution tooling, or trusted review and merge automation require approval
from `@thelarklan`.

## Current enforcement

The ruleset audit on 2026-08-28 found an active two-approval gate with stale
review dismissal, latest-push approval, resolved conversations, strict base
updates, squash-only merge, and the `bot-review-quorum` check. Code-owner review
is disabled. Repository auto-merge is enabled, but the trusted App has not yet
been granted the narrowly scoped pull-request write permission or deployed with
v2 auto-merge reconciliation. Human-only `CODEOWNERS` entries therefore request
review but do not yet gate merge, and automatic merging must remain unarmed.

The repository remains `Adopting`, not `Adopted`, until the owner enables
code-owner review, accepts the App permission update, and verifies both routine
and protected automatic-merge scenarios.

## Verification

Run:

```bash
bash scripts/verify.sh
git diff --check "$(git merge-base upstream/main HEAD)" HEAD
```

For documentation changes, manually confirm relative links and the rendered
pull-request template. For synchronization changes, run both update and check
mode against a disposable consumer fixture.

## Merge and cleanup

The `main protection` ruleset supplies the native review and status gates. Once
the v2 trusted App and code-owner rule are deployed and verified, the App arms
squash auto-merge and GitHub performs the merge. Routine changes require no
human action. Protected changes stop for `@thelarklan` approval and then merge
without a separate human merge action. Agents never use administrator bypass or
merge directly.

Delete the reviewed feature branch after merge and confirm the fork default
branch matches upstream.

## Exceptions

- Rule: protected and high-risk paths require approval from the human owner.
- Temporary exception: the active ruleset does not require code-owner review,
  and v2 App auto-merge reconciliation is not deployed.
- Justification: the enforcement setting remains to be enabled during initial
  standard adoption.
- Compensating control: automatic merge remains unarmed; protected-path pull
  requests remain agent-authored for eligible human review; the human owner
  performs the temporary deliberate merge; agents never merge or bypass rules.
- Owner: `@thelarklan`.
- Review date: 2026-09-04.

### Personal-repository reviewer-identity limitation

- Rule: only the rotating two configured non-author agents satisfy the peer
  quorum at the exact current head.
- Limitation: a personal repository cannot synchronously bind native approval
  slots to those accounts; App event processing and reconciliation are not an
  atomic GitHub review rule.
- Compensating control: the App re-reads the exact head and complete decisive
  review state immediately before arming auto-merge, publishes a required
  head-pinned check, revokes success and disables auto-merge when quorum is
  lost, and has no contents-write, administration, or direct-merge permission.
- Owner: `@thelarklan`.
- Review date: 2026-11-28.

The sole human code owner cannot approve their own guardrail change. Until
another human owner exists, a guardrail pull request must be agent-authored so
`@thelarklan` remains eligible to approve it.
