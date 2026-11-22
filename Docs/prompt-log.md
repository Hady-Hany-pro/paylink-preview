# AI Prompt Log

| Date | Author | Stage | Tool and Model | Prompt Reference | Summary of Answer | Verdict and Why |
|---|---|---|---|---|---|---|
| 2026-11-22 | Marina | Requirements | ChatGPT – GPT-6 | REQ-P01 | Generated an initial requirements document covering functional requirements, user stories, acceptance criteria, NFRs, and ambiguities. | Accepted – Provided a useful starting point, but required further refinement to address missing details and decisions to the ambiguities. |


## Detailed Prompts

### REQ-P01 – Initial Requirements Document
Act as an experienced Requirements Engineer. Carefully analyze the PayLink project assignment brief that I provide, then help me create a complete, clear, and professionally structured requirements document for Phase 1.

Use the assignment brief as the primary source of truth. Do not invent features, business rules, constraints, or decisions that are not supported by the brief. If information is missing or unclear, identify it explicitly and label any proposed interpretation as a suggestion or assumption that requires team confirmation.

**Required document contents** 

1\. Problem Summary
– Explain the problem PayLink is intended to solve.

2\. **Stakeholders**
– Identify and briefly describe all relevant stakeholders, including:
• Customers
• Agents
• Administrators
• Support employees
• External billers

– Add other stakeholders only when they are justified by the assignment brief.

3\. **Functional Requirements and User Stories**

– Write at least 25 clear, non-duplicated user stories.

– Use this format for every story: “As a [user/actor], I want [goal], so that [benefit].”

– Give every story a unique ID (US-01, US-02, etc.).

– Cover all mandatory functional requirements from FR-1 to FR-28, respecting the priorities and scope stated in the assignment.

– Map each relevant FR number to the user story or stories that address it. Include a traceability table showing FR ID, priority (if specified), and related user story IDs.

4\. **Acceptance Criteria**

– Add acceptance criteria to every user story using Given / When / Then.

– Make the criteria specific, testable, and unambiguous.

– Include important success, failure, boundary, and exceptional cases where relevant to the brief.

5\. **Priorities**

– Assign each user story one priority: Must, Should, or Could.

– Base priorities on the assignment brief. Do not upgrade a Should or Could requirement to Must without justification.

– Briefly explain any priority that is not obvious.

6\. **Non-Functional Requirements**

– Write at least six measurable non-functional requirements.

– Cover relevant quality attributes such as performance, security, reliability, correctness, auditability, modifiability, and testability.

– Use measurable targets from the assignment brief wherever they are provided.

– For each NFR, include a unique ID, quality attribute, requirement statement, and a way to verify or measure it.

– Do not invent numerical targets. If the brief does not provide a target, propose one separately and label it as requiring team approval.

7\. **Ambiguities and Open Questions**

– Identify unclear, incomplete, or potentially conflicting points in the assignment.

– For each one, explain why clarification is needed.

– Do not silently resolve ambiguity by inventing a rule.


**Output and quality requirements**

• Write in clear, professional, simple English suitable for a university software engineering project.

• Organize the document using Markdown headings, numbered sections, and tables where useful.

• Make the document detailed enough to satisfy the Phase 1 requirements, but avoid unnecessary repetition.

• Keep terminology consistent throughout the document.

• Ensure that user stories, acceptance criteria, priorities, modules, business rules, and traceability mappings agree with one another.

• List any information you need from me or my team before a decision can be finalized.

Before drafting the complete document, first review the assignment brief and identify any missing information that prevents an accurate requirements document. Then produce the requirements document based on the available information, clearly marking unresolved questions rather than stopping unnecessarily.

