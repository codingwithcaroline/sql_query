SELECT id, city, temperature, DAY
FROM (
SELECT *,
CASE WHEN temperature < 0
		AND LEAD(temperature) OVER(ORDER BY id) < 0
		AND LEAD(temperature, 2) OVER(ORDER BY id) < 0
	THEN 'Yes'
    WHEN temperature < 0
		AND LAG(temperature) OVER(ORDER BY id) < 0
		AND LEAD(temperature) OVER(ORDER BY id) < 0
	WHEN temperature < 0
		AND LAG(temperature) OVER(ORDER BY id) < 0
		AND LAG(temperature, 2) OVER(ORDER BY id) < 0
	THEN 'Yes'
	ELSE NULL
END flag 
FROM weather) x
WHERE x.flag = 'Yes';