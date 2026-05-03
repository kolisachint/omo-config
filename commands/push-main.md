---
description: Commit changes and push to origin main
agent: build
model: opencode-go/kimi-k2.5
---

Stage, commit, and push changes to origin main with proper git workflow.

## Pre-flight Checks:

### 1. Check Current Status
!`git status`

### 2. Check Branch
!`git branch --show-current`

Must be on `main` or `master` branch.

## Git Workflow:

### If on main/master branch:

#### Step 1: Review Changes
!`git diff --stat`

#### Step 2: Stage Changes
Stage files by logical groups:

**Group by concern:**
- Configuration changes
- Source code changes  
- Test changes
- Documentation changes

#### Step 3: Atomic Commits

Create focused commits (max 3-4 files per commit):

**Commit 1: Configuration**
```bash
git add [config files]
git commit -m "config: update [what changed]

Co-authored-by: Sisyphus <clio-agent@sisyphuslabs.ai>"
```

**Commit 2: Implementation**
```bash
git add [source files]
git commit -m "refactor: simplify [component]

- [change 1]
- [change 2]

Co-authored-by: Sisyphus <clio-agent@sisyphuslabs.ai>"
```

**Commit 3: Tests**
```bash
git add [test files]
git commit -m "test: add/update tests for [feature]

Co-authored-by: Sisyphus <clio-agent@sisyphuslabs.ai>"
```

#### Step 4: Verify History
!`git log --oneline -5`

#### Step 5: Push to Origin
```bash
git push origin main
```

Or if tracking branch:
```bash
git push
```

### If NOT on main/master:

Create PR instead:
```bash
git push -u origin $(git branch --show-current)
```

Then create PR to merge into main.

## Post-Push Verification:

!`git log --oneline origin/main -3`

Confirm commits are on origin/main.

## Safety Rules:

- ✅ Only push atomic, focused commits
- ✅ Ensure tests pass before pushing
- ✅ Review diff before committing
- ❌ Never push broken code
- ❌ Never push secrets/credentials
- ❌ Never force push to main
