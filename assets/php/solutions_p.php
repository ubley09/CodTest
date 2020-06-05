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
	while ($record = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
		echo "	<form action=\"best_solution.php\" method=\"GET\" id=\"form_{$record['id_solution']}\">
				<div class=\"d-flex d-xl-flex flex-column justify-content-between flex-lg-row align-items-lg-center flex-xl-row align-items-xl-center rating solutions\">
					<p data-toggle=\"tooltip\" data-bs-tooltip=\"\" data-placement=\"left\" id=\"full-name\" title=\"Name\">{$record['firstname']} {$record['lastname']}</p>
					<p data-toggle=\"tooltip\" data-bs-tooltip=\"\" data-placement=\"left\" title=\"Like\">{$record['likes']}</p>
					<p data-toggle=\"tooltip\" data-bs-tooltip=\"\" data-placement=\"left\" title=\"Dislike\">{$record['dislikes']}</p>
					<input type=\"hidden\" name=\"solution_state\" id=\"ss_{$record['id_solution']}\" value=\"{$record['solution_state']}\">
					<button class=\"btn btn-primary\" type=\"submit\" name=\"s\" value=\"{$record['id_solution']}\">CHECK THIS</button>
				</div>
				</form>";
	}

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
