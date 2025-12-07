# Plugin Marketplace Integration

Extend Claude Code with community plugins from various marketplaces.

## Available Marketplaces

### 1. Claude Code Plugins Plus
**URL**: https://github.com/jeremylongshore/claude-code-plugins-plus

- **254 plugins** total
- **185 with Agent Skills** (auto-activate based on context)
- 100% Anthropic 2025 Schema compliant

**Install:**
```bash
# Add marketplace
claude plugin marketplace add jeremylongshore/claude-code-plugins-plus

# Browse plugins
claude plugin list

# Install specific plugin
claude plugin install <plugin-name>
```

### 2. Community Marketplaces

| Marketplace | URL | Description |
|-------------|-----|-------------|
| claude-code-marketplace | github.com/ananddtyagi/claude-code-marketplace | Community plugins |
| Dev-GOM marketplace | github.com/Dev-GOM/claude-code-marketplace | Development tools |
| ingpoc marketplace | github.com/ingpoc/claude-code-plugins-marketplace | Various plugins |

## Plugin Categories

### Development
- Code formatters
- Linters
- Build tools
- Testing utilities

### Productivity
- Note-taking integration
- Task management
- Time tracking
- Documentation generators

### AI/ML
- Model integrations
- Prompt templates
- Fine-tuning helpers
- Evaluation tools

### DevOps
- CI/CD integrations
- Container management
- Cloud deployments
- Monitoring tools

## Creating Custom Plugins

### Plugin Structure
```
my-plugin/
├── PLUGIN.md           # Plugin definition
├── commands/           # Slash commands
│   └── my-command.md
├── agents/             # Custom agents
│   └── my-agent.md
└── skills/             # Skills
    └── my-skill/
        └── SKILL.md
```

### PLUGIN.md Template
```markdown
---
name: my-plugin
version: 1.0.0
description: My custom plugin
author: Your Name
repository: github.com/user/my-plugin
---

# My Plugin

Description of what this plugin does.

## Installation

Instructions for installation.

## Usage

How to use the plugin.
```

## Recommended Plugins

| Plugin | Description | Category |
|--------|-------------|----------|
| `code-review-plus` | Enhanced code review | Development |
| `git-workflow` | Git workflow automation | DevOps |
| `test-generator` | Comprehensive test generation | Testing |
| `doc-writer` | Documentation generator | Productivity |
| `security-scan` | Security vulnerability scanner | Security |

## Plugin Commands

```bash
# List installed plugins
claude plugin list --installed

# Search plugins
claude plugin search <query>

# Update plugins
claude plugin update

# Remove plugin
claude plugin remove <plugin-name>

# Plugin info
claude plugin info <plugin-name>
```

## Best Practices

1. **Review plugins** before installing - check source code
2. **Keep plugins updated** - run `claude plugin update` regularly
3. **Report issues** - contribute to the community
4. **Share your plugins** - publish to marketplaces
