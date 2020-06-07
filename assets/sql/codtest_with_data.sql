-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 07, 2020 at 09:02 PM
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

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `change_solution_state`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_solution_state` (`id_solution_p` INT(9))  BEGIN

	DECLARE state TINYINT(1);

	SELECT solution_state INTO state
	FROM solutions
	WHERE id_solution = id_solution_p;

	CASE state
		WHEN 0 THEN
			UPDATE solutions
			SET solution_state = 1
			WHERE id_solution = id_solution_p;
			SELECT 1 AS "state";
		WHEN 1 THEN
			UPDATE solutions
			SET solution_state = 0
			WHERE id_solution = id_solution_p;
			SELECT 0 AS "state";
		WHEN 2 THEN
			DELETE FROM solutions
			WHERE solutions.id_solution = id_solution_p;
			SELECT 2 AS "state";
		WHEN 3 THEN
			SELECT 3 AS "state";
	END CASE;

END$$

DROP PROCEDURE IF EXISTS `insert_solution`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_solution` (`solution_description_p` VARCHAR(1024), `id_contest_p` INT(9), `id_user_p` INT(9))  BEGIN

	DECLARE lastinsertid INT(9);

	INSERT INTO solutions (solution, solution_description, solution_state, id_contest, id_user)
		VALUES ("null", solution_description_p, 0, id_contest_p, id_user_p);

	SELECT LAST_INSERT_ID() INTO lastinsertid;

	UPDATE solutions
			SET solution = CONCAT("code", lastinsertid, ".txt")
			WHERE id_solution = lastinsertid;

	SELECT solution FROM solutions
	WHERE id_solution = lastinsertid;


END$$

DROP PROCEDURE IF EXISTS `new_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `new_user` (`username_p` VARCHAR(30), `password_p` VARCHAR(40), `firstname_p` VARCHAR(30), `lastname_p` VARCHAR(30), `email_p` VARCHAR(30))  BEGIN

	INSERT INTO users (username, password, firstname, lastname, email)
		VALUES (username_p, password_p, firstname_p, lastname_p, email_p);

	INSERT INTO ratings (likes, dislikes, id_user)
			VALUES (0, 0, LAST_INSERT_ID());

END$$

DROP PROCEDURE IF EXISTS `solution_check`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `solution_check` (`id_solution_p` INT(9), `solution_state_p` TINYINT(1))  BEGIN

	DECLARE userid INT(9);

	UPDATE solutions
		SET solution_state = solution_state_p
		WHERE id_solution = id_solution_p;

	SELECT id_user INTO userid
		FROM solutions
		WHERE id_solution = id_solution_p;

	IF solution_state_p = 2 THEN
		UPDATE ratings
			SET dislikes = dislikes + 1
			WHERE id_user = userid;
	ELSEIF solution_state_p = 3 THEN
		UPDATE ratings
			SET likes = likes + 1
			WHERE id_user = userid;
	END IF;

END$$

DELIMITER ;

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
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `contests`
--

INSERT INTO `contests` (`id_contest`, `title`, `description`, `language`, `difficulty`, `isclosed`, `id_user`) VALUES
(1, 'Phasellus venenatis turpis vitae neque', 'Integer ullamcorper posuere ipsum sed malesuada. Morbi nec nibh leo. Praesent vel dignissim dolor. Aliquam eget libero lorem. Cras sodales ut enim mattis efficitur. Curabitur purus urna, dignissim vel purus eget, consequat pellentesque mauris. Donec a quam posuere, hendrerit nulla a, porta elit. Praesent ac sagittis nisl. Etiam felis risus, ornare quis pretium vitae, malesuada ac ex. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Duis elit lectus, bibendum nec dolor faucibus, cursus interdum purus. Sed cursus nulla est, ac dignissim lorem tempor sed. Curabitur fermentum a orci eget consequat.', 'Java', 'Hard', 1, 1),
(2, 'Donec sodales faucibus aliquet', 'Nunc tristique id urna eu vestibulum. Mauris vestibulum interdum elit iaculis dignissim. Duis varius quam ut nunc pretium suscipit. Nam elementum sagittis ullamcorper. Cras volutpat tortor sed nisi consectetur, nec fringilla diam scelerisque. Nunc eleifend justo a faucibus dapibus. Quisque dictum lacinia arcu, ac porttitor nulla scelerisque vel. In porttitor facilisis congue. Aenean sed venenatis mi, vel pretium nibh.', 'C#', 'Easy', 0, 1),
(3, 'Morbi faucibus scelerisque eleifend', 'Fusce vulputate risus metus, sed vulputate massa volutpat ut. Fusce sit amet accumsan sem. Curabitur bibendum lorem at magna dignissim facilisis non nec diam. Aliquam ultrices ipsum ac felis porta consectetur. Phasellus ante ipsum, dignissim at leo a, maximus volutpat tellus. Vestibulum non eleifend nisi. Integer ligula tellus, gravida sit amet efficitur nec, gravida eget lacus. Aenean vestibulum eleifend commodo. Curabitur sed pharetra tortor, nec bibendum lacus. Proin commodo luctus lectus in lacinia. In massa ligula, feugiat vel ligula ut, mollis rutrum eros. Nulla convallis quis mi mattis pharetra. Aenean tincidunt diam suscipit nisi viverra dignissim vitae at metus. Mauris nulla dolor, elementum sit amet odio accumsan, efficitur consequat eros.', 'Python', 'Normal', 0, 1),
(4, 'Praesent tempus porttitor purus', 'sed gravida metus mattis a. Nunc mattis urna a rhoncus eleifend. Suspendisse porta semper velit, vitae rhoncus dui mattis et. Etiam vel quam porttitor, scelerisque nibh nec, lacinia elit. Donec velit mauris, placerat sed dolor et, laoreet fermentum libero. Nulla facilisi. Integer dapibus felis orci, quis auctor ligula luctus ut. Nullam a dui efficitur, commodo ante sed, porta nibh.', 'Java', 'Easy', 0, 1),
(5, 'Duis molestie mi neque, eu interdum eros', 'Maecenas sit amet dictum eros. Fusce placerat magna lectus. Vivamus at risus justo. Nam pharetra id nibh non dapibus. Mauris lobortis luctus nibh at blandit. Nullam metus risus, blandit et gravida et, convallis imperdiet enim. Suspendisse eu maximus orci. In et lacinia erat, et congue magna. Curabitur rutrum egestas urna, fermentum interdum diam suscipit sed. Nullam at maximus nibh, in efficitur quam. Suspendisse varius eleifend risus, sit amet egestas lacus fringilla ac.', 'Python', 'Hard', 0, 1),
(6, 'Suspendisse potenti', 'Proin ut sodales purus, in venenatis ligula. Suspendisse potenti. Integer vehicula arcu id velit varius, fringilla volutpat magna dictum. Nunc vel bibendum libero, vitae suscipit ipsum. Nunc sed turpis eu nulla suscipit tristique. Integer sagittis porta pharetra. Cras viverra rutrum lacus sed faucibus. Donec hendrerit augue eget velit rutrum fringilla. Mauris ullamcorper sodales quam, in ultrices arcu commodo ac. Etiam scelerisque, dui sed hendrerit sagittis, tellus augue pretium lorem, sed interdum metus felis vitae lacus. Morbi a arcu eget sapien faucibus pulvinar et at turpis.', 'Java', 'Normal', 0, 4),
(7, 'Nulla fermentum blandit porta', 'Mauris consequat magna quam, vel lacinia odio volutpat at. Phasellus ultricies, arcu et faucibus venenatis, enim turpis condimentum lacus, ut pellentesque neque sapien vitae arcu. Phasellus a mauris nec est ultricies tristique. Maecenas maximus vel nulla vitae blandit. Etiam egestas semper nisl, in egestas justo. Aliquam erat volutpat. Etiam justo nulla, scelerisque dignissim mattis in, maximus ut nibh. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Maecenas tristique ex sapien, eget sodales ante aliquet eu. Maecenas a erat eget erat semper condimentum. Vivamus eget consequat mi, vitae accumsan neque. Ut molestie viverra tortor sed luctus. Phasellus euismod ultrices suscipit. Sed eget magna turpis. Pellentesque ultricies, ipsum in lacinia mattis, odio ipsum cursus augue, ut dictum lectus elit ut ante.', 'C#', 'Hard', 0, 4),
(8, 'Aliquam cursus lacus diam', 'Vitae sollicitudin enim maximus quis. In hac habitasse platea dictumst. Nulla facilisi. Aliquam congue ornare ex, hendrerit accumsan turpis. Quisque porta faucibus neque a ultrices. Nullam sed lacus purus. In sit amet velit a leo pretium luctus id sed nisl. Suspendisse semper urna ante. Curabitur rutrum nisl id nulla interdum facilisis vitae sit amet libero. Sed interdum venenatis consectetur. Nunc pellentesque, turpis nec tristique gravida, lorem neque tristique mauris, vitae porta justo tortor quis augue.', 'Python', 'Normal', 0, 6),
(9, 'Ut aliquet luctus ipsum, eget interdum', 'Nullam auctor tellus ipsum, sed luctus dui ultricies sit amet. Fusce augue tellus, maximus et ornare non, mattis vitae mauris. Nunc finibus non lectus vitae vehicula. Etiam ac tincidunt nisl. Donec et dolor in neque vehicula vehicula. Sed mattis scelerisque dui, ac tincidunt velit congue ut. Curabitur justo nunc, varius at arcu id, facilisis malesuada purus. Donec id dui sit amet mi tristique sollicitudin.', 'Java', 'Normal', 0, 6),
(10, 'Sed tempor, felis eget pellentesque', 'ligula magna auctor neque, eu dictum elit orci at lectus. Ut sit amet sapien vitae velit tristique efficitur vel vel nisl. In feugiat consequat libero et gravida. Ut quis massa rhoncus, porttitor diam non, molestie nibh. Suspendisse magna nulla, tincidunt ac augue vel, tincidunt viverra neque. Praesent ac felis augue. Mauris efficitur, metus ut tincidunt sollicitudin, ligula sapien iaculis nisi, eget porttitor massa arcu et lorem. In nisi libero, iaculis id metus a, porttitor dictum urna. Etiam ut nisl sed mauris varius vestibulum. Donec id nulla imperdiet, gravida ligula eget, tempus enim. Curabitur eu libero vel leo tincidunt ultrices sit amet non eros. Donec eleifend eros sit amet mollis ornare. Proin leo urna, convallis eget accumsan sed, posuere et orci. Aenean id arcu vel est porttitor ullamcorper. Suspendisse potenti.', 'Java', 'Normal', 0, 6),
(11, 'Mauris a commodo tortor', 'Donec id facilisis nisl. Sed nec feugiat tellus. Curabitur tempor turpis nisl, in eleifend eros vehicula vel. Morbi euismod vel odio eget consectetur. Ut vel dui sit amet eros placerat malesuada vitae eget dolor. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque accumsan maximus tellus et convallis. Praesent mollis sem ligula, id porttitor tortor tempor in. Nam nibh ante, ullamcorper vitae fermentum et, semper et mauris. Etiam vel leo ac nulla efficitur tempus ut ut metus. In hac habitasse platea dictumst. Morbi faucibus congue est sit amet efficitur.', 'Java', 'Normal', 0, 6),
(12, 'Proin quis ante elit', 'Vestibulum posuere vel neque nec interdum. Suspendisse ut arcu convallis, fringilla risus ut, bibendum massa. Nulla dictum justo ac turpis viverra luctus. Suspendisse euismod condimentum risus vitae ullamcorper. Nunc commodo consectetur mi, vel cursus metus ultricies nec. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras eget egestas leo. Vestibulum lacinia dui in ex aliquet posuere. Proin pharetra viverra justo viverra dictum. Nullam tincidunt, leo et efficitur laoreet, mi quam interdum magna, vel accumsan mi purus vel lacus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Pellentesque bibendum aliquam dui. Proin elementum in risus et facilisis.', 'C#', 'Normal', 0, 6),
(13, 'Donec placerat fermentum ornare', 'Sed laoreet magna metus, nec faucibus nulla lacinia at. Vivamus non iaculis nulla. Proin erat lorem, dapibus sit amet pretium ornare, iaculis iaculis erat. Nullam nec diam quis lacus suscipit convallis. Ut vulputate vulputate dui ac posuere. Nulla imperdiet, massa eget fringilla dignissim, magna justo posuere magna, et condimentum quam sem sed lorem.', 'C#', 'Easy', 0, 6),
(14, 'Sed faucibus massa', 'Sed varius laoreet dignissim. Mauris mollis risus ultricies pellentesque varius. Fusce scelerisque egestas fermentum. Donec auctor risus non luctus iaculis. Aenean lacinia aliquam vehicula. Aliquam tincidunt urna et lectus suscipit lobortis.', 'Python', 'Easy', 0, 6),
(15, 'Suspendisse ut diam', 'Phasellus imperdiet feugiat tincidunt. In est felis, lacinia ut tincidunt eget, auctor a orci. Phasellus scelerisque lobortis tellus, non auctor sem congue eu. Mauris varius ornare tincidunt. Duis et sagittis elit. Proin non neque elementum, vehicula ex sit amet, sagittis quam. Morbi dapibus libero non libero sagittis semper. Quisque interdum metus eu neque tempor consequat. Proin sit amet est et lectus viverra viverra. Fusce quis dolor quam. Phasellus condimentum a tortor ut aliquam. Proin hendrerit congue est, at congue leo ultrices a. Vivamus viverra elementum pharetra.', 'Python', 'Hard', 0, 5),
(16, 'Quisque et justo sapien', 'Praesent in scelerisque odio. Mauris ullamcorper mi sit amet ipsum interdum lobortis. Etiam neque ante, vestibulum a ligula eget, molestie scelerisque est. Morbi dignissim rutrum libero vitae vulputate. Aenean bibendum erat velit, sit amet fringilla sem elementum vitae. Aliquam ac neque finibus, sodales quam vitae, feugiat ante.', 'Java', 'Easy', 0, 5),
(17, 'Nam eget orci tempus', 'Sed nec risus est. In pharetra urna vel ex egestas, eu pellentesque dolor dictum. Proin sit amet tincidunt eros, nec egestas justo. Vivamus id quam nec nunc pharetra cursus eu eu arcu. Morbi ac fringilla massa, ut placerat est. Nulla iaculis elit quis tincidunt faucibus. Donec est velit, malesuada ac quam eu, convallis faucibus quam. Sed dolor magna, aliquet non aliquam nec, tempus sit amet leo. Proin quis orci vulputate augue blandit euismod. Integer sodales efficitur justo a tristique. Praesent ut ligula ante. Morbi in est bibendum, luctus ipsum eget, pretium felis. In hac habitasse platea dictumst.', 'Java', 'Normal', 0, 5),
(18, 'Suspendisse tempus magna sapien', 'In sit amet sodales diam. Sed ac felis quam. Etiam rutrum tortor aliquet ligula venenatis, vitae mattis tellus ultrices. Maecenas purus nunc, porta vel ipsum ac, molestie aliquet lacus. In venenatis aliquam risus in commodo. Suspendisse semper dignissim convallis. Praesent dictum pulvinar dolor, non fermentum sem. Proin pellentesque risus a mi volutpat, a scelerisque orci sollicitudin. Cras sed elit et mauris rutrum eleifend. Sed lacinia ex magna, nec sodales neque rutrum eget. Fusce ut pulvinar turpis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Ut consequat nisl eget tristique ultrices. Donec id dolor vitae mauris feugiat dapibus. Quisque ut rutrum nulla, eu condimentum nisl.', 'C#', 'Hard', 0, 5),
(19, 'Nullam ac dolor egestas', 'Integer pulvinar odio nec nisi consequat, eget mattis dolor pulvinar. Aliquam nisl orci, commodo tincidunt ultrices sit amet, aliquam eget metus. Aliquam tristique eros et sem ullamcorper gravida. Nunc at elit metus. Quisque tempor risus in sem aliquet, sed ultrices massa cursus. Sed sed interdum mauris. Nullam sed consectetur tellus. Curabitur nec lacus in sapien molestie vulputate. Aliquam vestibulum congue luctus. Nulla efficitur maximus tellus, vitae fermentum ante vulputate a. Curabitur commodo nibh erat, maximus vehicula velit feugiat vel. Aenean ac rutrum justo.', 'C#', 'Easy', 0, 1);

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
(2, 0, 1),
(5, 2, 2),
(0, 0, 3),
(1, 0, 4),
(5, 1, 5),
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
  `solution_state` tinyint(1) NOT NULL,
  `id_contest` int(9) NOT NULL,
  `id_user` int(9) NOT NULL,
  PRIMARY KEY (`id_solution`),
  KEY `id_contest` (`id_contest`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `solutions`
--

INSERT INTO `solutions` (`id_solution`, `solution`, `solution_description`, `solution_state`, `id_contest`, `id_user`) VALUES
(1, 'code1.txt', 'In this program, you\'ll learn to store and add two integer numbers in Java. After addition, the final sum is displayed on the screen.', 3, 6, 5),
(2, 'code2.txt', 'In this program, you\'ll learn to multiply two floating point numbers in Java, store the result and display it on the screen.', 3, 10, 5),
(3, 'code3.txt', 'In this program, you\'ll learn to find and display the ASCII value of a character in Java. This is done using type-casting and normal variable assignment operations.', 3, 9, 5),
(4, 'code4.txt', 'In this program, you\'ll learn to compute quotient and remainder from the given dividend and divisor in Java.', 2, 11, 5),
(5, 'code5.txt', 'In this program, you will learn to add two numbers and display it using print() function.', 3, 14, 5),
(6, 'code6.txt', 'Here is source code of the C# program which checks a given integer is odd or even. The C# program is successfully compiled and executed with Microsoft Visual Studio. The program output is also shown below.', 3, 7, 5),
(7, 'code7.txt', 'Here is source code of the C# program that swaps two numbers. The C# program is successfully compiled and executed with Microsoft Visual Studio. The program output is also shown below.', 0, 12, 2),
(8, 'code8.txt', 'Check whether an alphabet is vowel or consonant using switch statement\r\n\r\nWhen you run the program, the output will be:\r\n\r\nz is consonant\r\n\r\nIn the above program, instead of using a long if condition, we replace it with a switch case statement.\r\n\r\nIf ch is either of cases: (\'a\', \'e\', \'i\', \'o\', \'u\'), vowel is printed. Else, default case is executed and consonant is printed on the screen.', 0, 11, 2),
(9, 'code9.txt', 'In this program, you\'ll learn to check if the given year is a leap year or not. This is checked using a if else statement.\r\n\r\nA leap year is exactly divisible by 4 except for century years (years ending with 00). The century year is a leap year only if it is perfectly divisible by 400.', 0, 6, 2),
(10, 'code10.txt', 'In this program, you\'ll learn to calculate the area of a triangle and display it.', 0, 14, 2),
(11, 'code11.txt', 'In this program, you\'ll learn to find the largest among three numbers using if else and display it.\r\n\r\nIn the program below, the three numbers are stored in num1, num2 and num3 respectively. We\'ve used the if...elif...else ladder to find the largest among the three and display it.', 0, 15, 2),
(12, 'code12.txt', 'Example to check whether an integer is a prime number or not using for loop and if...else statement. If the number is not prime, it\'s explained in output why it is not a prime number.\r\nA positive integer greater than 1 which has no other factors except 1 and the number itself is called a prime number. 2, 3, 5, 7 etc. are prime numbers as they do not have any other factors. But 6 is not prime (it is composite) since, 2 x 3 = 6.', 2, 5, 2),
(13, 'code13.txt', 'Here is source code of the C# Program to Print a Binary Triangle. The C# program is successfully compiled and executed with Microsoft Visual Studio. The program output is also shown below.', 2, 2, 2),
(14, 'code14.txt', 'In this program, you\'ll learn to find the factorial of a number using for and while loop in Java.\r\n\r\nThe factorial of a positive number n is given by:\r\n\r\nfactorial of n (n!) = 1 * 2 * 3 * 4 * ... * n\r\n', 3, 1, 2),
(15, 'code15.txt', 'In this program, you\'ll learn to check whether a given number is armstrong number or not. You\'ll learn to do this by using a for loop and a while loop in Java.\r\n\r\nA positive integer is called an Armstrong number of order n if\r\n\r\nabcd... = an + bn + cn + dn + ...\r\n\r\nIn case of an Armstrong number of 3 digits, the sum of cubes of each digits is equal to the number itself. For example:\r\n\r\n153 = 1*1*1 + 5*5*5 + 3*3*3  // 153 is an Armstrong number.\r\n', 0, 1, 4),
(16, 'code16.txt', 'In this program, you\'ll learn to convert octal number to a decimal number and vice-versa using functions in Java.\r\nWhen you run the program, the output will be:\r\n\r\n78 in decimal = 116 in octal\r\n\r\nThis conversion takes place as:\r\n\r\n8 | 78\r\n8 | 9 -- 6\r\n8 | 1 -- 1\r\n8 | 0 -- 1\r\n(116)\r\n', 0, 10, 1);

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
