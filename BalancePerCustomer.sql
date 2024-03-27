CREATE PROCEDURE dbo.BalancePerCustomer
(
    @name VARCHAR(50)
)
AS
BEGIN
    WITH a AS
    (
        SELECT
            cus.CustomerName,
            acc.AccountType,
            acc.Balance,
		SUM(CASE WHEN trans.TransactionType = 'Deposit' THEN trans.Amount ELSE ((-1) * trans.Amount) END) AS TotalAmount
        FROM 
            FactTransaction AS trans
        LEFT JOIN 
            DimAccount AS acc ON trans.AccountID = acc.AccountID
        LEFT JOIN 
            DimCustomer AS cus ON acc.CustomerID = cus.CustomerID
	WHERE acc.Status = 'active'
	GROUP BY cus.CustomerName, acc.AccountType, acc.Balance
    )
    SELECT
        CustomerName,
        AccountType,
        Balance,
        (Balance + TotalAmount) AS CurrentBalance
    FROM a
    WHERE CustomerName LIKE '%' + @name + '%';
END;

EXEC dbo.BalancePerCustomer @name = 'Shelly';
