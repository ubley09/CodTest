-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 17, 2020 at 02:34 PM
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
  `title` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `difficulty` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `isclosed` tinyint(1) NOT NULL,
  `id_user` int(9) NOT NULL,
  PRIMARY KEY (`id_contest`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contests`
--

INSERT INTO `contests` (`id_contest`, `title`, `description`, `language`, `difficulty`, `isclosed`, `id_user`) VALUES
(1, 'Phasellus venenatis turpis vitae neque', 'Integer ullamcorper posuere ipsum sed malesuada. Morbi nec nibh leo. Praesent vel dignissim dolor. Aliquam eget libero lorem. Cras sodales ut enim mattis efficitur. Curabitur purus urna, dignissim vel purus eget, consequat pellentesque mauris. Donec a quam posuere, hendrerit nulla a, porta elit. Praesent ac sagittis nisl. Etiam felis risus, ornare quis pretium vitae, malesuada ac ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis elit lectus, bibendum nec dolor faucibus, cursus interdum purus. Sed cursus nulla est, ac dignissim lorem tempor sed. Curabitur fermentum a orci eget consequat.', 'Java', 'Hard', 0, 1),
(2, 'Donec sodales faucibus aliquet', 'Nunc tristique id urna eu vestibulum. Mauris vestibulum interdum elit iaculis dignissim. Duis varius quam ut nunc pretium suscipit. Nam elementum sagittis ullamcorper. Cras volutpat tortor sed nisi consectetur, nec fringilla diam scelerisque. Nunc eleifend justo a faucibus dapibus. Quisque dictum lacinia arcu, ac porttitor nulla scelerisque vel. In porttitor facilisis congue. Aenean sed venenatis mi, vel pretium nibh.', 'C#', 'Easy', 0, 1),
(3, 'Morbi faucibus scelerisque eleifend', 'Fusce vulputate risus metus, sed vulputate massa volutpat ut. Fusce sit amet accumsan sem. Curabitur bibendum lorem at magna dignissim facilisis non nec diam. Aliquam ultrices ipsum ac felis porta consectetur. Phasellus ante ipsum, dignissim at leo a, maximus volutpat tellus. Vestibulum non eleifend nisi. Integer ligula tellus, gravida sit amet efficitur nec, gravida eget lacus. Aenean vestibulum eleifend commodo. Curabitur sed pharetra tortor, nec bibendum lacus. Proin commodo luctus lectus in lacinia. In massa ligula, feugiat vel ligula ut, mollis rutrum eros. Nulla convallis quis mi mattis pharetra. Aenean tincidunt diam suscipit nisi viverra dignissim vitae at metus. Mauris nulla dolor, elementum sit amet odio accumsan, efficitur consequat eros.', 'Python', 'Normal', 0, 1),
(4, 'Praesent tempus porttitor purus', 'sed gravida metus mattis a. Nunc mattis urna a rhoncus eleifend. Suspendisse porta semper velit, vitae rhoncus dui mattis et. Etiam vel quam porttitor, scelerisque nibh nec, lacinia elit. Donec velit mauris, placerat sed dolor et, laoreet fermentum libero. Nulla facilisi. Integer dapibus felis orci, quis auctor ligula luctus ut. Nullam a dui efficitur, commodo ante sed, porta nibh.', 'Java', 'Easy', 0, 1),
(5, 'Duis molestie mi neque, eu interdum eros', 'Maecenas sit amet dictum eros. Fusce placerat magna lectus. Vivamus at risus justo. Nam pharetra id nibh non dapibus. Mauris lobortis luctus nibh at blandit. Nullam metus risus, blandit et gravida et, convallis imperdiet enim. Suspendisse eu maximus orci. In et lacinia erat, et congue magna. Curabitur rutrum egestas urna, fermentum interdum diam suscipit sed. Nullam at maximus nibh, in efficitur quam. Suspendisse varius eleifend risus, sit amet egestas lacus fringilla ac.', 'Python', 'Hard', 0, 1),
(6, 'Suspendisse potenti', 'Proin ut sodales purus, in venenatis ligula. Suspendisse potenti. Integer vehicula arcu id velit varius, fringilla volutpat magna dictum. Nunc vel bibendum libero, vitae suscipit ipsum. Nunc sed turpis eu nulla suscipit tristique. Integer sagittis porta pharetra. Cras viverra rutrum lacus sed faucibus. Donec hendrerit augue eget velit rutrum fringilla. Mauris ullamcorper sodales quam, in ultrices arcu commodo ac. Etiam scelerisque, dui sed hendrerit sagittis, tellus augue pretium lorem, sed interdum metus felis vitae lacus. Morbi a arcu eget sapien faucibus pulvinar et at turpis.', 'Java', 'Normal', 0, 4),
(7, 'Nulla fermentum blandit porta', 'Mauris consequat magna quam, vel lacinia odio volutpat at. Phasellus ultricies, arcu et faucibus venenatis, enim turpis condimentum lacus, ut pellentesque neque sapien vitae arcu. Phasellus a mauris nec est ultricies tristique. Maecenas maximus vel nulla vitae blandit. Etiam egestas semper nisl, in egestas justo. Aliquam erat volutpat. Etiam justo nulla, scelerisque dignissim mattis in, maximus ut nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas tristique ex sapien, eget sodales ante aliquet eu. Maecenas a erat eget erat semper condimentum. Vivamus eget consequat mi, vitae accumsan neque. Ut molestie viverra tortor sed luctus. Phasellus euismod ultrices suscipit. Sed eget magna turpis. Pellentesque ultricies, ipsum in lacinia mattis, odio ipsum cursus augue, ut dictum lectus elit ut ante.', 'C#', 'Hard', 0, 4),
(8, 'Aliquam cursus lacus diam', 'Vitae sollicitudin enim maximus quis. In hac habitasse platea dictumst. Nulla facilisi. Aliquam congue ornare ex, hendrerit accumsan turpis. Quisque porta faucibus neque a ultrices. Nullam sed lacus purus. In sit amet velit a leo pretium luctus id sed nisl. Suspendisse semper urna ante. Curabitur rutrum nisl id nulla interdum facilisis vitae sit amet libero. Sed interdum venenatis consectetur. Nunc pellentesque, turpis nec tristique gravida, lorem neque tristique mauris, vitae porta justo tortor quis augue.', 'Python', 'Normal', 0, 6);

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
  `solution` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `solution_description` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
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