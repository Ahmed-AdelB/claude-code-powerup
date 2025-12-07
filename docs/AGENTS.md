# Specialized Agents

25 specialized agents across 3 categories + 2 integrations to handle any development task.

## Agent Categories

### 01-general-purpose (6 agents)
Core orchestration and coordination agents.
- `context-manager` - Manages conversation context
- `memory-coordinator` - Coordinates persistent memory
- `orchestrator` - Main task orchestrator
- `parallel-coordinator` - Handles parallel task execution
- `session-manager` - Manages session state
- `task-router` - Routes tasks to appropriate agents

### 02-planning (8 agents)
Design and planning specialists.
- `architect` - Software architecture design
- `exponential-planner` - Breaking down complex tasks
- `product-manager` - Product requirements
- `requirements-analyst` - Requirements analysis
- `risk-assessor` - Risk assessment
- `tech-lead` - Technical leadership
- `tech-spec-writer` - Technical specifications
- `ux-researcher` - User experience research

### 03-backend (10 agents)
Backend development specialists.
- `api-architect` - API design
- `authentication-specialist` - Auth systems
- `backend-developer` - General backend
- `django-expert` - Django framework
- `fastapi-expert` - FastAPI framework
- `go-expert` - Go language
- `graphql-specialist` - GraphQL APIs
- `microservices-architect` - Microservices
- `nodejs-expert` - Node.js
- `rails-expert` - Ruby on Rails

### 04-frontend (10 agents)
Frontend development specialists.
- `accessibility-expert` - a11y compliance
- `css-expert` - CSS/styling
- `frontend-developer` - General frontend
- `mobile-web-expert` - Mobile web
- `nextjs-expert` - Next.js framework
- `react-expert` - React framework
- `state-management-expert` - State management
- `testing-frontend` - Frontend testing
- `typescript-expert` - TypeScript
- `vue-expert` - Vue.js framework

### 05-database (6 agents)
Database specialists.
- `database-architect` - Database design
- `migration-expert` - Database migrations
- `mongodb-expert` - MongoDB
- `orm-expert` - ORM patterns
- `postgresql-expert` - PostgreSQL
- `redis-expert` - Redis

### 06-testing (8 agents)
Testing specialists.
- `api-test-expert` - API testing
- `e2e-test-expert` - End-to-end testing
- `integration-test-expert` - Integration testing
- `performance-test-expert` - Performance testing
- `tdd-coach` - Test-driven development
- `test-architect` - Test architecture
- `test-data-expert` - Test data management
- `unit-test-expert` - Unit testing

### 07-quality (8 agents)
Code quality specialists.
- `code-archaeologist` - Legacy code analysis
- `code-reviewer` - Code reviews
- `documentation-expert` - Documentation
- `linting-expert` - Linting and formatting
- `qa-validator` - QA validation
- `refactoring-expert` - Code refactoring
- `rubber-duck-debugger` - Debugging assistance
- `technical-debt-analyst` - Tech debt analysis

### 08-security (6 agents)
Security specialists.
- `compliance-expert` - Compliance (SOC2, GDPR)
- `owasp-specialist` - OWASP Top 10
- `penetration-tester` - Penetration testing
- `secrets-management-expert` - Secrets management
- `security-expert` - General security
- `vulnerability-scanner` - Vulnerability scanning

### 09-performance (5 agents)
Performance optimization specialists.
- `bundle-optimizer` - Bundle optimization
- `caching-expert` - Caching strategies
- `load-testing-specialist` - Load testing
- `performance-analyst` - Performance analysis
- `profiling-specialist` - Code profiling

### 10-devops (8 agents)
DevOps specialists.
- `ci-cd-specialist` - CI/CD pipelines
- `deployment-manager` - Deployments
- `devops-engineer` - General DevOps
- `docker-expert` - Docker
- `github-actions-specialist` - GitHub Actions
- `infrastructure-architect` - Infrastructure
- `kubernetes-expert` - Kubernetes
- `monitoring-expert` - Monitoring

### 11-cloud (5 agents)
Cloud platform specialists.
- `aws-expert` - Amazon Web Services
- `azure-specialist` - Microsoft Azure
- `gcp-specialist` - Google Cloud Platform
- `serverless-specialist` - Serverless
- `terraform-expert` - Terraform IaC

### 12-ai-ml (4 agents)
AI/ML specialists.
- `ai-agent-builder` - AI agent development
- `llm-integration-expert` - LLM integrations
- `ml-engineer` - Machine learning
- `prompt-engineer` - Prompt engineering

### 13-integration (4 agents)
Integration specialists.
- `api-integration-expert` - API integrations
- `mcp-integration-specialist` - MCP servers
- `third-party-api-specialist` - Third-party APIs
- `webhook-specialist` - Webhooks

### 14-business (4 agents)
Business analysis specialists.
- `business-analyst` - Business analysis
- `cost-optimizer` - Cost optimization
- `product-analyst` - Product analysis
- `stakeholder-communicator` - Communication

## Usage

Agents are automatically invoked based on task context. You can also explicitly request an agent:

```
Use the security-expert agent to review this code
```

Or use slash commands:
```
/agents:security security-expert
```

## Agent Location

Agents are stored in:
- `~/.claude/agents/` (user-level)
- `.claude/agents/` (project-level)
