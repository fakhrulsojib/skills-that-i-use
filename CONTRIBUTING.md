# Contributing

Thanks for your interest in making these skills better! Here's everything you need to get started.

---

## 🚀 Getting Started

1. **Fork** this repository
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/<your-username>/skills-that-i-use.git
   cd skills-that-i-use
   ```
3. **Create a branch** for your change:
   ```bash
   git checkout -b feat/your-change-name
   ```
4. Make your changes, test them, and submit a PR!

---

## 🧪 Development Setup

Skills are self-contained folders — no build step, no dependencies. To test a skill locally:

### Testing with Antigravity

```bash
# Symlink into your global config
ln -s $(pwd)/skills/your-skill-name \
      ~/.gemini/config/skills/your-skill-name

# Trigger the skill by asking your agent a relevant question
```

### Testing with Claude Code

```bash
ln -s $(pwd)/skills/your-skill-name \
      ~/.claude/skills/your-skill-name
```

### Verifying the `split_diff.sh` script

```bash
# Run shellcheck
shellcheck skills/code-review-using-subagents/scripts/split_diff.sh

# Test with a sample diff
git show HEAD > /tmp/test.patch
bash skills/code-review-using-subagents/scripts/split_diff.sh /tmp/test.patch /tmp/split_output
```

---

## 📦 Adding a New Skill

1. Create a folder under `skills/` with a descriptive kebab-case name
2. Include a `SKILL.md` with YAML frontmatter (`name`, `description`) and full instructions
3. Add a `README.md` alongside it explaining what it does, usage, and examples
4. Add any helper scripts under `scripts/` within the skill folder
5. Add a row to the skills table in the root `README.md`
6. Add an entry to `CHANGELOG.md`

### Skill Folder Structure

```
skills/your-skill-name/
├── SKILL.md           ← Core instructions (required)
├── README.md          ← Human-readable docs (required)
└── scripts/           ← Helper scripts (optional)
```

### SKILL.md Requirements

Every `SKILL.md` must have YAML frontmatter:

```yaml
---
name: your-skill-name
description: |
  Brief description of what the skill does.

  Trigger when:
  - Condition 1
  - Condition 2

  DO NOT trigger for:
  - Condition 3
---
```

---

## ✏️ Improving an Existing Skill

All improvements are welcome:

- **Better prompts** — sharper specialist prompts, more precise checklists
- **New file patterns** — additional path patterns for category detection
- **Bug fixes** — issues with diff splitting, category routing, etc.
- **Documentation** — clearer explanations, more examples, better FAQ answers

### How to Test Your Improvement

1. Link the skill into your agent (see Development Setup above)
2. Run a real code review on a commit you've previously reviewed
3. Compare the output — did your change improve the findings?

---

## 🏷️ Good First Issues

Look for issues labeled [`good first issue`](../../labels/good%20first%20issue). These are specifically picked as approachable starting points. Examples:

- Adding a new file pattern to `split_diff.sh`
- Improving a specialist's checklist
- Adding a troubleshooting Q&A to a skill's README
- Fixing typos or improving clarity in docs

---

## 📝 Pull Request Checklist

Before submitting, make sure:

- [ ] Skill folder follows the structure above
- [ ] `SKILL.md` has valid YAML frontmatter
- [ ] Root `README.md` table is updated (if adding a new skill)
- [ ] Tested locally with at least one real use case
- [ ] `CHANGELOG.md` updated with your changes
- [ ] No secrets, credentials, or personal paths in committed files
- [ ] Shell scripts pass `shellcheck` (if applicable)

---

## 💬 Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(code-review): add accessibility specialist agent
fix(code-review): correct controller pattern for nested routes
docs: improve installation instructions
feat: add new skill — commit-message-generator
chore: update editorconfig settings
```

---

## 📋 Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you agree to uphold a respectful and inclusive community.

---

## ❓ Questions?

- Open an [issue](../../issues) for bugs and feature requests
- Start a [discussion](../../discussions) for questions and ideas
- Check existing issues before creating a new one
