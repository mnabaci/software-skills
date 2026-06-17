#!/bin/bash
# Caches the active model for this session so route-prompt-check.sh can compare
# against it deterministically. SessionStart's "model" field is optional and
# absent after /clear or conversation recovery -- in that case we cache an
# empty model and the prompt-check script skips silently, matching the
# fallback behavior of the skill this replaces.
set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // empty')
model=$(echo "$input" | jq -r '.model // empty')

[ -z "$session_id" ] && exit 0

cache_dir="/tmp/claude-route-hook"
mkdir -p "$cache_dir"
jq -n --arg model "$model" '{model: $model, fired: false}' > "$cache_dir/$session_id.json"

exit 0
