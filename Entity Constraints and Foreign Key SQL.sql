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


--games entity

DROP TABLE IF EXISTS games;

CREATE TABLE games (
    game_id INTEGER PRIMARY KEY NOT NULL,
    season VARCHAR(255) NOT NULL,
    game_date DATE,
    matchup VARCHAR(100),
    away_team_id INTEGER,
    home_team_id INTEGER,
    home_score INTEGER,
    away_score INTEGER,
    winning_team INTEGER
);

--player stats entity

drop table if exists player_stats;

CREATE TABLE player_stats (
    game_id INTEGER NOT NULL,
    player_id INTEGER NOT NULL,
    team_id INTEGER,
    minutes_played INTEGER,
    field_goals_made INTEGER,
    field_goals_attempted INTEGER,
    three_pointers_made INTEGER,
    three_pointers_attempted INTEGER,
    free_throws_made INTEGER,
    free_throws_attempted INTEGER,
    rebounds INTEGER,
    assists INTEGER,
    steals INTEGER,
    blocks INTEGER,
    turnovers INTEGER,
    personal_fouls INTEGER,
    points_scored INTEGER,
    PRIMARY KEY (Game_ID, player_id)
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

-- Add foreign key to player table
ALTER TABLE player
ADD FOREIGN KEY (team_id) REFERENCES team(team_id);

-- Add foreign key to team table
ALTER TABLE team
ADD FOREIGN KEY (owner_id) REFERENCES owner(owner_id),
    FOREIGN KEY (conference_id) REFERENCES conference(conference_id),
    FOREIGN KEY (division_id) REFERENCES division(division_id),
    FOREIGN KEY (stadium_id) REFERENCES stadium(stadium_id),
    FOREIGN KEY (coach_id) REFERENCES coach(coach_id);


-- Add foreign key to total_player_stats table
ALTER TABLE total_player_stats
ADD FOREIGN KEY (team_id) REFERENCES team(team_id),
FOREIGN KEY (player_id) REFERENCES player(player_id);

-- Add foreign key to total_team_stats table
ALTER TABLE total_team_stats
ADD FOREIGN KEY (team_id) REFERENCES team(team_id);




ALTER TABLE division
ADD CONSTRAINT fk_division_conference_id
FOREIGN KEY (conference_id)
REFERENCES conference (conference_id)
ON DELETE CASCADE;
