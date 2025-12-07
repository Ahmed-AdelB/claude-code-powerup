# MCP Servers Configuration

Model Context Protocol (MCP) servers extend Claude Code with external tool integrations.

## Installed Servers

| Server | Description | Use Case |
|--------|-------------|----------|
| **git** | Git operations | commits, branches, diffs, history |
| **github** | GitHub API | issues, PRs, repos, actions |
| **filesystem** | File system access | read/write files outside sandbox |
| **memory** | Persistent memory | retain context across sessions |
| **puppeteer** | Browser automation | screenshots, web scraping, testing |
| **slack** | Team communication | send messages, search channels |

## Configuration

The MCP servers are configured in `.mcp.json`:

```json
{
  "mcpServers": {
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git", "--repository", "."]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\ahmed"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-memory"]
    },
    "puppeteer": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-puppeteer"]
    },
    "slack": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-slack"]
    }
  }
}
```

## Additional MCP Servers to Consider

### High-Value Additions

| Server | Package | Purpose |
|--------|---------|---------|
| **PostgreSQL** | `@modelcontextprotocol/server-postgres` | Database queries |
| **SQLite** | `@modelcontextprotocol/server-sqlite` | Local database |
| **Fetch** | `@modelcontextprotocol/server-fetch` | Enhanced web fetching |
| **Brave Search** | `@anthropic/mcp-server-brave-search` | Web search API |

### RAG & Vector Search

| Server | Package | Purpose |
|--------|---------|---------|
| **MCP-RAG** | `mcp-rag` | Document Q&A with ChromaDB |
| **Claude-Context** | `claude-context` | Code search with 40% token reduction |

### DevOps & Cloud

| Server | Package | Purpose |
|--------|---------|---------|
| **Kubernetes** | `mcp-k8s-go` | Kubernetes operations |
| **AWS** | `@aws/mcp` | AWS service integration |
| **Terraform** | `terraform-mcp` | Infrastructure as code |

## Installation

```bash
# Install additional servers
npm install -g @modelcontextprotocol/server-postgres
npm install -g @modelcontextprotocol/server-sqlite
npm install -g @modelcontextprotocol/server-fetch
```

## Verification

After configuring MCP servers, verify with:
```
/mcp
```

This shows all connected MCP servers and their status.

## Resources

- [Official MCP Servers](https://github.com/modelcontextprotocol/servers)
- [Awesome MCP Servers](https://github.com/punkpeye/awesome-mcp-servers) - 7260+ servers catalogued
