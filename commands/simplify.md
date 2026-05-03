---
description: Simplify and refactor code, then push to main
agent: build
model: opencode-go/kimi-k2.5
---

Analyze the codebase for simplification opportunities and refactoring needs.

## Tasks to perform:

1. **Review Code** - Identify:
   - Unnecessary complexity
   - Duplicate code
   - Dead/unused code
   - Over-engineered solutions
   - Poor naming conventions
   - Missing error handling

2. **Simplify & Refactor**:
   - Remove dead code
   - Consolidate duplicates
   - Simplify complex logic
   - Improve readability
   - Add proper error handling
   - Update naming for clarity

3. **Testing**:
   - Run existing tests (!`npm test` || !`pytest` || !`cargo test` || !`go test`)
   - Fix any broken tests
   - Ensure no regressions

4. **Git Workflow**:
   - Stage changes atomically
   - Create proper commit messages
   - Push to origin main

## Guidelines:

- Make atomic commits (one concern per commit)
- Never break functionality
- Prefer clarity over cleverness
- Remove only truly dead code (verify first)
- Keep commits small and focused
- Include "Co-authored-by: Sisyphus" in commits

## Commit message format:
```
refactor: simplify [component/name]

- Removed unused [function/variable]
- Consolidated [duplicate logic]
- Improved [readability/maintainability]

Co-authored-by: Sisyphus <clio-agent@sisyphuslabs.ai>
```

Start by reviewing the current state of the codebase and identifying the most impactful simplifications.
