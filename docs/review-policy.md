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
review dismissal. Its protected automatic path is not active until the
dedicated-team rule and trusted quorum check required by the standard are
deployed and verified. Until then, the human owner merges deliberately. Agents
never use administrator bypass or merge directly.

Delete the reviewed feature branch after merge and confirm the fork default
branch matches upstream.

## Exceptions

If the sole human code owner authors a guardrail change, the human code-owner
requirement cannot be satisfied normally. Until a second eligible human owner
exists, a deliberate administrator bypass is the documented exception for this
source repository only. The pull request must record the reason, exact head,
verification evidence, and compensating peer review. Agents never exercise the
bypass.
