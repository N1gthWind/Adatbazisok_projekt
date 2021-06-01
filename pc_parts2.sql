-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Máj 23. 11:49
-- Kiszolgáló verziója: 10.4.14-MariaDB
-- PHP verzió: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `computers`
--

DELIMITER $$
--
-- Eljárások
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCPU` ()  BEGIN
	SELECT COUNT(cpu_id) FROM cpu;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllGPU` ()  NO SQL
BEGIN

SELECT COUNT(videocard_id) FROM videocard;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetHighConsumptionCPUs` (IN `entered_value` INT(255))  BEGIN
	SELECT * 
 	FROM cpu
	WHERE tdp >= entered_value;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getSummary` (IN `tablename` VARCHAR(40))  BEGIN
DECLARE sum_variable DOUBLE;

START TRANSACTION;

IF tablename = 'cpu' THEN
 INSERT INTO summary(current_summary) SELECT SUM(price) from cpu;
END IF;
IF tablename = 'videocard' THEN
 INSERT INTO summary(current_summary) SELECT SUM(price) from videocard;
END IF;
IF tablename = 'ram' THEN
 INSERT INTO summary(current_summary) SELECT SUM(price) from ram;
END IF;
IF tablename = 'power_supply' THEN
 INSERT INTO summary(current_summary) SELECT SUM(price) from power_supply;
END IF;
COMMIT;
END$$

--
-- Függvények
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Calculate_Quantity_Between_Range` (`starting_value` DOUBLE, `ending_value` DOUBLE) RETURNS INT(11) BEGIN
   DECLARE result INT;

   SELECT COUNT(cpu_id) FROM cpu WHERE price >= starting_value AND price <= ending_value into @a;

   SET result = @a;

   RETURN result;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `counter` (`brands` VARCHAR(100)) RETURNS VARCHAR(11) CHARSET utf8 COLLATE utf8_hungarian_ci BEGIN
	DECLARE result INT(10);
    DECLARE smth VARCHAR(100);
    SET smth = brands;
    SELECT COUNT(gpu) FROM videocard WHERE brand = 'ASUS' INTO @b;
    SET result = @b;
    RETURN result;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `cpu`
--

CREATE TABLE `cpu` (
  `cpu_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(5) DEFAULT NULL,
  `gen` varchar(15) DEFAULT NULL,
  `socket` varchar(12) DEFAULT NULL,
  `core` int(11) DEFAULT NULL,
  `thread` int(11) DEFAULT NULL,
  `speed` decimal(2,1) DEFAULT NULL,
  `lthree` double DEFAULT NULL,
  `tdp` int(11) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `series` varchar(12) DEFAULT NULL,
  `turbo` decimal(2,1) DEFAULT NULL,
  `ltwo` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `cpu`
--

INSERT INTO `cpu` (`cpu_id`, `name`, `brand`, `gen`, `socket`, `core`, `thread`, `speed`, `lthree`, `tdp`, `price`, `series`, `turbo`, `ltwo`) VALUES
(1, '1200', 'AMD', 'SummitRidge', 'AM4', 4, 4, '3.1', 8, 65, '109.99', 'Ryzen 3', '3.4', 2),
(2, '1300X', 'AMD', 'SummitRidge', 'AM4', 4, 4, '3.5', 8, 65, '129.99', 'Ryzen 3', '3.7', 2),
(3, '1400', 'AMD', 'SummitRidge', 'AM4', 4, 8, '3.2', 8, 65, '164.99', 'Ryzen 5', '3.4', 2),
(4, '1500X', 'AMD', 'SummitRidge', 'AM4', 4, 8, '3.5', 16, 65, '189.99', 'Ryzen 5', '3.7', 2),
(5, '1600', 'AMD', 'SummitRidge', 'AM4', 6, 12, '3.2', 16, 65, '214.99', 'Ryzen 5', '3.6', 3),
(6, '1600X', 'AMD', 'SummitRidge', 'AM4', 6, 12, '3.6', 16, 95, '229.99', 'Ryzen 5', '4.0', 3),
(7, '1700', 'AMD', 'SummitRidge', 'AM4', 8, 16, '3.0', 16, 65, '299.99', 'Ryzen 7', '3.7', 4),
(8, '1700X', 'AMD', 'SummitRidge', 'AM4', 8, 16, '3.4', 16, 95, '329.99', 'Ryzen 7', '3.8', 4),
(9, '1800X', 'AMD', 'SummitRidge', 'AM4', 8, 16, '4.0', 16, 95, '459.99', 'Ryzen 7', '4.0', 4),
(10, '1920X', 'AMD', 'SummitRidge', 'AM4', 12, 24, '3.5', 32, 180, '799.99', 'ThreadRipper', '4.0', 6),
(11, '1950X', 'AMD', 'SummitRidge', 'AM4', 16, 32, '3.4', 32, 180, '999.99', 'ThreadRipper', '4.0', 8),
(12, '6100', 'Intel', 'SkyLake', 'LGA 1151', 2, 4, '3.7', 3, 51, '119.99', 'i3', NULL, 0.5),
(13, '6300', 'Intel', 'SkyLake', 'LGA 1151', 2, 4, '3.8', 4, 65, '134.99', 'i3', NULL, 0.5),
(14, '6320', 'Intel', 'SkyLake', 'LGA 1151', 2, 4, '3.9', 4, 65, '154.99', 'i3', NULL, 0.5),
(15, '6400', 'Intel', 'SkyLake', 'LGA 1151', 4, 4, '2.7', 6, 65, '184.99', 'i5', '3.3', 1),
(16, '6500', 'Intel', 'SkyLake', 'LGA 1151', 4, 4, '3.2', 6, 65, '204.99', 'i5', '3.6', 1),
(17, '6600', 'Intel', 'SkyLake', 'LGA 1151', 4, 4, '3.3', 6, 65, '219.99', 'i5', '3.9', 1),
(18, '6600K', 'Intel', 'SkyLake', 'LGA 1151', 4, 4, '3.5', 6, 91, '234.99', 'i5', '3.9', 1),
(19, '6700', 'Intel', 'SkyLake', 'LGA 1151', 4, 8, '3.4', 8, 65, '304.99', 'i7', '4.0', 1),
(20, '6700K', 'Intel', 'SkyLake', 'LGA 1151', 4, 8, '4.0', 8, 91, '329.99', 'i7', '4.2', 1),
(21, '6800K', 'Intel', 'Broadwell-E', 'LGA 2011-v3', 6, 12, '3.4', 15, 140, '349.99', 'i7', '3.6', 1.5),
(22, '6850K', 'Intel', 'Broadwell-E', 'LGA 2011-v3', 6, 12, '3.6', 15, 140, '389.99', 'i7', '3.8', 1.5),
(23, '6900K', 'Intel', 'Broadwell-E', 'LGA 2011-v3', 8, 16, '3.2', 20, 140, '1049.99', 'i7', '3.7', 2),
(24, '6950X', 'Intel', 'Broadwell-E', 'LGA 2011-v3', 10, 20, '3.0', 25, 140, '1730.37', 'i7', '3.5', 2.56),
(25, '7100', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '3.9', 3, 51, '129.99', 'i3', NULL, 0.5),
(26, '7300', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '4.0', 4, 51, '149.99', 'i3', NULL, 0.5),
(27, '7320', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '4.1', 4, 51, '159.99', 'i3', NULL, 0.5),
(28, '7350K', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '4.2', 4, 60, '169.99', 'i3', NULL, 0.5),
(29, '7400', 'Intel', 'KabyLake', 'LGA 1151', 4, 4, '3.0', 6, 65, '189.99', 'i5', '3.5', 1),
(30, '7500', 'Intel', 'KabyLake', 'LGA 1151', 4, 4, '3.4', 6, 65, '209.99', 'i5', '3.8', 1),
(31, '7600', 'Intel', 'KabyLake', 'LGA 1151', 4, 4, '3.5', 6, 65, '229.99', 'i5', '4.1', 1),
(32, '7600K', 'Intel', 'KabyLake', 'LGA 1151', 4, 4, '3.8', 6, 91, '239.99', 'i5', '4.2', 1),
(33, '7640X', 'Intel', 'KabyLakeX', 'LGA 2066', 4, 4, '4.0', 6, 112, '249.99', 'i5', '4.2', 4),
(34, '7700', 'Intel', 'KabyLake', 'LGA 1151', 4, 8, '3.6', 8, 65, '309.99', 'i7', '4.2', 1),
(35, '7700K', 'Intel', 'KabyLake', 'LGA 1151', 4, 8, '4.2', 8, 91, '339.99', 'i7', '4.5', 1),
(36, '7740X', 'Intel', 'KabyLakeX', 'LGA 2066', 4, 8, '4.3', 8, 112, '349.99', 'i7', '4.5', 4),
(37, '7800X', 'Intel', 'SkyLakeX', 'LGA 2066', 6, 12, '3.5', 8.25, 140, '529.99', 'i7', '4.0', 6),
(38, '7820X', 'Intel', 'SkyLakeX', 'LGA 2066', 8, 16, '3.6', 11, 140, '599.99', 'i7', '4.3', 8),
(39, '7900X', 'Intel', 'SkyLakeX', 'LGA 2066', 10, 20, '3.3', 13.75, 140, '1059.99', 'i9', '4.3', 10),
(40, 'G3900', 'Intel', 'SkyLake', 'LGA 1151', 2, 2, '2.8', 2, 65, '34.99', 'Celeron', NULL, 0.5),
(41, 'G3920', 'Intel', 'SkyLake', 'LGA 1151', 2, 2, '2.9', 2, 65, '44.99', 'Celeron', NULL, 0.5),
(42, 'G3930', 'Intel', 'KabyLake', 'LGA 1151', 2, 2, '2.9', 2, 51, '39.99', 'Celeron', NULL, 0.5),
(43, 'G3950', 'Intel', 'KabyLake', 'LGA 1151', 2, 2, '3.0', 2, 51, '49.99', 'Celeron', NULL, 0.5),
(44, 'G4400', 'Intel', 'SkyLake', 'LGA 1151', 2, 2, '3.3', 3, 54, '54.99', 'Pentium', NULL, 0.5),
(45, 'G4500', 'Intel', 'SkyLake', 'LGA 1151', 2, 2, '3.5', 3, 65, '64.99', 'Pentium', NULL, 0.5),
(46, 'G4520', 'Intel', 'SkyLake', 'LGA 1151', 2, 2, '3.6', 3, 65, '74.99', 'Pentium', NULL, 0.5),
(47, 'G4560', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '3.5', 3, 54, '59.99', 'Pentium', NULL, 0.5),
(48, 'G4600', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '3.6', 3, 51, '69.99', 'Pentium', NULL, 0.5),
(49, 'G4620', 'Intel', 'KabyLake', 'LGA 1151', 2, 4, '3.7', 3, 51, '79.99', 'Pentium', NULL, 0.5),
(51, '10710', 'Intel', '10th', 'LGA 1151', 6, 12, '3.6', 16, 65, '299.99', 'i10', '4.2', 2),
(52, '2700X', 'AMD', 'Pinnacle Ridge', 'AM4', 8, 16, '3.7', 16, 105, '229.99', 'Ryzen 7', '4.3', 4),
(53, '3700X', 'AMD', 'Matisse', 'AM4', 8, 16, '3.6', 32, 65, '329.99', 'Ryzen 7', '4.4', 4);

--
-- Eseményindítók `cpu`
--
DELIMITER $$
CREATE TRIGGER `after_cpu_delete` AFTER DELETE ON `cpu` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('cpu','deleted',OLD.cpu_id); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_cpu_insert` AFTER INSERT ON `cpu` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('cpu','inserted',NEW.cpu_id); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_cpu_update` AFTER UPDATE ON `cpu` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('cpu','updated',NEW.cpu_id); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `gpumem`
--

CREATE TABLE `gpumem` (
  `gpumem_id` int(11) NOT NULL,
  `gpu` varchar(30) NOT NULL,
  `memory` int(11) DEFAULT NULL,
  `memoryType` varchar(10) DEFAULT NULL,
  `memoryInterface` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `gpumem`
--

INSERT INTO `gpumem` (`gpumem_id`, `gpu`, `memory`, `memoryType`, `memoryInterface`) VALUES
(1, 'GeForce GTX 1050', 2, 'GDDR5', 128),
(2, 'GeForce GTX 1060', 3, 'GDDR5X', 192),
(3, 'GeForce GTX 1080', 8, 'GDDR5X', 256),
(4, 'GeForce GTX 1080 Ti', 11, 'GDDR5X', 352),
(5, 'Radeon Vega Frontier Edition', 16, 'HBM2', 2048),
(6, 'GeForce RTX 3060', 12, 'GDDR5X', 192),
(9, 'GeForce GTX 980', 4, 'GDDR5', 256);

--
-- Eseményindítók `gpumem`
--
DELIMITER $$
CREATE TRIGGER `after_gpumem_delete` AFTER DELETE ON `gpumem` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('gpumem','deleted',OLD.gpumem_id); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_gpumem_insert` AFTER INSERT ON `gpumem` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('gpumem','inserted',NEW.gpumem_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_gpumem_update` AFTER UPDATE ON `gpumem` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('gpumem','updated',NEW.gpumem_id); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `gskill_rams_speed_above_average`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `gskill_rams_speed_above_average` (
`ram_id` int(11)
,`name` varchar(30)
,`brand` varchar(30)
,`capacity` int(11)
,`speed` int(11)
,`timing` varchar(15)
,`cas` int(11)
,`price` decimal(6,2)
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `part_type` enum('cpu','gpumem','makers','motherbards','power_supply','ram','ramspeed','sockettype','videocard') CHARACTER SET utf8 NOT NULL,
  `current_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `operation` enum('inserted','deleted','updated') CHARACTER SET utf8mb4 NOT NULL,
  `part_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- A tábla adatainak kiíratása `logs`
--

INSERT INTO `logs` (`log_id`, `part_type`, `current_time`, `operation`, `part_id`) VALUES
(3, 'gpumem', '2021-05-21 13:10:25', 'inserted', 8),
(4, 'gpumem', '2021-05-21 13:49:50', 'deleted', 8),
(5, 'cpu', '2021-05-21 18:05:20', 'inserted', 50),
(6, 'cpu', '2021-05-21 18:07:20', 'inserted', 51),
(7, 'cpu', '2021-05-21 18:07:54', 'deleted', 50),
(8, 'cpu', '2021-05-21 19:24:58', 'inserted', 52),
(9, 'cpu', '2021-05-21 19:24:58', 'inserted', 53),
(10, 'videocard', '2021-05-23 09:46:22', 'inserted', 27),
(11, 'videocard', '2021-05-23 09:47:26', 'updated', 27),
(12, 'gpumem', '2021-05-23 09:48:33', 'inserted', 9),
(13, 'videocard', '2021-05-23 09:48:35', 'updated', 27);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `manufacturers`
--

CREATE TABLE `manufacturers` (
  `brand` varchar(30) NOT NULL,
  `type` varchar(15) NOT NULL,
  `directLink` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `manufacturers`
--

INSERT INTO `manufacturers` (`brand`, `type`, `directLink`) VALUES
('AMD', 'cpu', 'http://www.amd.com/en/home'),
('AMD', 'gpu', 'http://www.amd.com/en/home'),
('ASROCK', 'motherboard', 'http://www.asrock.com/index.asp'),
('ASUS', 'gpu', 'https://www.asus.com/us/'),
('BIOSTAR', 'motherboard', 'http://www.biostar-usa.com/app/en-us/'),
('CORSAIR', 'ram', 'http://www.corsair.com/en-us'),
('ENERMAX', 'poewer supply', 'www.enermaxusa.com/'),
('EVGA', 'gpu', 'https://www.evga.com/'),
('G.SKILL', 'ram', 'https://www.gskill.com/en/'),
('GIGABYTE', 'gpu', 'http://www.gigabyte.us/'),
('Intel', 'cpu', 'https://www.intel.com/content/www/us/en/homepage.html'),
('MSI', 'gpu', 'https://us.msi.com/'),
('PNY', 'gpu', 'https://www.pny.com/'),
('ROSEWILL', 'power supply', 'www.rosewill.com/'),
('SILVERSTONE', 'power supply', 'www.silverstonetek.com/'),
('TEAM', 'ram', 'www.teamgroupinc.com/en/index.php'),
('ZOTAC', 'gpu', 'https://www.zotac.com/');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `motherboards`
--

CREATE TABLE `motherboards` (
  `motherboard_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `socket` varchar(12) DEFAULT NULL,
  `chipset` varchar(15) DEFAULT NULL,
  `memoryCap` int(11) DEFAULT NULL,
  `memoryStandard` varchar(10) DEFAULT NULL,
  `usbPorts` int(11) DEFAULT NULL,
  `PCI` int(11) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL,
  `type` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `motherboards`
--

INSERT INTO `motherboards` (`motherboard_id`, `name`, `brand`, `socket`, `chipset`, `memoryCap`, `memoryStandard`, `usbPorts`, `PCI`, `price`, `type`) VALUES
(1, 'am4A', 'ASUS', 'AM4', 'B350', 64, 'DDR4', 8, 1, '89.99', 'AMD'),
(2, 'am4AR', 'ASROCK', 'AM4', 'B350', 64, 'DDR4', 7, 1, '74.99', 'AMD'),
(3, 'am4B', 'BIOSTAR', 'AM4', 'X370', 32, 'DDR4', 7, 1, '109.99', 'AMD'),
(4, 'am4G', 'GIGABYTE', 'AM4', 'B350', 64, 'DDR4', 7, 1, '109.99', 'AMD'),
(5, 'am4M', 'MSI', 'AM4', 'B350', 64, 'DDR4', 6, 1, '101.99', 'AMD'),
(6, 'lga1151A', 'ASUS', 'LGA 1151', 'Z270', 64, 'DDR4', 8, 3, '629.99', 'Intel'),
(7, 'lga1151AS', 'ASROCK', 'LGA 1151', 'Z170', 64, 'DDR4', 12, 3, '169.99', 'Intel'),
(8, 'lga1151B', 'BIOSTAR', 'LGA 1151', 'Z270', 64, 'DDR4', 9, 3, '154.99', 'Intel'),
(9, 'lga1151G', 'GIGABYTE', 'LGA 1151', 'Z270', 64, 'DDR4', 9, 2, '499.99', 'Intel'),
(10, 'lga1151M', 'MSI', 'LGA 1151', 'Z170', 64, 'DDR4', 7, 3, '546.99', 'Intel'),
(11, 'lga2011-v3A', 'ASUS', 'LGA 2011-v3', 'X99', 128, 'DDR4', 12, 7, '239.99', 'Intel'),
(12, 'lga2011-v3AS', 'ASROCK', 'LGA 2011-v3', 'X99', 128, 'DDR4', 13, 5, '329.99', 'Intel'),
(13, 'lga2011-v3E', 'EVGA', 'LGA 2011-v3', 'X99', 128, 'DDR4', 14, 5, '219.99', 'Intel'),
(14, 'lga2011-v3G', 'GIGABYTE', 'LGA 2011-v3', 'X99', 128, 'DDR4', 10, 4, '219.99', 'Intel'),
(15, 'lga2011-v3M', 'MSI', 'LGA 2011-v3', 'X99', 128, 'DDR4', 15, 4, '329.99', 'Intel'),
(16, 'lga2066A', 'ASUS', 'LGA 2066', 'X299', 128, 'DDR4', 13, 9, '339.99', 'Intel'),
(17, 'lga2066AS', 'ASROCK', 'LGA 2066', 'X299', 128, 'DDR4', 11, 4, '389.99', 'Intel'),
(18, 'lga2066G', 'GIGABYTE', 'LGA 2066', 'X299', 128, 'DDR4', 12, 5, '249.99', 'Intel'),
(19, 'lga2066M', 'MSI', 'LGA 2066', 'X299', 128, 'DDR4', 13, 4, '399.99', 'Intel');

--
-- Eseményindítók `motherboards`
--
DELIMITER $$
CREATE TRIGGER `after_motherboard_delete` AFTER DELETE ON `motherboards` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('motherboards','deleted',OLD.motherboard_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_motherboard_insert` AFTER INSERT ON `motherboards` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('motherboards','inserted',NEW.motherboard_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_motherboard_update` AFTER UPDATE ON `motherboards` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('motherboards','updated',NEW.motherboard_id); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `power_supply`
--

CREATE TABLE `power_supply` (
  `power_supply_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `maxPower` int(11) DEFAULT NULL,
  `fans` int(11) DEFAULT NULL,
  `energyEfficiency` varchar(20) DEFAULT NULL,
  `weight` double(4,2) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `power_supply`
--

INSERT INTO `power_supply` (`power_supply_id`, `name`, `brand`, `maxPower`, `fans`, `energyEfficiency`, `weight`, `price`) VALUES
(1, '1000C', 'CORSAIR', 1000, 1, '80 plus gold', 4.41, '178.99'),
(2, '1000E', 'EVGA', 1000, 1, '80 plus gold', 7.00, '209.99'),
(3, '1000EN', 'ENERMAX', 1000, 1, '80 plus platinum', 6.21, '194.92'),
(4, '1000R', 'ROSEWILL', 1000, 1, '80 plus bronze', 6.23, '139.99'),
(5, '1000S', 'SILVERSTONE', 1000, 1, '80 plus silver', 6.60, '179.89'),
(6, '1200C', 'CORSAIR', 1200, 1, '80 plus platinum', 8.40, '259.99'),
(7, '1200E', 'EVGA', 1200, 1, '80 plus platinum', 8.00, '308.00'),
(8, '1200R', 'ROSEWILL', 1200, 1, '80 plus gold', 8.81, '219.99'),
(9, '1200S', 'SILVERSTONE', 1200, 1, '80 plus platinum', 7.28, '239.99'),
(10, '1500C', 'CORSAIR', 1500, 1, '80 plus titanium', 12.65, '449.99'),
(11, '1500EN', 'ENERMAX', 1500, 1, '80 plus gold', 7.09, '550.00'),
(12, '1500R', 'ROSEWILL', 1500, 1, '80 plus titanium', 7.70, '359.99'),
(13, '1500S', 'SILVERSTONE', 1500, 1, '80 plus gold', 7.05, '337.34'),
(14, '1600E', 'EVGA', 1600, 1, '80 plus platinum', 8.00, '449.99'),
(15, '1600R', 'ROSEWILL', 1600, 1, '80 plus gold', 7.70, '549.99'),
(16, '500C', 'CORSAIR', 500, 1, '80 plus white', 4.06, '39.99'),
(17, '500E', 'EVGA', 500, 1, '80 plus bronze', 4.00, '49.99'),
(18, '500EN', 'ENERMAX', 500, 2, '80 plus platinum', 6.97, '125.25'),
(19, '500G', 'GIGABYTE', 500, 1, '80 plus bronze', 4.55, '69.99'),
(20, '500R', 'ROSEWILL', 500, 1, '80 plus bronze', 5.11, '54.99'),
(21, '500S', 'SILVERSTONE', 500, 1, '80 plus gold', 6.53, '89.99'),
(22, '600C', 'CORSAIR', 600, 1, '80 plus bronze', 4.55, '69.99'),
(23, '600E', 'EVGA', 600, 1, '80 plus bronze', 4.00, '54.99'),
(24, '600EN', 'ENERMAX', 600, 1, '80 plus platinum', 3.58, '144.45'),
(25, '600R', 'ROSEWILL', 600, 1, '80 plus bronze', 4.00, '54.99'),
(26, '600S', 'SILVERSTONE', 600, 1, '80 plus gold', 3.20, '117.31'),
(27, '850C', 'CORSAIR', 850, 1, '80 plus gold', 4.38, '115.99'),
(28, '850E', 'EVGA', 850, 1, '80 plus gold', 6.00, '159.99'),
(29, '850EN', 'ENERMAX', 850, 1, '80 plus platinum', 7.85, '145.20'),
(30, '850R', 'ROSEWILL', 850, 1, '80 plus bronze', 3.80, '65.99'),
(31, '850S', 'SILVERSTONE', 850, 1, '80 plus gold', 5.51, '159.99');

--
-- Eseményindítók `power_supply`
--
DELIMITER $$
CREATE TRIGGER `after_power_supply_delete` AFTER DELETE ON `power_supply` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('power_supply','deleted',OLD.power_supply_id); 
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_power_supply_insert` AFTER INSERT ON `power_supply` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('power_supply','inserted',NEW.power_supply_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_power_supply_update` AFTER UPDATE ON `power_supply` FOR EACH ROW BEGIN    
    	INSERT INTO logs(part_type,operation,part_id) VALUES('power_supply','updated',NEW.power_supply_id); 
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ram`
--

CREATE TABLE `ram` (
  `ram_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `speed` int(11) DEFAULT NULL,
  `timing` varchar(15) DEFAULT NULL,
  `cas` int(11) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `ram`
--

INSERT INTO `ram` (`ram_id`, `name`, `brand`, `capacity`, `speed`, `timing`, `cas`, `price`) VALUES
(1, '2133areG.S', 'G.SKILL', 8, 2133, '11-11-11', 11, '63.99'),
(2, '2133ripG.S', 'G.SKILL', 8, 2133, '10-12-12-31', 10, '64.99'),
(3, '2133sniG.S', 'G.SKILL', 8, 2133, '10-12-12-31', 10, '65.99'),
(4, '2133triG.S', 'G.SKILL', 16, 2133, '9-11-11-31', 9, '122.99'),
(5, '2133venCOR', 'CORSAIR', 8, 2133, '11-12-12-27', 11, '69.99'),
(6, '2400areG.S', 'G.SKILL', 8, 2400, '11-13-13-31', 11, '64.99'),
(7, '2400darTEA', 'TEAM', 16, 2400, '11-13-13-35', 11, '104.99'),
(8, '2400domCOR', 'CORSAIR', 8, 2400, '11-13-13-31', 11, '89.99'),
(9, '2400ripG.S', 'G.SKILL', 8, 2400, '11-13-13-31', 11, '64.99'),
(10, '2400sniG.S', 'G.SKILL', 8, 2400, '11-13-13-31', 11, '65.99'),
(11, '2400triG.S', 'G.SKILL', 8, 2400, '10-12-12-31', 10, '85.99'),
(12, '2400venCOR', 'CORSAIR', 8, 2400, '11-13-13-31', 11, '69.99'),
(13, '3866domCOR', 'CORSAIR', 32, 3866, '18-22-22-40', 18, '499.99'),
(14, '3866ripG.S', 'G.SKILL', 8, 3866, '18-22-22-42', 18, '109.99'),
(15, '3866t-fTEA', 'TEAM', 16, 3866, '18-20-20-44', 19, '207.99'),
(16, '3866triG.S', 'G.SKILL', 32, 3866, '18-19-19-39', 18, '483.99'),
(17, '3866venCOR', 'CORSAIR', 32, 3866, '18-22-22-40', 18, '386.99'),
(18, '4000domCOR', 'CORSAIR', 8, 4000, '19-23-23-45', 19, '159.99'),
(19, '4000ripG.S', 'G.SKILL', 8, 4000, '19-21-21-41', 19, '115.99'),
(20, '4000t-fTEA', 'TEAM', 16, 4000, '18-20-20-44', 18, '228.99'),
(21, '4000triG.S', 'G.SKILL', 16, 4000, '19-21-21-41', 19, '212.99'),
(22, '4000venCOR', 'CORSAIR', 64, 4000, '19-23-23-45', 19, '799.99'),
(23, '4133triG.S', 'G.SKILL', 16, 4133, '19-19-19-39', 19, '240.99'),
(24, '4133venCOR', 'CORSAIR', 32, 4133, '19-25-25-45', 19, '489.99'),
(25, '4200triG.S', 'G.SKILL', 8, 4200, '19-26-26-46', 19, '384.99'),
(26, '4200venCOR', 'CORSAIR', 8, 4200, '19-26-26-46', 19, '199.99'),
(27, '4266triG.S', 'G.SKILL', 16, 4266, '19-19-19-39', 19, '251.99'),
(28, '4266venCOR', 'CORSAIR', 16, 4266, '19-26-26-46', 19, '329.99'),
(29, '4333venCOR', 'CORSAIR', 16, 4333, '19-26-26-46', 19, '319.99');

--
-- Eseményindítók `ram`
--
DELIMITER $$
CREATE TRIGGER `after_ram_delete` AFTER DELETE ON `ram` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ram','deleted',OLD.ram_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_ram_insert` AFTER INSERT ON `ram` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ram','inserted',NEW.ram_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_ram_update` AFTER UPDATE ON `ram` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ram','updated',NEW.ram_id);  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `ramspeed`
--

CREATE TABLE `ramspeed` (
  `ramspeed_id` int(11) NOT NULL,
  `speed` int(11) NOT NULL,
  `type` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `ramspeed`
--

INSERT INTO `ramspeed` (`ramspeed_id`, `speed`, `type`) VALUES
(1, 2133, '240-Pin DDR3'),
(2, 2400, '240-Pin DDR3'),
(3, 3866, '288-Pin DDR4'),
(4, 4000, '288-Pin DDR4'),
(5, 4133, '288-Pin DDR4'),
(6, 4200, '288-Pin DDR4'),
(7, 4266, '288-Pin DDR4'),
(8, 4333, '288-Pin DDR4');

--
-- Eseményindítók `ramspeed`
--
DELIMITER $$
CREATE TRIGGER `after_ramspeed_delete` AFTER DELETE ON `ramspeed` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ramspeed','deleted',OLD.ramspeed_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_ramspeed_insert` AFTER INSERT ON `ramspeed` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ramspeed','inserted',NEW.ramspeed_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_ramspeed_update` AFTER UPDATE ON `ramspeed` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('ramspeed','updated',NEW.ramspeed_id);  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `sockettype`
--

CREATE TABLE `sockettype` (
  `sockettype_id` int(11) NOT NULL,
  `socket` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `sockettype`
--

INSERT INTO `sockettype` (`sockettype_id`, `socket`) VALUES
(1, 'AM4'),
(2, 'LGA 1151'),
(3, 'LGA 2011-v3'),
(4, 'LGA 2066');

--
-- Eseményindítók `sockettype`
--
DELIMITER $$
CREATE TRIGGER `after_sockettype_delete` AFTER DELETE ON `sockettype` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('sockettype','deleted',OLD.sockettype_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sockettype_insert` AFTER INSERT ON `sockettype` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('sockettype','inserted',NEW.sockettype_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_sockettype_update` AFTER UPDATE ON `sockettype` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('sockettype','updated',NEW.sockettype_id);  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `summary`
--

CREATE TABLE `summary` (
  `summary_id` int(11) NOT NULL,
  `current_summary` double(11,2) NOT NULL,
  `time_currently` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- A tábla adatainak kiíratása `summary`
--

INSERT INTO `summary` (`summary_id`, `current_summary`, `time_currently`) VALUES
(3, 12458.30, '2021-05-21 20:54:40'),
(4, 15694.86, '2021-05-21 20:57:47'),
(5, 12458.30, '2021-05-21 20:57:57');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `videocard`
--

CREATE TABLE `videocard` (
  `videocard_id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `brand` varchar(30) DEFAULT NULL,
  `core_clock` int(11) DEFAULT NULL,
  `gpu` varchar(30) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- A tábla adatainak kiíratása `videocard`
--

INSERT INTO `videocard` (`videocard_id`, `name`, `brand`, `core_clock`, `gpu`, `price`) VALUES
(1, '1050A', 'ASUS', 1404, 'GeForce GTX 1050', '129.99'),
(2, '1050E', 'EVGA', 1354, 'GeForce GTX 1050', '114.99'),
(3, '1050G', 'GIGABYTE', 1379, 'GeForce GTX 1050', '119.99'),
(4, '1050M', 'MSI', 1354, 'GeForce GTX 1050', '119.99'),
(5, '1050P', 'PNY', 1354, 'GeForce GTX 1050', '119.99'),
(6, '1050Z', 'ZOTAC', 1354, 'GeForce GTX 1050', '109.99'),
(7, '1060A', 'ASUS', 1594, 'GeForce GTX 1060', '259.77'),
(8, '1060E', 'EVGA', 1506, 'GeForce GTX 1060', '219.99'),
(9, '1060G', 'GIGABYTE', 1620, 'GeForce GTX 1060', '244.99'),
(10, '1060M', 'MSI', 1544, 'GeForce GTX 1060', '229.99'),
(11, '1060P', 'PNY', 1506, 'GeForce GTX 1060', '229.99'),
(12, '1060Z', 'ZOTAC', 1506, 'GeForce GTX 1060', '249.99'),
(13, '1080A', 'ASUS', 1695, 'GeForce GTX 1080', '578.99'),
(14, '1080E', 'EVGA', 1708, 'GeForce GTX 1080', '549.99'),
(15, '1080G', 'GIGABYTE', 1721, 'GeForce GTX 1080', '549.99'),
(16, '1080M', 'MSI', 1771, 'GeForce GTX 1080', '579.99'),
(17, '1080P', 'PNY', 1708, 'GeForce GTX 1080', '569.99'),
(18, '1080tiA', 'ASUS', 1480, 'GeForce GTX 1080 Ti', '739.77'),
(19, '1080tiE', 'EVGA', 1556, 'GeForce GTX 1080 Ti', '749.99'),
(20, '1080tiG', 'GIGABYTE', 1544, 'GeForce GTX 1080 Ti', '719.99'),
(21, '1080tiM', 'MSI', 1506, 'GeForce GTX 1080 Ti', '729.99'),
(22, '1080tiP', 'PNY', 1582, 'GeForce GTX 1080 Ti', '739.99'),
(23, '1080tiZ', 'ZOTAC', 1569, 'GeForce GTX 1080 Ti', '759.99'),
(24, '1080Z', 'ZOTAC', 1620, 'GeForce GTX 1080', '539.99'),
(25, 'vegaA', 'AMD', 1382, 'Radeon Vega Frontier Edition', '999.99'),
(26, 'vegalcA', 'AMD', 1382, 'Radeon Vega Frontier Edition', '1499.99'),
(27, '980', 'ASUS', 1127, 'GeForce GTX 980', '224.99');

--
-- Eseményindítók `videocard`
--
DELIMITER $$
CREATE TRIGGER `after_videocard_delete` AFTER DELETE ON `videocard` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('videocard','deleted',OLD.videocard_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_videocard_insert` AFTER INSERT ON `videocard` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('videocard','inserted',NEW.videocard_id);  
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_videocard_update` AFTER UPDATE ON `videocard` FOR EACH ROW BEGIN 
    	INSERT INTO logs(part_type,operation,part_id) VALUES('videocard','updated',NEW.videocard_id);  
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `viewallryzen7cpus`
-- (Lásd alább az aktuális nézetet)
--
CREATE TABLE `viewallryzen7cpus` (
`brand` varchar(5)
,`name` varchar(30)
,`core` int(11)
,`thread` int(11)
,`speed` decimal(2,1)
);

-- --------------------------------------------------------

--
-- Nézet szerkezete `gskill_rams_speed_above_average`
--
DROP TABLE IF EXISTS `gskill_rams_speed_above_average`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `gskill_rams_speed_above_average`  AS SELECT `ram`.`ram_id` AS `ram_id`, `ram`.`name` AS `name`, `ram`.`brand` AS `brand`, `ram`.`capacity` AS `capacity`, `ram`.`speed` AS `speed`, `ram`.`timing` AS `timing`, `ram`.`cas` AS `cas`, `ram`.`price` AS `price` FROM `ram` WHERE `ram`.`speed` > (select avg(`ram`.`speed`) from `ram`) AND `ram`.`brand` = 'G.SKILL' ;

-- --------------------------------------------------------

--
-- Nézet szerkezete `viewallryzen7cpus`
--
DROP TABLE IF EXISTS `viewallryzen7cpus`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `viewallryzen7cpus`  AS SELECT `cpu`.`brand` AS `brand`, `cpu`.`name` AS `name`, `cpu`.`core` AS `core`, `cpu`.`thread` AS `thread`, `cpu`.`speed` AS `speed` FROM `cpu` WHERE `cpu`.`series` = 'Ryzen 7' ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `cpu`
--
ALTER TABLE `cpu`
  ADD PRIMARY KEY (`cpu_id`),
  ADD KEY `brand` (`brand`),
  ADD KEY `cpu_ibfk_2` (`socket`);

--
-- A tábla indexei `gpumem`
--
ALTER TABLE `gpumem`
  ADD PRIMARY KEY (`gpumem_id`),
  ADD KEY `gpu` (`gpu`);

--
-- A tábla indexei `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`);

--
-- A tábla indexei `manufacturers`
--
ALTER TABLE `manufacturers`
  ADD PRIMARY KEY (`brand`,`type`);

--
-- A tábla indexei `motherboards`
--
ALTER TABLE `motherboards`
  ADD PRIMARY KEY (`motherboard_id`),
  ADD KEY `brand` (`brand`),
  ADD KEY `type` (`type`),
  ADD KEY `mobo_ibfk_2` (`socket`);

--
-- A tábla indexei `power_supply`
--
ALTER TABLE `power_supply`
  ADD PRIMARY KEY (`power_supply_id`),
  ADD KEY `brand` (`brand`);

--
-- A tábla indexei `ram`
--
ALTER TABLE `ram`
  ADD PRIMARY KEY (`ram_id`),
  ADD KEY `brand` (`brand`),
  ADD KEY `ram_ibfk_2` (`speed`);

--
-- A tábla indexei `ramspeed`
--
ALTER TABLE `ramspeed`
  ADD PRIMARY KEY (`ramspeed_id`),
  ADD KEY `speed` (`speed`);

--
-- A tábla indexei `sockettype`
--
ALTER TABLE `sockettype`
  ADD PRIMARY KEY (`sockettype_id`),
  ADD KEY `socket` (`socket`);

--
-- A tábla indexei `summary`
--
ALTER TABLE `summary`
  ADD PRIMARY KEY (`summary_id`);

--
-- A tábla indexei `videocard`
--
ALTER TABLE `videocard`
  ADD PRIMARY KEY (`videocard_id`),
  ADD KEY `brand` (`brand`),
  ADD KEY `videocard_ibfk_2` (`gpu`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `cpu`
--
ALTER TABLE `cpu`
  MODIFY `cpu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT a táblához `gpumem`
--
ALTER TABLE `gpumem`
  MODIFY `gpumem_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT a táblához `motherboards`
--
ALTER TABLE `motherboards`
  MODIFY `motherboard_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT a táblához `power_supply`
--
ALTER TABLE `power_supply`
  MODIFY `power_supply_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT a táblához `ram`
--
ALTER TABLE `ram`
  MODIFY `ram_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT a táblához `ramspeed`
--
ALTER TABLE `ramspeed`
  MODIFY `ramspeed_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT a táblához `sockettype`
--
ALTER TABLE `sockettype`
  MODIFY `sockettype_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `summary`
--
ALTER TABLE `summary`
  MODIFY `summary_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT a táblához `videocard`
--
ALTER TABLE `videocard`
  MODIFY `videocard_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `cpu`
--
ALTER TABLE `cpu`
  ADD CONSTRAINT `cpu_ibfk_1` FOREIGN KEY (`brand`) REFERENCES `manufacturers` (`brand`) ON DELETE CASCADE,
  ADD CONSTRAINT `cpu_ibfk_2` FOREIGN KEY (`socket`) REFERENCES `sockettype` (`socket`) ON DELETE CASCADE;

--
-- Megkötések a táblához `motherboards`
--
ALTER TABLE `motherboards`
  ADD CONSTRAINT `motherboards_ibfk_1` FOREIGN KEY (`brand`) REFERENCES `manufacturers` (`brand`) ON DELETE CASCADE,
  ADD CONSTRAINT `motherboards_ibfk_2` FOREIGN KEY (`socket`) REFERENCES `sockettype` (`socket`) ON DELETE CASCADE,
  ADD CONSTRAINT `motherboards_ibfk_3` FOREIGN KEY (`type`) REFERENCES `manufacturers` (`brand`) ON DELETE SET NULL;

--
-- Megkötések a táblához `power_supply`
--
ALTER TABLE `power_supply`
  ADD CONSTRAINT `power_supply_ibfk_1` FOREIGN KEY (`brand`) REFERENCES `manufacturers` (`brand`);

--
-- Megkötések a táblához `ram`
--
ALTER TABLE `ram`
  ADD CONSTRAINT `ram_ibfk_1` FOREIGN KEY (`brand`) REFERENCES `manufacturers` (`brand`) ON DELETE CASCADE,
  ADD CONSTRAINT `ram_ibfk_2` FOREIGN KEY (`speed`) REFERENCES `ramspeed` (`speed`) ON DELETE SET NULL;

--
-- Megkötések a táblához `videocard`
--
ALTER TABLE `videocard`
  ADD CONSTRAINT `videocard_ibfk_1` FOREIGN KEY (`brand`) REFERENCES `manufacturers` (`brand`) ON DELETE CASCADE,
  ADD CONSTRAINT `videocard_ibfk_2` FOREIGN KEY (`gpu`) REFERENCES `gpumem` (`gpu`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
