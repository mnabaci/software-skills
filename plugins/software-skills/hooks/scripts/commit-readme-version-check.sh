#!/bin/bash
# Soft reminder before `git commit`: if the staged change looks feature-shaped
# (new files, or a sizeable diff) and the repo has a README plus a recognizable
# version file, but neither is staged, nudge Claude to consider updating them.
#
# Deliberately a pure shell heuristic with no LLM call, so it can run on every
# commit without burning tokens. It can't judge *whether* a bump is warranted
# (that's a semantic call) - it only flags "this looks worth a second look"
# and lets Claude, which already holds the full diff in context, decide.
set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
tool_name=$(echo "$input" | jq -r '.tool_name // empty')
[ "$tool_name" = "Bash" ] || exit 0

command_str=$(echo "$input" | jq -r '.tool_input.command // empty')
[ -n "$command_str" ] || exit 0
echo "$command_str" | grep -Eq '(^|[;&|]\s*)git\s+commit\b' || exit 0

cwd=$(echo "$input" | jq -r '.cwd // empty')
[ -n "$cwd" ] && cd "$cwd" 2>/dev/null

repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0
cd "$repo_root"

readme=$(find . -maxdepth 1 -iname 'README*' | head -1)
[ -n "$readme" ] || exit 0
readme_rel=${readme#./}

version_file=""
for candidate in package.json pyproject.toml Cargo.toml composer.json VERSION version.txt; do
  if [ -f "$candidate" ]; then
    version_file="$candidate"
    break
  fi
done
if [ -z "$version_file" ]; then
  version_file=$(find . -maxdepth 4 -path '*.claude-plugin/plugin.json' 2>/dev/null | head -1)
  version_file=${version_file#./}
fi
[ -n "$version_file" ] || exit 0

staged=$(git diff --cached --name-only 2>/dev/null) || exit 0
[ -n "$staged" ] || exit 0

readme_staged=0
echo "$staged" | grep -qiF "$readme_rel" && readme_staged=1

version_staged=0
echo "$staged" | grep -qiF "$version_file" && version_staged=1

# Already touching both - nothing to remind about.
[ "$readme_staged" -eq 1 ] && [ "$version_staged" -eq 1 ] && exit 0

new_files=$(git diff --cached --name-status 2>/dev/null | grep -c '^A' || true)
total_files=$(echo "$staged" | grep -c . || true)
insertions=$(git diff --cached --shortstat 2>/dev/null | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+' || true)
insertions=${insertions:-0}

substantive=0
if [ "$new_files" -ge 1 ] || [ "$total_files" -ge 3 ] || [ "$insertions" -ge 30 ]; then
  substantive=1
fi
[ "$substantive" -eq 1 ] || exit 0

missing=""
if [ "$readme_staged" -eq 0 ] && [ "$version_staged" -eq 0 ]; then
  missing="$readme_rel and $version_file"
elif [ "$readme_staged" -eq 0 ]; then
  missing="$readme_rel"
else
  missing="$version_file"
fi

msg="Reminder: this commit touches $total_files file(s) ($new_files new) but doesn't update $missing. If this is a real feature/behavior change, consider bumping the version and/or noting it in the README before committing - use your judgment, not every commit needs this."

jq -n --arg msg "$msg" '{hookSpecificOutput: {permissionDecision: "allow"}, systemMessage: $msg}'
exit 0
