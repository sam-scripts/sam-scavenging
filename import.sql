CREATE TABLE IF NOT EXISTS `scavenging_rep` (
    `citizen_id` varchar(255) NOT NULL, 
    `rep` int NOT NULL DEFAULT 0,
    PRIMARY KEY (`citizen_id`)
);