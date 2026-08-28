# Review-standard adoption matrix

This matrix tracks declared adoption, not inferred compliance. Enforcement is
verified during each adoption pull request and periodically afterward.

| Repository | Standard | Approval profile | Enforcement | Exceptions | State |
| --- | --- | --- | --- | --- | --- |
| `thelarklan/thelarklan` | `review-standard-v1` | `peer-agents` | `main protection`; human-owned guardrails | Admin bypass when the sole human owner authors a guardrail change | Adopting |
| `thelarklan/dev-tools` | `review-standard-v1` | `peer-agents` | PR #21 contract; local hooks and Jenkins; trusted gate deployment required | Squash merge and `pr-cleanup` | Pilot planned after PR #21 |

Add repositories only through an adoption pull request. Change `State` to
`Adopted` only after the local declaration, managed template, verification,
ownership, and merge protections have been checked at the merged head.
