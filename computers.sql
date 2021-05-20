-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2021. Máj 20. 13:10
-- Kiszolgáló verziója: 10.4.14-MariaDB
-- PHP verzió: 7.4.11

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

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `addresses`
--

CREATE TABLE `addresses` (
  `id` int(10) NOT NULL,
  `cust_id` int(10) NOT NULL,
  `address` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `city` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `country` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `zip_code` varchar(12) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `addresses`
--

INSERT INTO `addresses` (`id`, `cust_id`, `address`, `city`, `country`, `zip_code`) VALUES
(1, 1, 'Obere Str. 57', 'Berlin', 'Germany', '12209'),
(2, 2, 'Avda. de la Constitución 2222', 'México D.F.', 'Mexico', '05021'),
(3, 3, '120 Hanover Sq.', 'London', 'UK', 'WA1 1DP'),
(4, 4, '12, rue des Bouchers', 'Marseille', 'France', '13008'),
(5, 5, '23 Tsawassen Blvd', 'Tsawassen', 'Canada', 'T2F 8M4'),
(6, 6, 'Åkergatan 24', 'Bräcke', 'Sweden', 'S-844 67');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computer`
--

CREATE TABLE `computer` (
  `id` int(10) NOT NULL,
  `computer_category_id` int(11) NOT NULL,
  `reg_date` date DEFAULT NULL,
  `title` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `computer_desc` varchar(1024) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `model` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computers_part`
--

CREATE TABLE `computers_part` (
  `id` int(10) NOT NULL,
  `manufacturer_id` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL,
  `comp_part_desc` varchar(1024) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `model` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computers_sold`
--

CREATE TABLE `computers_sold` (
  `id` int(10) NOT NULL,
  `cust_id` int(10) NOT NULL,
  `computer_part_id` int(10) NOT NULL,
  `computer_id` int(10) NOT NULL,
  `agreed_price` decimal(8,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computer_category`
--

CREATE TABLE `computer_category` (
  `id` int(10) NOT NULL,
  `category_desc` varchar(1024) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computer_computer_part`
--

CREATE TABLE `computer_computer_part` (
  `computer_id` int(10) NOT NULL,
  `computer_part_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `computer_payments`
--

CREATE TABLE `computer_payments` (
  `id` int(10) NOT NULL,
  `cust_id` int(10) NOT NULL,
  `payment_status_code` int(10) NOT NULL,
  `parts_sold_id` int(10) NOT NULL,
  `computers_sold_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `customer`
--

CREATE TABLE `customer` (
  `id` int(10) NOT NULL,
  `cellphone` varchar(20) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `email_address` varchar(128) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `customer`
--

INSERT INTO `customer` (`id`, `cellphone`, `email_address`) VALUES
(1, '0482398193', 'victorjmcghee@rhyta.com'),
(2, '07722017960', 'margaretsallen@rhyta.com'),
(3, '8143790730', 'bethanyjpeake@armyspy.com'),
(4, ' 9145594792', 'wallaceebuckingham@jourrapide.com'),
(5, '6319692802', 'cynthiazcromer@dayrep.com'),
(6, '4343322386', 'lindarworley@armyspy.com');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `manufacturer`
--

CREATE TABLE `manufacturer` (
  `id` int(10) NOT NULL,
  `full_name` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL,
  `contact` varchar(64) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `manufacturer`
--

INSERT INTO `manufacturer` (`id`, `full_name`, `contact`) VALUES
(1, 'Asus', 'https://www.asus.com/us/support/	');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `parts_sold`
--

CREATE TABLE `parts_sold` (
  `id` int(10) NOT NULL,
  `cust_id` int(10) NOT NULL,
  `computer_part_id` int(10) NOT NULL,
  `computer_id` int(10) DEFAULT NULL,
  `agreed_price` decimal(8,2) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `payment_status`
--

CREATE TABLE `payment_status` (
  `status_code` int(10) NOT NULL,
  `payment_desc` varchar(255) COLLATE utf8_hungarian_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_customer_fk` (`cust_id`);

--
-- A tábla indexei `computer`
--
ALTER TABLE `computer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `computer_category_ff` (`computer_category_id`);

--
-- A tábla indexei `computers_part`
--
ALTER TABLE `computers_part`
  ADD PRIMARY KEY (`id`),
  ADD KEY `computer_part_manufacturer_foreign_key` (`manufacturer_id`);

--
-- A tábla indexei `computers_sold`
--
ALTER TABLE `computers_sold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `computer_sold_customer_fk` (`cust_id`),
  ADD KEY `computer_sold_computer_fk` (`computer_id`),
  ADD KEY `computer_sold_computer_part_id_fk` (`computer_part_id`);

--
-- A tábla indexei `computer_category`
--
ALTER TABLE `computer_category`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `computer_computer_part`
--
ALTER TABLE `computer_computer_part`
  ADD PRIMARY KEY (`computer_id`);

--
-- A tábla indexei `computer_payments`
--
ALTER TABLE `computer_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `computer_payments_customer_fk` (`cust_id`),
  ADD KEY `computer_payments_payment_status_fk` (`payment_status_code`),
  ADD KEY `computer_payments_part_sold_fk` (`parts_sold_id`),
  ADD KEY `computer_payments_computer_sold_fk` (`computers_sold_id`);

--
-- A tábla indexei `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `manufacturer`
--
ALTER TABLE `manufacturer`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `parts_sold`
--
ALTER TABLE `parts_sold`
  ADD PRIMARY KEY (`id`),
  ADD KEY `part_sold_customer_fk` (`cust_id`),
  ADD KEY `part_sold_computer_part_fk` (`computer_part_id`);

--
-- A tábla indexei `payment_status`
--
ALTER TABLE `payment_status`
  ADD PRIMARY KEY (`status_code`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `computer`
--
ALTER TABLE `computer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `computers_part`
--
ALTER TABLE `computers_part`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `computers_sold`
--
ALTER TABLE `computers_sold`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `computer_category`
--
ALTER TABLE `computer_category`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `computer_computer_part`
--
ALTER TABLE `computer_computer_part`
  MODIFY `computer_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `computer_payments`
--
ALTER TABLE `computer_payments`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `manufacturer`
--
ALTER TABLE `manufacturer`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `parts_sold`
--
ALTER TABLE `parts_sold`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `payment_status`
--
ALTER TABLE `payment_status`
  MODIFY `status_code` int(10) NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_customer_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `computers_part`
--
ALTER TABLE `computers_part`
  ADD CONSTRAINT `computer_part_manufacturer_foreign_key` FOREIGN KEY (`manufacturer_id`) REFERENCES `manufacturer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `computers_sold`
--
ALTER TABLE `computers_sold`
  ADD CONSTRAINT `computer_sold_computer_fk` FOREIGN KEY (`computer_id`) REFERENCES `computer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computer_sold_customer_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `computer_payments`
--
ALTER TABLE `computer_payments`
  ADD CONSTRAINT `computer_payments_computer_sold_fk` FOREIGN KEY (`computers_sold_id`) REFERENCES `computers_sold` (`computer_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computer_payments_customer_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `computer_payments_payment_status_fk` FOREIGN KEY (`payment_status_code`) REFERENCES `payment_status` (`status_code`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Megkötések a táblához `parts_sold`
--
ALTER TABLE `parts_sold`
  ADD CONSTRAINT `part_sold_computer_part_fk` FOREIGN KEY (`computer_part_id`) REFERENCES `computers_part` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `part_sold_customer_fk` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
