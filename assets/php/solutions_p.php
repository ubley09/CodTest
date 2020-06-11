<?php
require_once "db_config.php";


function showUserContest($connection, $idUser, $idContest)
{
	$sql = "SELECT *
			FROM contests
			WHERE id_user = $idUser AND id_contest = $idContest";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);
	if (empty($record)) {
		return false;
	}
	$isclosed = $record['isclosed'] == 1 ? "checked" : "";
	echo "		<div id=\"sorted-contest-descript\" class=\"description\">
					<h1>{$record['title']}</h1>
					<p>{$record['description']}</p>
					<p>{$record['language']} / {$record['difficulty']}</p>
					<p id=\"contest-id\" hidden>{$record['id_contest']}</p>
				</div>
				<label class=\"switch\">
  				<input type=\"checkbox\" {$isclosed} id=\"isclosed-cb\">
 			 	<span class=\"slider round\"></span>
				</label>
			";
	return true;
}

if (isset($_GET['cc'])) {
	session_start();
	$idUser = $_SESSION['id_user'];
	$idContest = $_GET['cc'];
	$sql = "SELECT solutions.id_solution, solutions.solution_state, users.firstname, users.lastname, ratings.likes, ratings.dislikes
			FROM contests
			JOIN solutions ON solutions.id_contest = contests.id_contest
			JOIN users ON users.id_user = solutions.id_user
			JOIN ratings ON ratings.id_user = solutions.id_user
			WHERE contests.id_user = $idUser AND contests.id_contest = $idContest";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$solutionArr = mysqli_fetch_all($result, MYSQLI_ASSOC);
	exit(json_encode($solutionArr));
}
if (isset($_GET['ss'])) {
	$sql = "CALL change_solution_state({$_GET['ss']})";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	if ($record['state'] == 2) {
		$target_dir = "../files/";
		unlink($target_dir . "code" . $_GET['ss'] . ".txt");
	}
	exit($record['state']);
}
if (isset($_GET['ic'])) {
	session_start();
	$sql = "UPDATE contests
			SET isclosed = NOT isclosed
			WHERE id_user = {$_SESSION['id_user']} AND id_contest = {$_GET['ci']}";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	exit("OK");
}
