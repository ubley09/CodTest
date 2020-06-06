<?php
require_once "db_config.php";


function showUserContest($connection, $idUser, $idContest)
{
	$sql = "SELECT *
			FROM contests
			WHERE id_user = $idUser AND id_contest = $idContest";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);
	echo "	<div class=\"col\">
				<div id=\"sorted-contest-descript\" class=\"description\">
					<h1>{$record['title']}</h1>
					<p>{$record['description']}</p>
					<p>{$record['language']} / {$record['difficulty']}</p>
					<p id=\"contest-id\" hidden>{$record['id_contest']}</p>
				</div>
			</div>";

	return true;
}

function showContestSolutions($connection, $idUser, $idContest)
{
	$sql = "SELECT solutions.id_solution, solutions.solution_state, users.firstname, users.lastname, ratings.likes, ratings.dislikes
			FROM contests
			JOIN solutions ON solutions.id_contest = contests.id_contest
			JOIN users ON users.id_user = solutions.id_user
			JOIN ratings ON ratings.id_user = solutions.id_user
			WHERE contests.id_user = $idUser AND contests.id_contest = $idContest";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$solutionArr = mysqli_fetch_all($result, MYSQLI_ASSOC);
	
	exit(json_encode($solutionArr));
	return true;
}
if (isset($_GET['cc'])) {
	session_start();
	if (!showContestSolutions($connection, $_SESSION['id_user'], $_GET['cc'])) {
		echo '<script language="javascript">';
		echo 'show_toast("Something wrong!");';
		echo '</script>';
	}

}
if (isset($_GET['ss'])) {
	$sql = "CALL change_solution_state({$_GET['ss']})";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	if ($record['state'] == 2) {
		$target_dir = "../files/";
		unlink($target_dir."code".$_GET['ss'].".txt");
	}

	exit($record['state']);
}
