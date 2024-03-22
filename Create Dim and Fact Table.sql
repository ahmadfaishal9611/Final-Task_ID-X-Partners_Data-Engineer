CREATE TABLE DimCustomer (
	CustomerID INT PRIMARY KEY NOT NULL,
	CustomerName VARCHAR (50) NOT NULL,
	Address VARCHAR (50) NOT NULL,
	CityName VARCHAR (50) NOT NULL,
	StateName VARCHAR (50) NOT NULL,
	Age INT NOT NULL,
	Gender VARCHAR (50) NOT NULL,
	Email VARCHAR (50) NOT NULL
);

CREATE TABLE DimAccount (
	AccountID INT PRIMARY KEY NOT NULL,
	CustomerID INT NOT NULL,
	AccountType VARCHAR (50) NOT NULL,
	Balance INT NOT NULL,
	DateOpened DATETIME NOT NULL,
	Status VARCHAR (50) NOT NULL,
	FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

CREATE TABLE DimBranch (
	BranchID INT PRIMARY KEY NOT NULL,
	BranchName VARCHAR (50) NOT NULL,
	BranchLocation VARCHAR (50) NOT NULL
);

CREATE TABLE FactTransaction (
	TransactionID INT PRIMARY KEY NOT NULL,
	AccountID INT NOT NULL,
	TransactionDate DATETIME NOT NULL,
	Amount INT NOT NULL,
	TransactionType VARCHAR (50) NOT NULL,
	BranchID INT NOT NULL,
	FOREIGN KEY (AccountID) REFERENCES DimAccount(AccountID),
	FOREIGN KEY (BranchID) REFERENCES DimBranch(BranchID)
);