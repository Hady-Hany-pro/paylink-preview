# Phase 1: Requirements Engineering
# 1. Problem Summary

PayLink is a digital payment company operating in Egypt that allows customers to pay utility bills, including electricity, water, mobile top-ups, and internet bills, through a digital wallet.

Currently, customers need convenient ways to pay their bills without visiting utility offices or waiting in queues. At the same time, utility companies (billers) need to receive payments accurately and efficiently.

PayLink aims to solve this problem by providing a centralized backend system that manages customer wallets, processes bill payments, communicates with different billers, calculates service fees, and maintains accurate financial records.

The system must also protect customers' money and handle situations such as duplicate payment requests, insufficient balances, biller failures, network timeouts, and delayed payment confirmations.

## System Purpose

The main purpose of PayLink is to provide a reliable, secure, and extensible backend for digital wallet and bill-payment operations.

The system will:

- Allow customers to register and manage their accounts.
- Maintain digital wallets with available and held balances.
- Support wallet top-ups through simulated cards or agent cash.
- Display billers and their required customer information.
- Retrieve bill amounts through bill inquiries.
- Calculate service fees and payment totals.
- Process bill payments using wallet funds.
- Communicate with multiple external billers using different protocols.
- Handle payment confirmations, failures, timeouts, and callbacks.
- Maintain financial ledgers and audit records.
- Send payment notifications.
- Support agent commissions.
- Provide operational support and reconciliation capabilities.

---

# 2. Stakeholders

Stakeholders are individuals or organizations that interact with PayLink, use its services, operate the system, or are affected by its behavior.

| ID | Stakeholder | Description | Main Interest | 
|---|---|---|---|
| ST-01 | Customers | Individuals who register, maintain wallets, inquire about bills, and make payments. | Convenient payments, accurate balances, security, and receipts. |
| ST-02 | Agents | Shop owners or employees who use PayLink terminals to perform payments on behalf of customers. | Successful transactions and accurate commission payments. |
| ST-03 | Administrators | Authorized employees responsible for managing billers, services, fees, limits, and system configurations. | System configuration and operational control. |
| ST-04 | Support Employees | Employees who investigate payment issues, search transaction histories, and manage account blocking. | Transaction visibility and problem resolution. |
| ST-05 | External Billers | Electricity, water, mobile, and internet companies that provide bill information and receive payments. | Accurate payment processing and settlement. |
| ST-06 | External Notification Providers | Third-party services responsible for delivering SMS, email, or push notifications. | Receiving valid messages and reporting delivery results. |


**Note:** ST-06 is justified by the notification-provider integration described in the assignment. 

## Stakeholder Responsibilities

- Customers initiate wallet and payment operations.
- Agents make payments on behalf of customers.
- Administrators maintain system configurations and biller information.
- Support employees investigate transaction problems and manage account restrictions.
- Billers provide bill information and payment results.
- Notification providers deliver transaction messages.

---

# 3. Functional Requirements and User Stories

## 3.1 User Story Format

All user stories follow this standard format: 
**As a [user/actor], I want [goal], so that [benefit].**

Each story has:

- A unique ID.
- A related functional requirement ID.
- A priority: Must, Should, or Could.
- Acceptance criteria using Given / When / Then.

### Priority Definitions

| Priority | Meaning |
|---|---|
| Must | Mandatory functionality explicitly required by the assignment. |
| Should | Important functionality that should be implemented but is not a mandatory Must requirement. |
| Could | Optional functionality that can be implemented if time and resources allow. |

## 3.2 User Stories

### A. Accounts and Wallet

#### US-01 – Customer Registration

**Related FR:** FR-1  
**Priority:** Must  
**User Story:**
As a customer, I want to register for a PayLink account, so that I can access wallet and bill-payment services.
**Acceptance Criteria:**
- **Given** a customer provides the required valid registration information, **When** they submit the registration request, **Then** the system creates a customer account with basic verification.
- **Given** a customer submits invalid or incomplete required information, **When** registration is attempted, **Then** the system rejects the request and returns an appropriate validation error.
- **Given** an account already exists for the submitted unique identifier, **When** another registration is attempted, **Then** the system prevents duplicate account creation.

*Note: The required registration fields and authentication mechanism need confirmation.*

#### US-02 – Customer Verification Upgrade

**Related FR:** FR-2  
**Priority:** Should  
**User Story:**
As a customer, I want to upgrade my account to verified status, so that I can access higher daily payment limits.
**Acceptance Criteria:**
- **Given** a customer has basic verification, **When** an authorized verification process approves the upgrade, **Then** the customer's verification level changes to verified.
- **Given** a customer has verified status, **When** the system checks the daily payment limit, **Then** it applies the verified limit of 30,000 EGP.
- **Given** an upgrade request has not been approved, **When** the customer attempts to use verified limits, **Then** the basic limit remains applicable.

#### US-03 – View Wallet Balance and Transaction History

**Related FR:** FR-3  
**Priority:** Must  
**User Story:**

As a customer, I want to view my available balance, held balance, and transaction history, so that I can monitor my money and previous transactions.

**Acceptance Criteria:**

- **Given** a customer has an active wallet, **When** they request their wallet information, **Then** the system displays available and held balances.
- **Given** a customer has previous transactions, **When** they request their transaction history, **Then** the system displays their recorded wallet transactions.
- **Given** a customer has no previous transactions, **When** they request transaction history, **Then** the system returns an empty history without an error.

#### US-04 – Wallet Top-Up

**Related FR:** FR-4  
**Priority:** Must  
**User Story:**
As a customer, I want to top up my wallet using a simulated card or agent cash, so that I can add money and pay bills.

**Acceptance Criteria:**

- **Given** a valid simulated card top-up or agent cash top-up is submitted, **When** the operation succeeds, **Then** the wallet balance increases by the credited amount.
- **Given** a top-up operation fails, **When** the failure is processed, **Then** the wallet balance remains unchanged.
- **Given** a top-up succeeds, **When** the financial transaction is recorded, **Then** a corresponding ledger entry is created.

#### US-05 – Ledger-Based Balance Management

**Related FR:** FR-5  
**Priority:** Must  
**User Story:**
As a PayLink financial system, I want every wallet balance change to generate a ledger entry, so that wallet balances can be calculated accurately from recorded financial transactions.

**Acceptance Criteria:**

- **Given** a wallet operation changes available or held funds, **When** the operation is committed, **Then** the system creates the corresponding ledger entry.
- **Given** a wallet has multiple ledger entries, **When** its balance is calculated, **Then** the balance is derived from the ledger rather than directly overwritten.
- **Given** an operation is rejected before any money movement, **When** it is completed, **Then** no financial movement is recorded as a successful ledger entry.

### B. Biller Catalog

#### US-06 – Manage Billers and Services

**Related FR:** FR-6  
**Priority:** Must  
**User Story:**

As an administrator, I want to add, edit, and disable billers and their services, so that PayLink can manage the available payment providers.

**Acceptance Criteria:**

- **Given** an administrator provides valid biller information, **When** they add a biller, **Then** the biller is stored in the catalog.
- **Given** an existing biller or service is selected, **When** an administrator edits its information, **Then** the updated information is saved.
- **Given** an administrator disables a biller or service, **When** a customer requests the available catalog, **Then** the disabled item is not offered as an active payment option.
- **Given** an unauthorized user attempts to modify the catalog, **When** the request is submitted, **Then** the operation is denied.

#### US-07 – View Billers and Required Input Fields

**Related FR:** FR-7  
**Priority:** Must  
**User Story:**

As a customer, I want to view available billers and their required input fields, so that I can provide the correct information for a bill inquiry.

**Acceptance Criteria:**

- **Given** active billers exist, **When** a customer requests the biller catalog, **Then** the system displays the active billers and services.
- **Given** a customer selects a biller, **When** they view its service details, **Then** the system displays the required input fields.
- **Given** a biller is disabled, **When** the catalog is requested, **Then** that biller is not presented as an active service.

### C. Payment Processing

#### US-08 – Bill Inquiry

**Related FR:** FR-8  
**Priority:** Must  
**User Story:**

As a customer, I want to inquire about my bill and see the amount, service fee, and total, so that I know how much money will be deducted before confirming payment.

**Acceptance Criteria:**

- **Given** a customer provides valid biller-specific information, **When** they request a bill inquiry, **Then** the system retrieves the bill amount from the selected biller.
- **Given** the biller returns a valid amount, **When** the inquiry is processed, **Then** the system calculates and displays the service fee and total payment amount.
- **Given** the biller returns an inquiry error, **When** the inquiry is processed, **Then** the system informs the customer that the inquiry could not be completed.
- **Given** a biller does not respond within its expected inquiry period, **When** the inquiry times out, **Then** the system reports the inquiry failure without incorrectly charging the wallet.

#### US-09 – Pay a Bill Using Wallet Funds

**Related FR:** FR-9  
**Priority:** Must  
**User Story:**

As a customer, I want to pay a bill using my PayLink wallet, so that I can settle my utility bills without visiting the biller's office.

**Acceptance Criteria:**

- **Given** a customer has sufficient available funds and passes the required payment checks, **When** they confirm a valid bill payment, **Then** the system initiates payment processing.
- **Given** the biller confirms the payment, **When** the confirmation is received, **Then** the payment becomes Completed and the held amount is finalized.
- **Given** the customer has insufficient available funds, **When** they attempt payment, **Then** the payment is rejected without making the balance negative.
- **Given** the payment is not yet confirmed, **When** the customer views its status, **Then** the system displays its current payment state.

#### US-10 – Idempotent Payment Requests

**Related FR:** FR-10  
**Priority:** Must  
**User Story:**

As a customer, I want repeated payment requests with the same idempotency key to return the original result, so that network retries do not create duplicate charges.

**Acceptance Criteria:**

- **Given** a payment request has already been processed using an idempotency key, **When** the same request is submitted again with that key, **Then** the system returns the original result without creating another payment.
- **Given** a payment request uses a new valid idempotency key, **When** it is submitted, **Then** the system processes it as a new request, subject to normal validation.
- **Given** the same key is reused with conflicting payment details, **When** the request is submitted, **Then** the system must not execute a second financial operation.

*The exact response for conflicting payloads should be confirmed by the team.*

#### US-11 – Enforce Payment Lifecycle

**Related FR:** FR-11  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want every payment to follow the defined lifecycle, so that payment statuses remain consistent and unauthorized transitions are prevented.

**Acceptance Criteria:**

- **Given** a newly created payment passes fraud checks and has sufficient funds, **When** validation succeeds, **Then** it transitions from Initiated to FundsHeld.
- **Given** a payment fails fraud checks or has insufficient funds, **When** validation is completed, **Then** it transitions from Initiated to Rejected.
- **Given** a payment is FundsHeld, **When** its request is sent to the biller, **Then** it transitions to SentToBiller.
- **Given** a payment is SentToBiller, **When** the biller confirms it, **Then** it transitions to Completed.
- **Given** a payment is SentToBiller, **When** the biller refuses it, **Then** it transitions to Failed.
- **Given** a payment is SentToBiller, **When** no response arrives within the configured timeout, **Then** it transitions to Unknown.
- **Given** a payment is Unknown, **When** a later confirmation or refusal is received, **Then** it transitions to Completed or Failed respectively.
- **Given** a requested transition is not defined in the lifecycle, **When** the system attempts it, **Then** the transition is rejected.

#### US-12 – Hold and Release Wallet Funds

**Related FR:** FR-12  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want to hold wallet funds before contacting a biller and release them when a payment fails, so that customers' available balances remain accurate.

**Acceptance Criteria:**

- **Given** a payment passes validation and the customer has sufficient available funds, **When** payment processing begins, **Then** the required amount is moved from available balance to held balance.
- **Given** a payment is held, **When** the biller confirms it, **Then** the held amount is finalized as a payment charge.
- **Given** a payment fails and the biller is confirmed not to have received it, **When** the failure is processed, **Then** the held amount is released to the customer's available balance.
- **Given** a payment is Unknown, **When** the system processes the timeout, **Then** the held amount remains reserved until the biller's outcome is known.

#### US-13 – Handle Biller Timeouts and Retries

**Related FR:** FR-13  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want timed-out payments to become Unknown and be re-queried according to the retry schedule, so that uncertain payment outcomes can be resolved safely.

**Acceptance Criteria:**

- **Given** a live biller does not respond within 10 seconds, **When** the timeout is reached, **Then** the payment becomes Unknown.
- **Given** a payment becomes Unknown, **When** its retry schedule reaches 1, 5, and 15 minutes, **Then** the system performs up to three re-queries according to that schedule.
- **Given** a retry or reconciliation confirms payment success, **When** the result is processed, **Then** the payment becomes Completed.
- **Given** a retry or reconciliation confirms payment refusal or non-receipt, **When** the result is processed, **Then** the payment becomes Failed.
- **Given** all three retries have been exhausted without a confirmed result, **When** retry processing ends, **Then** the payment waits for reconciliation rather than being automatically refunded.

#### US-14 – Process Asynchronous Biller Callbacks

**Related FR:** FR-14  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want to receive asynchronous payment callbacks from TopUpNet and ignore duplicate callbacks, so that delayed payment results are processed exactly once.

**Acceptance Criteria:**

- **Given** TopUpNet initially accepts a payment, **When** its callback later reports success, **Then** the corresponding payment is updated to Completed.
- **Given** TopUpNet initially accepts a payment, **When** its callback reports failure, **Then** the corresponding payment is updated to Failed.
- **Given** a callback has already been successfully processed, **When** the same callback is received again, **Then** the system ignores the duplicate and logs it.
- **Given** a callback references an unknown payment, **When** it is received, **Then** the system does not modify an unrelated payment.

#### US-15 – Support Multiple Biller Integrations

**Related FR:** FR-15  
**Priority:** Must  
**User Story:**

As a PayLink platform, I want to integrate ElectroCo, AquaCo, and TopUpNet through separate adapters, so that customers can use multiple billers without depending on their individual communication protocols.

**Acceptance Criteria:**

- **Given** ElectroCo is selected, **When** the system sends an inquiry or payment, **Then** it communicates using REST and JSON.
- **Given** AquaCo is selected, **When** the system communicates with it, **Then** it uses its SOAP-style XML over HTTP protocol and handles its different response fields and error codes.
- **Given** TopUpNet is selected, **When** the system submits a mobile top-up, **Then** it handles the asynchronous acceptance response and subsequent callback.
- **Given** a new biller is introduced, **When** its integration is added, **Then** the existing business modules remain unchanged, with changes limited to the integration module and configuration.

*NetCo's daily CSV integration is optional.*

### D. Fees and Commissions

#### US-16 – Calculate Service Fees and Promotions

**Related FR:** FR-16  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want to calculate service fees according to biller-specific pricing rules and active promotions, so that customers are charged the correct total amount.

**Acceptance Criteria:**

- **Given** an electricity or water bill is processed, **When** its service fee is calculated, **Then** the fee is 2.50 EGP.
- **Given** a mobile top-up amount is processed, **When** its fee is calculated, **Then** the fee is 1.5% of the amount, with a minimum of 1 EGP.
- **Given** an internet payment is up to and including 200 EGP, **When** its fee is calculated, **Then** the fee is 2 EGP.
- **Given** an internet payment exceeds 200 EGP, **When** its fee is calculated, **Then** the fee is 4 EGP.
- **Given** an eligible promotion is active for the selected biller, **When** its fee is calculated, **Then** the fee is zero.
- **Given** a promotion is outside its configured start and end dates, **When** its fee is calculated, **Then** the normal fee rule applies.

#### US-17 – Agent-Assisted Payment and Commission

**Related FR:** FR-17  
**Priority:** Should  
**User Story:**

As an agent, I want to pay a customer's bill through my PayLink terminal, so that I can provide payment services and earn a commission.

**Acceptance Criteria:**

- **Given** an authorized agent has a valid payment request and the customer has sufficient funds, **When** the payment is completed, **Then** the system records the agent as the payment initiator.
- **Given** an agent-assisted payment is successfully completed, **When** the commission is calculated, **Then** the agent earns 40% of the service fee.
- **Given** an agent-assisted payment fails, **When** its result is processed, **Then** no completion-based commission is credited.
- **Given** the payment is still Unknown, **When** commission processing is evaluated, **Then** no completion-based commission is credited.

### E. Fraud Checks and Payment Limits

#### US-18 – Enforce Single and Daily Payment Limits

**Related FR:** FR-18  
**Priority:** Must  
**User Story:**

As a PayLink payment system, I want to validate single-payment and daily payment limits, so that customers cannot exceed the allowed transaction amounts.

**Acceptance Criteria:**

- **Given** a payment amount is below 5 EGP or above 10,000 EGP, **When** payment validation occurs, **Then** the payment is rejected with a clear reason.
- **Given** a basic customer has already used their daily payment allowance, **When** another payment would exceed 5,000 EGP for the day, **Then** the payment is rejected.
- **Given** a verified customer has already used their daily payment allowance, **When** another payment would exceed 30,000 EGP for the day, **Then** the payment is rejected.
- **Given** a payment would exceed a configured limit, **When** it is rejected, **Then** no funds are held or charged.

*Whether the service fee is included when calculating these limits requires team confirmation.*

#### US-19 – Apply Payment Velocity Restrictions

**Related FR:** FR-19  
**Priority:** Should  
**User Story:**

As a PayLink fraud-control system, I want to detect more than five payments within 60 seconds from one account, so that suspicious payment activity can be restricted.

**Acceptance Criteria:**

- **Given** an account makes five payments within a 60-second period, **When** the system evaluates its activity, **Then** the velocity rule does not block it solely for those five payments.
- **Given** an account makes more than five payments within 60 seconds, **When** the system evaluates its activity, **Then** the account is blocked for 10 minutes.
- **Given** an account is blocked by the velocity rule, **When** it attempts another payment during the blocking period, **Then** the payment is rejected with a clear reason.
- **Given** the 10-minute blocking period has ended, **When** the customer attempts a payment, **Then** the temporary velocity restriction no longer prevents the request.

### F. Support Operations

#### US-20 – Search Payment by Reference

**Related FR:** FR-20  
**Priority:** Must  
**User Story:**

As a support employee, I want to search for a payment using its reference and view its full history, so that I can investigate customer payment problems.

**Acceptance Criteria:**

- **Given** a valid payment reference exists, **When** an authorized support employee searches for it, **Then** the system displays the payment details and recorded history.
- **Given** a payment has undergone multiple state transitions, **When** its history is requested, **Then** the system displays the recorded transitions in their chronological order.
- **Given** no payment matches the reference, **When** the search is performed, **Then** the system returns a clear not-found result.
- **Given** an unauthorized user attempts to access support transaction history, **When** the request is submitted, **Then** access is denied.

#### US-21 – Block and Unblock Customer Accounts

**Related FR:** FR-21  
**Priority:** Should  
**User Story:**

As a support employee, I want to block or unblock a customer account, so that I can restrict or restore payment access when necessary.

**Acceptance Criteria:**

- **Given** an authorized support employee selects an active account, **When** they block it, **Then** the account becomes blocked.
- **Given** an account is blocked, **When** a payment is attempted, **Then** the system rejects the payment with a clear reason.
- **Given** an authorized support employee selects a blocked account, **When** they unblock it, **Then** the account becomes eligible for normal payment validation.
- **Given** an account-blocking action occurs, **When** the action is completed, **Then** it is recorded in the audit log.

### G. Notifications

#### US-22 – Notify Customers of Payment Results

**Related FR:** FR-22  
**Priority:** Must  
**User Story:**

As a customer, I want to receive SMS and push notifications when my payment completes or fails, so that I know the outcome of my transaction.

**Acceptance Criteria:**

- **Given** a payment becomes Completed, **When** its final result is processed, **Then** the system initiates an SMS and push notification.
- **Given** a payment becomes Failed, **When** its final result is processed, **Then** the system initiates an SMS and push notification containing a clear failure reason.
- **Given** a payment becomes Unknown, **When** the timeout is processed, **Then** the customer is informed that the payment is still being processed.
- **Given** a payment notification is initiated, **When** it is sent, **Then** it references the corresponding payment.

#### US-23 – Retry Failed Notifications

**Related FR:** FR-23  
**Priority:** Should  
**User Story:**

As a PayLink notification system, I want to retry failed SMS or email deliveries up to three times, so that temporary provider failures do not immediately prevent customer communication.

**Acceptance Criteria:**

- **Given** an SMS or email delivery fails, **When** a retry is scheduled, **Then** the system attempts delivery again.
- **Given** a notification continues to fail, **When** three retries have been performed, **Then** the notification is marked as undelivered.
- **Given** a payment has already completed, **When** notification delivery fails, **Then** the payment remains Completed.
- **Given** a notification is marked undelivered, **When** its status is inspected, **Then** the delivery failure is visible.

### H. System Configuration and Audit

#### US-24 – Update Fees and Limits Without Redeployment

**Related FR:** FR-24  
**Priority:** Should  
**User Story:**

As an administrator, I want to edit fee and limit values without redeploying the application, so that PayLink can update business configurations efficiently.

**Acceptance Criteria:**

- **Given** an authorized administrator provides a valid new configuration value, **When** they save it, **Then** the updated value is stored.
- **Given** a fee or limit configuration is updated, **When** a subsequent payment uses that configuration, **Then** the system applies the current configured value.
- **Given** an unauthorized user attempts to modify configurations, **When** the request is submitted, **Then** the operation is denied.
- **Given** an administrator changes a configuration, **When** the action is completed, **Then** the change is recorded in the audit log.

#### US-25 – Record Financial and Administrative Audit Events

**Related FR:** FR-25  
**Priority:** Must  
**User Story:**

As a PayLink company, I want every money movement and administrative action recorded in an audit log, so that financial activities and system changes can be traced and investigated.

**Acceptance Criteria:**

- **Given** a wallet money movement occurs, **When** the operation is committed, **Then** an audit record is created.
- **Given** an administrator changes a biller, fee, or limit configuration, **When** the change is completed, **Then** an audit record is created.
- **Given** an audit record is created, **When** it is inspected, **Then** it includes who performed the action, when it occurred, and why.
- **Given** a money movement is committed, **When** the system records it, **Then** its audit record is not omitted.

### I. Reconciliation

#### US-26 – Generate Daily Reconciliation Report

**Related FR:** FR-26  
**Priority:** Should  
**User Story:**

As a support employee, I want to generate a daily reconciliation report using a biller's settlement file, so that I can identify differences between PayLink records and actual biller payments.

**Acceptance Criteria:**

- **Given** a valid settlement file is available, **When** reconciliation is performed, **Then** the system compares its payment records with the biller's records.
- **Given** a settlement file contains a payment that PayLink recorded as Failed, **When** reconciliation is completed, **Then** the difference is flagged in the report for support review.
- **Given** a discrepancy is detected, **When** the report is generated, **Then** the discrepancy is included with sufficient reference information for investigation.
- **Given** no discrepancies are detected, **When** reconciliation is completed, **Then** the report reflects the comparison result without inventing differences.

### J. Optional Refund and Reporting Features

#### US-27 – Request Refund for Completed Payment

**Related FR:** FR-27  
**Priority:** Could  
**User Story:**

As a customer, I want to request a refund for a completed payment, so that I can recover money when a valid refund case exists.

**Acceptance Criteria:**

- **Given** a customer has a completed payment, **When** they submit a refund request, **Then** the system records the request for support review.
- **Given** a refund request is pending, **When** an authorized support employee approves it, **Then** the system processes the approved refund.
- **Given** a refund request is rejected, **When** the decision is recorded, **Then** the original completed payment is not refunded.
- **Given** a refund is successfully processed, **When** the wallet is updated, **Then** the corresponding financial and audit records are created.

*Refund amount, eligibility, and the final state transition require clarification.*

#### US-28 – View Daily Operational Totals

**Related FR:** FR-28  
**Priority:** Could  
**User Story:**

As an administrator, I want to view daily payment totals, fees earned, commissions paid, and failures per biller, so that I can monitor PayLink's daily operations.

**Acceptance Criteria:**

- **Given** payment records exist for a selected day, **When** an administrator requests daily totals, **Then** the system displays the number of payments.
- **Given** completed payments contain service fees and agent commissions, **When** the report is generated, **Then** it displays the fees earned and commissions paid.
- **Given** payments exist for multiple billers, **When** the report is generated, **Then** it displays failure totals per biller.
- **Given** no transactions exist for the selected day, **When** the report is requested, **Then** the system displays zero totals.

---

# 4. Non-Functional Requirements

Non-functional requirements define the quality attributes and operational characteristics expected from PayLink.

The following requirements use measurable targets explicitly stated in the assignment wherever possible.

## 4.1 NFR List

### NFR-01 – Financial Correctness

**Quality Attribute:** Correctness  
**Requirement:**

The system must prevent duplicate financial charges and negative wallet balances during concurrent and duplicate payment operations.

**Target:** Zero double charges and zero negative balances in the concurrency and duplicate-payment tests.

**Verification:**
- Submit the same payment request multiple times with the same idempotency key.
- Submit two simultaneous payments from a wallet that can cover only one.
- Verify that only one payment succeeds and the wallet balance never becomes negative.

### NFR-02 – Payment Performance

**Quality Attribute:** Performance  
**Requirement:**

The system must sustain at least 100 payments per second for one continuous minute against the mock billers.

**Target:** 100 payments per second sustained for 60 seconds.

**Verification:**
- Execute a load test against the deployed application and mock billers.
- Measure throughput and record the number of successfully processed requests.
- Report the test results.

### NFR-03 – Biller Failure Isolation

**Quality Attribute:** Reliability and Resilience  
**Requirement:**

An outage or failure affecting one biller must not prevent payment operations involving other billers.

**Target:** Payments to available billers continue operating during another biller's outage.

**Verification:**
- Simulate an ElectroCo outage.
- Attempt payment operations through AquaCo and TopUpNet.
- Verify that their operations continue independently.

### NFR-04 – Biller Modifiability

**Quality Attribute:** Modifiability and Extensibility  
**Requirement:**

The system must support adding a new biller by changing only the Biller Integration module and configuration, without modifying existing business modules.

**Target:** Only the integration module and configuration require changes.

**Verification:**
- Introduce a new mock biller.
- Compare changed files against the existing implementation.
- Verify that Accounts, Wallet, Payment Processing, and other existing modules remain unchanged.

### NFR-05 – Auditability

**Quality Attribute:** Auditability and Accountability  
**Requirement:**

Every money movement must have a corresponding audit record containing who performed the operation, when it occurred, and why.

**Target:** 100% of money movements have an audit record.

**Verification:**
- Execute wallet top-ups, holds, charges, and refunds.
- Compare committed money movements with their audit records.
- Verify that every record contains the required information.

### NFR-06 – Domain Test Coverage

**Quality Attribute:** Testability  
**Requirement:**

The system's domain logic must be covered by automated unit tests.

**Target:** At least 70% line coverage on domain logic, measured through CI.

**Verification:**
- Execute the automated test suite in GitHub Actions.
- Generate a line coverage report.
- Verify that domain logic coverage reaches at least 70%.

### NFR-07 – Monetary Precision

**Quality Attribute:** Financial Accuracy  
**Requirement:**

All monetary calculations and wallet operations must use exact decimal types rather than floating-point representations.

**Target:** No floating-point arithmetic for monetary values.

**Verification:**
- Inspect monetary data types and calculation implementations.
- Test percentage fees, fixed fees, commissions, and rounding.
- Verify that stored and calculated amounts retain the required decimal precision.

### NFR-08 – Payment Timeout Handling

**Quality Attribute:** Reliability  
**Requirement:**

Live biller payment requests must be subject to a 10-second timeout, after which an unanswered payment becomes Unknown rather than being automatically treated as failed.

**Target:** 10 seconds.

**Verification:**
- Configure a mock biller to delay its response beyond 10 seconds.
- Verify the payment becomes Unknown.
- Verify that the money remains held.

### NFR-09 – Security

**Quality Attribute:** Security

**Requirement:**

The system must prevent unauthorized users from accessing protected features and performing actions outside their assigned roles.

**Target:** Only authenticated and authorized users can access protected features.

**Verification:**
- Try accessing protected features without logging in.
- Try performing admin actions using a customer account.
- Verify that unauthorized access is rejected.

## 6.2 NFR Summary

| ID | Quality Attribute | Measurable Target |
|---|---|---|
| NFR-01 | Correctness | Zero double charges and zero negative balances |
| NFR-02 | Performance | 100 payments/second for 60 seconds |
| NFR-03 | Resilience | One biller outage does not stop other billers |
| NFR-04 | Modifiability | New biller requires only integration and configuration changes |
| NFR-05 | Auditability | 100% of money movements audited |
| NFR-06 | Testability | At least 70% domain logic line coverage |
| NFR-07 | Financial Accuracy | Exact decimal types, never floating point |
| NFR-08 | Reliability | 10-second live biller timeout |

**Note:** NFR-07 is a technology constraint rather than a numerical quality threshold. NFR-08 uses an explicit business timeout from the assignment.

No additional numerical targets have been invented.

---

# 5. Ambiguities and Open Questions

The following items are not sufficiently specified in the assignment. They should be discussed with the team before implementation. The proposed decisions represent our suggested approach to keep the system simple, consistent, and practical to implement.

| ID | Area | Open Question | Why Clarification Is Needed | Proposed Decision |
|---|---|---|---|---|
| AQ-01 | Registration | What information must customers provide during registration? | Required fields and validation rules are not defined. | Name, email, phone number, and password should be enough to create an account. We want to keep registration simple and avoid unnecessary fields. |
| AQ-02 | Verification | Who approves verified status, and what evidence is required? | FR-2 describes upgrading without defining the process. | Customers should submit their verification information, and an administrator should review and approve or reject the request. |
| AQ-03 | Top-ups | What are the exact simulated card and agent cash top-up procedures? | FR-4 does not define provider responses, limits, or agent authorization. | Card top-ups should be simulated without connecting to a real payment provider. Agent cash top-ups should be performed by an authorized agent. |
| AQ-04 | Bill Inquiry | Does an inquiry expire, and can a payment use an old inquiry result? | Bill amounts can change over time. | Customers should perform a new inquiry before payment to ensure that the bill amount is up to date. |
| AQ-05 | Payment Limits | Do daily and single-payment limits include service fees? | The brief does not explicitly define whether limits apply to the bill amount or total amount. | Limits should apply to the total amount deducted from the wallet, including service fees, because this represents the actual amount spent by the customer. |
| AQ-06 | Daily Limits | What time zone and reset boundary define a new day? | Daily limit calculations need a consistent time boundary. | Use Egypt local time, with daily limits resetting at midnight. |
| AQ-07 | Promotions | What happens when promotions overlap or their dates share a boundary? | Multiple eligible promotions could produce conflicting fee calculations. | Only one promotion should apply to a payment. We suggest selecting the promotion that gives the customer the highest benefit. |
| AQ-08 | Agent Payments | Does an agent initiate payment using the customer's wallet or another funding mechanism? | The brief specifies agent-assisted payment but not the exact authorization and funding flow. | The agent should initiate the payment on behalf of the customer, but the amount should be deducted from the customer's wallet after customer authorization. |
| AQ-09 | Idempotency | What happens when the same key is reused with different payment data? | The brief requires returning the original result but does not define conflicting payload behavior. | The same idempotency key should only be accepted with the same request data. Reusing it with different data should result in a rejected request. |
| AQ-10 | Payment States | What happens if all three retries fail to establish the payment outcome? | The brief says to wait for reconciliation but does not define how long the payment remains Unknown. | Keep the payment in Unknown until reconciliation confirms its actual result. Do not release the reserved amount or finalize the deduction until the outcome is known. |
| AQ-11 | Callbacks | How are callback requests authenticated and validated? | Security requirements for external callbacks are not specified. | Validate callbacks using a shared secret or signature to ensure that requests come from trusted billers. |
| AQ-12 | Notifications | Is email required in the final system, or is it only an additional supported channel? | FR-22 explicitly requires SMS and push, whereas the notification module also mentions email. | SMS and push should be implemented as required channels. Email can be treated as optional if time allows. |
| AQ-13 | Refunds | Can customers request partial refunds or only full refunds, and who approves them? | FR-27 does not define refund amounts or the complete approval workflow. | Support full refunds only in the first version. A support employee should review and approve or reject refund requests. Approved refunds should be returned to the customer's wallet. |
| AQ-14 | Reconciliation | What is the exact settlement-file format and matching key? | The file schema and matching logic are not supplied. | Use a simple CSV settlement file containing a transaction reference that can be matched with the corresponding PayLink payment. |
| AQ-15 | Biller Integration | Are mock biller APIs and their contracts supplied by the instructors? | This determines the exact request and response implementation. | If mock APIs are not supplied, we should create simple mock biller services with predefined success, failure, timeout, and status-check responses. |
| AQ-16 | Performance | Does the 100 payments/second target measure submitted requests or successfully completed payments? | The performance measurement needs a consistent definition. | Measure the number of payment requests processed per second under the specified test conditions. The exact measurement criteria should be confirmed with the instructor. |

---