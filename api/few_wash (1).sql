-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 03, 2024 at 09:00 AM
-- Server version: 10.6.17-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `androidh_fluttertraining`
--

-- --------------------------------------------------------

--
-- Table structure for table `few_wash`
--

CREATE TABLE `few_wash` (
  `id` int(11) NOT NULL,
  `refWash` text NOT NULL,
  `customerId` text NOT NULL,
  `dateStart` text NOT NULL,
  `timeStart` text NOT NULL,
  `dateEnd` text NOT NULL,
  `timeEnd` text NOT NULL,
  `dry` text NOT NULL,
  `amountCloth` text NOT NULL,
  `detergen` text NOT NULL,
  `softener` text NOT NULL,
  `total` text NOT NULL,
  `status` text NOT NULL,
  `idAdminReceive` text NOT NULL,
  `idAdminOrder` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `few_wash`
--

INSERT INTO `few_wash` (`id`, `refWash`, `customerId`, `dateStart`, `timeStart`, `dateEnd`, `timeEnd`, `dry`, `amountCloth`, `detergen`, `softener`, `total`, `status`, `idAdminReceive`, `idAdminOrder`) VALUES
(1, 'ref-6743', 'cus-901', '27 / Aug / 24', '10:00', '28 / Aug / 24', '10:00', 'false', '9', '3', '4', '155', 'Recive', '16', '16'),
(3, 'ref-2285', 'cus-901', '27 / Aug / 24', '14:00', '28 / Aug / 24', '16:00', 'false', '6', '1', '2', '100', 'Recive', '', ''),
(4, 'ref-5519', 'cus-901', '26 / Aug / 24', '14:00', '28 / Aug / 24', '18:00', 'false', '10', '4', '4', '170', 'Recive', '16', ''),
(5, 'ref-8948', 'cus-901', '26 / Aug / 24', '08:00', '27 / Aug / 24', '10:00', 'false', '5', '5', '5', '165', 'Recive', '16', '16'),
(6, 'ref-2350', 'cus-901', '29 / Aug / 24', '14:00', '31 / Aug / 24', '14:00', 'false', '4', '4', '4', '140', 'Order', '', ''),
(7, 'ref-2650', 'cus-901', '31 / Aug / 24', '08:00', '31 / Aug / 24', '16:00', 'false', '2', '2', '2', '90', 'Order', '', ''),
(8, 'ref-1626', 'cus-901', '29 / Aug / 24', '16:00', '31 / Aug / 24', '18:00', 'false', '1', '1', '1', '65', 'Order', '', ''),
(9, 'ref-413', 'cus-901', '28 / Aug / 24', '18:00', '28 / Aug / 24', '18:00', 'false', '4', '4', '4', '140', 'Order', '', ''),
(10, 'ref-9106', 'cus-901', '29 / Aug / 24', '10:00', '29 / Aug / 24', '12:00', 'false', '12', '1', '1', '120', 'Order', '', ''),
(11, 'ref-1298', 'cus-901', '30 / Aug / 24', '10:00', '30 / Aug / 24', '10:00', 'false', '8', '3', '3', '140', 'Order', '', ''),
(12, 'ref-338', 'cus-901', '31 / Aug / 24', '10:00', '31 / Aug / 24', '10:00', 'false', '7', '5', '5', '175', 'Recive', '', ''),
(13, 'ref-9345', 'cus-667', '26 / Aug / 24', '10:00', '26 / Aug / 24', '08:00', 'false', '1', '1', '1', '65', 'Order', '', ''),
(14, 'ref-808', 'cus-667', '28 / Aug / 24', '14:00', '30 / Aug / 24', '14:00', 'false', '15', '1', '1', '135', 'Order', '', ''),
(15, 'ref-2602', 'cus-667', '28 / Aug / 24', '10:00', '28 / Aug / 24', '12:00', 'false', '1', '1', '1', '65', 'Order', '', ''),
(16, 'ref-3633', 'cus-901', '30 / Aug / 24', '14:00', '31 / Aug / 24', '12:00', 'false', '15', '3', '1', '155', 'Order', '', ''),
(17, 'ref-8788', 'cus-901', '31 / Aug / 24', '12:00', '31 / Aug / 24', '16:00', 'false', '8', '4', '3', '150', 'Order', '', ''),
(18, 'ref-115', 'cus-667', '31 / Aug / 24', '10:00', '31 / Aug / 24', '12:00', 'false', '9', '4', '4', '165', 'Order', '', ''),
(19, 'ref-7707', 'cus-667', '03 / Sep / 24', '10:00', '03 / Sep / 24', '12:00', 'false', '6', '1', '1', '90', 'Order', '16', '16'),
(20, 'ref-8852', 'cus-539', '11 / Sep / 24', '10:00', '04 / Sep / 24', '12:00', 'true', '7', '1', '1', '135', 'Order', '', ''),
(21, 'ref-822', 'cus-539', '18 / Sep / 24', '10:00', '04 / Sep / 24', '10:00', 'false', '6', '2', '2', '110', 'Order', '', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `few_wash`
--
ALTER TABLE `few_wash`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `few_wash`
--
ALTER TABLE `few_wash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
