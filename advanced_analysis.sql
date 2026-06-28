-- Топ 10 акаунтів за сумою відправлень
SELECT
    name_orig,
    total_sent,
    transaction_count,
    rank
FROM (
    SELECT
        name_orig,
        SUM(amount) AS total_sent,
        COUNT(*) AS transaction_count,
        RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
    FROM finances
    GROUP BY name_orig
) ranked
WHERE rank <= 10
ORDER BY rank;

-- Часові тренди fraud по годинах (топ 20 за кількістю fraud)
SELECT
    step,
    COUNT(*) FILTER (WHERE is_fraud = 1) AS fraud_count,
    COUNT(*) AS total_count,
    ROUND(100.0 * COUNT(*) FILTER (WHERE is_fraud = 1) / COUNT(*), 4) AS fraud_rate_pct
FROM finances
WHERE type IN ('TRANSFER', 'CASH_OUT')
GROUP BY step
ORDER BY fraud_count DESC
LIMIT 20;
