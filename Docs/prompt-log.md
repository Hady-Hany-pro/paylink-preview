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
| **2026-11-23** | Hady | Design | Google Gemini (Antigravity) | DES-P06 | Created an interactive HTML viewer using Mermaid.js CDN that displays all 6 PayLink design models with tabbed navigation and responsive zooming. | **Accepted** – Provided a standalone single-page HTML application embedding all 6 Mermaid models with tabs, clean styling, and full rendering support. |

---

## Detailed Prompts

### REQ-P01 – Initial Requirements Document
* **Author:** Marina | **Stage:** Requirements | **Tool:** ChatGPT – GPT-6
```text
Act as an experienced Requirements Engineer. Carefully analyze the PayLink project assignment brief that I provide, then help me create a complete, clear, and professionally structured requirements document for Phase 1.

Use the assignment brief as the primary source of truth. Do not invent features, business rules, constraints, or decisions that are not supported by the brief. If information is missing or unclear, identify it explicitly and label any proposed interpretation as a suggestion or assumption that requires team confirmation.

Required document contents:
1. Problem Summary
2. Stakeholders (Customers, Agents, Administrators, Support, External billers)
3. Functional Requirements and User Stories (FR-1 to FR-28, MoSCoW priorities)
4. Acceptance Criteria (Given / When / Then)
5. Non-Functional Requirements (Measurable metrics)
6. Ambiguities and Architectural Decisions
```

---

### DES-P01 – Use-Case Diagram
* **Author:** Hady | **Stage:** Design | **Tool:** Claude 3.5 Sonnet
```text
Act as a Software Architect. Based on PayLink's requirements (Docs/Requirements.md), generate a Mermaid Use-Case diagram that maps stakeholders ST-01 through ST-07 to functional requirements FR-01 through FR-28 including biller inquiries, wallet payments, commissions, and reconciliation.
Ensure the diagram strictly adheres to Section 2.5 of the student brief (Completed is a terminal state), and model explicit <<include>> relationships for Bill Inquiry and Fraud checks.
```

---

### DES-P02 – Domain Class Diagram & 5 Design Patterns
* **Author:** Hady | **Stage:** Design | **Tool:** ChatGPT – GPT-6
```text
Generate a Mermaid Class Diagram for PayLink's domain model, showing Account, Wallet, Payment, Biller, LedgerEntry, Hold, FeeConfiguration, FeeTier, SettlementFile, ReconciliationDiscrepancy, Notification, and AuditLog.
Requirements:
1. Model Account-to-Wallet as 1-to-1.
2. Use exact Decimal types for monetary amounts (no float/double).
3. Include blocked_until timestamp in Account for the 10-minute temporary velocity block (FR-19).
4. Explicitly model the 5 Design Patterns: Adapter & Factory (Billers), Strategy (Fees), State (Payment Lifecycle), Chain of Responsibility (Fraud Checks), and Observer/Command (Decoupling).
```

---

### DES-P03 – Refund Sequence Diagram (Zero Phantom Credits)
* **Author:** Hady | **Stage:** Design | **Tool:** Claude 3.5 Sonnet
```text
Create a Mermaid sequence diagram for the refund flow when AquaCo rejects a water bill payment (SOAP/XML fault: AMOUNT_EXCEEDS_BILL).
Requirements:
1. Strictly follow the Section 2.5 lifecycle: Initiated -> FundsHeld -> SentToBiller -> Failed -> Refunded.
2. Do not insert invalid CREDIT ledger entries on hold release; adhere to the balance formula: available_balance = sum(LEDGER_ENTRIES) - sum(active_HOLDS). Updating hold to RELEASED restores available balance with zero phantom credits.
3. Ensure syntax is clean for Mermaid (no semicolons in notes, no raw # or unescaped tokens).
```

---

### DES-P04 – Bill Payment Sequence Diagram (Balanced Ledger)
* **Author:** Hady | **Stage:** Design | **Tool:** Google Gemini (Gemini 2.0)
```text
Generate a Mermaid sequence diagram for paying an electricity bill through ElectroCo (REST/JSON) showing real-time inquiry, server fee calculation, limits check, wallet hold, biller dispatch, and balanced multi-party ledger.
Requirements:
1. Divide the flow into Stage A (Inquiry & server fee calculation) and Stage B (Payment execution).
2. Include an alt branch for Hard Case 4 rejection (limits exceeded or velocity > 5 req/60s).
3. Ensure the multi-party double-entry ledger balances to exactly 352.50 EGP for both Direct Customer Payment (CREDIT 2.50 to fee income) and Agent-Assisted Payment (CREDIT 1.50 to fee income + CREDIT 1.00 to agent commission).
```

---

### DES-P05 – Database ERD (14 Relational Tables)
* **Author:** Hady | **Stage:** Design | **Tool:** Claude 3.5 Sonnet
```text
Generate an ERD for PayLink database in Mermaid format with at least 10 tables covering all 8 Hard Cases in Section 2.7.
Requirements:
1. Include tables for BILLER_CALLBACKS (Hard Case 6 deduplication), SETTLEMENT_FILES, and RECONCILIATION_DISCREPANCIES (Hard Case 7 support review).
2. Include SYSTEM_CONFIGURATIONS (FR-24 dynamic limits) and FEE_TIERS (tiered pricing).
3. Add blocked_until to ACCOUNTS for 10-minute velocity blocks.
4. Make national_id, phone_number, and email nullable for SYSTEM accounts.
5. Use exact cardinality: |o--o{ for optional agent and nullable payment foreign keys.
```

---

### DES-P06 – Interactive Design Viewer & Multi-Model Visualizer
* **Author:** Hady | **Stage:** Design | **Tool:** Google Gemini (Antigravity)
```text
Create an interactive HTML viewer using Mermaid.js CDN that displays all 6 PayLink design models with tabbed navigation and responsive zooming.
Embed the 6 verified models: Use-Case, Domain Class, Pay Bill Sequence, Refund Sequence, Payment State Machine, and Database ERD.
```
