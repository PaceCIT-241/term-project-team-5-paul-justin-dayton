USE nfl_stats;

-- Insert Teams by Division

-- AFC East
INSERT INTO teams (team_name, city, conference, division) VALUES
('Bills', 'Buffalo', 'AFC', 'East'),
('Dolphins', 'Miami', 'AFC', 'East'),
('Patriots', 'New England', 'AFC', 'East'),
('Jets', 'New York', 'AFC', 'East');

-- AFC North
INSERT INTO teams (team_name, city, conference, division) VALUES
('Ravens', 'Baltimore', 'AFC', 'North'),
('Bengals', 'Cincinnati', 'AFC', 'North'),
('Browns', 'Cleveland', 'AFC', 'North'),
('Steelers', 'Pittsburgh', 'AFC', 'North');

-- AFC South
INSERT INTO teams (team_name, city, conference, division) VALUES
('Texans', 'Houston', 'AFC', 'South'),
('Colts', 'Indianapolis', 'AFC', 'South'),
('Jaguars', 'Jacksonville', 'AFC', 'South'),
('Titans', 'Tennessee', 'AFC', 'South');

-- AFC West
INSERT INTO teams (team_name, city, conference, division) VALUES
('Broncos', 'Denver', 'AFC', 'West'),
('Chiefs', 'Kansas City', 'AFC', 'West'),
('Raiders', 'Las Vegas', 'AFC', 'West'),
('Chargers', 'Los Angeles', 'AFC', 'West');

-- NFC East
INSERT INTO teams (team_name, city, conference, division) VALUES
('Cowboys', 'Dallas', 'NFC', 'East'),
('Giants', 'New York', 'NFC', 'East'),
('Eagles', 'Philadelphia', 'NFC', 'East'),
('Commanders', 'Washington', 'NFC', 'East');

-- NFC North
INSERT INTO teams (team_name, city, conference, division) VALUES
('Bears', 'Chicago', 'NFC', 'North'),
('Lions', 'Detroit', 'NFC', 'North'),
('Packers', 'Green Bay', 'NFC', 'North'),
('Vikings', 'Minnesota', 'NFC', 'North');

-- NFC South
INSERT INTO teams (team_name, city, conference, division) VALUES
('Falcons', 'Atlanta', 'NFC', 'South'),
('Panthers', 'Carolina', 'NFC', 'South'),
('Saints', 'New Orleans', 'NFC', 'South'),
('Buccaneers', 'Tampa Bay', 'NFC', 'South');

-- NFC West
INSERT INTO teams (team_name, city, conference, division) VALUES
('Cardinals', 'Arizona', 'NFC', 'West'),
('Rams', 'Los Angeles', 'NFC', 'West'),
('49ers', 'San Francisco', 'NFC', 'West'),
('Seahawks', 'Seattle', 'NFC', 'West');