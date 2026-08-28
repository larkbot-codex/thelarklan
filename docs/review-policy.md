# Repository review policy

Standard: review-standard-v1
Approval profile: peer-agents
Human owner: @thelarklan

This repository is the normative source for the standard it adopts. Routine
changes require two eligible non-author agent approvals. Changes to
`/.github/CODEOWNERS`, `/.github/workflows/`, or the normative standard and its
distribution tooling require approval from `@thelarklan`.

## Current enforcement

The ruleset audit on 2026-08-28 found an active two-approval gate with stale
review dismissal, latest-push approval, resolved conversations, strict base
updates, squash-only merge, and the `bot-review-quorum` check. Code-owner review
is disabled, so the human-only `CODEOWNERS` entries request review but do not
currently gate merge.

The repository remains `Adopting`, not `Adopted`, until the maintainer enables
code-owner review and verifies it against a protected-path pull request.

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

The `main protection` ruleset supplies the routine two-approval gate and stale
review dismissal. This repository is user-owned, so its protected automatic
path is ineligible until organization ownership, a dedicated-team rule, and the
trusted quorum check required by the standard are deployed and verified. Until
then, the human owner merges deliberately. Agents never use administrator
bypass or merge directly.

Delete the reviewed feature branch after merge and confirm the fork default
branch matches upstream.

## Exceptions

- Rule: protected and high-risk paths require approval from the human owner.
- Temporary exception: the active ruleset does not require code-owner review.
- Justification: the enforcement setting remains to be enabled during initial
  standard adoption.
- Compensating control: protected-path pull requests remain agent-authored for
  eligible human review; the human owner performs the deliberate merge; agents
  never merge or use administrator bypass.
- Owner: `@thelarklan`.
- Review date: 2026-09-04.

The sole human code owner cannot approve their own guardrail change. Until
another human owner exists, a guardrail pull request must be agent-authored so
`@thelarklan` remains eligible to approve it.
