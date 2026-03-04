SELECT
    customer_id,
    account_name,
    CAST(contract_value_arr AS NUMERIC) AS contract_value_arr,
    is_active AS crm_status
FROM `revenue-operations-analytics.raw.salesforce_crm`
