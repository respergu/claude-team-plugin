# Dependency Categories

When classifying coupling between modules, use these categories:

## 1. Shared Data
Modules read/write the same data (database tables, files, shared state). Changes to the data schema ripple through all dependents.

## 2. Shared Types
Modules import the same type definitions. Changing a type forces changes in all consumers.

## 3. Call Chain
Module A calls B which calls C. Testing A requires B and C to work (or be mocked).

## 4. Co-Ownership
Multiple modules own overlapping responsibilities. Changes require coordinating across boundaries.

## 5. Temporal
Modules must execute in a specific order. Reordering breaks behavior.

---

# Refactor RFC Issue Template

Use this template when creating GitHub issues in Step 7:

```markdown
## RFC: [Module Name] Deepening Refactor

### Problem
_What friction was observed and why it matters._

### Current State
_Which modules/files are involved and how they're coupled._

### Dependency Category
_From the list above._

### Proposed Interface
_The chosen interface design from Step 6._

### Migration Path
1. _Step-by-step migration from current to proposed state._
2. _Each step should be independently deployable._

### Test Impact
- Tests to add: ...
- Tests to remove/replace: ...
- Tests unchanged: ...

### Risks
_What could go wrong and how to mitigate it._
```
