SELECT user_id, user_name, email
FROM (
	SELECT *
	row_number() OVER (PARTITION BY user_name ORDER BY user_id) AS rn
	FROM users;
ORDER BY user_id) x
WHERE x.rn > 1;