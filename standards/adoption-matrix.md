# Review-standard adoption matrix

This matrix tracks declared adoption, not inferred compliance. Enforcement was
audited through the GitHub ruleset API on 2026-08-28 and must be verified again
during each adoption pull request and periodically afterward.

| Repository | Standard | Approval profile | Enforcement | Exceptions | State |
| --- | --- | --- | --- | --- | --- |
| `thelarklan/thelarklan` | `review-standard-v1` | `peer-agents` | User-owned; two approvals, code-owner review, latest-push approval; maintainer merge | Sole human owner must not author a human-only guardrail PR | Adopting via PR #4 |
| `thelarklan/dev-tools` | `review-standard-v1` | `peer-agents` | User-owned; two approvals and trusted check; code-owner review and Jenkins ruleset checks still required; maintainer merge | Squash merge and `pr-cleanup` | Pilot via PR #23 |
| `thelarklan/wsl-tools` | Not adopted | Not declared | User-owned; two approvals, trusted check, and three CI contexts; code-owner review disabled | None recorded | Wave 2 planned |
| `thelarklan/podman-tools` | Not adopted | Not declared | User-owned; two approvals and trusted check; code-owner review disabled; no repository CI required | None recorded | Wave 2 planned |
| `thelarklan/jenkins-controller` | Not adopted | Not declared | User-owned; two approvals and trusted check; code-owner review disabled; no repository CI required | Infrastructure risk requires a repository-specific audit | Wave 3 planned |
| `thelarklan/lol` | Not adopted | Not declared | User-owned; two approvals and trusted check; code-owner review disabled; no repository CI required | Repository scope and verification surface require classification | Wave 4 planned |

Add repositories only through an adoption pull request. Change `State` to
`Adopted` only after the local declaration, managed template, verification,
ownership, and merge protections have been checked at the merged head.

## Incremental rollout

1. Merge and tag the canonical standard, then complete the `dev-tools` pilot.
2. Adopt in `wsl-tools` and `podman-tools`, reusing the tooling-oriented policy
   while keeping PowerShell, container, and platform verification local.
3. Audit and adopt in `jenkins-controller` after defining human-only deployment,
   credential, and controller-configuration paths plus reliable CI contexts.
4. Classify the `lol` repository's purpose and verification surface before
   selecting an approval profile or copying managed files.

Each wave uses one focused adoption pull request per repository. A repository
does not advance to `Adopted` while a required status context is absent,
code-owner enforcement is disabled, or a recorded exception lacks an owner and
review date.
