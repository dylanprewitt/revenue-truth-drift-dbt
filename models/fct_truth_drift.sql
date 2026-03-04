CREATE OR REPLACE TABLE `revenue-operations-analytics.raw.fct_truth_drift` AS
WITH billing AS (
    SELECT * FROM `revenue-operations-analytics.raw.stg_stripe_billing`
),
crm AS (
    SELECT * FROM `revenue-operations-analytics.raw.stg_salesforce_crm`
)
SELECT
    COALESCE(b.customer_id, c.customer_id) AS customer_id,
    b.billing_status,
    c.crm_status,
    (COALESCE(b.mrr_amount, 0) * 12) AS billing_annual_run_rate,
    COALESCE(c.contract_value_arr, 0) AS crm_contract_value,
    ((COALESCE(b.mrr_amount, 0) * 12) - COALESCE(c.contract_value_arr, 0)) AS financial_variance,
    CASE
        WHEN b.customer_id IS NULL THEN 'Missing in Billing'
        WHEN c.customer_id IS NULL THEN 'Missing in CRM'
        WHEN (COALESCE(b.mrr_amount, 0) * 12) != COALESCE(c.contract_value_arr, 0) THEN 'Value Drift'
        WHEN b.billing_status = 'active' AND c.crm_status = false THEN 'Status Drift'
        ELSE 'Aligned'
    END AS audit_flag
FROM billing b
FULL OUTER JOIN crm c 
    ON b.customer_id = c.customer_id;
