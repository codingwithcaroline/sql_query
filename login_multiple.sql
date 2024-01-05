SELECT DISTINCT user_name
FROM (
	SELECT * 
	CASE WHEN user_name = LEAD(user_name) OVER(ORDER login_id)
		AND user_name = LEAD(user_name, 2) OVER(ORDER BY login_id)
	THEN user_name
	ELSE null
END AS repeated_users
FROM login_details) x
WHERE x.repeated_users IS NOT null;