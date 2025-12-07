# Tri-Agent Security & Quality Audit Report
Date: 2025-12-07
Auditors: Claude Opus 4.5, Codex GPT-5.1, Gemini 3 Pro Preview

## CRITICAL ISSUES (2)

### 1. Shell Command Injection Vulnerability
- **File**: `.claude/agents/gemini-reviewer.md:20`
- **Severity**: CRITICAL
- **Found by**: Gemini 3 Pro Preview
- **Description**: The documented usage `gemini ... "$(cat file.py)"` is unsafe. If file contains shell metacharacters, arbitrary code execution is possible.
- **Fix**: Use piped input `cat file.py | gemini ...` or `--file` flag

### 2. Duplicate Agent Directory Structure
- **Files**: `.claude/01-*` vs `.claude/agents/`
- **Severity**: CRITICAL
- **Found by**: Claude Opus 4.5
- **Description**: Two parallel agent structures exist:
  - OLD: `.claude/01-general-purpose/`, `.claude/02-planning/`, etc. (92 agents)
  - NEW: `.claude/agents/00-orchestrators/`, etc. (25 agents)
- **Fix**: Remove old numbered directories or merge into agents/_archived

## HIGH SEVERITY ISSUES (3)

### 3. Insecure Permission - .mcp.json Writable
- **File**: `.claude/settings.json:131`
- **Severity**: HIGH
- **Found by**: Gemini 3 Pro Preview
- **Description**: `Write(./*.json)` allows overwriting `.mcp.json`, enabling MCP server replacement with malicious commands
- **Fix**: Add `Write(.mcp.json)` to deny list

### 4. Documentation Mismatch - Agent Count
- **File**: `.claude/CLAUDE.md:8`
- **Severity**: HIGH
- **Found by**: Claude Opus 4.5
- **Description**: Documentation says "85+ Specialized Agents" but only 25 active agents exist
- **Fix**: Update to "25 Specialized Agents (3 Categories + 2 Integrations)"

### 5. GitHub Authentication Broken
- **Severity**: HIGH
- **Found by**: Claude Opus 4.5
- **Description**: 
  - gh CLI token invalid in keyring
  - GITHUB_TOKEN environment variable not set
  - MCP GitHub server failing
- **Fix**: Run `gh auth login` and set GITHUB_TOKEN

## MEDIUM SEVERITY ISSUES (3)

### 6. Argument Injection in Hooks
- **File**: `.claude/hooks/pre-commit.ps1:108`
- **Severity**: MEDIUM
- **Found by**: Gemini 3 Pro Preview
- **Description**: Git diff passed directly as CLI argument, potential for injection and privacy leak
- **Fix**: Use temporary file for diff content

### 7. MCP Documentation Outdated
- **File**: `.claude/CLAUDE.md:100-104`
- **Severity**: MEDIUM
- **Found by**: Claude Opus 4.5
- **Description**: Lists only 4 MCP servers, actual .mcp.json has 8
- **Fix**: Update to include memory, sqlite, fetch, puppeteer

### 8. Obsolete Open PRs
- **Severity**: MEDIUM
- **Found by**: Claude Opus 4.5
- **Description**: 
  - PR #3 (Windows hooks) - OBSOLETE, already on master
  - PR #2 (Plugin docs) - Needs review
- **Fix**: Close PR #3, review/merge PR #2

## LOW SEVERITY ISSUES (2)

### 9. Missing Tool Validation in Hooks
- **File**: `.claude/hooks/pre-commit.ps1:25`
- **Severity**: LOW
- **Found by**: Gemini 3 Pro Preview
- **Description**: No validation if codex/gemini missing when TRI_AGENT_REVIEW enabled
- **Fix**: Add clear error messages for missing tools

### 10. Broad Filesystem Access
- **File**: `.mcp.json:24`
- **Severity**: LOW
- **Found by**: Gemini 3 Pro Preview
- **Description**: filesystem server has `.` (root) access
- **Fix**: Ensure deny rules cover `.git/`, `.ssh/`, `.env`

## SUMMARY

| Severity | Count |
|----------|-------|
| CRITICAL | 2 |
| HIGH | 3 |
| MEDIUM | 3 |
| LOW | 2 |
| **TOTAL** | **10** |

## IMMEDIATE ACTIONS REQUIRED

1. Fix shell injection vulnerability in gemini-reviewer.md
2. Add `.mcp.json` to Write deny list
3. Remove or archive old numbered agent directories
4. Update CLAUDE.md documentation
5. Set GITHUB_TOKEN and re-authenticate gh CLI
