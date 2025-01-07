# [Santas Christmas card list 💌](https://adventofsql.com/challenges/13)

## Description
Santa faced a dilemma after the Board of Christmas Directors flagged concerns about certain corporations receiving an excessive number of premium gift hampers. Notably, MegaCorp had claimed 40% of the hampers, raising suspicions.

With help from Mrs. Claus, armed with her MBA in Christmas Analytics, they analyzed email domain patterns. The investigation revealed some companies were exploiting the system by using multiple email domains, including personal, corporate, and subsidiary addresses. One standout offender, Winter Wonderland Corp., had inflated its hamper quota through a web of shell companies. Even TechGiant Industries had outpaced entire nations like Luxembourg.

Santa and Mrs. Claus worked tirelessly to expose these schemes using advanced database queries, uncovering three corporations running sophisticated hamper-maximizing operations. To restore fairness, Santa implemented domain aggregation rules, ensuring each corporate entity would receive a single gift hamper quota moving forward, preserving the integrity of Christmas cheer.

## Challenge
[Download Challenge data](https://github.com/thatlaconic/advent-of-sql-day-13/blob/main/advent_of_sql_day_13.sql)

Create a list of all the domains that exist in the contacts list emails.

## Dataset
This dataset contains 1 table. 
### Using PostgreSQL
**input**
```sql
SELECT *
FROM contact_list ;
```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-13/blob/main/contact.PNG)

### Solution
[Download Solution Code](https://github.com/thatlaconic/advent-of-sql-day-13/blob/main/advent_answer_day13.sql)

**input**
```sql
SELECT domain, COUNT(users) AS total_users, ARRAY_AGG(users) AS users_array
FROM (SELECT id, name, UNNEST(email_addresses) AS users, 
			SPLIT_PART(UNNEST(email_addresses),'@','-1') AS domain, 
			ROW_NUMBER() OVER(PARTITION BY UNNEST(email_addresses), 
			SPLIT_PART(UNNEST(email_addresses),'@','-1')) AS row_num
		FROM contact_list)
GROUP BY domain
ORDER BY total_users DESC ;

```
**output**

![](https://github.com/thatlaconic/advent-of-sql-day-13/blob/main/d13.PNG)

