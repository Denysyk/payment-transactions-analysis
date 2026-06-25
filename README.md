# Payment Transactions Analysis

SQL analysis of a 6.3M-row simulated mobile payments dataset focused on transaction patterns and fraud detection effectiveness.

## Stack

- PostgreSQL, DBeaver
- Tableau Public
- Dataset: [PaySim (Kaggle)](https://www.kaggle.com/datasets/ealaxi/paysim1)

## Dataset

PaySim simulates mobile money transactions based on real logs from an African mobile money service.

- 6,362,620 transactions
- 743 time steps (1 step = 1 hour, ~31 days)
- 5 transaction types: PAYMENT, TRANSFER, CASH_OUT, CASH_IN, DEBIT
- Includes fraud labels: isFraud (ground truth) and isFlaggedFraud (system flag)

## Key Findings

**1. TRANSFER has the highest monetary value despite low volume**

| Type | Count | % of Total | Avg Amount | Total Amount |
|------|------:|-----------:|-----------:|-------------:|
| CASH_OUT | 2,237,500 | 35.17% | 176,273.96 | 394.4B |
| PAYMENT | 2,151,495 | 33.81% | 13,057.60 | 28.1B |
| CASH_IN | 1,399,284 | 21.99% | 168,920.24 | 236.4B |
| TRANSFER | 532,909 | 8.38% | 910,647.01 | 485.3B |
| DEBIT | 41,432 | 0.65% | 5,483.67 | 0.2B |

**2. Fraud exists only in TRANSFER and CASH_OUT**

| Type | Total | Fraud Count | Fraud Rate |
|------|------:|------------:|-----------:|
| TRANSFER | 532,909 | 4,097 | 0.77% |
| CASH_OUT | 2,237,500 | 4,116 | 0.18% |
| CASH_IN / DEBIT / PAYMENT | 3,592,211 | 0 | 0.00% |

Classic money-muling pattern: funds transferred out, then immediately cashed out.

**3. The platform's fraud flag catches only 0.19% of actual fraud**

| Total Fraud | Caught | Missed | Detection Rate |
|------------:|-------:|-------:|---------------:|
| 8,213 | 16 | 8,197 | 0.19% |

**4. Top senders made exactly 1 transaction each, moving tens of millions in a single transfer — a behavioral red flag.**

**5. Several time steps show 100% fraud rate — all transactions in those windows were fraudulent.**

## Files

- `eda.sql` — exploratory data analysis
- `fraud_analysis.sql` — fraud rate and detection effectiveness
- `advanced_analysis.sql` — account ranking, time trends

## Dashboard

[Tableau Public](https://public.tableau.com/app/profile/denys.brativnyk/viz/PaymentTransactionsAnalysis/Dashboard1)
