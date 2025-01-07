SELECT domain, COUNT(users) AS total_users, ARRAY_AGG(users) AS users_array
FROM (SELECT id, name, UNNEST(email_addresses) AS users, 
			SPLIT_PART(UNNEST(email_addresses),'@','-1') AS domain, 
			ROW_NUMBER() OVER(PARTITION BY UNNEST(email_addresses), 
			SPLIT_PART(UNNEST(email_addresses),'@','-1')) AS row_num
		FROM contact_list)
GROUP BY domain
ORDER BY total_users DESC
;
