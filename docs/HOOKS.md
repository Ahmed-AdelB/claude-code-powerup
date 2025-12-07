# Automation Hooks

Hooks automate actions based on Claude Code events.

## Available Hooks

### Pre-commit Hook
Runs before each git commit to ensure code quality.

```bash
#!/bin/bash
# hooks/pre-commit.sh

# Check for secrets
if grep -rn "password\|api_key\|secret" --include="*.js" --include="*.ts" .; then
  echo "WARNING: Potential secrets detected!"
  exit 1
fi

# Run linter
npm run lint || exit 1

# Run type check
npm run typecheck || exit 1
```

### Post-edit Hook
Runs after file edits for automatic formatting.

```bash
#!/bin/bash
# hooks/post-edit.sh

FILE="$1"

# Auto-format based on file type
case "$FILE" in
  *.ts|*.tsx|*.js|*.jsx)
    npx prettier --write "$FILE"
    ;;
  *.py)
    black "$FILE"
    ;;
esac
```

### Quality Gate Hook
Enforces quality standards before deployment.

```bash
#!/bin/bash
# hooks/quality-gate.sh

# Run tests with coverage
npm run test:coverage || exit 1

# Check coverage threshold (80%)
COVERAGE=$(npm run test:coverage -- --json | jq '.total.lines.pct')
if (( $(echo "$COVERAGE < 80" | bc -l) )); then
  echo "Coverage below 80%: $COVERAGE%"
  exit 1
fi

# Security audit
npm audit --audit-level=high || exit 1
```

## Configuration

Hooks are configured in `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write \"$FILE_PATH\"",
            "timeout": 30
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "echo 'About to run bash command'"
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "git status --short"
          }
        ]
      }
    ]
  }
}
```

## Hook Events

| Event | Trigger |
|-------|---------|
| `SessionStart` | When Claude Code session begins |
| `PreToolUse` | Before a tool is executed |
| `PostToolUse` | After a tool completes |
| `Shutdown` | When session ends |

## Hook Configuration Options

| Option | Description |
|--------|-------------|
| `matcher` | Regex to match tool names |
| `type` | `command` for shell commands |
| `command` | The command to execute |
| `timeout` | Max execution time (seconds) |

## Environment Variables in Hooks

Hooks have access to:
- `$FILE_PATH` - Path of affected file
- `$TOOL_NAME` - Name of tool being used
- `$TOOL_INPUT` - JSON input to tool
- `$TOOL_OUTPUT` - JSON output from tool

## Hook Location

Hook scripts are stored in:
- `~/.claude/hooks/` (user-level)
- `.claude/hooks/` (project-level)
