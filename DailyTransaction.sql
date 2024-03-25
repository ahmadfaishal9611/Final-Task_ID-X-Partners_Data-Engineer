CREATE PROCEDURE dbo.DailyTransaction
(
	@start_date DATETIME,
	@end_date DATETIME
)
AS
BEGIN
	SELECT 
		CAST (TransactionDate AS DATE) AS Date,
		COUNT(TransactionID) AS TotalTransactions,
		SUM(Amount) AS TotalAmount
	FROM dbo.FactTransaction
	WHERE CAST (TransactionDate AS DATE) BETWEEN @start_date AND @end_date
	GROUP BY CAST (TransactionDate AS DATE);
END;

EXEC dbo.DailyTransaction @start_date='2024-01-18', @end_date='2024-01-20';

