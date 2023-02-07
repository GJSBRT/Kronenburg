INSERT INTO `licenses` (`type`, `label`) VALUES
	('islandlicense', 'Island License')
;

CREATE TABLE `cayoperico_categories` (
	`name` varchar(60) NOT NULL,
	`label` varchar(60) NOT NULL,

	PRIMARY KEY (`name`)
);

INSERT INTO `cayoperico_categories` (name, label) VALUES
	('islandvehicles','Eiland Voertuigen')
;

CREATE TABLE `cayoperico_vehicles` (
	`name` varchar(60) NOT NULL,
	`model` varchar(60) NOT NULL,
	`price` int(11) NOT NULL,
	`category` varchar(60) DEFAULT NULL,

	PRIMARY KEY (`model`)
);

INSERT INTO `cayoperico_vehicles` (name, model, price, category) VALUES
	('Offroad ATV','verus',25000,'islandvehicles'),
	('Yosemite','yosemite3',20000,'islandvehicles'),
	('Offroad 4x4','seminole2',25000,'islandvehicles'),
	('Flathead Ratbike','ratbike',30000,'islandvehicles'),
	('Offroad Motor','manchez',45000,'islandvehicles'),
	('Offroad Pitbike','manchez2',10000,'islandvehicles'),
	('Pickup Truck','rebel2',10000,'islandvehicles'),
	('Kamacho','kamacho',40000,'islandvehicles')
;
