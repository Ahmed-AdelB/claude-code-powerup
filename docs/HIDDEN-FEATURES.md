# Hidden Features & Power User Tricks

## Secret Commands (! prefix)

| Command | Description |
|---------|-------------|
| `!help` | Show hidden commands |
| `!state` | Dump internal state |
| `!memory` | Show memory usage |
| `!tokens` | Display token count |
| `!cost` | Show API cost so far |
| `!export` | Export conversation |
| `!import` | Import conversation |
| `!checkpoint` | Create checkpoint |
| `!rollback` | Revert to checkpoint |
| `!parallel` | Toggle parallel mode |
| `!verbose` | Toggle verbose output |
| `!debug` | Enter debug mode |
| `!metrics` | Show performance metrics |

## Extended Thinking Modes

| Trigger | Tokens | Use Case |
|---------|--------|----------|
| "think" | ~4,000 | Simple problems |
| "think hard" / "megathink" | ~10,000 | Moderate complexity |
| "think harder" / "ultrathink" | ~32,000 | Complex architecture |

**Example:**
```
ultrathink about the best way to refactor this authentication system
```

## Time Travel

View past conversations:
```
/history 2024-12-01
```

## Session Management

```bash
# Continue last session
claude -c

# Resume specific session
claude -r "session-id"

# Fork from existing session
claude --fork-session
```

## Output Control

```bash
# Silent mode - just code
claude -p "query" --quiet

# JSON output
claude -p "query" --json

# Full turn-by-turn output
claude --verbose
```

## Model Selection

```bash
# Use Opus
claude --model opus

# Sonnet with 1M context
claude --model sonnet[1m]

# Opus for planning, Sonnet for execution
claude --model opusplan
```

## Permission Modes

```bash
# Read-only exploration
claude --permission-mode plan

# Auto-accept edits
claude --permission-mode acceptEdits

# Skip all prompts (dangerous!)
claude --dangerously-skip-permissions
```

## Terminal Notifications

```bash
claude config set --global preferredNotifChannel terminal_bell
```

## Shell Aliases

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Quick Claude Code access
alias cc='claude --dangerously-skip-permissions'
alias ccc='claude -c'  # Continue last session
alias ccr='claude -r'  # Resume by ID

# Claudify - auto-fix last command
fix() {
  local last_cmd=$(fc -ln -1)
  claude -p "Fix this command: $last_cmd" --output-format text
}

# Project-specific launchers
alias ccproject='cd ~/myproject && claude'
```

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| Ctrl+C | Cancel current operation |
| Ctrl+D | Exit Claude Code |
| Ctrl+L | Clear screen |
| Ctrl+R | Search command history |
| Ctrl+_ | Undo prompt input |
| Ctrl+O | Toggle verbose output |
| Shift+Enter | New line |

## Parallel Instances

Run 2-3 Claude instances simultaneously:
- One for backend logic
- One for frontend components
- One for tests/documentation

## Configuration Commands

```bash
claude config              # Access all settings
claude config list         # List all config values
claude config set KEY VALUE # Set a config value
claude update              # Update to latest version
claude --version           # Check version
```

## Headless/CI Mode

```bash
# Run non-interactively
claude -p "Analyze codebase and create report" --output-format json

# Pipe data for processing
cat error.log | claude -p "Analyze errors and suggest fixes"

# Scheduled maintenance
claude -p "Update copyright headers to 2025" --json
```

## Environment Variables

```bash
# Performance
export MAX_THINKING_TOKENS=10000
export BASH_DEFAULT_TIMEOUT_MS=60000

# Model defaults
export ANTHROPIC_MODEL=opus

# Disable features
export DISABLE_TELEMETRY=1
export DISABLE_AUTOUPDATER=1
```

## Advanced CLI Flags

| Flag | Description |
|------|-------------|
| `--model` | Select model |
| `--timeout` | Set timeout |
| `--max-tokens` | Limit tokens |
| `--temperature` | Set temperature |
| `--system-prompt` | Custom system prompt |
| `--no-cache` | Disable caching |
