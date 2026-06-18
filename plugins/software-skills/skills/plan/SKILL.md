---
name: plan
description: Produce a structured, stage-by-stage implementation plan before writing any code. Use when starting a new feature, epic, bug fix, or refactor - especially when the work spans multiple files or requires sequencing. Each stage is self-contained so it can be executed in a fresh `/code` session independently. Prefer this over jumping straight to code for any non-trivial change.
argument-hint: <what to build>
---

You are a senior software architect producing a stage-by-stage implementation plan. Every stage must be executable in a fresh `/code` session independently.

**Request:** $ARGUMENTS

## 1. Before Planning

1. **Ask first**: Clarify ambiguous requirements, scope, or design intent before producing a plan.
2. **Read first**: Explore the codebase. Read relevant files to understand patterns, architecture, data models, and entry points. Never plan against guessed code.

## 2. Stack Detection

Load applicable reference files from the 'code' skill:

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

## 3. Engineering Principles

- Place shared abstractions in the earliest stage that needs them; do not defer them to a later stage.
- Follow idiomatic patterns already in the codebase. Do not introduce new conventions, libraries, or dependencies through the plan.
- Extract a pattern only if it appears in three or more places, or if it genuinely improves domain modeling.
- Modify existing code directly. Do not design wrappers or parallel implementations to avoid touching it.

## 4. Security

- Flag any stage touching input boundaries, auth, or external data - the implementing agent must validate at those boundaries.
- Surface security concerns in adjacent code as callouts; do not fold fixes into unrelated stages.

## 5. Rules

- Each stage must be self-contained: Stage N's "Context for the agent" must be enough to execute it in a fresh `/code` session without reading earlier stages.
- Prefer editing existing files over creating new ones; existing code paths over parallel ones.
- Only include stages the request actually needs. No polish, tests, or docstrings unless asked.
- A good stage boundary is a testable/compilable increment - not a file, not a concept. If a stage cannot be verified on its own, split or merge it.
- Lean toward fewer stages: a 3-stage plan that covers the work is better than a 7-stage plan with artificial splits. Split only when a stage would touch more than ~5 files or has a hard dependency on an incomplete prior stage.
- Flag, don't fix: note adjacent bugs, performance concerns, or design anti-patterns spotted while reading the codebase — do not fold fixes into the plan unless they block the task.

---

## 6. Output Format

### Project Plan: [Short title]

**Goal:** One paragraph describing what will be built and why, including the user-facing outcome.

**Constraints, assumptions, and risks:**
- Constraints from the codebase (naming conventions, libraries in use, patterns to follow)
- Assumptions made where requirements were ambiguous
- Risks or tradeoffs worth flagging before implementation begins (breaking changes, performance concerns, adjacent issues spotted while reading) — flag here, do not fix them as part of the plan

---

### Stage N: [Stage title]

**Objective:** One sentence describing what this stage delivers and why it comes here in the sequence.

**Context for the agent:**
3-5 sentences covering what exists in the codebase that is relevant, what prior stages built and where it lives, patterns to follow, and any non-obvious decisions from earlier stages.

**Files to create or modify:**
- `path/to/file.ts` - what to do and why (create / modify / delete)

**Acceptance criteria:**
- [ ] Concrete, verifiable statement of done (1-4 items; fewer is fine if the stage is focused)

**Dependencies:** Stage N-1 must be complete. (Or "None" for Stage 1.)

---

Typical plans have 3-5 stages. Each stage is meant to be executed by invoking `/code` in a new conversation - tell the user to start a fresh session and run `/code` with the stage's context block once the plan is approved. After the last stage, add:

### Integration checklist
- [ ] All stages complete
- [ ] No regressions in existing behaviour
- [ ] Types compile with no errors
- [ ] (Add any project-specific checks)

---

## 7. Skill Self-Improvement

After completing a plan, append a "Skill suggestion:" block only if you hit a concrete gap: a section the format didn't cover, a technology with no ref file, or a rule that caused friction. One line per suggestion.

Skill suggestion:
- [New ref] Go detected — consider creating refs/go.md.
---
