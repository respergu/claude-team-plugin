---
description: Analyze codebase for architectural friction and propose module-deepening refactors
model: opus
---

Explore a codebase like an AI would, surface architectural friction, discover opportunities for improving testability, and propose module-deepening refactors as GitHub issue RFCs.

A **deep module** (John Ousterhout, "A Philosophy of Software Design") has "a small interface hiding a large implementation." Deep modules are more testable, more AI-navigable, and let you test at the boundary instead of inside.

## Process

### 1. Explore the Codebase

Use the Agent tool with `subagent_type=Explore` to navigate naturally. Do NOT follow rigid heuristics — explore organically and note friction:

- Where does understanding one concept require bouncing between many small files?
- Where are modules so shallow that the interface is nearly as complex as the implementation?
- Where have pure functions been extracted just for testability, but the real bugs hide in how they're called?
- Where do tightly-coupled modules create integration risk in the seams between them?
- Which parts are untested or hard to test?

The friction you encounter IS the signal.

### 2. Present Candidates

Show a numbered list of deepening opportunities with:
- **Cluster:** modules/concepts involved
- **Why they're coupled:** shared types, call patterns, co-ownership
- **Dependency category:** per REFERENCE.md
- **Test impact:** what existing tests would be replaced

Do NOT propose interfaces yet. Ask: "Which of these would you like to explore?"

### 3. User Picks a Candidate

### 4. Frame the Problem Space

Write a user-facing explanation:
- Constraints any new interface must satisfy
- Dependencies it relies on
- A rough illustrative code sketch to ground the constraints

Show to user, then immediately proceed to Step 5.

### 5. Design Multiple Interfaces

Spawn 3+ sub-agents in parallel, each producing a radically different interface:

- **Agent 1:** "Minimize the interface — aim for 1-3 entry points max"
- **Agent 2:** "Maximize flexibility — support many use cases and extension"
- **Agent 3:** "Optimize for the most common caller — make the default case trivial"
- **Agent 4 (if applicable):** "Design around the ports & adapters pattern for cross-boundary dependencies"

Each sub-agent outputs: interface signature, usage example, what complexity it hides, dependency strategy, and trade-offs.

Present designs sequentially, compare in prose, then give an opinionated recommendation (strongest design and why, or propose a hybrid).

### 6. User Picks an Interface (or Accepts Recommendation)

### 7. Create GitHub Issue

Create a refactor RFC as a GitHub issue using `gh issue create` with the template from `references/REFERENCE.md`. Do NOT ask user to review before creating — just create it and share the URL.
