CREATE OR REPLACE VIEW `revenue-operations-analytics.raw.stg_stripe_billing` AS
SELECT
    customer_id,
    subscription_plan,
    CAST(mrr_amount AS NUMERIC) AS mrr_amount,
    status AS billing_status
FROM `revenue-operations-analytics.raw.stripe_billing`;
