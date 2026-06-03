# Changelog

All notable changes to this project are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

---

## [1.0.0] — 2026-06-03

### 🎉 Initial Release

#### Added [code-review-using-subagents](skills/code-review-using-subagents/) skill with features:
- **12 specialist subagents** — Security, Performance, CTO, Controllers, Services, Domain/ORM, Views/UI, Build/Config, Tests, Tech Debt, Filters, Infrastructure
- **Auto tech-stack detection** — Grails, Java/Maven, Node.js, Python, Go, Rust
- **Diff splitting engine** — Splits combined diffs into category-specific patches via `split_diff.sh`
- **Event-driven dispatch** — Queue-based subagent dispatch with staggered launches to avoid rate limits
- **Real-time streaming report** — Findings appended as each specialist completes
- **Built-in resilience** — Retry logic (2 retries per agent) with self-review fallback on persistent failures
- **Read-only sandbox** — All subagents run with `enable_write_tools: false`
- **Two review modes** — Quick (3-4 agents) and Thorough (10-14 agents)
- **Severity-ranked output** — Critical → High → Medium → Low with exact file locations and drop-in code fixes
- **Category-specific checklists** — Each specialist has a detailed audit checklist embedded in its prompt
- **Smart controller splitting** — Automatically splits controllers A-M / N-Z when >30 files are changed

#### Repository
- **6-agent install support** — Antigravity, Claude Code, Codex CLI, Cursor, Windsurf, GitHub Copilot
- **Contribution infrastructure** — Code of Conduct, issue/PR templates, security policy
- **Documentation** — README with architecture diagram, matrix, and quick start guide
