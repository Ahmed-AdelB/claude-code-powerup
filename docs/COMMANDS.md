# Slash Commands

20+ slash commands for SDLC automation and development workflows.

## SDLC Commands

| Command | Description |
|---------|-------------|
| `/brainstorm` | Generate and explore ideas |
| `/plan` | Create detailed implementation plans |
| `/execute` | Execute planned tasks |
| `/review` | Code review and quality checks |
| `/test` | Run and manage tests |
| `/document` | Generate documentation |
| `/debug` | Debug issues |
| `/track` | Track project progress |

## Git Commands

| Command | Description |
|---------|-------------|
| `/git:commit` | Smart commit with semantic message |
| `/git:branch` | Branch management |
| `/git:pr` | Create pull requests |
| `/git:sync` | Sync with remote |
| `/git-smart` | Analyze changes and commit |

## Analysis Commands

| Command | Description |
|---------|-------------|
| `/analyze` | Deep code analysis (security, performance, quality) |
| `/refactor` | Smart refactoring with SOLID principles |

## Multi-Model Commands

| Command | Description |
|---------|-------------|
| `/multi-model:codex` | Use GPT Codex for code generation |
| `/multi-model:gemini` | Use Gemini for analysis |
| `/multi-model:consensus` | Tri-agent consensus for critical changes |

## AB Method Commands

| Command | Description |
|---------|-------------|
| `/ab-method:create-mission` | Create a new mission |
| `/ab-method:create-task` | Create a task within mission |
| `/ab-method:resume-mission` | Resume existing mission |
| `/ab-method:test-mission` | Test mission execution |
| `/ab-method:ab-master` | Master orchestration |

## Testing Commands

| Command | Description |
|---------|-------------|
| `/test-gen` | Generate comprehensive tests |
| `/debug-issue` | Debug and fix issues |

## Documentation Commands

| Command | Description |
|---------|-------------|
| `/doc` | Generate documentation |

## Agent Commands

Use `/agents:index` to see all available agents, or invoke specific agents:
- `/agents:backend api-architect`
- `/agents:frontend react-expert`
- `/agents:security vulnerability-scanner`
- `/agents:testing e2e-test-expert`

## Creating Custom Commands

Create a markdown file in `~/.claude/commands/`:

```markdown
---
description: My custom command
allowed-tools: Read, Edit, Bash
---
Do something with $ARGUMENTS:
1. Step one
2. Step two
3. Step three
```

## Command Location

Commands are stored in:
- `~/.claude/commands/` (user-level)
- `.claude/commands/` (project-level)
