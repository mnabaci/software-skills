# Software Skills Marketplace

A curated collection of Claude Code skills for software engineering, planning, and critical thinking. Created by Mehmet Abaci.

## 🚀 Quick Start

Add this marketplace to Claude Code:

```bash
/plugin marketplace add https://github.com/mnabaci/software-skills
```

Then install the skills plugin:

```bash
/plugin install software-skills@software-skills
```

## 📦 What's Included

### **Code** (`/code`)
Write clean, maintainable code with pragmatic engineering principles. Includes stack-specific anti-patterns for:
- TypeScript
- React
- Next.js
- Vue
- Node.js
- C#
- Python
- C++

### **Plan** (`/plan`)
Create detailed implementation plans before coding. Reads code first, respects existing patterns, and avoids over-engineering.

### **Challenge** (`/challenge`)
Stress-test ideas and plans with skeptical, constructive critique. Perfect for validating assumptions before investing time.

### **Code Review** (`/code-review`)
Checks a diff against the same pragmatic principles `/code` enforces - overengineering, scope creep, misapplied SOLID/DRY, unnecessary abstraction, security boundaries. A self-check for adherence to team conventions, not a hunt for correctness bugs.

### **Plan Review** (`/plan-review`)
Verifies an implementation actually matches a `/plan` stage - files touched, acceptance criteria, scope boundaries. Run it after executing a stage, before moving to the next one.

## ⚙️ Hooks

This plugin ships two deterministic, no-LLM-call hooks:
- **Model-tier check** - on session start and each prompt, flags a mismatch between the active model and the task's apparent complexity.
- **Commit reminder** - before `git commit`, if the staged change looks feature-shaped (new files, sizeable diff) but the README and version file aren't part of it, surfaces a one-line nudge to consider updating them. Soft reminder only - it never blocks the commit, and Claude decides whether a given change actually warrants it.

## 🏗️ Marketplace Structure

```
.
├── .claude-plugin/
│   └── marketplace.json          # Marketplace catalog
├── plugins/
│   └── software-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json       # Plugin manifest
│       ├── hooks/
│       │   ├── hooks.json        # Hook registration
│       │   └── scripts/          # Model-tier check + commit reminder
│       └── skills/
│           ├── code/             # Code quality skill (+ refs/ per stack)
│           ├── plan/             # Planning skill
│           ├── challenge/        # Critique skill
│           ├── code-review/      # Diff review against /code's principles
│           └── plan-review/      # Implementation-vs-plan-stage conformance
├── README.md
└── .gitignore
```

## 📖 Using the Skills

Once installed, use them directly in Claude Code:

- `/software-skills:code` — Write or modify code
- `/software-skills:plan` — Plan a change before coding
- `/software-skills:challenge` — Critique a plan or idea
- `/software-skills:code-review` — Review a diff for adherence to engineering principles
- `/software-skills:plan-review` — Verify an implementation matches its plan stage

## 🔄 Updates

This marketplace uses **auto-update from git commits**. Every push to `main` automatically becomes a new version. To update:

```bash
/plugin marketplace update software-skills
/plugin install software-skills@software-skills
```

## 📝 License

MIT

## 🤝 Contributing

Found an issue or want to improve a skill? Open a PR or issue on GitHub.
