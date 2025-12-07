# Claude Code Ultimate Power-Up

Complete configuration to supercharge Claude Code with:
- **25 Specialized Agents** across 3 categories + 2 integrations
- **20+ Slash Commands** for SDLC automation
- **MCP Servers** for external tool integration
- **Hooks** for automation
- **Skills** for complex workflows
- **Hidden Features** and power user tricks

## Quick Install

```bash
# Clone this repo
git clone https://github.com/Ahmed-AdelB/claude-code-powerup.git

# Copy to your Claude Code config
xcopy /E /I /Y .claude C:\Users\%USERNAME%\.claude
copy /Y .mcp.json C:\Users\%USERNAME%\.mcp.json

# Restart Claude Code
```

## What's Included

### Agents (25)
| Category | Count | Examples |
|----------|-------|----------|
| 00-orchestrators | 7 | orchestrator, task-router, context-manager, session-manager |
| 01-core-engineers | 6 | backend-engineer, frontend-engineer, database-specialist |
| 02-specialists | 10 | security-expert, code-reviewer, architect, ml-engineer |
| integrations | 2 | codex-sdlc-developer, gemini-reviewer |

### Commands (20+)
- `/sdlc:brainstorm` - Generate ideas
- `/sdlc:spec` - Write specifications
- `/sdlc:plan` - Create implementation plan
- `/sdlc:execute` - Execute plan
- `/sdlc:status` - Check project status
- And many more...

### MCP Servers
- **git** - Git operations
- **github** - GitHub API
- **filesystem** - File system access
- **memory** - Persistent memory
- **puppeteer** - Browser automation
- **fetch** - Enhanced web fetching
- **sqlite** - Local database

### Hidden Features
- `!state`, `!tokens`, `!cost`, `!checkpoint`, `!rollback`
- Extended thinking: "think", "think hard", "ultrathink"
- Time travel: `/history 2024-12-01`

## Sources

Based on:
- [claude-sdlc-orchestrator](https://github.com/Ahmed-AdelB/claude-sdlc-orchestrator)
- [awesome-mcp-servers](https://github.com/punkpeye/awesome-mcp-servers)
- [claude-code-plugins-plus](https://github.com/jeremylongshore/claude-code-plugins-plus)
- Official Claude Code documentation
