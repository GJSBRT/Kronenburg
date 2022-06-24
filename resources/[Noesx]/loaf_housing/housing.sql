CREATE TABLE IF NOT EXISTS `loaf_housing` (
    `identifier` VARCHAR(255),
    `housedata` LONGTEXT,
    PRIMARY KEY (`identifier`)
);

CREATE TABLE IF NOT EXISTS `loaf_bought_houses` (
    `houseid` INT(9),
    `owner` VARCHAR(255),
    PRIMARY KEY (`houseid`)
);

ALTER TABLE `users` ADD COLUMN `loaf_furniture` LONGTEXT;

CREATE TABLE IF NOT EXISTS `loaf_last_login` (
    `identifier` VARCHAR(255),
    `login_time` INT(255),
    PRIMARY KEY (`identifier`)
);

INSERT INTO `items` (name, label, weight) VALUES
	("lockpick", "Lockpick", 5)
;

INSERT INTO `datastore` (name, label, shared) VALUES
  ("property", "Property", 0)
;