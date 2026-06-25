-- Загальна картина датасету
SELECT 
    COUNT(*) AS total_transactions,
    COUNT(DISTINCT name_orig) AS unique_senders,
    COUNT(DISTINCT name_dest) AS unique_receivers,
    MIN(step) AS first_step,
    MAX(step) AS last_step,
    SUM(amount) AS total_volume
FROM finances;

-- Розподіл по типах транзакцій
SELECT 
    type,
    COUNT(*) AS transaction_count,
    ROUND(AVG(amount), 2) AS avg_amount,
    SUM(amount) AS total_amount,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_total
FROM finances
GROUP BY type
ORDER BY transaction_count DESC;