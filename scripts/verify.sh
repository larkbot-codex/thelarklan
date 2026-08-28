#!/usr/bin/env bash
set -euo pipefail

project_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
cd -- "$project_dir"

cmp -- templates/pull_request_template.md .github/pull_request_template.md
bash scripts/sync-review-standard.sh --check .
shellcheck scripts/*.sh test/*.sh

for test_script in test/*.sh; do
    bash "$test_script"
done
