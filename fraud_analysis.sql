-- Fraud rate по типах транзакцій
WITH fraud_by_type AS (
    SELECT
        type,
        COUNT(*) AS total,
        SUM(is_fraud) AS fraud_count
    FROM finances
    GROUP BY type
)
SELECT
    type,
    total,
    fraud_count,
    ROUND(100.0 * fraud_count / total, 4) AS fraud_rate_pct
FROM fraud_by_type
ORDER BY fraud_rate_pct DESC;

-- Ефективність системи виявлення fraud
SELECT
    COUNT(*) FILTER (WHERE is_fraud = 1) AS total_fraud,
    COUNT(*) FILTER (WHERE is_fraud = 1 AND isflagged_fraud = 1) AS caught_by_system,
    COUNT(*) FILTER (WHERE is_fraud = 1 AND isflagged_fraud = 0) AS missed_by_system,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_fraud = 1 AND isflagged_fraud = 1)
          / COUNT(*) FILTER (WHERE is_fraud = 1), 2) AS detection_rate_pct
FROM finances
WHERE type IN ('TRANSFER', 'CASH_OUT');
