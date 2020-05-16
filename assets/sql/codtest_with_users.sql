-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 16, 2020 at 04:32 PM
-- Server version: 10.4.10-MariaDB
-- PHP Version: 7.3.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codtest`
--

-- --------------------------------------------------------

--
-- Table structure for table `contests`
--

DROP TABLE IF EXISTS `contests`;
CREATE TABLE IF NOT EXISTS `contests` (
  `id_contest` int(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `difficulty` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `isclosed` tinyint(1) NOT NULL,
  `id_user` int(9) NOT NULL,
  PRIMARY KEY (`id_contest`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE IF NOT EXISTS `ratings` (
  `likes` int(9) NOT NULL,
  `dislikes` int(9) NOT NULL,
  `id_user` int(9) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`likes`, `dislikes`, `id_user`) VALUES
(0, 0, 1),
(0, 0, 2),
(0, 0, 3),
(0, 0, 4),
(0, 0, 5),
(0, 0, 6);

-- --------------------------------------------------------

--
-- Table structure for table `solutions`
--

DROP TABLE IF EXISTS `solutions`;
CREATE TABLE IF NOT EXISTS `solutions` (
  `id_solution` int(9) NOT NULL AUTO_INCREMENT,
  `solution` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `solution_description` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isgood` tinyint(1) NOT NULL,
  `checked` tinyint(1) NOT NULL,
  `id_contest` int(9) NOT NULL,
  `id_user` int(9) NOT NULL,
  PRIMARY KEY (`id_solution`),
  KEY `id_contest` (`id_contest`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `firstname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `lastname` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `username`, `password`, `firstname`, `lastname`, `email`) VALUES
(1, 'Ubley', '369d7aeef623f225866af2f788a1d2b618a35b97', 'Robert', 'Kovac', 'robika09@gmail.com'),
(2, 'Molly11', 'a10f67672cf81b27132e041d6ba32fdfcfd4d207', 'Molly', 'Solverson', 'MollyS@gmail.com'),
(3, 'LMalvo11', '58e29df9be7c4addb2b0ea2a7332ced1902bdcbd', 'Lorne', 'Malvo', 'LorneM@gmail.com'),
(4, 'Gus2014', '7929876655246e79c8b5ebcd583b56305fdf089a', 'Gus', 'Gimly', 'GusG@gmail.com'),
(5, 'Lester2014', '532177130e35942b59c42c1ab37c0e4b6b8c06f7', 'Lester', 'Nygaard', 'LesterN@gmail.com'),
(6, 'Lou10', '77405a9b72e176b28e5e574420e80b93dde4fd43', 'Lou', 'Solverson', 'LoutS@gmail.com');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `contests`
--
ALTER TABLE `contests`
  ADD CONSTRAINT `user_contest` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `user_ratings` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `solutions`
--
ALTER TABLE `solutions`
  ADD CONSTRAINT `contest_solution` FOREIGN KEY (`id_contest`) REFERENCES `contests` (`id_contest`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_solution` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
