select * from financial_loan_Analysis

---------------	PROBLEM STATEMENT --------------------

-- 1. Total Loan Application 

SELECT COUNT(id)as Total_Loan_Application from financial_loan_Analysis

SELECT COUNT(id) as Latest_Month_Total_Loan_Application from financial_loan_Analysis
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021  -- this data is for december 2021

SELECT COUNT(id) as Previous_Month_Total_Loan_Application from financial_loan_Analysis
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- 2. Total Funded Amount 

SELECT SUM(loan_amount) as Total_Fund_Amount from financial_loan_Analysis

SELECT SUM(loan_amount) as Latest_Month_Fund_Disbursed from financial_loan_Analysis
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(loan_amount) as Previous_Month_Fund_Disbursed from financial_loan_Analysis
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- 3. Total Amount Received 

SELECT SUM(total_payment) as Total_Amount_Received from financial_loan_Analysis

SELECT SUM(total_payment) as Latest_Month_Total_Amount_Received from financial_loan_Analysis
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT SUM(total_payment) as Previous_Month_Total_Amount_Received from financial_loan_Analysis
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

-- 4. Average Interest Rate

SELECT ROUND((SUM(int_rate)/COUNT(int_rate)),4) * 100 as Average_Interest_Rate from financial_loan_Analysis -- multiply by 100 bcoz of convert into percentage

SELECT ROUND(AVG(int_rate),4) * 100 as Average_Interest_Rate from financial_loan_Analysis

SELECT ROUND(AVG(int_rate),4) * 100 as Latest_Month_Average_Rate from financial_loan_Analysis
where MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 

SELECT ROUND(AVG(int_rate),4) * 100 as Latest_Month_Average_Rate from financial_loan_Analysis
where MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 


-- Average Debt-to-Income Ratio (DTI)

SELECT ROUND(AVG(dti),4) * 100 as Average_Debt_Income_Ratio from financial_loan_Analysis

SELECT ROUND(AVG(dti),4) * 100 as Latest_Month_Average_dti from financial_loan_Analysis
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

SELECT ROUND(AVG(dti),4) * 100 as Latest_Month_Average_dti from financial_loan_Analysis
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

------------------------------------------------------------------------------------------------------------------------------

-- Good Loan v Bad Loan KPI’s

SELECT loan_status from financial_loan_Analysis 

SELECT distinct(loan_status) from financial_loan_Analysis -- -- Fully Paid and Current Considered as a good loan and Charged off considered as a Bad loan

SELECT COUNT(loan_status) from financial_loan_Analysis

-- GOOD LOAN APPLICATION PERCENTAGE

SELECT 
      COUNT(CASE When loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)* 100.0
	  /
	  COUNT(id) as GOOD_LOAN_Percentage from financial_loan_Analysis

-- GOOD LOAN APPLICATIONS

SELECT 
      COUNT(CASE when loan_status = 'Fully Paid' OR loan_status='Current' THEN id END) as Good_Loan_Applications 
	  from financial_loan_Analysis

-- GOOD LOAN FUNDED AMOUNT

SELECT 
       SUM(CASE when loan_status = 'Fully Paid' OR loan_status = 'Current' Then loan_amount END) as Good_Loan_Funded_Amount 
	   from financial_loan_Analysis


-- GOOD LOAN TOTAL RECEIVED AMOUNT

SELECT 
      SUM(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN total_payment END) as Good_Loan_Total_Amount_Received
	  from financial_loan_Analysis

--------------------------------------------------------------------------------------------------------

-- Bad Loan Application Percentage

SELECT 
      COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0
	  /
	  COUNT(id) as Bad_Loan_Application_Percentage from financial_loan_Analysis


-- Bad Loan Applications

SELECT 
      COUNT(CASE when loan_status = 'Charged Off' THEN id END) as Bad_Loan_Application 
	  from financial_loan_Analysis


SELECT COUNT(id) as Bad_Loan_Application from financial_loan_Analysis
where loan_status = 'Charged Off'

-- Bad Loan Funded Amount

SELECT 
      SUM(CASE when loan_status = 'Charged Off' THEN loan_amount END) as Bad_Loan_Funded_AMount
	  from financial_loan_Analysis

SELECT SUM(loan_amount) as Bad_Loan_Funded_AMount from financial_loan_Analysis
where loan_status = 'Charged Off'

-- Bad Loan Total Received Amount

SELECT 
       SUM(CASE when loan_status = 'Charged Off' THEN total_payment END) as Bad_Loan_Total_Received_Amount
	   from financial_loan_Analysis


SELECT SUM(total_payment) as Bad_Loan_Total_Received_Amount from financial_loan_Analysis
where loan_status = 'Charged Off'


--------------------------------------------------------------------------------------------------------------------

          ----    LOAN STATUS ------

      --Loan Status Grid View
--In order to gain a comprehensive overview of our lending operations and monitor the performance of loans, we aim 
--to create a grid view report categorized by 'Loan Status.’ By providing insights into metrics such as 'Total Loan 
--Applications,' 'Total Funded Amount,' 'Total Amount Received,' 'Month-to-Date (MTD) Funded Amount,' 'MTD Amount 
--Received,' 'Average Interest Rate,' and 'Average Debt-to-Income Ratio (DTI),' this grid view will empower us to
--make data-driven decisions and assess the health of our loan portfolio.

SELECT loan_status,
	COUNT(id) as Total_Loan_Application, 
	SUM(loan_amount) as Total_Funded_Amount,
	SUM(total_payment) as Total_Amount_Received,
	AVG(int_rate) * 100 as Average_interest_Rate,
	AVG(dti) * 100 as Average_Debt_to_Income_Ratio
	from financial_loan_Analysis
	group by loan_status


SELECT loan_status, 
		SUM(loan_amount) as MTD_Funded_Amount,
		SUM(total_payment) as MTD_Received_Amount
		from financial_loan_Analysis
		where MONTH(issue_date) = 12 
		group by loan_status


------------------------------------------------------------------------------------------------------------
			---	BANK LOAN REPORT | OVERVIEW ---

   --- MONTH WISE 

SELECT 
		MONTH(issue_date) as Month_Number,
		DATENAME(MONTH,issue_date) as Month_Name,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_Loan_Amount,
		SUM(total_payment) as Received_Amount
		from financial_loan_Analysis
		group by MONTH(issue_date),DATENAME(MONTH,issue_date)
		order by MONTH(issue_date)


            --- STATE WISE --

SELECT 
		address_state as state,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		group by address_state
		order by address_state


      ---- Term Wise ----

SELECT 
		term as TERM,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUm(total_payment) as Received_amount
		from financial_loan_Analysis
		group by term
		order by term


		--- EMPLOYEE LENGTH --

SELECT 
		emp_length as Employee_Length,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		group by emp_length
		order by emp_length


		--- PURPOSE ---

SELECT 
		purpose as Purpose,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		group by purpose
		order by purpose


		--- HOME OWNERSHIP ---

SELECT 
		home_ownership as Home_Owner,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		group by home_ownership
		order by home_ownership


SELECT 
		home_ownership as Home_Owner,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		where grade = 'A'
		group by home_ownership
		order by home_ownership


SELECT 
		home_ownership as Home_Owner,
		COUNT(id) as Total_Loan_Application,
		SUM(loan_amount) as Funded_amount,
		SUM(total_payment) as Received_amount
		from financial_loan_Analysis
		where grade = 'A' and address_state = 'CA'
		group by home_ownership
		order by home_ownership























