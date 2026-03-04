# Revenue Operations "Truth Drift" Analytics Pipeline

## Objective
Establish absolute truth and financial transparency by automatically auditing the variance between billing systems and CRM platforms. 

## The Business Problem
Modern SaaS architectures often experience "Truth Drift"—a silent misalignment where a customer's contract state in the CRM (Salesforce) contradicts their active billing state (Stripe). This results in revenue leakage, inflated Annual Recurring Revenue (ARR) reporting, and compliance violations. Manual auditing carries an unsustainably high Intrinsic Cost.

## The Solution
This project represents an automated, high-leverage Modern Data Stack (MDS) pipeline designed to identify uncontested "Golden Ocean" opportunities for revenue recovery. By applying strict, modular SQL transformations, the architecture mathematically guarantees the detection of financial anomalies.

### Architecture & Stack
* **Data Warehouse:** Google BigQuery
* **Transformation Layer:** SQL (Staging & Fact Materializations)
* **Ingestion:** Flat File Auto-Detect (Simulated Fivetran/Airbyte)

### Core Logic (The 99/1 Rule)
The pipeline executes a `FULL OUTER JOIN` on normalized primary keys (`customer_id`) to expose the following drift categories:
1. **Value Drift:** Annualized MRR does not match Contracted ARR.
2. **Status Drift:** Account is marked "Churned" in CRM but remains "Active" in Billing.
3. **Orphan Records:** Entity exists in one system but is entirely missing from the other.

## Portfolio Demonstration
This repository contains the exact DDL statements required to cast raw system data into a pristine, auditable `fct_truth_drift` table, prioritizing commercial accuracy and objective truth above all metrics.
