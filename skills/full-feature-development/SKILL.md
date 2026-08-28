---
name: full-feature-development
description: Use when you have an approved implementation plan and want to execute the complete development lifecycle - from workspace setup through task execution, reviews, verification, and branch completion - without manual skill orchestration
---

# Full Feature Development

Single entry point that orchestrates the complete feature lifecycle. Follow **subagent-driven-development** for the core process — this skill adds the patterns SDD doesn't cover.

**Announce at start:** "I'm using the full-feature-development skill to execute this plan end-to-end."

## Skill Chain

Execute these skills in order. SDD handles Phase 2 internally.

| Phase | Skill | What It Does |
|-------|-------|-------------|
| 1. Setup | `using-git-worktrees` | Detect/create workspace isolation |
| 1. Setup | *(this skill)* | Baseline verification + live tracker |
| 2. Execute | `subagent-driven-development` | Full task loop with reviews |
| 3. Verify | `verification-before-completion` | Fresh evidence before completion claim |
| 4. Finish | `finishing-a-development-branch` | Present merge/PR/keep/discard options |

## Additions to SDD

### 1. Baseline Verification (before Task 1)

**MANDATORY.** Run the project's verification commands before dispatching any task:

```bash
# Example for this project — adapt per project
pnpm --filter backend lint && pnpm --filter backend typecheck
pnpm --filter backend test
```

Record the baseline test count. All tasks must maintain or increase it. If baseline fails, fix before proceeding.

### 2. Live Task Artifact (`task.md`)

Create a `task.md` artifact alongside SDD's `progress.md` ledger. The ledger is for recovery; the artifact is for live visibility.

**Format:**

```markdown
# [Feature Name] — Task Tracker

## Active Skills
| Skill | Role |
|-------|------|
| full-feature-development | Orchestration |
| subagent-driven-development | Task dispatch + review |
| ... | ... |

## Current Phase
**Phase: [Setup | Execution | Final Verification | Completion]**
- [x] Baseline: lint ✅, typecheck ✅, N/N tests ✅

## Tasks
- [x] **Task 1:** [name] ✅
  - Commits: `base..head`
  - Review: Approved (0 Critical, N Important, N Minor)
  - Verified: N/N tests pass
- [/] **Task 2:** [name]
  - Base SHA: `sha`
  - Status: 🔄 [Implementer dispatching | Reviewer dispatched | Fix in progress]
- [ ] **Task 3:** [name]

## Workflow Recovery Notes
If context is lost, check:
1. This artifact for current phase
2. `.superpowers/sdd/progress.md` for completed tasks
3. `git log --oneline` for actual commits
```

### 3. Update Trackers at EVERY Step

Update both `task.md` and `progress.md` at each transition:

| Event | task.md Update | progress.md Update |
|-------|---------------|-------------------|
| Task starts | Mark `[/]`, record base SHA | — |
| Implementer done | Add head SHA, test count | — |
| Reviewer dispatched | Add reviewer status | — |
| Fix dispatched | Add fix status | — |
| Task approved | Mark `[x]`, add review summary | Add complete line |
| Phase change | Update "Current Phase" | Update task table |

### 4. Extract ALL Briefs Upfront

Before Task 1, extract all task briefs:
```bash
scripts/task-brief PLAN_FILE 1 .superpowers/sdd/task-1-brief.md
scripts/task-brief PLAN_FILE 2 .superpowers/sdd/task-2-brief.md
# ... for all tasks
```

This avoids blocking on extraction during the loop and lets you reference brief sizes in the tracker.

### 5. Parallel Prep

While waiting for a reviewer, extract the next task's brief (if not already done) and prepare the next implementer dispatch prompt. This saves wall-clock time.

### 6. Final Verification Gate

After all tasks complete and before the whole-branch review, run fresh verification. This is the `verification-before-completion` skill: **evidence before claims**.

Record exact output (exit codes, test counts) in `task.md` before dispatching the final reviewer.

## Red Flags

- Skipping baseline verification
- Forgetting to update `task.md` (the whole point of this skill)
- Claiming completion without fresh verification evidence
- Re-dispatching tasks the ledger marks complete
