-- Same-Sex Marriage System
-- Author: RO-Journey Team
-- Version: 1.0

-- Modify the marriage table to remove gender restrictions
ALTER TABLE `marriage` MODIFY COLUMN `partner_id1` INT(11) NOT NULL;
ALTER TABLE `marriage` MODIFY COLUMN `partner_id2` INT(11) NOT NULL;

-- Add indexes for better performance
ALTER TABLE `marriage` ADD INDEX `idx_partner1` (`partner_id1`);
ALTER TABLE `marriage` ADD INDEX `idx_partner2` (`partner_id2`);

-- Update marriage view if it exists
DROP VIEW IF EXISTS `marriage_view`;
CREATE VIEW `marriage_view` AS
SELECT 
    m.*,
    c1.name as partner1_name,
    c2.name as partner2_name,
    c1.class as partner1_class,
    c2.class as partner2_class
FROM 
    `marriage` m
    LEFT JOIN `char` c1 ON m.partner_id1 = c1.char_id
    LEFT JOIN `char` c2 ON m.partner_id2 = c2.char_id;

-- Add marriage status to character table if not exists
ALTER TABLE `char` ADD COLUMN IF NOT EXISTS `marriage_id` INT(11) DEFAULT NULL;
ALTER TABLE `char` ADD INDEX `idx_marriage` (`marriage_id`);

-- Add marriage benefits table
CREATE TABLE IF NOT EXISTS `marriage_benefits` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `marriage_id` INT(11) NOT NULL,
    `benefit_type` VARCHAR(50) NOT NULL,
    `value` INT(11) NOT NULL,
    `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_marriage_benefits` (`marriage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add default benefits
INSERT INTO `marriage_benefits` (`marriage_id`, `benefit_type`, `value`) 
SELECT id, 'exp_bonus', 10 FROM `marriage` ON DUPLICATE KEY UPDATE value = 10;

INSERT INTO `marriage_benefits` (`marriage_id`, `benefit_type`, `value`) 
SELECT id, 'hp_bonus', 5 FROM `marriage` ON DUPLICATE KEY UPDATE value = 5;

INSERT INTO `marriage_benefits` (`marriage_id`, `benefit_type`, `value`) 
SELECT id, 'sp_bonus', 5 FROM `marriage` ON DUPLICATE KEY UPDATE value = 5; 