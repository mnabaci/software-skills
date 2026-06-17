#!/bin/bash
# Deterministic replacement for the /route skill's model-tier check. The skill
# relied on the model choosing to self-trigger a meta check before diving into
# a task, which it almost never did in practice. This runs unconditionally on
# every prompt instead, using a keyword/length heuristic (cheap, no LLM call)
# to classify the prompt and compare it against the model cached at
# SessionStart by route-session-start.sh.
#
# Each rule below requires a high-confidence signal on one side specifically
# to avoid nagging: e.g. a Sonnet/Opus session is never flagged down just
# because a prompt didn't happen to match a "complex" keyword -- only a
# clearly trivial, short prompt triggers a downgrade suggestion. Fires at
# most once per session so it nudges rather than repeats itself every turn.
set -euo pipefail

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
session_id=$(echo "$input" | jq -r '.session_id // empty')
prompt=$(echo "$input" | jq -r '.prompt // empty')

[ -z "$session_id" ] && exit 0

cache_file="/tmp/claude-route-hook/$session_id.json"
[ -f "$cache_file" ] || exit 0

model=$(jq -r '.model // empty' "$cache_file")
fired=$(jq -r '.fired // false' "$cache_file")

[ -z "$model" ] && exit 0
[ "$fired" = "true" ] && exit 0
[ -z "$prompt" ] && exit 0

lower_model=$(echo "$model" | tr '[:upper:]' '[:lower:]')
tier=""
case "$lower_model" in
  *opus*) tier="opus" ;;
  *fable*) tier="opus" ;;
  *sonnet*) tier="sonnet" ;;
  *haiku*) tier="haiku" ;;
  *) exit 0 ;;
esac

lower_prompt=$(echo "$prompt" | tr '[:upper:]' '[:lower:]')
word_count=$(echo "$prompt" | wc -w | tr -d ' ')

is_complex=0
if echo "$lower_prompt" | grep -Eq 'security (audit|review)|threat model|architecture (decision|review|redesign)|design system|migration plan|deep dive|deep-dive|across (many|multiple|[4-9][0-9]*|[1-9][0-9]+) files|refactor.*entire|redesign|compliance (audit|review)|trade-?offs|root cause.*production|incident (review|postmortem)|post-?mortem'; then
  is_complex=1
fi

is_trivial=0
if [ "$word_count" -le 14 ] && echo "$lower_prompt" | grep -Eq '^(what is|what.s|what does|how do i|how to|explain|quick question|just (a )?question|fix (the )?typo|rename (the )?variable|one-line|single-line|format this)'; then
  is_trivial=1
fi

rule=""
if [ "$is_complex" -eq 1 ] && { [ "$tier" = "haiku" ] || [ "$tier" = "sonnet" ]; }; then
  rule="up_opus"
elif [ "$is_trivial" -eq 1 ] && [ "$tier" = "opus" ]; then
  rule="down_sonnet"
elif [ "$is_complex" -eq 0 ] && [ "$is_trivial" -eq 0 ] && [ "$tier" = "haiku" ]; then
  rule="up_sonnet"
fi

[ -z "$rule" ] && exit 0

case "$rule" in
  up_opus) msg="Model suggestion: complex/architecture-level task → consider switching to Opus with /model opus." ;;
  down_sonnet) msg="Model suggestion: quick/trivial request → consider switching to Sonnet with /model sonnet." ;;
  up_sonnet) msg="Model suggestion: standard dev work on Haiku → consider switching to Sonnet with /model sonnet." ;;
esac

jq -n --arg model "$model" '{model: $model, fired: true}' > "$cache_file"
jq -n --arg msg "$msg" '{systemMessage: $msg}'

exit 0
