-- Create NFL Stats Database
CREATE DATABASE IF NOT EXISTS nfl_stats;
USE nfl_stats;

-- Teams Table
CREATE TABLE teams (
    team_name VARCHAR(50) PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    conference VARCHAR(3) NOT NULL,
    division VARCHAR(20) NOT NULL
);

-- Positions Table
CREATE TABLE positions (
    position_id VARCHAR(5) PRIMARY KEY,
    position_name VARCHAR(20) NOT NULL
);

-- Players Table
CREATE TABLE players (
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    position_id VARCHAR(5) NOT NULL,
    team_name VARCHAR(50),
    jersey_number INT CHECK (jersey_number BETWEEN 0 AND 99),
    PRIMARY KEY (last_name, first_name),
    INDEX idx_team (team_name),
    INDEX idx_position (position_id),
    FOREIGN KEY (team_name) REFERENCES teams(team_name),
    FOREIGN KEY (position_id) REFERENCES positions(position_id)
);

-- Season Stats Table
CREATE TABLE season_stats (
    last_name VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    season_year INT NOT NULL CHECK (season_year >= 2024),
    PRIMARY KEY (last_name, first_name, season_year),
    completions INT DEFAULT 0,
    attempts INT DEFAULT 0,
    completion_percentage DECIMAL(4,1) DEFAULT 0.0 CHECK (completion_percentage BETWEEN 0 AND 100),
    passing_yards INT DEFAULT 0,
    passing_touchdowns INT DEFAULT 0,
    interceptions INT DEFAULT 0,
    passer_rating DECIMAL(4,1) DEFAULT 0.0 CHECK (passer_rating BETWEEN 0 AND 158.3),
    rushing_yards INT DEFAULT 0,
    rushing_touchdowns INT DEFAULT 0,
    receptions INT DEFAULT 0,
    receiving_yards INT DEFAULT 0,
    receiving_touchdowns INT DEFAULT 0,
    tackles INT DEFAULT 0,
    sacks DECIMAL(3,1) DEFAULT 0,
    FOREIGN KEY (last_name, first_name) REFERENCES players(last_name, first_name)
);
