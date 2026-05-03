---
description: Review code for issues and improvements
agent: momus
model: opencode-go/kimi-k2.5
---

Perform a comprehensive code review to identify issues and improvement opportunities.

## Review Checklist:

### Code Quality
- [ ] Unnecessary complexity
- [ ] Code duplication
- [ ] Dead/unused code
- [ ] Over-engineering
- [ ] Poor naming
- [ ] Magic numbers/strings

### Architecture
- [ ] Proper separation of concerns
- [ ] Design pattern violations
- [ ] Tight coupling
- [ ] Missing abstractions

### Error Handling
- [ ] Missing error checks
- [ ] Silent failures
- [ ] Poor error messages
- [ ] Resource leaks

### Performance
- [ ] Inefficient algorithms
- [ ] Unnecessary computations
- [ ] Memory leaks
- [ ] N+1 queries

### Security
- [ ] Injection vulnerabilities
- [ ] Hardcoded secrets
- [ ] Improper input validation
- [ ] Unsafe defaults

### Testing
- [ ] Missing test coverage
- [ ] Brittle tests
- [ ] Slow tests
- [ ] Flaky tests

## Output Format:

Provide findings as:

### 🔴 Critical (Fix Immediately)
- Issue: [description]
- Location: [file:line]
- Fix: [suggestion]

### 🟡 Warning (Should Fix)
- Issue: [description]
- Location: [file:line]
- Fix: [suggestion]

### 🟢 Nitpick (Nice to Have)
- Issue: [description]
- Location: [file:line]
- Fix: [suggestion]

## Recent Changes:
!`git log --oneline -10`

Review these changes and identify any issues introduced.
