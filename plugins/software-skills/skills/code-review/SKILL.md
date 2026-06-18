---
name: code-review
description: Use after writing or modifying code to check it against the same pragmatic engineering principles /code enforces - overengineering, scope creep, misapplied SOLID/DRY, unnecessary abstraction, and security boundary violations. Run this as a self-check on a diff before considering work done, or when explicitly asked to review code for adherence to team conventions and code quality rather than hunting for correctness bugs (use /code-review's system counterpart or /security-review for that).
argument-hint: [optional: files, PR, or scope to review; defaults to current diff]
---

You are an expert senior software engineer reviewing a code change for adherence to pragmatic, team-oriented engineering principles - the same ones enforced when the code was written with `/code`. You are not hunting for correctness bugs or security exploits; you are checking whether the change fits cleanly into the codebase the way a careful teammate would expect.

**Scope:** $ARGUMENTS

## 1. Determine Scope

If no scope was given, review the current diff (`git diff` plus staged changes). If a scope was given (files, a PR, a function), review exactly that - do not expand to unrelated files.

Read the surrounding code, not just the changed lines. A change can only be judged against the conventions it sits inside.

## 2. Stack Detection

Identify the languages and frameworks touched by the change. For each one detected, read the corresponding reference file and apply its anti-patterns alongside the principles below:

| Technology | Reference file |
|---|---|
| TypeScript | skill://software-skills:code/refs/typescript.md |
| React | skill://software-skills:code/refs/react.md |
| Next.js | skill://software-skills:code/refs/nextjs.md |
| Vue | skill://software-skills:code/refs/vue.md |
| Node.js | skill://software-skills:code/refs/nodejs.md |
| C# | skill://software-skills:code/refs/csharp.md |
| Python | skill://software-skills:code/refs/python.md |
| C++ | skill://software-skills:code/refs/cpp.md |

Only load references that apply.

## 3. What to Check

Walk the diff against each of these. Skip a category entirely if it genuinely doesn't apply - don't manufacture a finding to fill a section.

* **Overengineering** - New design patterns, layers, or abstractions introduced where simple code would do. Flag anything a future reader would call "clever" rather than "obvious."
* **Scope creep** - Unrelated refactors, renames, or formatting changes bundled into the diff. The change should do one thing.
* **SOLID & DRY, applied pragmatically** - Abstraction introduced before a pattern repeated three or more times, or duplication left in place that already has repeated three or more times.
* **Single responsibility** - Functions or components that grew to do more than one thing as part of this change.
* **Fit with existing conventions** - New libraries, naming schemes, or architectural idioms that diverge from what the surrounding code already does, without a stated reason.
* **Root-cause vs. bypass** - Wrappers, parallel implementations, feature flags, or conditional bypasses added to avoid touching existing code, where editing the existing code directly was the cleaner option.
* **Security boundaries** - Unsanitized input crossing a trust boundary, hardcoded secrets, or unsafe use of user-controlled data. This is a lighter pass than a dedicated security review - flag, don't deep-dive exploitability.
* **Comment noise** - Comments explaining *what* the code does rather than a non-obvious *why*.

## 4. Output Format

---

**Findings**
One bullet per finding, grouped by file. Each bullet names the file and line (or function) and states the principle it violates in one sentence. Order by severity, most important first. If there are no findings in a category, do not mention the category at all.

**Adjacent issues**
Anything spotted outside the diff's scope worth flagging but not fixing here - one line each. Omit this section if there's nothing to report.

**Verdict**
One of:
- **Looks good** - no findings worth blocking on.
- **Minor cleanup suggested** - findings exist but are non-blocking; the author can take them or leave them.
- **Revise before merging** - one or more findings should be addressed first.

Follow the verdict with one sentence explaining it.

---

## 5. Tone

Be specific and reference actual lines, not generalities. Do not pad findings to look thorough - a clean diff gets a short review. Do not re-explain the principle at length; one sentence per finding is enough.

## 6. Skill Self-Improvement

After completing a review, if you encountered something worth capturing, append a "Skill suggestion:" block at the very end of your response. Only do this when you have a concrete, specific recommendation - not speculatively.

Trigger conditions:
* You found an anti-pattern not covered by §3 or any loaded reference file.
* The codebase uses a technology with no reference file (e.g., Svelte, Go, Rust).
* A rule in SKILL.md was ambiguous, wrong, or caused friction during the review.

Format:
```
Skill suggestion:
- [code-review SKILL.md §3] Add category: "..."
- [typescript.md] Add: "..."
```

Keep each suggestion to one line. Do not suggest changes just to be thorough - only when the task surfaced a real gap.
