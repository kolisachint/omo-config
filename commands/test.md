---
description: Run tests and fix failures
agent: build
model: opencode-go/kimi-k2.5
---

Run the test suite and fix any failures.

## Test Execution:

Detect and run appropriate test command:
!`npm test 2>/dev/null || pytest 2>/dev/null || cargo test 2>/dev/null || go test ./... 2>/dev/null || make test 2>/dev/null || echo "No test command found"`

## If Tests Pass:
✅ All tests passing - ready to commit/push

## If Tests Fail:

### 1. Analyze Failures
Identify:
- Which tests are failing
- Error messages
- Stack traces
- Recent changes that may have caused failures

### 2. Fix Strategy

For each failing test:
- Understand what the test expects
- Check if test is outdated (needs update) or code is broken (needs fix)
- Apply appropriate fix
- Re-run tests

### 3. Common Fixes

**Test outdated:**
- Update test expectations
- Remove obsolete tests
- Add missing test coverage

**Code broken:**
- Fix the bug causing failure
- Add missing error handling
- Restore broken functionality

**Flaky tests:**
- Add proper setup/teardown
- Fix race conditions
- Add retry logic
- Improve test isolation

### 4. Verification

Re-run tests until all pass:
!`npm test 2>/dev/null || pytest 2>/dev/null || cargo test 2>/dev/null || go test ./... 2>/dev/null || make test 2>/dev/null`

## Output:

Provide summary:
- Tests run: [N]
- Passed: [N]
- Failed: [N]
- Skipped: [N]

If failures were fixed, provide commit message:
```
fix: resolve test failures

- Fixed [specific issue]
- Updated [outdated test]
- Added [missing test coverage]

Co-authored-by: Sisyphus <clio-agent@sisyphuslabs.ai>
```
