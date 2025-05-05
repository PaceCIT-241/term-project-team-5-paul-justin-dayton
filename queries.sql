USE nfl_stats;

-- Query to get top 25 QBs by passing yards
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as player_name,
    pos.position_name,
    qb.passing_yards,
    p.team_name
FROM players p
JOIN positions pos ON p.position_id = pos.position_id
JOIN qb_season_stats qb ON p.last_name = qb.last_name AND p.first_name = qb.first_name
WHERE pos.position_id = 'QB'
ORDER BY qb.passing_yards DESC
LIMIT 25;

-- Query to get top 25 RBs by rushing yards
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as player_name,
    pos.position_name,
    rb.yards as rushing_yards,
    p.team_name
FROM players p
JOIN positions pos ON p.position_id = pos.position_id
JOIN rb_season_stats rb ON p.last_name = rb.last_name AND p.first_name = rb.first_name
WHERE pos.position_id = 'RB'
ORDER BY rb.yards DESC
LIMIT 25;

-- Query to get top 25 WRs by receiving yards
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as player_name,
    pos.position_name,
    wr.yards as receiving_yards,
    p.team_name
FROM players p
JOIN positions pos ON p.position_id = pos.position_id
JOIN wr_season_stats wr ON p.last_name = wr.last_name AND p.first_name = wr.first_name
WHERE pos.position_id = 'WR'
ORDER BY wr.yards DESC
LIMIT 25;

-- Query to get top 25 combined WRs and RBs by total yards
SELECT 
    CONCAT(p.first_name, ' ', p.last_name) as player_name,
    pos.position_name,
    p.team_name,
    CASE 
        WHEN pos.position_id = 'WR' THEN wr.yards
        WHEN pos.position_id = 'RB' THEN rb.yards
    END as total_yards,
    CASE 
        WHEN pos.position_id = 'WR' THEN 'Receiving'
        WHEN pos.position_id = 'RB' THEN 'Rushing'
    END as yards_type
FROM players p
JOIN positions pos ON p.position_id = pos.position_id
LEFT JOIN wr_season_stats wr ON p.last_name = wr.last_name AND p.first_name = wr.first_name
LEFT JOIN rb_season_stats rb ON p.last_name = rb.last_name AND p.first_name = rb.first_name
WHERE pos.position_id IN ('WR', 'RB')
    AND (wr.yards IS NOT NULL OR rb.yards IS NOT NULL)
ORDER BY total_yards DESC
LIMIT 25;


-- Position Group Performance Summary / Average
SELECT
    pos.position_name,
    COUNT(DISTINCT CONCAT(p.first_name, ' ', p.last_name)) as player_count,
    CASE
        WHEN pos.position_id = 'QB' THEN
            ROUND(AVG(qb.passing_yards), 2)
        WHEN pos.position_id = 'RB' THEN
            ROUND(AVG(rb.yards), 2)
        WHEN pos.position_id = 'WR' THEN
            ROUND(AVG(wr.yards), 2)
    END as avg_yards,
    CASE
        WHEN pos.position_id = 'QB' THEN
            ROUND(AVG(qb.passing_touchdowns), 2)
        WHEN pos.position_id = 'RB' THEN
            ROUND(AVG(rb.touchdowns), 2)
        WHEN pos.position_id = 'WR' THEN
            ROUND(AVG(wr.touchdowns), 2)
    END as avg_touchdowns
FROM positions pos
JOIN players p ON pos.position_id = p.position_id
LEFT JOIN qb_season_stats qb ON p.last_name = qb.last_name AND p.first_name = qb.first_name
LEFT JOIN rb_season_stats rb ON p.last_name = rb.last_name AND p.first_name = rb.first_name
LEFT JOIN wr_season_stats wr ON p.last_name = wr.last_name AND p.first_name = wr.first_name
GROUP BY pos.position_name, pos.position_id
ORDER BY player_count DESC;

-- Top players at each position
DROP VIEW IF EXISTS top_position_players;
CREATE VIEW top_position_players AS
SELECT * FROM (
    SELECT 
        CONCAT(p.first_name, ' ', p.last_name) as player_name,
        pos.position_name,
        p.team_name,
        CASE
            WHEN pos.position_id = 'QB' THEN qb.passing_yards
            WHEN pos.position_id = 'RB' THEN rb.yards
            WHEN pos.position_id = 'WR' THEN wr.yards
        END as yards,
        CASE
            WHEN pos.position_id = 'QB' THEN 'Passing'
            WHEN pos.position_id = 'RB' THEN 'Rushing'
            WHEN pos.position_id = 'WR' THEN 'Receiving'
        END as yards_type,
        CASE
            WHEN pos.position_id = 'QB' THEN qb.passing_touchdowns
            WHEN pos.position_id = 'RB' THEN rb.touchdowns
            WHEN pos.position_id = 'WR' THEN wr.touchdowns
        END as touchdowns
    FROM players p
    JOIN positions pos ON p.position_id = pos.position_id
    LEFT JOIN qb_season_stats qb ON p.last_name = qb.last_name AND p.first_name = qb.first_name AND pos.position_id = 'QB'
    LEFT JOIN rb_season_stats rb ON p.last_name = rb.last_name AND p.first_name = rb.first_name AND pos.position_id = 'RB'
    LEFT JOIN wr_season_stats wr ON p.last_name = wr.last_name AND p.first_name = wr.first_name AND pos.position_id = 'WR'
    WHERE (pos.position_id = 'QB' AND qb.passing_yards = (
            SELECT MAX(passing_yards) FROM qb_season_stats
          ))
       OR (pos.position_id = 'RB' AND rb.yards = (
            SELECT MAX(yards) FROM rb_season_stats
          ))
       OR (pos.position_id = 'WR' AND wr.yards = (
            SELECT MAX(yards) FROM wr_season_stats
          ))
) top_players;

-- Query to show the top players from the view
SELECT * FROM top_position_players;

-- Create read-only admin user
CREATE USER 'admin_readonly'@'localhost';

-- Grant only SELECT privileges on the nfl_stats database
GRANT SELECT ON nfl_stats.* TO 'admin_readonly'@'localhost';

-- Ensure the user can't modify anything
REVOKE INSERT, UPDATE, DELETE ON nfl_stats.* FROM 'admin_readonly'@'localhost';

CREATE USER 'mel.kiper'@'localhost' IDENTIFIED BY 'draft2024';
GRANT SELECT ON nfl_stats.* TO 'mel.kiper'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON nfl_stats.* FROM 'mel.kiper'@'localhost';

CREATE USER 'roger.goodell'@'localhost' IDENTIFIED BY 'commissioner2024';
GRANT SELECT ON nfl_stats.* TO 'roger.goodell'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON nfl_stats.* FROM 'roger.goodell'@'localhost';

CREATE USER 'pat.mcafee'@'localhost' IDENTIFIED BY 'fortheband2024';
GRANT SELECT ON nfl_stats.* TO 'pat.mcafee'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON nfl_stats.* FROM 'pat.mcafee'@'localhost';

-- All users have read-only access to view NFL statistics
-- None can modify, insert, or delete data