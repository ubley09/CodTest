<?php
require_once "db_config.php";


if (isset($_POST['contest-id'])) {
	session_start();
	if (insertSolutionToSql($connection, $_POST['contest-id'], $_POST['Comment'], $_SESSION['id_user'])) {
		exit("OK");
	} else {
		exit("ERROR");
	}
}
if (isset($_GET['sortContest_bt'])) {
	$rngContestArr = rngSortContests($connection, $_GET['sort-language'], $_GET['sort-difficulty'], $_SESSION['id_user']);
} else {
	header('Location: solve_contests.php');
	exit();
}

function rngSortContests($connection, $language, $difficulty, $user)
{
	$sql = "SELECT id_contest, title, description, language, difficulty, isclosed, id_user
			FROM contests
			WHERE language = \"$language\" AND difficulty = \"$difficulty\" AND isclosed = 0 AND id_user != {$user} AND id_contest NOT IN(
				SELECT contests.id_contest
				FROM contests
				LEFT JOIN solutions ON solutions.id_contest = contests.id_contest
				WHERE solutions.id_user = {$user})
			ORDER BY RAND()";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_all($result, MYSQLI_ASSOC);

	return $record;
}

function insertSolutionToSql($connection, $id_contest, $description, $user)
{
	$target_dir = "../files/";
	$target_file = $target_dir . basename($_FILES["user_group_logo"]["name"]);
	$uploadOk = 1;
	$txtFileType = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));

	if ($_FILES["user_group_logo"]["size"] > 100000) {
		exit("TOO BIG FILE:" . strval($_FILES["user_group_logo"]["size"]) . "B");
		$uploadOk = 0;
	}

	// Allow certain file formats
	if (
		$txtFileType != "txt" && $txtFileType != "cs" && $txtFileType != "py" && $txtFileType != "java"
	) {
		exit("BAD FILE TYPE");
		$uploadOk = 0;
	}

	// Check if $uploadOk is set to 0 by an error
	if ($uploadOk == 0) {
		return false;
	} else {
		$sql = "CALL insert_solution(\"{$description}\", {$id_contest}, {$user})";
		$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
		$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

		if (move_uploaded_file($_FILES["user_group_logo"]["tmp_name"], $target_dir . $record['solution'])) {
			return true;
		} else {
			return false;
		}
	}
}
