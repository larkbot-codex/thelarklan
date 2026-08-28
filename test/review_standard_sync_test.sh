#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
test_dir=$(mktemp -d)
trap 'rm -rf -- "$test_dir"' EXIT

consumer=$test_dir/consumer
mkdir -p -- "$consumer/.github" "$consumer/docs"
cp -- "$project_dir/docs/review-policy.md" "$consumer/docs/review-policy.md"
cp -- "$project_dir/.github/CODEOWNERS" "$consumer/.github/CODEOWNERS"

bash "$project_dir/scripts/sync-review-standard.sh" "$consumer"
cmp -- "$project_dir/templates/pull_request_template.md" "$consumer/.github/pull_request_template.md"
bash "$project_dir/scripts/sync-review-standard.sh" --check "$consumer"

printf '\n<!-- drift -->\n' >>"$consumer/.github/pull_request_template.md"
if bash "$project_dir/scripts/sync-review-standard.sh" --check "$consumer" 2>"$test_dir/drift-error"; then
    printf 'check mode accepted a modified managed template\n' >&2
    exit 1
fi
grep -Fq 'template is out of date' "$test_dir/drift-error"

sed -i 's/Approval profile: peer-agents/Approval profile: invalid/' "$consumer/docs/review-policy.md"
if bash "$project_dir/scripts/sync-review-standard.sh" "$consumer" 2>"$test_dir/profile-error"; then
    printf 'sync accepted an invalid approval profile\n' >&2
    exit 1
fi
grep -Fq 'no valid approval profile' "$test_dir/profile-error"

printf 'review standard synchronization tests passed\n'
