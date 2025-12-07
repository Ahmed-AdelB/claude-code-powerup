# Automation Hooks

Hooks automate actions based on Claude Code events.

## Current Configuration

Hooks are configured in \ using PowerShell for Windows compatibility:

## Available Hooks

### Pre-commit Hook
Runs before each git commit to ensure code quality.
- Checks for secrets/sensitive data
- Detects debug code
- Runs linter and type checks
- Triggers tri-agent review (if enabled)

### Post-edit Hook
Runs after file edits for automatic formatting.
- Auto-formats based on file type
- Runs Prettier for JS/TS
- Runs Black for Python

### Quality Gate Hook
Enforces quality standards before deployment.
- Verifies test coverage >= 80%
- Security audit
- Documentation checks

## Hook Events

| Event | Trigger |
|-------|---------|
| \ | Before a tool is executed |
| \ | After a tool completes |
| \ | When session ends |

## Hook Location

Hook scripts are stored in:
- \ (user-level)
- \ (project-level)

Both \ (PowerShell) and \ (Bash) versions are available.
