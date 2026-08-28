# Repository review policy

Standard: review-standard-v1
Approval profile: peer-agents
Human owner: @thelarklan

This repository is the normative source for the standard it adopts. Routine
changes require two eligible non-author agent approvals. Changes to
`/.github/CODEOWNERS`, `/.github/workflows/`, or the normative standard and its
distribution tooling require approval from `@thelarklan`.

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

The sole human code owner cannot approve their own guardrail change, and the
active ruleset has no working bypass. Until another human owner exists, a
guardrail pull request must be agent-authored so `@thelarklan` remains eligible
to approve it. No exception authorizes an agent bypass.
