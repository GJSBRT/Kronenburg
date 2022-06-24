CREATE TABLE IF NOT EXISTS `doors` (
  `index` int(11) NOT NULL AUTO_INCREMENT,
  `door` longtext NOT NULL,
  KEY `index` (`index`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4;

INSERT INTO `items` (`name`, `label`) VALUES
  ('keys_master_key','Master Key'),
  ('keys_master_key_single_use','Master Key (Single Use)'),
  ('keys_missionrow_pd_front','Mission Row PD Key (Front)'),

  ('lockpickv2','Lockpick (V2)'),
  ('thermite','Thermite'),
  ('hacking_laptop','Hacking Laptop');

