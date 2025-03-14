-- Check if the column exists before adding it
SET @column_exists := (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'login'
    AND COLUMN_NAME = 'discord_id'
);

-- Add discord_id column to login table if it doesn't exist
IF @column_exists = 0 THEN
    ALTER TABLE 'login' 
    ADD COLUMN 'discord_id' VARCHAR(20) DEFAULT NULL AFTER 'email';
END IF;

-- Create WoE statistics table
CREATE TABLE IF NOT EXISTS 'woe_data' (
    'id' INT AUTO_INCREMENT PRIMARY KEY,
    'player_name' VARCHAR(24) NOT NULL,
    'damage_amount' BIGINT DEFAULT 0,
    'damage_received' BIGINT DEFAULT 0,
    'heal_amount' BIGINT DEFAULT 0,
    'kill_count' INT DEFAULT 0,
    'death_count' INT DEFAULT 0,
    'skill_count' INT DEFAULT 0,
    'last_update' TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX 'idx_player_name' ('player_name')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create WoE sessions table
CREATE TABLE IF NOT EXISTS 'woe_sessions' (
    'id' INT AUTO_INCREMENT PRIMARY KEY,
    'start_time' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    'end_time' TIMESTAMP NULL,
    'castle_id' INT DEFAULT 0,
    'guild_id' INT DEFAULT 0,
    'guild_name' VARCHAR(24) DEFAULT NULL,
    'status' ENUM('active', 'completed', 'cancelled') DEFAULT 'active'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create WoE participation table
CREATE TABLE IF NOT EXISTS 'woe_participation' (
    'id' INT AUTO_INCREMENT PRIMARY KEY,
    'session_id' INT NOT NULL,
    'player_name' VARCHAR(24) NOT NULL,
    'guild_id' INT DEFAULT 0,
    'guild_name' VARCHAR(24) DEFAULT NULL,
    'join_time' TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    'leave_time' TIMESTAMP NULL,
    FOREIGN KEY ('session_id') REFERENCES 'woe_sessions'('id') ON DELETE CASCADE,
    INDEX 'idx_player_name' ('player_name'),
    INDEX 'idx_session_id' ('session_id')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS 'idx_discord_id' ON 'login'('discord_id');
CREATE INDEX IF NOT EXISTS 'idx_last_update' ON 'woe_data'('last_update');
CREATE INDEX IF NOT EXISTS 'idx_start_time' ON 'woe_sessions'('start_time');
CREATE INDEX IF NOT EXISTS 'idx_status' ON 'woe_sessions'('status');

-- Add comments to tables
ALTER TABLE 'login' 
MODIFY COLUMN 'discord_id' VARCHAR(20) COMMENT 'Discord user ID for bot integration';

-- Create view for WoE statistics
CREATE OR REPLACE VIEW 'vw_woe_stats' AS
SELECT 
    w.player_name,
    c.class,
    w.damage_amount,
    w.damage_received,
    w.heal_amount,
    w.kill_count,
    w.death_count,
    w.skill_count,
    w.last_update
FROM 'woe_data' w
LEFT JOIN 'char' c ON w.player_name = c.name; 