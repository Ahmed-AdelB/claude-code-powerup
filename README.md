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
| Category | Examples |
|----------|----------|
| 01-general-purpose | Router, orchestrator |
| 02-planning | Architect, designer |
| 03-backend | API, database, services |
| 04-frontend | React, UI/UX |
| 05-database | SQL, migrations |
| 06-testing | Unit, integration, e2e |
| 07-quality | Code review, linting |
| 08-security | Vulnerability, audit |
| 09-performance | Optimization, profiling |
| 10-devops | CI/CD, Docker, K8s |
| 11-cloud | AWS, Azure, GCP |
| 12-ai-ml | ML models, data |
| 13-integration | APIs, webhooks |
| 14-business | Analysis, requirements |

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
