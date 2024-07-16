USE [Bank Loan DB]

SELECT * FROM loan_data

SELECT COUNT(id) as TOTAL_LOAN_APPLICATIONS FROM loan_data

SELECT COUNT(id) as MTD_TOTAL_LOAN_APPLICATIONS FROM loan_data
WHERE MONTH(issue_date) = 12

SELECT COUNT(id) as PMTD_TOTAL_LOAN_APPLICATIONS FROM loan_data
WHERE MONTH(issue_date) = 11

SELECT SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT FROM loan_data

SELECT SUM(loan_amount) AS MTD_TOTAL_FUNDED_AMOUNT FROM loan_data
WHERE MONTH(issue_date) = 12

SELECT SUM(loan_amount) AS PMTD_TOTAL_FUNDED_AMOUNT FROM loan_data
WHERE MONTH(issue_date) = 11

SELECT SUM(total_payment) AS TOTAL_AMOUNT_RECEIVED FROM loan_data

SELECT SUM(total_payment) AS MTD_TOTAL_AMOUNT_RECEIVED FROM loan_data
WHERE MONTH(issue_date) = 12

SELECT SUM(total_payment) AS PMTD_TOTAL_AMOUNT_RECEIVED FROM loan_data
WHERE MONTH(issue_date) = 11

SELECT ROUND(AVG(int_rate), 4) * 100 as AVG_INTEREST_RATE FROM loan_data

SELECT ROUND(AVG(int_rate), 4) * 100 as MTD_AVG_INTEREST_RATE FROM loan_data
WHERE MONTH(issue_date) = 12

SELECT ROUND(AVG(int_rate), 4) * 100 as PMTD_AVG_INTEREST_RATE FROM loan_data
WHERE MONTH(issue_date) = 11

SELECT ROUND(AVG(dti), 4) * 100 as AVG_DTI FROM loan_data

SELECT ROUND(AVG(dti), 4) * 100 as MTD_AVG_DTI FROM loan_data
WHERE MONTH(issue_date) = 12

SELECT ROUND(AVG(dti), 4) * 100 as PMTD_AVG_DTI FROM loan_data
WHERE MONTH(issue_date) = 11

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100)
	/
	COUNT(id) AS GOOD_LOAN_PERC
FROM loan_data

SELECT COUNT(id) AS GOOD_LOAN_APPLICATIONS FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(loan_amount) AS GOOD_LOAN_FUNDED_AMOUNT FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

SELECT SUM(total_payment) AS GOOD_LOAN_TOTAL_AMOUNT_RECEIVED FROM loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'



SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100)
	/
	COUNT(id) AS BAD_LOAN_PERC
FROM loan_data

SELECT COUNT(id) AS BAD_LOAN_APPLICATIONS FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(loan_amount) AS BAD_LOAN_FUNDED_AMOUNT FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT SUM(total_payment) AS BAD_LOAN_TOTAL_AMOUNT_RECEIVED FROM loan_data
WHERE loan_status = 'Charged Off'

SELECT
    loan_status,
	COUNT(id) AS LOAN_COUNT,
	SUM(total_payment) AS TOTAL_AMOUT_RECEIVED,
	SUM(loan_amount) AS TOTAL_AMOUNT_FUNDED,
	AVG(int_rate * 100) AS INTEREST_RATE,
	AVG(dti * 100) AS DTI
FROM
    loan_data
GROUP BY 
    loan_status


SELECT 
    loan_status,
	SUM(total_payment) AS MTD_TOTAL_AMOUNT_RECEIVED,
	SUM(loan_amount) AS MTD_TOTAL_FUNDED_AMOUNT
FROM
    loan_data
WHERE 
    MONTH(issue_date) = 12
GROUP BY 
    loan_status


SELECT 
    loan_status,
	SUM(total_payment) AS PMTD_TOTAL_AMOUNT_RECEIVED,
	SUM(loan_amount) AS PMTD_TOTAL_FUNDED_AMOUNT
FROM
    loan_data
WHERE 
    MONTH(issue_date) = 11
GROUP BY 
    loan_status


SELECT 
    MONTH(issue_date) AS MONTH_NUMBER,
	DATENAME(MONTH, issue_date) AS MONTH_NAME,
	COUNT(id) AS TOTAL_LOAN_APPLICATIONS,
	SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT
FROM loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


SELECT 
    address_state,
	COUNT(id) AS TOTAL_LOAN_APPLICATIONS,
	SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT
FROM loan_data
GROUP BY address_state
ORDER BY SUM(loan_amount) DESC


SELECT 
    term,
	COUNT(id) AS TOTAL_LOAN_APPLICATIONS,
	SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT
FROM loan_data
GROUP BY term
ORDER BY term


SELECT 
    home_ownership,
	COUNT(id) AS TOTAL_LOAN_APPLICATIONS,
	SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT,
	SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT
FROM loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC




