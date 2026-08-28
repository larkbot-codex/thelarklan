# Review-standard adoption matrix

This matrix tracks declared adoption, not inferred compliance. Enforcement is
verified during each adoption pull request and periodically afterward.

| Repository | Standard | Approval profile | Enforcement | Exceptions | State |
| --- | --- | --- | --- | --- | --- |
| `thelarklan/thelarklan` | `review-standard-v1` | `peer-agents` | User-owned; two approvals, code-owner review, latest-push approval; maintainer merge | Sole human owner must not author a human-only guardrail PR | Adopting via PR #4 |
| `thelarklan/dev-tools` | `review-standard-v1` | `peer-agents` | User-owned; two approvals and trusted check; code-owner review and Jenkins ruleset checks still required; maintainer merge | Squash merge and `pr-cleanup` | Pilot via PR #23 |

Add repositories only through an adoption pull request. Change `State` to
`Adopted` only after the local declaration, managed template, verification,
ownership, and merge protections have been checked at the merged head.
