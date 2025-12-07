# Agent Consolidation Plan

**Current:** 94 agents
**Target:** 21 agents (78% reduction)
**Rationale:** Gemini 3 Pro Preview: "94 agents mimics a bureaucracy rather than an agile team"

## Consolidation Strategy

### Keep: Orchestrators (6 agents)
These are core routing and coordination - DO NOT CONSOLIDATE
- orchestrator
- task-router
- context-manager
- session-manager
- memory-coordinator
- parallel-coordinator

### Create: Core Engineers (6 consolidated agents)

#### 1. backend-engineer
**Replaces 10 agents:**
- backend-developer
- nodejs-expert
- django-expert
- fastapi-expert
- rails-expert
- go-expert
- graphql-specialist
- microservices-architect
- api-architect
- ~~authentication-specialist~~ (move to specialists)

**Responsibility:** All backend development. Stack passed as context.

#### 2. frontend-engineer
**Replaces 10 agents:**
- frontend-developer
- react-expert
- nextjs-expert
- vue-expert
- typescript-expert
- css-expert
- mobile-web-expert
- state-management-expert
- testing-frontend
- ~~accessibility-expert~~ (move to specialists)

**Responsibility:** All frontend development. Framework passed as context.

#### 3. database-specialist
**Replaces 6 agents:**
- database-architect
- postgresql-expert
- mongodb-expert
- redis-expert
- orm-expert
- migration-expert

**Responsibility:** All database work. DB type passed as context.

#### 4. devops-engineer
**Replaces 8 agents:**
- devops-engineer (consolidate into this)
- docker-expert
- kubernetes-expert
- ci-cd-specialist
- github-actions-specialist
- deployment-manager
- monitoring-expert
- infrastructure-architect

**Responsibility:** All DevOps. Tool passed as context.

#### 5. cloud-architect
**Replaces 5 agents:**
- aws-expert
- azure-specialist
- gcp-specialist
- serverless-specialist
- terraform-expert

**Responsibility:** All cloud platforms. Provider passed as context.

#### 6. test-engineer
**Replaces 8 agents:**
- unit-test-expert
- integration-test-expert
- e2e-test-expert
- api-test-expert
- performance-test-expert
- test-architect
- test-data-expert
- tdd-coach

**Responsibility:** All testing. Type passed as context.

### Keep: Specialists (9 consultant agents)
These provide specialized expertise when called by core engineers.

#### 7. security-expert
**Replaces 6 agents:**
- security-expert (keep this one)
- owasp-specialist (merge)
- penetration-tester (merge)
- vulnerability-scanner (merge)
- compliance-expert (merge)
- secrets-management-expert (merge)

**Role:** Security audits, vulnerability scanning, compliance

#### 8. performance-specialist
**Replaces 5 agents:**
- performance-analyst (keep this)
- profiling-specialist (merge)
- caching-expert (merge)
- load-testing-specialist (merge)
- bundle-optimizer (merge)

**Role:** Performance optimization, profiling, caching

#### 9. code-reviewer
**Replaces 8 agents:**
- code-reviewer (keep this)
- refactoring-expert (merge)
- technical-debt-analyst (merge)
- qa-validator (merge)
- linting-expert (merge)
- documentation-expert (merge)
- code-archaeologist (merge)
- rubber-duck-debugger (merge)

**Role:** Code quality, refactoring, technical debt

#### 10. architect
**Replaces 8 agents:**
- architect (keep this)
- tech-spec-writer (merge)
- tech-lead (merge)
- exponential-planner (merge)
- risk-assessor (merge)
- ~~ux-researcher~~ (less critical)
- ~~requirements-analyst~~ (merge to product-manager)
- ~~product-manager~~ (keep separate)

**Role:** System design, architecture, technical planning

#### 11. product-manager
**Replaces 4 agents:**
- product-manager (keep this)
- requirements-analyst (merge)
- ux-researcher (merge)
- ~~exponential-planner~~ (move to architect)

**Role:** Requirements, PRDs, user stories

#### 12. business-analyst
**Replaces 4 agents:**
- business-analyst (keep this)
- cost-optimizer (merge)
- product-analyst (merge)
- stakeholder-communicator (merge)

**Role:** Business analysis, cost optimization, stakeholder communication

#### 13. ml-engineer
**Replaces 4 agents:**
- ml-engineer (keep this)
- llm-integration-expert (merge)
- ai-agent-builder (merge)
- prompt-engineer (merge)

**Role:** AI/ML, LLM integration, agent building

#### 14. integration-specialist
**Replaces 4 agents:**
- api-integration-expert (keep this)
- mcp-integration-specialist (merge)
- third-party-api-specialist (merge)
- webhook-specialist (merge)

**Role:** API integrations, webhooks, MCP servers

#### 15. accessibility-expert
**Keep standalone:** Critical for inclusive design, WCAG compliance

#### 16. authentication-specialist
**Keep standalone:** Security-critical, OAuth, JWT, RBAC

## Final Count

| Category | Count |
|----------|-------|
| Orchestrators | 6 |
| Core Engineers | 6 |
| Specialists | 9 |
| **TOTAL** | **21** |

## Implementation Plan

1. Create new consolidated agent files
2. Archive old agents to `.claude/agents/_archived/`
3. Update CLAUDE.md to reference new structure
4. Test routing with consolidated agents

## Benefits

- ✅ Faster routing (less ambiguity)
- ✅ Lower context usage (smaller system prompt)
- ✅ Clearer responsibilities
- ✅ More agile workflow
- ✅ Easier to maintain
