<?php
require_once "db_config.php";

if (isset($_POST['solution_bt'])) {
	if (insertSolutionToSql($connection, $_POST['contest-id'], $_POST['user_group_logo'], $_POST['Comment'], $_SESSION['id_user'])) {
	} else {
		echo '<script language="javascript">';
		echo 'alert("Error!")';
		echo '</script>';
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

function insertSolutionToSql($connection, $id_contest, $solution, $description, $user)
{
	$sql = "INSERT INTO solutions (id_solution, solution, solution_description, isgood, checked, id_contest, id_user)
	VALUES (NULL, \"$solution\", \"$description\", 0, 0, $id_contest, \"$user\")";
	if (mysqli_query($connection, $sql)) {
	} else {
		die("Error: " . mysqli_error($connection));
		return false;
	}
	return true;
}
