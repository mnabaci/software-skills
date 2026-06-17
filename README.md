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
- Vue
- Node.js
- C#

### **Plan** (`/plan`)
Create detailed implementation plans before coding. Reads code first, respects existing patterns, and avoids over-engineering.

### **Challenge** (`/challenge`)
Stress-test ideas and plans with skeptical, constructive critique. Perfect for validating assumptions before investing time.

## 🏗️ Marketplace Structure

```
.
├── .claude-plugin/
│   └── marketplace.json          # Marketplace catalog
├── plugins/
│   └── software-skills/
│       ├── .claude-plugin/
│       │   └── plugin.json       # Plugin manifest
│       └── skills/
│           ├── code/             # Code quality skill
│           ├── plan/             # Planning skill
│           └── challenge/        # Critique skill
├── README.md
└── .gitignore
```

## 📖 Using the Skills

Once installed, use them directly in Claude Code:

- `/software-skills:code` — Write or modify code
- `/software-skills:plan` — Plan a change before coding
- `/software-skills:challenge` — Critique a plan or idea

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
