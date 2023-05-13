-- player entity
DROP TABLE IF EXISTS player
;

CREATE TABLE player (
  
player_id INT NOT NULL,
player_first_name VARCHAR(255),
player_last_name VARCHAR(255),
team_id INT Not Null,
age INT,
player_height float,
player_weight float,
college VARCHAR(255),
country VARCHAR(255),
PRIMARY KEY (Player_ID)
);

-- team entity

DROP TABLE IF EXISTS team;

CREATE TABLE team (
  
team_id INT PRIMARY KEY NOT NULL,
team_name VARCHAR(255),
city VARCHAR(255),
state_province VARCHAR(255),  
country VARCHAR(255), 
owner_id INT,  
conference_id INT,
division_id INT,
stadium_id INT,
coach_id INT
);

-- coach entity

DROP TABLE IF EXISTS coach;

CREATE TABLE coach (
coach_id INT PRIMARY KEY not null,
first_name VARCHAR(255),
last_name VARCHAR(255), 
salary FLOAT,
position VARCHAR(255)
);


-- owner entity

DROP TABLE if exists owner;

CREATE TABLE owner (
owner_id INT PRIMARY KEY NOT NULL,
owner_first_name VARCHAR(255),
owner_last_name VARCHAR(255)
);

-- stadium entity

drop table if exists stadium;
CREATE TABLE stadium (
  stadium_id INT PRIMARY KEY NOT NULL,
  stadium_name VARCHAR(255) NOT NULL,
  address VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  zip VARCHAR(255),
);

-- season entity drop table if exists season;

CREATE TABLE season (
season varchar(255) PRIMARY KEY not null,
start_date date,
regular_season_end_date date,
end_date date
);

INSERT INTO season 
(season, start_date, regular_season_end_date, end_date)
VALUES ('2021-22', '2021-10-19', '2022-04-10', '2022-06-16');

-- division entity 
drop table if exists division;
CREATE TABLE division (
  division_id INT PRIMARY KEY not null,
  division_name VARCHAR(255),
  conference_id INT
);

-- conference entity

DROP TABLE IF EXISTS conference;
CREATE TABLE conference (
  conference_id INT PRIMARY KEY not null,
  conference_name VARCHAR(255)
);

-- boxscore entity

drop table if exists boxscore;
CREATE TABLE boxscore (
  game_id INT PRIMARY KEY not null,
  player_id INT,
  team VARCHAR(255),
  game_date DATE,
  matchup VARCHAR(255),
  home_team VARCHAR(255),
  away_team VARCHAR(255),
  home_team_id INT,
  away_team_id INT,
  minutes_played FLOAT,
  field_goals_made INT,
  field_goals_attempted INT,
  three_point_field_goal_made INT,
  three_point_field_goal_attempted INT,
  free_throws_made INT,
  free_throws_attempted INT,
  rebounds INT,
  assists INT,
  steals INT,
  blocks INT,
  turnovers INT,
  personal_fouls INT,
  points_scored INT,
);

-- total player stats entity

drop table if exists  total_player_stats;

CREATE TABLE total_player_stats (
  team_id INTEGER not null,
  player_id INTEGER not null,
season varchar(255) not null,
  team_abb VARCHAR(255),
  games_played INTEGER,
  minutes_played INTEGER,
  field_goals_made INTEGER,
  field_goals_attempted INTEGER,
  three_pointers_made INTEGER,
  three_pointers_attempted INTEGER,
  free_throws_made INTEGER,
  free_throws_attempted INTEGER,
  rebounds_total INTEGER,
  assists_total INTEGER,
  steals_total INTEGER,
  blocks_total INTEGER,
  turnovers_total INTEGER,
  personal_fouls_total INTEGER,
  points_scored_total INTEGER,
  PRIMARY KEY (team_id, player_id, season)
);

-- total team stats entity

drop table if exists total_team_stats;
CREATE TABLE total_team_stats (
  season VARCHAR(255) NOT NULL,
  team_id INTEGER NOT NULL,
  team VARCHAR(255),
  minutes_played_total INTEGER,
  field_goals_made_total INTEGER,
  field_goals_attempted_total INTEGER,
  three_pointers_made_total INTEGER,
  three_pointers_attempted_total INTEGER,
  free_throws_made_total INTEGER,
  free_throws_attempted_total INTEGER,
  rebounds_total INTEGER,
  assists_total INTEGER,
  steals_total INTEGER,
  blocks_total INTEGER,
  turnovers_total INTEGER,
  personal_fouls_total INTEGER,
  points_scored_total INTEGER,
  PRIMARY KEY (season, team_id)
);

-- average team stats entity

DROP TABLE IF EXISTS average_player_stats;

CREATE TABLE average_player_stats (
  team_id INTEGER NOT NULL,
  player_id INTEGER NOT NULL,
  season VARCHAR(255) NOT NULL,
  team_abb VARCHAR(255),
  games_played INTEGER,
  minutes_played_avg DECIMAL(10,2),
  field_goals_made_avg DECIMAL(10,2),
  field_goals_attempted_avg DECIMAL(10,2),
  three_pointers_made_avg DECIMAL(10,2),
  three_pointers_attempted_avg DECIMAL(10,2),
  free_throws_made_avg DECIMAL(10,2),
  free_throws_attempted_avg DECIMAL(10,2),
  rebounds_total_avg DECIMAL(10,2),
  assists_total_avg DECIMAL(10,2),
  steals_total_avg DECIMAL(10,2),
  blocks_total_avg DECIMAL(10,2),
  turnovers_total_avg DECIMAL(10,2),
  personal_fouls_total_avg DECIMAL(10,2),
  points_scored_avg DECIMAL(10,2),
  PRIMARY KEY (team_id, player_id, season)
);

INSERT INTO average_player_stats 
SELECT 
  tps.team_id,
  tps.player_id,
  tps.season,
  tps.team_abb,
  tps.games_played,
  CAST(tps.minutes_played AS DECIMAL(10,2)) / tps.games_played AS minutes_played_avg,
  CAST(tps.field_goals_made AS DECIMAL(10,2)) / tps.games_played AS field_goals_made_avg,
  CAST(tps.field_goals_attempted AS DECIMAL(10,2)) / tps.games_played AS field_goals_attempted_avg,
  CAST(tps.three_pointers_made AS DECIMAL(10,2)) / tps.games_played AS three_pointers_made_avg,
  CAST(tps.three_pointers_attempted AS DECIMAL(10,2)) / tps.games_played AS three_pointers_attempted_avg,
  CAST(tps.free_throws_made AS DECIMAL(10,2)) / tps.games_played AS free_throws_made_avg,
  CAST(tps.free_throws_attempted AS DECIMAL(10,2)) / tps.games_played AS free_throws_attempted_avg,
  CAST(tps.rebounds_total AS DECIMAL(10,2)) / tps.games_played AS rebounds_total_avg,
  CAST(tps.assists_total AS DECIMAL(10,2)) / tps.games_played AS assists_total_avg,
  CAST(tps.steals_total AS DECIMAL(10,2)) / tps.games_played AS steals_total_avg,
  CAST(tps.blocks_total AS DECIMAL(10,2)) / tps.games_played AS blocks_total_avg,
  CAST(tps.turnovers_total AS DECIMAL(10,2)) / tps.games_played AS turnovers_total_avg,
  CAST(tps.personal_fouls_total AS DECIMAL(10,2)) / tps.games_played AS personal_fouls_total_avg,
  CAST(tps.points_scored_total AS DECIMAL(10,2)) / tps.games_played AS points_scored_avg
FROM 
  total_player_stats tps;


-- average team stats entity

drop table if exists average_team_stats;

CREATE TABLE average_team_stats (
  season VARCHAR(255) NOT NULL,
  team_id INTEGER NOT NULL,
  team VARCHAR(255),
  minutes_played_average DECIMAL(10,2),
  field_goals_made_average DECIMAL(10,2),
  field_goals_attempted_average DECIMAL(10,2),
  three_pointers_made_average DECIMAL(10,2),
  three_pointers_attempted_average DECIMAL(10,2),
  free_throws_made_average DECIMAL(10,2),
  free_throws_attempted_average DECIMAL(10,2),
  rebounds_average DECIMAL(10,2),
  assists_average DECIMAL(10,2),
  steals_average DECIMAL(10,2),
  blocks_average DECIMAL(10,2),
  turnovers_average DECIMAL(10,2),
  personal_fouls_average DECIMAL(10,2),
  points_scored_average DECIMAL(10,2),
  PRIMARY KEY (season, team_id)
);

INSERT INTO average_team_stats (season, team_id, team, minutes_played_average, field_goals_made_average, field_goals_attempted_average, three_pointers_made_average, three_pointers_attempted_average, free_throws_made_average, free_throws_attempted_average, rebounds_average, assists_average, steals_average, blocks_average, turnovers_average, personal_fouls_average, points_scored_average)
SELECT 
    season,
    team_id,
    team,
    CAST(minutes_played_total AS DECIMAL(10,2)) / 82 AS minutes_played_average,
    CAST(field_goals_made_total AS DECIMAL(10,2)) / 82 AS field_goals_made_average,
    CAST(field_goals_attempted_total AS DECIMAL(10,2)) / 82 AS field_goals_attempted_average,
    CAST(three_pointers_made_total AS DECIMAL(10,2)) / 82 AS three_pointers_made_average,
    CAST(three_pointers_attempted_total AS DECIMAL(10,2)) / 82 AS three_pointers_attempted_average,
    CAST(free_throws_made_total AS DECIMAL(10,2)) / 82 AS free_throws_made_average,
    CAST(free_throws_attempted_total AS DECIMAL(10,2)) / 82 AS free_throws_attempted_average,
    CAST(rebounds_total AS DECIMAL(10,2)) / 82 AS rebounds_average,
    CAST(assists_total AS DECIMAL(10,2)) / 82 AS assists_average,
    CAST(steals_total AS DECIMAL(10,2)) / 82 AS steals_average,
    CAST(blocks_total AS DECIMAL(10,2)) / 82 AS blocks_average,
    CAST(turnovers_total AS DECIMAL(10,2)) / 82 AS turnovers_average,
    CAST(personal_fouls_total AS DECIMAL(10,2)) / 82 AS personal_fouls_average,
    CAST(points_scored_total AS DECIMAL(10,2)) / 82 AS points_scored_average
FROM total_team_stats;

-- constraints. Each team must have an owner, stadium, coach, division, and conference

ALTER TABLE team
ADD CONSTRAINT team_owner_fk
FOREIGN KEY (owner_id)
REFERENCES owner(owner_id);

ALTER TABLE team
ADD CONSTRAINT team_conference_fk
FOREIGN KEY (conference_id)
REFERENCES conference(conference_id);

ALTER TABLE team
ADD CONSTRAINT team_division_fk
FOREIGN KEY (division_id)
REFERENCES division(division_id);

ALTER TABLE team
ADD CONSTRAINT team_coach_fk
FOREIGN KEY (coach_id)
REFERENCES coach(coach_id);

ALTER TABLE team
ADD CONSTRAINT team_stadium_fk
FOREIGN KEY (stadium_id)
REFERENCES stadium(stadium_id);

