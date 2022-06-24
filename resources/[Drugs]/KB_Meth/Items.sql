/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for essentialmode
CREATE DATABASE IF NOT EXISTS `essentialmode` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `essentialmode`;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
	('acetone', 'Acetone', 1, 0, 1),
	('methlab', 'Draagbare MethLab', 1, 0, 1),
	('meth', 'Meth', 1, 0, 1),
	('lithium', 'Batterijen', 1, 0, 1);
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;