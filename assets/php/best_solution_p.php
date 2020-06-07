<?php
require_once "db_config.php";


function selectSolution($connection, $id_solution_p)
{
	$sql = "SELECT users.firstname, users.lastname, solutions.solution, solutions.solution_description, contests.language, contests.difficulty
		FROM solutions
		JOIN contests ON contests.id_contest = solutions.id_contest
		JOIN users ON users.id_user = solutions.id_user
		WHERE solutions.id_solution = {$id_solution_p} AND solutions.solution_state = 3
		AND contests.id_user = {$_SESSION['id_user']}";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);
	if (empty($record)) {
		return false;
	}
	echo "
	<h2>{$record['firstname']} {$record['lastname']} solution description:</h2>
	<p>{$record['solution_description']}</p>
	<p>{$record['language']} / {$record['difficulty']}</p>
	";
	$GLOBALS['file'] = $record['solution'];
	return true;
}

function printFile()
{
	$target_dir = "assets/files/";
	$fullpath = $target_dir . basename($GLOBALS['file']);
	$text = htmlspecialchars(file_get_contents($fullpath));
	$text = nl2br($text);
	echo $text;
	exit();
}
