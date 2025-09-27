create database marketing_campaign;
use marketing_campaign;
CREATE TABLE marketing_campaign (
    ID INT PRIMARY KEY,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(50),
    Income DECIMAL(10,2),
    Kidhome INT,
    Teenhome INT,
    Dt_Customer DATE,
    Recency INT,
    MntWines INT,
    MntFruits INT,
    MntMeatProducts INT,
    MntFishProducts INT,
    MntSweetProducts INT,
    MntGoldProds INT,
    NumDealsPurchases INT,
    NumWebPurchases INT,
    NumCatalogPurchases INT,
    NumStorePurchases INT,
    NumWebVisitsMonth INT,
    AcceptedCmp3 INT,
    AcceptedCmp4 INT,
    AcceptedCmp5 INT,
    AcceptedCmp1 INT,
    AcceptedCmp2 INT,
    Complain INT,
    Z_CostContact INT,
    Z_Revenue INT,
    Response INT
);
LOAD DATA INFILE '/C:\Users\aliya\OneDrive\Desktop\Customer Personality\Task1_Datacleaning/marketing_campaign.csv'
INTO TABLE marketing_campaign
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

desc cleaned_dataset;

select max(income), min(income), avg(income)
from cleaned_dataset;

--Customers with high income
select id,income,education,marital_status
from cleaned_dataset
where income > 80000
order by income desc;

--Average income per education level
select Education, Avg(income) as avg_income
from cleaned_dataset
group by Education
order by avg_income desc;

show tables;

select * from cleaned_dataset limit 10;

-- join
SELECT a.ID, a.Marital_Status, b.ID
FROM cleaned_dataset a
JOIN cleaned_dataset b
  ON a.Marital_Status = b.Marital_Status
WHERE a.ID <> b.ID;

-- customer who earns more than average income
select ID, income
from cleaned_dataset 
where income >(
select avg(income)
from cleaned_dataset);

-- Aggregate functions
-- Total spending per customer
select ID, (mntwines + mntfruits + mntmeatproducts + mntfishproducts + mntsweetproducts + mntgoldprods) as total_spending
from cleaned_dataset
order by total_spending desc;

-- Average Recency
select  avg(recency) as Avg_Recency 
from cleaned_dataset;

-- Views
-- create a view for high value customers
-- Create a view for high value customers
CREATE VIEW HighValueCustomers AS
SELECT ID, Income,
       (MntWines + MntFruits + MntMeatProducts + 
        MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend
FROM cleaned_dataset
WHERE Income > 70000;

create INDEX idx_income on cleaned_dataset(Income);
CREATE INDEX idx_dt_customer ON cleaned_dataset(Dt_Customer);
drop table marketing_campaign;
show tables;
desc highvaluecustomers;

