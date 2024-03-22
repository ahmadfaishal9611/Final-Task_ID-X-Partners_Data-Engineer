CREATE PROCEDURE dbo.BalancePerCustomer
(
    @name VARCHAR(50)
)
AS
BEGIN
    WITH a AS
    (
        SELECT
            trans.TransactionID,
            cus.CustomerName,
            trans.TransactionDate,
            acc.AccountType,
            acc.Balance,
            trans.Amount,
            trans.TransactionType
        FROM 
            FactTransaction AS trans
        LEFT JOIN 
            DimAccount AS acc ON trans.AccountID = acc.AccountID
        LEFT JOIN 
            DimCustomer AS cus ON acc.CustomerID = cus.CustomerID
		WHERE acc.Status = 'active'
    ),
    b AS
    (
        SELECT
            CustomerName,
            AccountType,
            Balance,
            SUM(CASE WHEN TransactionType = 'Deposit' THEN Amount ELSE 0 END) AS TotalDeposit,
            SUM(CASE WHEN TransactionType != 'Deposit' THEN Amount ELSE 0 END) AS TotalNonDeposit
        FROM a
        GROUP BY CustomerName, AccountType, Balance
    )
    SELECT
        CustomerName,
        AccountType,
        Balance,
        (Balance + TotalDeposit - TotalNonDeposit) AS CurrentBalance
    FROM b
    WHERE CustomerName LIKE '%' + @name + '%';
END;

EXEC dbo.BalancePerCustomer @name = 'Shelly';
