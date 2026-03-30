---
name: write-a-prd
description: Collaboratively create a PRD through interviews, codebase analysis, and modular design
allowed-tools: Agent, Read, Glob, Grep, Bash, WebFetch
model: opus
tags: planning, documentation
format-version: 1
user-invocable: true
metadata:
  author: mattpocock
  version: 1.0.0
---

Create a Product Requirements Document through a collaborative, structured process. Follow these steps (skip any that are not needed):

## Step 1: Gather Context

Ask the user to describe:
- The problem they're facing
- Any potential solutions they've considered
- Who the stakeholders are

## Step 2: Explore the Repository

Verify the user's assertions by exploring the codebase. Understand the current state of the code relevant to this feature or change.

## Step 3: Relentless Interview

Interview the user relentlessly about every aspect of this plan until you reach a shared understanding. Walk down each branch of the design tree, resolving dependencies between decisions one-by-one. For each question, provide your recommended answer.

Ask questions one at a time.

If a question can be answered by exploring the codebase, explore the codebase instead.

## Step 4: Module Design

Sketch the major modules needed. Seek opportunities to extract **deep modules** — those that encapsulate a lot of functionality in a simple, testable interface which rarely changes.

## Step 5: Generate PRD

Create the PRD as a GitHub issue using this template:

### Problem Statement
_The user's perspective on the challenges they face._

### Solution
_How the solution addresses the problem._

### User Stories
1. As a [role], I want [capability], so that [benefit].
2. ...

### Implementation Decisions
- **Modules:** Which modules are needed, their interfaces, and how they interact.
- **Technical clarifications:** Architecture, schema changes, API contracts.
- Do NOT include file paths or code snippets — keep this at the design level.

### Testing Decisions
- What makes a good test for this feature?
- Which modules should be tested?
- Any prior art or patterns to follow?

### Out of Scope
_Items explicitly excluded from this PRD._

### Further Notes
_Additional context about the feature._
