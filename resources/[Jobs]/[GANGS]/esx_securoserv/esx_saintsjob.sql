USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_cali', 'cali', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_cali', 'cali', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_cali', 'cali', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('cali','Cali Kartell')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('cali',0,'recruit','Wannabe',1500,'{}','{}'),
	('cali',1,'officer','Member',1500,'{}','{}'),
	('cali',2,'sergeant','Truster',1500,'{}','{}'),
	('cali',3,'lieutenant','Executer',1500,'{}','{}'),
	('cali',4,'boss','OG',1500,'{}','{}')
;

