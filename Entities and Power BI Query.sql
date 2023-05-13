SELECT * --1
from player

select * --2 
from coach

select * --3
from owner

select * --4
from team

select * --5
from stadium

select * --6
from season

select * --7
from conference

select * --8
from division


select * --9
from player_stats

select * --10
from games




SELECT 
t.team_name,
c.first_name,
c.last_name,
c.salary,
COUNT(winning_team) AS Wins
FROM games g
inner join team as t
on t.team_id = g.winning_team
inner join coach c
on c.coach_id = t.coach_id
GROUP BY  
t.team_name,
c.first_name,
c.last_name,
c.salary
ORDER BY 5 DESC;


SELECT 
    p.player_id,
	p.player_last_name,
	p.player_first_name,
	player_first_name + ' ' + player_last_name as "name",
	t.team_name,
    SUM(three_pointers_made) AS '3PM',
    SUM(three_pointers_attempted) AS '3PA',
    CASE
        WHEN SUM(three_pointers_attempted) = 0 THEN 0
        ELSE ROUND(CAST(SUM(three_pointers_made) AS float) / SUM(three_pointers_attempted),3)
    END AS '3P%'
FROM player_stats s
inner join player p
inner join team t
on t.team_id = p.team_id
on p.player_id = s.player_id
GROUP BY  
t.team_name,
p.player_id,
	p.player_last_name,
	p.player_first_name
HAVING SUM(three_pointers_made) > 150;


SELECT
    CASE
        WHEN SUM(three_pointers_attempted) = 0 THEN 0
        ELSE ROUND(CAST(SUM(three_pointers_made) AS float) / SUM(three_pointers_attempted), 3)
    END AS 'Average 3P%'
FROM player_stats;