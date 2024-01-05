SELECT *
FROM patient_logs;

MONTH		account		no_of_patients		unique_patients
jan			1			2					2				--> YES
jan			2			4					3				--> YES
jan			3			2					2				--> NO
mar			1			1					1				--> YES

SELECT MONTH, account_id, no_of_patients
FROM (
SELECT *
RANK() OVER (partition by month by no_of_patients desc) AS rnk
FROM (
SELECT MONTH, account_id, COUNT(1) AS no_of_patients
FROM (
	SELECT DISTINCT to_char(DATE, 'MONTH') AS MONTH, account_id, patient_id
    FROM patient_logs) pl
GROUP BY MONTH, account_id) x
) temp
WHERE temp.rnk IN (1, 2);

