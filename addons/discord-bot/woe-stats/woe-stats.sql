CREATE TABLE `woe_stats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `account_id` int(11) NOT NULL,
  `char_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `damage_received` int(11) NOT NULL,
  `damage_healed` int(11) NOT NULL,
  `skills_used` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
