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

| Field | Details |
|---|---|
| Related FR | FR-1 |
| Priority | Must |

**User Story**

As a customer, I want to register for a PayLink account, so that I can access wallet and bill-payment services.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer provides the required valid registration information | they submit the registration request | the system creates a customer account with basic verification. |
| 2 | a customer submits invalid or incomplete required information | registration is attempted | the system rejects the request and returns an appropriate validation error. |
| 3 | an account already exists for the submitted unique identifier | another registration is attempted | the system prevents duplicate account creation. |

**Note:** The required registration fields and authentication mechanism need confirmation.

#### US-02 – Customer Verification Upgrade

| Field | Details |
|---|---|
| Related FR | FR-2 |
| Priority | Should |

**User Story**

As a customer, I want to upgrade my account to verified status, so that I can access higher daily payment limits.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer has basic verification | an authorized verification process approves the upgrade | the customer's verification level changes to verified. |
| 2 | a customer has verified status | the system checks the daily payment limit | it applies the verified limit of 30,000 EGP. |
| 3 | an upgrade request has not been approved | the customer attempts to use verified limits | the basic limit remains applicable. |

#### US-03 – View Wallet Balance and Transaction History

| Field | Details |
|---|---|
| Related FR | FR-3 |
| Priority | Must |

**User Story**

As a customer, I want to view my available balance, held balance, and transaction history, so that I can monitor my money and previous transactions.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer has an active wallet | they request their wallet information | the system displays available and held balances. |
| 2 | a customer has previous transactions | they request their transaction history | the system displays their recorded wallet transactions. |
| 3 | a customer has no previous transactions | they request transaction history | the system returns an empty history without an error. |

#### US-04 – Wallet Top-Up

| Field | Details |
|---|---|
| Related FR | FR-4 |
| Priority | Must |

**User Story**

As a customer, I want to top up my wallet using a simulated card or agent cash, so that I can add money and pay bills.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a valid simulated card top-up or agent cash top-up is submitted | the operation succeeds | the wallet balance increases by the credited amount. |
| 2 | a top-up operation fails | the failure is processed | the wallet balance remains unchanged. |
| 3 | a top-up succeeds | the financial transaction is recorded | a corresponding ledger entry is created. |

#### US-05 – Ledger-Based Balance Management

| Field | Details |
|---|---|
| Related FR | FR-5 |
| Priority | Must |

**User Story**

As a PayLink financial system, I want every wallet balance change to generate a ledger entry, so that wallet balances can be calculated accurately from recorded financial transactions.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a wallet operation changes available or held funds | the operation is committed | the system creates the corresponding ledger entry. |
| 2 | a wallet has multiple ledger entries | its balance is calculated | the balance is derived from the ledger rather than directly overwritten. |
| 3 | an operation is rejected before any money movement | it is completed | no financial movement is recorded as a successful ledger entry. |

### B. Biller Catalog

#### US-06 – Manage Billers and Services

| Field | Details |
|---|---|
| Related FR | FR-6 |
| Priority | Must |

**User Story**

As an administrator, I want to add, edit, and disable billers and their services, so that PayLink can manage the available payment providers.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an administrator provides valid biller information | they add a biller | the biller is stored in the catalog. |
| 2 | an existing biller or service is selected | an administrator edits its information | the updated information is saved. |
| 3 | an administrator disables a biller or service | a customer requests the available catalog | the disabled item is not offered as an active payment option. |
| 4 | an unauthorized user attempts to modify the catalog | the request is submitted | the operation is denied. |

#### US-07 – View Billers and Required Input Fields

| Field | Details |
|---|---|
| Related FR | FR-7 |
| Priority | Must |

**User Story**

As a customer, I want to view available billers and their required input fields, so that I can provide the correct information for a bill inquiry.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | active billers exist | a customer requests the biller catalog | the system displays the active billers and services. |
| 2 | a customer selects a biller | they view its service details | the system displays the required input fields. |
| 3 | a biller is disabled | the catalog is requested | that biller is not presented as an active service. |

### C. Payment Processing

#### US-08 – Bill Inquiry

| Field | Details |
|---|---|
| Related FR | FR-8 |
| Priority | Must |

**User Story**

As a customer, I want to inquire about my bill and see the amount, service fee, and total, so that I know how much money will be deducted before confirming payment.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer provides valid biller-specific information | they request a bill inquiry | the system retrieves the bill amount from the selected biller. |
| 2 | the biller returns a valid amount | the inquiry is processed | the system calculates and displays the service fee and total payment amount. |
| 3 | the biller returns an inquiry error | the inquiry is processed | the system informs the customer that the inquiry could not be completed. |
| 4 | a biller does not respond within its expected inquiry period | the inquiry times out | the system reports the inquiry failure without incorrectly charging the wallet. |

#### US-09 – Pay a Bill Using Wallet Funds

| Field | Details |
|---|---|
| Related FR | FR-9 |
| Priority | Must |

**User Story**

As a customer, I want to pay a bill using my PayLink wallet, so that I can settle my utility bills without visiting the biller's office.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer has sufficient available funds and passes the required payment checks | they confirm a valid bill payment | the system initiates payment processing. |
| 2 | the biller confirms the payment | the confirmation is received | the payment becomes Completed and the held amount is finalized. |
| 3 | the customer has insufficient available funds | they attempt payment | the payment is rejected without making the balance negative. |
| 4 | the payment is not yet confirmed | the customer views its status | the system displays its current payment state. |

#### US-10 – Idempotent Payment Requests

| Field | Details |
|---|---|
| Related FR | FR-10 |
| Priority | Must |

**User Story**

As a customer, I want repeated payment requests with the same idempotency key to return the original result, so that network retries do not create duplicate charges.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a payment request has already been processed using an idempotency key | the same request is submitted again with that key | the system returns the original result without creating another payment. |
| 2 | a payment request uses a new valid idempotency key | it is submitted | the system processes it as a new request, subject to normal validation. |
| 3 | the same key is reused with conflicting payment details | the request is submitted | the system must not execute a second financial operation. |

**The exact response for conflicting payloads should be confirmed by the team.**

#### US-11 – Enforce Payment Lifecycle

| Field | Details |
|---|---|
| Related FR | FR-11 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want every payment to follow the defined lifecycle, so that payment statuses remain consistent and unauthorized transitions are prevented.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a newly created payment passes fraud checks and has sufficient funds | validation succeeds | it transitions from Initiated to FundsHeld. |
| 2 | a payment fails fraud checks or has insufficient funds | validation is completed | it transitions from Initiated to Rejected. |
| 3 | a payment is FundsHeld | its request is sent to the biller | it transitions to SentToBiller. |
| 4 | a payment is SentToBiller | the biller confirms it | it transitions to Completed. |
| 5 | a payment is SentToBiller | the biller refuses it | it transitions to Failed. |
| 6 | a payment is SentToBiller | no response arrives within the configured timeout | it transitions to Unknown. |
| 7 | a payment is Unknown | a later confirmation or refusal is received | it transitions to Completed or Failed respectively. |
| 8 | a requested transition is not defined in the lifecycle | the system attempts it | the transition is rejected. |

#### US-12 – Hold and Release Wallet Funds

| Field | Details |
|---|---|
| Related FR | FR-12 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want to hold wallet funds before contacting a biller and release them when a payment fails, so that customers' available balances remain accurate.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a payment passes validation and the customer has sufficient available funds | payment processing begins | the required amount is moved from available balance to held balance. |
| 2 | a payment is held | the biller confirms it | the held amount is finalized as a payment charge. |
| 3 | a payment fails and the biller is confirmed not to have received it | the failure is processed | the held amount is released to the customer's available balance. |
| 4 | a payment is Unknown | the system processes the timeout | the held amount remains reserved until the biller's outcome is known. |

#### US-13 – Handle Biller Timeouts and Retries

| Field | Details |
|---|---|
| Related FR | FR-13 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want timed-out payments to become Unknown and be re-queried according to the retry schedule, so that uncertain payment outcomes can be resolved safely.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a live biller does not respond within 10 seconds | the timeout is reached | the payment becomes Unknown. |
| 2 | a payment becomes Unknown | its retry schedule reaches 1, 5, and 15 minutes | the system performs up to three re-queries according to that schedule. |
| 3 | a retry or reconciliation confirms payment success | the result is processed | the payment becomes Completed. |
| 4 | a retry or reconciliation confirms payment refusal or non-receipt | the result is processed | the payment becomes Failed. |
| 5 | all three retries have been exhausted without a confirmed result | retry processing ends | the payment waits for reconciliation rather than being automatically refunded. |

#### US-14 – Process Asynchronous Biller Callbacks

| Field | Details |
|---|---|
| Related FR | FR-14 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want to receive asynchronous payment callbacks from TopUpNet and ignore duplicate callbacks, so that delayed payment results are processed exactly once.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | TopUpNet initially accepts a payment | its callback later reports success | the corresponding payment is updated to Completed. |
| 2 | TopUpNet initially accepts a payment | its callback reports failure | the corresponding payment is updated to Failed. |
| 3 | a callback has already been successfully processed | the same callback is received again | the system ignores the duplicate and logs it. |
| 4 | a callback references an unknown payment | it is received | the system does not modify an unrelated payment. |

#### US-15 – Support Multiple Biller Integrations

| Field | Details |
|---|---|
| Related FR | FR-15 |
| Priority | Must |

**User Story**

As a PayLink platform, I want to integrate ElectroCo, AquaCo, and TopUpNet through separate adapters, so that customers can use multiple billers without depending on their individual communication protocols.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | ElectroCo is selected | the system sends an inquiry or payment | it communicates using REST and JSON. |
| 2 | AquaCo is selected | the system communicates with it | it uses its SOAP-style XML over HTTP protocol and handles its different response fields and error codes. |
| 3 | TopUpNet is selected | the system submits a mobile top-up | it handles the asynchronous acceptance response and subsequent callback. |
| 4 | a new biller is introduced | its integration is added | the existing business modules remain unchanged, with changes limited to the integration module and configuration. |

**NetCo's daily CSV integration is optional.**

### D. Fees and Commissions

#### US-16 – Calculate Service Fees and Promotions

| Field | Details |
|---|---|
| Related FR | FR-16 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want to calculate service fees according to biller-specific pricing rules and active promotions, so that customers are charged the correct total amount.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an electricity or water bill is processed | its service fee is calculated | the fee is 2.50 EGP. |
| 2 | a mobile top-up amount is processed | its fee is calculated | the fee is 1.5% of the amount, with a minimum of 1 EGP. |
| 3 | an internet payment is up to and including 200 EGP | its fee is calculated | the fee is 2 EGP. |
| 4 | an internet payment exceeds 200 EGP | its fee is calculated | the fee is 4 EGP. |
| 5 | an eligible promotion is active for the selected biller | its fee is calculated | the fee is zero. |
| 6 | a promotion is outside its configured start and end dates | its fee is calculated | the normal fee rule applies. |

#### US-17 – Agent-Assisted Payment and Commission

| Field | Details |
|---|---|
| Related FR | FR-17 |
| Priority | Should |

**User Story**

As an agent, I want to pay a customer's bill through my PayLink terminal, so that I can provide payment services and earn a commission.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an authorized agent has a valid payment request and the customer has sufficient funds | the payment is completed | the system records the agent as the payment initiator. |
| 2 | an agent-assisted payment is successfully completed | the commission is calculated | the agent earns 40% of the service fee. |
| 3 | an agent-assisted payment fails | its result is processed | no completion-based commission is credited. |
| 4 | the payment is still Unknown | commission processing is evaluated | no completion-based commission is credited. |

### E. Fraud Checks and Payment Limits

#### US-18 – Enforce Single and Daily Payment Limits

| Field | Details |
|---|---|
| Related FR | FR-18 |
| Priority | Must |

**User Story**

As a PayLink payment system, I want to validate single-payment and daily payment limits, so that customers cannot exceed the allowed transaction amounts.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a payment amount is below 5 EGP or above 10,000 EGP | payment validation occurs | the payment is rejected with a clear reason. |
| 2 | a basic customer has already used their daily payment allowance | another payment would exceed 5,000 EGP for the day | the payment is rejected. |
| 3 | a verified customer has already used their daily payment allowance | another payment would exceed 30,000 EGP for the day | the payment is rejected. |
| 4 | a payment would exceed a configured limit | it is rejected | no funds are held or charged. |

**Whether the service fee is included when calculating these limits requires team confirmation.**

#### US-19 – Apply Payment Velocity Restrictions

| Field | Details |
|---|---|
| Related FR | FR-19 |
| Priority | Should |

**User Story**

As a PayLink fraud-control system, I want to detect more than five payments within 60 seconds from one account, so that suspicious payment activity can be restricted.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an account makes five payments within a 60-second period | the system evaluates its activity | the velocity rule does not block it solely for those five payments. |
| 2 | an account makes more than five payments within 60 seconds | the system evaluates its activity | the account is blocked for 10 minutes. |
| 3 | an account is blocked by the velocity rule | it attempts another payment during the blocking period | the payment is rejected with a clear reason. |
| 4 | the 10-minute blocking period has ended | the customer attempts a payment | the temporary velocity restriction no longer prevents the request. |

### F. Support Operations

#### US-20 – Search Payment by Reference

| Field | Details |
|---|---|
| Related FR | FR-20 |
| Priority | Must |

**User Story**

As a support employee, I want to search for a payment using its reference and view its full history, so that I can investigate customer payment problems.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a valid payment reference exists | an authorized support employee searches for it | the system displays the payment details and recorded history. |
| 2 | a payment has undergone multiple state transitions | its history is requested | the system displays the recorded transitions in their chronological order. |
| 3 | no payment matches the reference | the search is performed | the system returns a clear not-found result. |
| 4 | an unauthorized user attempts to access support transaction history | the request is submitted | access is denied. |

#### US-21 – Block and Unblock Customer Accounts

| Field | Details |
|---|---|
| Related FR | FR-21 |
| Priority | Should |

**User Story**

As a support employee, I want to block or unblock a customer account, so that I can restrict or restore payment access when necessary.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an authorized support employee selects an active account | they block it | the account becomes blocked. |
| 2 | an account is blocked | a payment is attempted | the system rejects the payment with a clear reason. |
| 3 | an authorized support employee selects a blocked account | they unblock it | the account becomes eligible for normal payment validation. |
| 4 | an account-blocking action occurs | the action is completed | it is recorded in the audit log. |

### G. Notifications

#### US-22 – Notify Customers of Payment Results

| Field | Details |
|---|---|
| Related FR | FR-22 |
| Priority | Must |

**User Story**

As a customer, I want to receive SMS and push notifications when my payment completes or fails, so that I know the outcome of my transaction.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a payment becomes Completed | its final result is processed | the system initiates an SMS and push notification. |
| 2 | a payment becomes Failed | its final result is processed | the system initiates an SMS and push notification containing a clear failure reason. |
| 3 | a payment becomes Unknown | the timeout is processed | the customer is informed that the payment is still being processed. |
| 4 | a payment notification is initiated | it is sent | it references the corresponding payment. |

#### US-23 – Retry Failed Notifications

| Field | Details |
|---|---|
| Related FR | FR-23 |
| Priority | Should |

**User Story**

As a PayLink notification system, I want to retry failed SMS or email deliveries up to three times, so that temporary provider failures do not immediately prevent customer communication.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an SMS or email delivery fails | a retry is scheduled | the system attempts delivery again. |
| 2 | a notification continues to fail | three retries have been performed | the notification is marked as undelivered. |
| 3 | a payment has already completed | notification delivery fails | the payment remains Completed. |
| 4 | a notification is marked undelivered | its status is inspected | the delivery failure is visible. |

### H. System Configuration and Audit

#### US-24 – Update Fees and Limits Without Redeployment

| Field | Details |
|---|---|
| Related FR | FR-24 |
| Priority | Should |

**User Story**

As an administrator, I want to edit fee and limit values without redeploying the application, so that PayLink can update business configurations efficiently.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | an authorized administrator provides a valid new configuration value | they save it | the updated value is stored. |
| 2 | a fee or limit configuration is updated | a subsequent payment uses that configuration | the system applies the current configured value. |
| 3 | an unauthorized user attempts to modify configurations | the request is submitted | the operation is denied. |
| 4 | an administrator changes a configuration | the action is completed | the change is recorded in the audit log. |

#### US-25 – Record Financial and Administrative Audit Events

| Field | Details |
|---|---|
| Related FR | FR-25 |
| Priority | Must |

**User Story**

As a PayLink company, I want every money movement and administrative action recorded in an audit log, so that financial activities and system changes can be traced and investigated.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a wallet money movement occurs | the operation is committed | an audit record is created. |
| 2 | an administrator changes a biller, fee, or limit configuration | the change is completed | an audit record is created. |
| 3 | an audit record is created | it is inspected | it includes who performed the action, when it occurred, and why. |
| 4 | a money movement is committed | the system records it | its audit record is not omitted. |

### I. Reconciliation

#### US-26 – Generate Daily Reconciliation Report

| Field | Details |
|---|---|
| Related FR | FR-26 |
| Priority | Should |

**User Story**

As a support employee, I want to generate a daily reconciliation report using a biller's settlement file, so that I can identify differences between PayLink records and actual biller payments.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a valid settlement file is available | reconciliation is performed | the system compares its payment records with the biller's records. |
| 2 | a settlement file contains a payment that PayLink recorded as Failed | reconciliation is completed | the difference is flagged in the report for support review. |
| 3 | a discrepancy is detected | the report is generated | the discrepancy is included with sufficient reference information for investigation. |
| 4 | no discrepancies are detected | reconciliation is completed | the report reflects the comparison result without inventing differences. |

### J. Optional Refund and Reporting Features

#### US-27 – Request Refund for Completed Payment

| Field | Details |
|---|---|
| Related FR | FR-27 |
| Priority | Could |

**User Story**

As a customer, I want to request a refund for a completed payment, so that I can recover money when a valid refund case exists.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | a customer has a completed payment | they submit a refund request | the system records the request for support review. |
| 2 | a refund request is pending | an authorized support employee approves it | the system processes the approved refund. |
| 3 | a refund request is rejected | the decision is recorded | the original completed payment is not refunded. |
| 4 | a refund is successfully processed | the wallet is updated | the corresponding financial and audit records are created. |

**Refund amount, eligibility, and the final state transition require clarification.**

#### US-28 – View Daily Operational Totals

| Field | Details |
|---|---|
| Related FR | FR-28 |
| Priority | Could |

**User Story**

As an administrator, I want to view daily payment totals, fees earned, commissions paid, and failures per biller, so that I can monitor PayLink's daily operations.

**Acceptance Criteria**

| # | Given | When | Then |
|---:|---|---|---|
| 1 | payment records exist for a selected day | an administrator requests daily totals | the system displays the number of payments. |
| 2 | completed payments contain service fees and agent commissions | the report is generated | it displays the fees earned and commissions paid. |
| 3 | payments exist for multiple billers | the report is generated | it displays failure totals per biller. |
| 4 | no transactions exist for the selected day | the report is requested | the system displays zero totals. |

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