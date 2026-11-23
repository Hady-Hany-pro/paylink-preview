# AI Prompt Log

This log documents interactions with AI tools throughout Phase 1 (Requirements, Design, and DevOps), fulfilling the course requirement for structured prompting and critical evaluation of AI-generated output.

---

| Date | Author | Stage | Tool and Model | Prompt Reference | Summary of Answer | Verdict and Why |
|---|---|---|---|---|---|---|
| 2026-11-22 | Marina | Requirements | ChatGPT – GPT-6 | REQ-P01 | Generated an initial requirements document covering functional requirements, user stories, acceptance criteria, NFRs, and ambiguities. | Accepted – Provided a useful starting point, but required further refinement to address missing details and decisions to the ambiguities. |
| **2026-11-20** | Hady | Design | Claude 3.5 Sonnet | DES-P01 | Generated a Mermaid Use-Case diagram mapping stakeholders ST-01 through ST-07 to functional requirements FR-01 through FR-28. | **Fixed** – AI included a conflicting dispute refund case that violated the terminal Completed state, and missed the automated Scheduler. Fixed by removing the conflicting dispute use case to strictly adhere to Section 2.5 FSM, adding Scheduler ST-07, and adding explicit includes for Inquiry and Fraud checks. |
| **2026-11-21** | Hady | Design | ChatGPT – GPT-6 | DES-P02 | Generated a domain class diagram for PayLink showing Account, Wallet, Payment, and Biller entities with attributes and methods. | **Fixed** – AI generated 1:N Account-Wallet, used floating point types for currency, lacked temporal tracking for 10-minute temporary blocks, and omitted the 5 design patterns. Fixed by enforcing 1:1 Account-Wallet, exact Decimal types, adding `blocked_until: DateTime`, and explicitly modeling all 5 Design Patterns. |
| **2026-11-21** | Hady | Design | Claude 3.5 Sonnet | DES-P03 | Generated a Mermaid sequence diagram for refunding a rejected water bill payment with AquaCo (SOAP/XML). | **Fixed** – AI output had syntax errors (semicolons in notes), skipped the intermediate `FUNDS_HELD` state, and added an invalid CREDIT ledger entry on hold release. Fixed by eliminating syntax errors, enforcing strict Section 2.5 lifecycle (`Initiated` &rarr; `FundsHeld` &rarr; `SentToBiller` &rarr; `Failed` &rarr; `Refunded`), and restoring balance via hold status `RELEASED` with zero phantom credits. |
| **2026-11-22** | Hady | Design | Google Gemini (Gemini 2.0) | DES-P04 | Generated a Mermaid sequence diagram for paying an electricity bill with ElectroCo (REST/JSON) with fee calculation, hold, and double-entry ledger. | **Fixed** – AI had client send the fee, missed the bill inquiry step, omitted Hard Case 4 rejection, and created an unbalanced ledger when no agent was present. Fixed by dividing into Stage A (Inquiry & server fee calculation) and Stage B (Execution), adding Hard Case 4 rejection branch (`REJECTED`), and implementing an alt/else double-entry ledger that balances to 352.50 EGP for both direct and agent-assisted payments. |
| **2026-11-22** | Hady | Design | Claude 3.5 Sonnet | DES-P05 | Generated a database ERD in Mermaid covering all 8 Hard Cases with at least 10 tables. | **Fixed** – AI omitted webhook deduplication, lacked line-by-line reconciliation, used mandatory constraints for system accounts, had incorrect mandatory agent cardinality, and lacked temporary block duration. Fixed by adding `BILLER_CALLBACKS` (Hard Case 6), `RECONCILIATION_DISCREPANCIES` (Hard Case 7), `SYSTEM_CONFIGURATIONS` (FR-24), `FEE_TIERS` (tiered pricing), renaming to `SETTLEMENT_FILES`, adding `blocked_until`, making system credentials nullable, and correcting nullable relationships to `|o--o{`. |
| **2026-11-23** | Hady | Design | Google Gemini (Antigravity) | DES-P06 | Generated a Mermaid state diagram (stateDiagram-v2) for the complete bill payment lifecycle enforcing Section 2.5 finite state machine transitions. | **Fixed** – AI initially allowed automatic refunds from the Unknown state upon timeout. Fixed by enforcing strict Section 2.5 rules: Unknown requires retry queries or settlement reconciliation, and automatic refunds from Unknown are strictly prohibited (funds remain safely held). |
| 2026-11-23 | Mohamed Salah | DevOps Planning | ChatGPT – GPT-6 | DEV-P01 | Analyzed the Phase 1 assignment requirements and generated a prioritized implementation plan for the DevOps responsibilities, including Docker, SQL Server, testing, CI/CD, and repository workflow. | Accepted – Provided a clear implementation sequence based on the assignment brief and separated Phase 1 deliverables from Phase 2 implementation tasks. |
| 2026-11-23 | Mohamed Salah | DevOps | ChatGPT – GPT-6 | DEV-P02 | Generated a minimal FastAPI application with a health-check endpoint, project dependencies, and an automated test using Pytest and TestClient. | Accepted – Provided a working application foundation. Ruff identified an import-formatting issue in the test file, which was corrected before proceeding. |
| 2026-11-23 | Mohamed Salah | DevOps | ChatGPT – GPT-6 | DEV-P03 | Designed the Docker environment for FastAPI and Microsoft SQL Server 2025 using Dockerfile and Docker Compose, including persistent storage, health checks, and non-root execution. | Accepted – The Docker image built successfully, SQL Server became healthy, and the FastAPI container started successfully. |
| 2026-11-23 | Mohamed Salah | DevOps / Security | ChatGPT – GPT-6 | DEV-P04 | Reviewed Dockerfile security warnings and Docker Scout vulnerability findings, then evaluated base-image updates, package upgrades, and non-root execution. | Fixed – The initial recommendation suggested that updating the base image and system packages would address the vulnerability findings. Docker Scout still reported 14 high vulnerabilities in the selected base image. The assessment was corrected to distinguish fixable vulnerabilities from those without an available fix and to require scanning the final application image before claiming remediation. |
| 2026-11-23 | Mohamed Salah | DevOps / CI-CD | ChatGPT – GPT-6 | DEV-P05 | Generated a GitHub Actions CI workflow to install Python dependencies, run Ruff linting, execute Pytest, and build the Docker image on repository updates. | Accepted – The workflow was created with separate quality-checking steps. Local linting, testing, and Docker build checks passed. The remote GitHub Actions result remained pending at the time of logging. |
---

## Detailed Prompts

### REQ-P01 – Initial Requirements Document
Act as an experienced Requirements Engineer. Carefully analyze the PayLink project assignment brief that I provide, then help me create a complete, clear, and professionally structured requirements document for Phase 1.

Use the assignment brief as the primary source of truth. Do not invent features, business rules, constraints, or decisions that are not supported by the brief. If information is missing or unclear, identify it explicitly and label any proposed interpretation as a suggestion or assumption that requires team confirmation.

**Required document contents** 

1. **Problem Summary**
– Explain the problem PayLink is intended to solve.

2. **Stakeholders**
– Identify and briefly describe all relevant stakeholders, including:
• Customers
• Agents
• Administrators
• Support employees
• External billers
– Add other stakeholders only when they are justified by the assignment brief.

3. **Functional Requirements and User Stories**
– Write at least 25 clear, non-duplicated user stories.
– Use this format for every story: “As a [user/actor], I want [goal], so that [benefit].”
– Give every story a unique ID (US-01, US-02, etc.).
– Cover all mandatory functional requirements from FR-1 to FR-28, respecting the priorities and scope stated in the assignment.
– Map each relevant FR number to the user story or stories that address it. Include a traceability table showing FR ID, priority (if specified), and related user story IDs.

4. **Acceptance Criteria**
– Add acceptance criteria to every user story using Given / When / Then.
– Make the criteria specific, testable, and unambiguous.
– Include important success, failure, boundary, and exceptional cases where relevant to the brief.

5. **Priorities**
– Assign each user story one priority: Must, Should, or Could.
– Base priorities on the assignment brief. Do not upgrade a Should or Could requirement to Must without justification.
– Briefly explain any priority that is not obvious.

6. **Non-Functional Requirements**
– Write at least six measurable non-functional requirements.
– Cover relevant quality attributes such as performance, security, reliability, correctness, auditability, modifiability, and testability.
– Use measurable targets from the assignment brief wherever they are provided.
– For each NFR, include a unique ID, quality attribute, requirement statement, and a way to verify or measure it.
– Do not invent numerical targets. If the brief does not provide a target, propose one separately and label it as requiring team approval.

7. **Ambiguities and Open Questions**
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

---

### DES-P01 – Use-Case Diagram (System Actors & Functional Scope)
Act as an experienced Software Systems Architect. Analyze the PayLink assignment brief and the finalized requirements document (`Docs/Requirements.md`), then generate a complete, rigorous Mermaid Use-Case diagram for the Phase 1 Design Pack.

Use the requirements specification and Section 2.5 of the student brief as the absolute source of truth. Do not include features or relationships that contradict the finite state machine.

**Required diagram contents**

1. **System Stakeholders & Actors**
– Accurately model all primary and secondary actors:
• `ST-01: Customer` (End consumer paying bills and viewing history)
• `ST-02: Agent` (Retail merchant paying on behalf of customers)
• `ST-03: Administrator` (System config, fee matrix, biller catalog)
• `ST-04: Support Employee` (Auditing, search, account blocking)
• `ST-05: External Biller` (Utility debt inquiry and payment settlement)
• `ST-06: Notification Gateway` (Multi-channel SMS/push delivery)
• `ST-07: Scheduler / System Cron` (Automated nightly reconciliation and retry triggers)

2. **System Boundary & Functional Use Cases**
– Enclose all core use cases inside `subgraph PayLink System`.
– Map use case nodes directly to functional requirements (`FR-01` through `FR-28`).
– Explicitly model essential use cases: Registration (FR-01), KYC Verification (FR-02), Balance Query (FR-03), Wallet Top-Up (FR-04), Biller Discovery (FR-07), Debt Inquiry (FR-08), Bill Payment (FR-09), Agent Assisted Payment & Commission (FR-17), Webhook Callback (FR-14), Unknown Payment Retry (FR-13), Fraud & Velocity Checks (FR-18/19), Payment History Search (FR-20), Account Blocking (FR-21), Financial Audit Log (FR-25), Nightly Reconciliation (FR-26), Dynamic Config Management (FR-24), and Operations Dashboard (FR-28).

3. **Strict State Machine Alignment**
– Strictly respect Section 2.5 of the brief: `Completed` is an immutable terminal state.
– Do not model post-completion dispute refund use cases that violate the state machine lifecycle.

4. **UML Relationships & Includes**
– Model payment dependencies using standard UML include semantics:
• Bill Payment (`FR-09`) must explicitly include Real-Time Bill Inquiry (`FR-08`) and Fraud Checks (`FR-18/19`).
• Agent Payment (`FR-17`) must explicitly include Customer Bill Payment (`FR-09`).
• Bill Payment must trigger Notification Dispatch (`FR-22/23`).

**Output and quality requirements**
• Generate valid, clean Mermaid code using `graph LR`.
• Avoid complex nested labels that break Mermaid parsers.
• Group related use cases logically to ensure clean visual layout in markdown viewers.

---

### DES-P02 – Domain Class Diagram & 5 Design Patterns
Act as a Senior Object-Oriented Domain Architect. Carefully review the PayLink domain model, fiduciary balance invariants, and the course design pattern requirements, then create an enterprise-grade Domain Class Diagram in Mermaid.

Follow the assignment brief's strict financial rules: balances must never be stored as unconstrained mutable numbers, floating-point arithmetic is strictly prohibited, and design patterns must be applied with concrete architectural justification.

**Required diagram contents**

1. **Core Domain Entities & Attributes**
– Model core domain classes with exact types:
• `Account`: UUID id, national_id, phone_number, email, role, verification_level, status, `blocked_until: DateTime` (nullable, recording the 10-minute velocity lockout expiration per FR-19), daily_spent_amount, and daily_limit_reset_at.
• `Wallet`: UUID id, account_id, available_balance (Decimal), held_balance (Decimal), currency. Methods for creating, releasing, and capturing holds, and recalculating balances from ledger entries.
• `LedgerEntry`: UUID id, wallet_id, payment_id (nullable), transaction_reference, direction (DEBIT/CREDIT), amount (Decimal), balance_after (Decimal), description, created_at.
• `Hold`: UUID id, wallet_id, payment_id, amount (Decimal), status (HELD, CAPTURED, RELEASED), expires_at, created_at.
• `Payment`: UUID id, idempotency_key, customer_id, agent_id (nullable), biller_service_id, bill_reference, biller_transaction_id, bill_amount (Decimal), fee_amount (Decimal), agent_commission (Decimal), total_amount (Decimal), status (PaymentStatus), retry_count.
• `Biller` and `BillerService`: Full catalog attributes and bounds.
• `FeeConfiguration` and `FeeTier`: Supporting fixed, percentage, and tiered pricing structures.
• `SettlementFile` and `ReconciliationDiscrepancy`: Representing nightly reconciliation files and line-by-line variance auditing.
• `Notification` and `AuditLog`: Supporting multi-channel alerting and immutable security logging.

2. **Fiduciary Balance Invariant & Relationships**
– Model Account-to-Wallet as strict 1-to-1 (`Account "1" --> "1" Wallet`).
– Wallet tracks multiple LedgerEntries and reserves multiple Holds.
– Payment locks funds via 0..1 Hold.
– All monetary quantities must use exact `Decimal` types.

3. **Explicit Realization of the 5 Required Design Patterns**
– Clearly model each of the 5 design patterns required by Section 3.4 of the brief:
• **Adapter & Factory Pattern:** `BillerAdapter` interface (`inquire`, `pay`, `checkStatus`), `BillerFactory`, and concrete implementations (`ElectroCoAdapter`, `AquaCoAdapter`, `TopUpNetAdapter`).
• **Strategy Pattern:** `FeeStrategy` interface and concrete implementations (`FixedFeeStrategy`, `PercentageFeeStrategy`, `TieredFeeStrategy`).
• **State Pattern:** `PaymentState` interface managing valid lifecycle state transitions.
• **Chain of Responsibility Pattern:** `FraudCheckHandler` abstract class with handler chain (`DailyLimitHandler`, `VelocityHandler`, `BlockedAccountHandler`).
• **Observer & Command Pattern:** `PaymentObserver` / `NotificationService` and `RetryPaymentCommand` decoupling external side-effects.

**Output and quality requirements**
• Generate valid Mermaid `classDiagram` code.
• Include visibility indicators (`+` public, `-` private), parameter types, and return types.
• Organize relationships cleanly into entity associations, pattern implementations, and inheritance.

---

### DES-P03 – Refund Sequence Diagram (Failure Handling & Zero Phantom Credits)
Act as a Lead Fintech Payments Orchestration Engineer. Design a complete, step-by-step sequence diagram in Mermaid illustrating the execution and automatic refund of a failed bill payment.

Use Section 2.2, Section 2.5, Section 2.7 (Hard Case 3), and Section 3.3 (Correctness) of the student brief as the primary source of truth.

**Required diagram contents**

1. **Scenario & Protocol Specifications**
– The scenario represents a customer attempting to pay an AquaCo water bill where AquaCo rejects the transaction with a SOAP-style XML fault (`AMOUNT_EXCEEDS_BILL`).
– Model all participating subsystems: Customer, API Gateway, Fraud Engine, Wallet & Ledger Module, Payment Orchestrator, AquaCo Adapter, External AquaCo SOAP Server, and Notification Gateway.

2. **Strict Payment Lifecycle Transitions**
– Enforce the strict finite state machine defined in Section 2.5 with no omitted intermediate steps:
`Initiated` &rarr; `FundsHeld` &rarr; `SentToBiller` &rarr; `Failed` &rarr; `Refunded`.
– Jumping directly from Hold creation to `SentToBiller` without passing through `FundsHeld` is strictly prohibited.

3. **Mathematical Balance Invariant & Zero Phantom Credits**
– Accurately depict how funds are held and released without corrupting the financial ledger:
• At hold creation, funds move from `available_balance` to `held_balance`. No ledger debit has occurred.
• When AquaCo returns the SOAP fault, the payment transitions to `FAILED`.
• To refund, the orchestrator releases the hold (`status = RELEASED`).
• In accordance with the balance formula $\text{available\_balance} = \sum(\text{ledger}) - \sum(\text{active holds})$, releasing the hold immediately restores available balance.
• Do not insert an erroneous CREDIT ledger entry during hold release, as that would generate duplicate phantom money.

4. **External Notifications & Client Response**
– Orchestrator emits `PaymentFailed` event to Notification Gateway.
– Gateway asynchronously delivers localized SMS notification to customer explaining the biller refusal.
– API Gateway returns HTTP 422 Unprocessable Entity with error code and confirmation that funds remain available.

**Output and quality requirements**
• Output valid Mermaid `sequenceDiagram` syntax with `autonumber` enabled.
• Ensure notes and messages are clean of special characters that break Mermaid parsing (no semicolons in text, no unescaped `#` symbols, no HTML angle brackets).

---

### DES-P04 – Bill Payment Sequence Diagram (Balanced Multi-Party Double-Entry Ledger)
Act as a Principal Payment Systems Architect & Ledger Specialist. Create an end-to-end Mermaid sequence diagram modeling a complete, successful utility bill payment with real-time inquiry, server-calculated fees, and balanced double-entry ledger settlement.

Follow Egyptian fintech rules, Section 2.2, Section 2.6, and Section 2.7 of the student brief as the absolute source of truth.

**Required diagram contents**

1. **Stage A: Real-Time Bill Inquiry & Server Fee Calculation**
– Customer initiates debt inquiry with ElectroCo meter number.
– ElectroCo Adapter queries external REST/JSON API and returns debt amount (350.00 EGP).
– Core `Fees & Commissions Module` dynamically computes the service fee on the server using the configured fee strategy (Fixed fee = 2.50 EGP). The client is never trusted to calculate fees.
– Customer receives inquiry summary displaying: Bill = 350.00 EGP, Fee = 2.50 EGP, Total Due = 352.50 EGP.

2. **Stage B: Payment Execution & Hard Case 4 Branching**
– Customer submits payment confirmation with unique `IdempotencyKey`.
– Engine executes Idempotency check: if key exists in cache, return cached receipt immediately without duplicate deduction.
– If key is new, transition payment to `INITIATED`.
– Engine evaluates Fraud, Limit & Velocity Chain.
– **Hard Case 4 Handling:** Model an explicit `alt` branch where limit or velocity checks fail (e.g., velocity > 5 req/60s). Engine transitions payment to `REJECTED`, returns HTTP 422, and terminates with 0 funds held.
– If validation passes: Wallet reserves 352.50 EGP in `HOLDS` table, decreasing available balance. Payment transitions to `FUNDS_HELD`.

3. **Biller Dispatch & Confirmation**
– Payment transitions to `SENT_TO_BILLER`.
– Adapter invokes ElectroCo `POST /api/v1/bills/pay`.
– ElectroCo confirms payment with HTTP 200, status `PAID`, and external transaction ID `ELEC-5544`.

4. **Balanced Multi-Party Double-Entry Ledger (FR-5 & FR-17)**
– Inside an atomic database transaction, transition payment to `COMPLETED` and capture the hold.
– Model balanced double-entry ledger entries using an `alt / else` block:
• **Direct Customer Payment (No Agent):**
  - Customer Wallet: `DEBIT 352.50 EGP`
  - Biller Settlement Payable Account: `CREDIT 350.00 EGP`
  - PayLink Fee Income Account: `CREDIT 2.50 EGP`
  - Total Debits (352.50) == Total Credits (350.00 + 2.50).
• **Agent-Assisted Payment (FR-17):**
  - Customer Wallet: `DEBIT 352.50 EGP`
  - Biller Settlement Payable Account: `CREDIT 350.00 EGP`
  - PayLink Fee Income Account: `CREDIT 1.50 EGP`
  - Agent Wallet Commission: `CREDIT 1.00 EGP` (40% of 2.50 EGP fee)
  - Total Debits (352.50) == Total Credits (350.00 + 1.50 + 1.00).

5. **Asynchronous Alerts & Customer Receipt**
– PaymentCompleted event emitted to Notification Gateway for async SMS/push dispatch.
– API Gateway returns HTTP 200 with final receipt and external biller reference.

**Output and quality requirements**
• Pure Mermaid `sequenceDiagram` syntax with `autonumber`.
• Visual grouping using `rect rgb(...)` blocks distinguishing Stage A from Stage B.
• Clean, unescaped text adhering strictly to Mermaid statement grammar.

---

### DES-P05 – Database ERD (14 Relational Tables covering all Hard Cases)
Act as a Senior Database Administrator & Fintech Data Architect. Design a normalized, relational Entity-Relationship Diagram in Mermaid for PayLink's PostgreSQL database.

The schema must cover all mandatory functional modules, satisfy 3NF principles where appropriate, and provide concrete tables supporting all 8 Hard Cases defined in Section 2.7 of the student brief.

**Required diagram contents**

1. **Table Coverage (Minimum 10 tables required; target 14 relational tables)**
– `ACCOUNTS`: id (PK), national_id, phone_number, email (all three nullable for SYSTEM accounts, UNIQUE for customers/agents), role, verification_level, status, `blocked_until` (timestamp for velocity block expiration), daily_spent_amount, daily_limit_reset_at, timestamps.
– `WALLETS`: id (PK), account_id (FK, UK), currency, available_balance, held_balance, timestamps.
– `LEDGER_ENTRIES`: id (PK), wallet_id (FK), payment_id (FK, nullable), transaction_reference (UK), direction (DEBIT/CREDIT), amount, balance_after, description, created_at.
– `HOLDS`: id (PK), wallet_id (FK), payment_id (FK, UK), amount, status (HELD/CAPTURED/RELEASED), expires_at, timestamps.
– `BILLERS` and `BILLER_SERVICES`: Provider catalog, protocols, service boundaries, and required field definitions.
– `FEE_CONFIGURATIONS` and `FEE_TIERS`: Configurable fee rules supporting fixed, percentage, and tiered rates with promo windows.
– `PAYMENTS` and `PAYMENT_STATUS_HISTORY`: Central payment records with idempotency_key (UK), external biller_transaction_id, fee_amount, agent_commission, and immutable audit history of all state transitions.
– `BILLER_CALLBACKS`: Unique `callback_reference` (UK) storing asynchronous webhook payloads for Hard Case 6 deduplication.
– `SETTLEMENT_FILES` and `RECONCILIATION_DISCREPANCIES`: Ingesting daily biller settlement files and logging matched, missing, or mismatched records for Hard Case 7 reconciliation.
– `NOTIFICATIONS`: Dispatch records with retry counts, channel, template codes, and delivery statuses (including UNDELIVERED per FR-23).
– `SYSTEM_CONFIGURATIONS`: Key-value configuration store for dynamic runtime threshold and limit management (FR-24).
– `AUDIT_LOGS`: Append-only compliance trail recording actor, action, affected entity, before/after JSON states, and IP address (FR-25).

2. **Precise Cardinality & Nullability Constraints**
– `ACCOUNTS ||--|| WALLETS`: Strict 1:1 ownership.
– `ACCOUNTS |o--o{ PAYMENTS : agent_processes`: Optional agent involvement (0 or 1 agent per payment).
– `PAYMENTS |o--o{ LEDGER_ENTRIES : generates`: Nullable payment_id for non-payment ledger writes (top-ups, manual adjustments).
– `PAYMENTS |o--o{ RECONCILIATION_DISCREPANCIES : referenced_in`: Nullable payment_id for external discrepancies absent from PayLink database.
– `BILLERS ||--o{ SETTLEMENT_FILES`: Matching class diagram naming conventions.

**Output and quality requirements**
• Generate valid Mermaid `erDiagram` code.
• Include PK and FK tags alongside field type annotations.
• Accurately quote string constraints and explanatory comments.

---

### DES-P06 – Payment State Machine & Section 2.5 Lifecycle
Act as a Senior Payment Systems Reliability Architect. Create a formal finite state machine diagram in Mermaid using `stateDiagram-v2` specifying the complete lifecycle of a PayLink bill payment.

Use Section 2.5 (Payment life cycle), Section 2.6 (Business rules), and Hard Cases 1 & 2 of the student brief as the absolute source of truth.

**Required diagram contents**

1. **Finite States Representation**
– Accurately model all mandatory lifecycle states:
• `Initiated` (Payment request received and validated)
• `FundsHeld` (Amount successfully reserved in customer wallet hold)
• `Rejected` (Initial fraud/limit failure or insufficient balance; terminal)
• `SentToBiller` (Payload dispatched downstream to external biller adapter)
• `Completed` (Biller confirms success; hold converted to permanent charge; terminal)
• `Failed` (Biller refuses transaction or timeout resolved as unpaid)
• `Unknown` (Biller request times out after 10 seconds; funds strictly held)
• `Refunded` (Held funds restored to available balance; terminal)
– Explicitly mark `Rejected`, `Completed`, and `Refunded` as final states terminating at `[*]`.

2. **Valid Transition Invariants (Section 2.5)**
– Enforce the strict transition matrix defined in Section 2.5 with no unauthorized transitions:
• `Initiated` &rarr; `FundsHeld` (Fraud checks pass and wallet has enough funds)
• `Initiated` &rarr; `Rejected` (Fraud check fails or funds are insufficient)
• `FundsHeld` &rarr; `SentToBiller` (Request sent to biller adapter)
• `SentToBiller` &rarr; `Completed` (Biller confirms PAID)
• `SentToBiller` &rarr; `Failed` (Biller refuses with error code)
• `SentToBiller` &rarr; `Unknown` (No response within 10-second timeout per Hard Case 2)
• `Unknown` &rarr; `Completed` (Biller later confirms via callback, retry query, or settlement file)
• `Unknown` &rarr; `Failed` (Biller later refuses or nightly reconciliation confirms no payment)
• `Failed` &rarr; `Refunded` (Hold released back to customer wallet)

3. **Strict Unknown State Handling & No Auto-Refund Rule**
– Accurately highlight the core fintech invariant: A payment in `Unknown` is NEVER refunded automatically.
– Funds must strictly remain in `held_balance` until conclusive confirmation is received from the biller or nightly settlement file.

4. **Annotations & Notes**
– Include descriptive notes documenting:
• Note on `Unknown`: "A payment in UNKNOWN is NEVER refunded automatically! Money stays held until conclusive verification (FR-13)."
• Note on `Completed`: "Hold is captured into permanent debit. Agent commission is credited if applicable (FR-17)."

**Output and quality requirements**
• Generate valid Mermaid code using `stateDiagram-v2`.
• Clean transition descriptions and readable layout.
• Ensure full consistency with all other 5 Phase 1 design models.
---

### DEV-P01 – Phase 1 DevOps Planning

Act as an experienced DevOps Engineer and Software Engineering Project Advisor. Carefully analyze the PayLink Year Work Project assignment brief and identify the exact responsibilities and deliverables required for Phase 1.

**Context:**

The project uses Python and FastAPI. The team has already created a private GitHub repository and divided responsibilities between Requirements, Design, and DevOps.

**Required tasks:**

1. Identify all DevOps-related Phase 1 requirements from the assignment brief.
2. Separate mandatory Phase 1 tasks from Phase 2 implementation tasks.
3. Identify the required Docker, Docker Compose, GitHub Actions, and repository configuration.
4. Define the minimum application and testing skeleton required for Phase 1.
5. Provide a practical implementation sequence.
6. Explain how to verify each deliverable before submission.

**Output requirements:**

- Follow the assignment brief as the primary source of truth.
- Do not introduce unnecessary Phase 2 implementation.
- Provide actionable steps and commands.
- Clearly distinguish completed, pending, and unverified requirements.

---

### DEV-P02 – FastAPI Foundation and Automated Testing

Act as a Senior Python Backend Engineer. Help me create the minimum working application foundation for the PayLink project using Python and FastAPI.

**Required implementation:**

1. Create a FastAPI application inside `app/main.py`.
2. Configure the application title, description, and version.
3. Implement a health-check endpoint using `GET /health`.
4. Return a JSON response indicating that the application is healthy.
5. Create an automated test using Pytest and FastAPI TestClient.
6. Store the test inside `Test/test_main.py`.
7. Prepare a `requirements.txt` containing the necessary dependencies.

**Constraints:**

- Keep the application minimal because this is Phase 1.
- Do not implement wallet, payments, biller integrations, or business logic.
- Ensure that the application can run locally and inside Docker.
- Ensure the test verifies both the HTTP status code and response body.

**Expected result:**

A working FastAPI skeleton with at least one passing automated test.

---

### DEV-P03 – Docker and Microsoft SQL Server Setup

Act as a Senior DevOps Engineer. Design a Docker-based development environment for the PayLink backend using Python, FastAPI, and Microsoft SQL Server 2025 Developer Edition.

**Required components:**

1. A Dockerfile for the FastAPI application.
2. A Docker Compose configuration containing:
   - FastAPI application service.
   - Microsoft SQL Server 2025 Developer service.
3. A persistent Docker volume for SQL Server data.
4. A SQL Server health check.
5. Application startup dependency on database health.
6. Environment-variable configuration for database credentials.
7. A `.env.example` file without real credentials.

**Security requirements:**

- The FastAPI container must run using a non-root user.
- Do not hardcode database passwords in Dockerfile or Compose.
- Do not expose secrets through Git commits.
- Optimize Dockerfile layers and dependency installation.

**Verification requirements:**

- Docker Compose configuration must validate successfully.
- Both containers must start successfully.
- SQL Server must reach a healthy state.
- FastAPI must respond successfully to its health-check endpoint.

Do not claim that the application has an active database connection unless that connection is actually implemented and tested.

---

### DEV-P04 – Dockerfile Security and Vulnerability Analysis

Act as a Container Security Engineer. Review my Dockerfile and Docker vulnerability scan results.

**Context:**

The application uses Python 3.14 with a Debian Slim base image. SonarLint reported a root-user security warning and Dockerfile optimization issues. Docker Scout also reported high-severity vulnerabilities in the base image.

**Required tasks:**

1. Identify the security implications of running the application as root.
2. Modify the Dockerfile to create and use a dedicated non-root application user.
3. Improve Dockerfile layer organization by combining consecutive RUN instructions where appropriate.
4. Recommend safe base-image updates.
5. Explain the difference between operating-system vulnerabilities and Python package vulnerabilities.
6. Analyze Docker Scout findings and identify which vulnerabilities have available fixed versions.
7. Distinguish between vulnerabilities that can be fixed and vulnerabilities without an available fix.

**Important constraints:**

- Do not suppress security warnings.
- Do not claim that vulnerabilities are resolved without a new scan.
- Do not blindly upgrade dependencies without considering compatibility.
- Verify the final built application image rather than relying only on the base-image scan.

**Expected result:**

A more secure Dockerfile, documented vulnerability findings, and a clear verification process.

---

### DEV-P05 – GitHub Actions CI Pipeline

Act as a Senior DevOps Engineer. Create a GitHub Actions Continuous Integration workflow for the PayLink backend project.

**Project configuration:**

- Backend: Python 3.14.
- Framework: FastAPI.
- Testing: Pytest.
- Linting: Ruff.
- Containerization: Docker.

**Required workflow:**

1. Trigger the workflow on pushes to repository branches.
2. Trigger the workflow on Pull Requests targeting `main`.
3. Support manual execution.
4. Checkout the repository.
5. Set up the required Python version.
6. Install dependencies from `requirements.txt`.
7. Run Ruff checks against the application and tests.
8. Execute automated tests using Pytest.
9. Build the Docker image.

**Security requirements:**

- Use official, maintained GitHub Actions.
- Apply the minimum required workflow permissions.
- Do not expose environment secrets in logs.
- Keep the workflow readable and maintainable.

**Expected result:**

A CI pipeline that automatically checks code quality, executes tests, and verifies that the Docker image can be built before changes are merged into the main branch.