<p align="center">
  <img src="docs/assets/banner.svg" alt="Skills That I Use" width="720" />
</p>

<h1 align="center">Skills That I Use</h1>

<p align="center">
  <strong>A curated collection of custom AI agent skills that supercharge my dev workflow.</strong>
</p>

<p align="center">
  <a href="#-skills"><img src="https://img.shields.io/badge/skills-1-blueviolet?style=flat-square" alt="Skills" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue?style=flat-square" alt="License" /></a>
  <a href="CONTRIBUTING.md"><img src="https://img.shields.io/badge/PRs-welcome-brightgreen?style=flat-square" alt="PRs Welcome" /></a>
  <a href="#-supported-agents"><img src="https://img.shields.io/badge/agents-6+-teal?style=flat-square" alt="Agents" /></a>
</p>

<p align="center">
  <sub>Battle-tested workflows that have genuinely changed how I work. Not toy demos.</sub>
</p>

---

## 📦 Skills

| Skill | What It Does | Agents |
|-------|-------------|--------|
| [**code-review-using-subagents**](skills/code-review-using-subagents/) | Orchestrates **up to 12 specialist subagents** (security, performance, CTO, controllers, services, domain, tests, etc.) to review commits in parallel. Produces a unified severity-ranked report with production-ready fixes. | Any agent with subagent support |

> More skills coming soon.

---

## 🚀 Installation

```bash
git clone https://github.com/<your-username>/skills-that-i-use.git ~/skills-that-i-use
```

Then link or copy the skill(s) you want into your agent:

<details>
<summary><strong>Claude Code</strong></summary>

```bash
# Global (all projects)
ln -s ~/skills-that-i-use/skills/<skill-name> \
      ~/.claude/skills/<skill-name>

# Or project-specific
ln -s ~/skills-that-i-use/skills/<skill-name> \
      .claude/skills/<skill-name>
```
</details>

<details>
<summary><strong>Antigravity</strong></summary>

```bash
ln -s ~/skills-that-i-use/skills/<skill-name> \
      ~/.gemini/config/skills/<skill-name>
```
</details>

<details>
<summary><strong>OpenAI Codex CLI</strong></summary>

Codex uses `AGENTS.md` for instructions. Append the skill content:

```bash
# Global
cat ~/skills-that-i-use/skills/<skill-name>/SKILL.md \
    >> ~/.codex/AGENTS.md

# Or project-specific
cat ~/skills-that-i-use/skills/<skill-name>/SKILL.md \
    >> ./AGENTS.md
```
</details>

<details>
<summary><strong>Cursor</strong></summary>

```bash
mkdir -p .cursor/rules
cp ~/skills-that-i-use/skills/<skill-name>/SKILL.md \
   .cursor/rules/<skill-name>.mdc
```
</details>

<details>
<summary><strong>Windsurf</strong></summary>

```bash
mkdir -p .windsurf/rules
cp ~/skills-that-i-use/skills/<skill-name>/SKILL.md \
   .windsurf/rules/<skill-name>.md
```
</details>

<details>
<summary><strong>GitHub Copilot</strong></summary>

```bash
mkdir -p .github/instructions
cp ~/skills-that-i-use/skills/<skill-name>/SKILL.md \
   .github/instructions/<skill-name>.instructions.md
```
</details>

---

## 📁 Repo Structure

```
skills-that-i-use/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── SECURITY.md
├── CHANGELOG.md
├── .editorconfig
├── skills/
│   └── <skill-name>/
│       ├── README.md
│       ├── SKILL.md
│       └── scripts/
├── examples/
└── docs/
    └── assets/
```

---

## 🤝 Contributing

Contributions are welcome — new skills, better prompts, docs, bug fixes.

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

---

## 📄 License

[MIT](LICENSE)

---

<p align="center">
  <sub>Made with ❤️ by <a href="https://www.linkedin.com/in/fakhrulsojib/">fakhrulislam</a></sub>
</p>
