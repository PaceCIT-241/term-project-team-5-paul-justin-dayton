-- EXECUTION ORDER: Run this file SECOND (after schema.sql)
USE nfl_stats;

-- Insert offensive skill positions
INSERT INTO positions (position_id, position_name) VALUES
('QB', 'Quarterback'),
('RB', 'Running Back'),
('WR', 'Wide Receiver'),
('TE', 'Tight End');
