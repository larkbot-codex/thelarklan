# Review standard v1

Status: normative
Identifier: `review-standard-v1`

This is the common review contract for repositories under `thelarklan`. A
consumer repository implements it through the adoption contract and documents
only repository-specific verification, ownership, extensions, and exceptions.

## Roles and approval profiles

Every pull request has a submitter, one or more independent reviewers, and a
human maintainer responsible for protected paths and exceptional merges. The
submitter never approves their own pull request.

Each repository declares one routine-change approval profile:

- `peer-agents`: at least two eligible non-author agent code owners approve the
  exact current head. Agent reviews are authoritative under the shared review
  contract, but this profile alone does not authorize automatic merge.
- `human`: at least one eligible non-author human code owner approves.

Automation that does not submit a formal review under an eligible reviewer
principal is advisory and cannot satisfy either profile. The trusted quorum App
supplies evidence only: it has no merge authority, never executes pull-request
code, and cannot substitute its check for either native approval.

Protected and explicitly high-risk paths always require approval from the human
owner, regardless of the routine profile. At minimum these include ownership,
review enforcement, CI workflow, credential, and deployment-control files.

If the sole human owner authors a protected-path change, the code-owner gate has
no eligible reviewer. The repository must require an agent to author that
change for human review, add another human owner, or explicitly document an
auditable administrator-bypass exception. Agents never exercise that bypass.

## Pull-request lifecycle

1. Start from the current upstream default branch and use a focused feature
   branch. One pull request introduces one independently useful change.
2. Open as a draft with the canonical pull-request template. Complete every
   applicable evidence section; use `Not applicable` with a reason rather than
   deleting a required section.
3. Keep behavior, user guidance, tests, and CI contracts aligned.
4. Run all repository-required tree and PR-diff checks at the exact head offered
   for review. Record the base revision, head revision, environment, commands,
   and observed results.
5. Mark ready only when available required checks pass and manual verification
   is complete. A missing required environment keeps the pull request in draft
   unless a maintainer explicitly accepts the recorded limitation.
6. Any new commit or history rewrite invalidates earlier evidence and approval.
   Rerun checks, update the recorded head, and obtain approval of the latest
   reviewable push.

## Review method and findings

Reviewers make three distinct passes:

1. **Intent and scope:** the change solves the stated problem, remains focused,
   and identifies deferred behavior.
2. **Correctness and risk:** behavior, failure and recovery paths, security,
   compatibility, destructive operations, and negative tests are sound.
3. **Standards and maintenance:** repository conventions, documentation,
   portability, operability, and test coverage remain aligned.

Findings use these severities:

- `blocker`: unsafe or incorrect; must be fixed before approval.
- `warning`: material risk or maintainability defect; must be fixed or
  explicitly accepted by a maintainer before approval.
- `suggestion`: worthwhile improvement that is not required for this change.
- `nit`: optional local polish.

Each blocking finding states the consequence and evidence. The reviewer who
opened a blocking thread resolves it or confirms the response; authors do not
self-resolve blocking review findings merely because code changed.

## Merge gate

The default branch is protected by a ruleset that:

- requires pull requests and the repository's declared approval count; for
  `peer-agents`, this is two approvals from the dedicated three-agent team;
- requires code-owner approval and approval of the latest reviewable push;
- dismisses stale approvals when commits change;
- requires all available mandatory status checks;
- blocks force pushes and branch deletion; and
- blocks agents, repository helpers, and the quorum App from bypassing or
  directly merging.

For `peer-agents`, protected automatic merge is a separate, stricter path. It
requires an organization-owned repository; a dedicated team containing exactly
three agent accounts; two native, team-scoped approvals; and a successful
head-pinned trusted quorum check. Its ruleset has no bypass actors. GitHub, not
an agent or repository helper, performs the merge after the complete gate is
satisfied. A user-owned repository or any repository missing one prerequisite
remains on its documented maintainer path.
Nobody approves or directly merges their own pull request. After merge,
repository-specific cleanup must remove only the verified feature branch and
synchronize the local and fork default branches.

## Local adoption and exceptions

The consumer adoption file is authoritative for local commands and ownership;
this document remains authoritative for common intent. Exceptions must identify
the exact rule, justification, compensating control, owner, and review date.
Silence is not an exception.

Changes to normative behavior create a new standard version. Editorial fixes
may update this document without changing its identifier.
