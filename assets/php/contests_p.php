<?php
require_once "db_config.php";

if (isset($_POST['addContest_bt'])) {

	if (insertNewContestToSql($connection, trim($_POST['cTitle']), trim($_POST['cDescription']), $_POST['cLanguage'], $_POST['cDifficulty'])) {
		echo '<script language="javascript">';
		echo 'alert("Successfully added the contest!")';
		echo '</script>';
	} else {
		echo '<script language="javascript">';
		echo 'alert("Something wrong!")';
		echo '</script>';
	}
}

if (!showUserContests($connection, $_SESSION['id_user'])) {
	echo '<script language="javascript">';
	echo 'alert("Something wrong!")';
	echo '</script>';
}




function showUserContests($connection, $idUser)
{
	$sql = "SELECT contests.*, COUNT(solutions.id_contest) AS \"solutions\"
			FROM contests
			LEFT JOIN solutions ON contests.id_contest = solutions.id_contest
			WHERE contests.id_user = $idUser
			GROUP BY contests.id_contest";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	while ($record = mysqli_fetch_array($result, MYSQLI_ASSOC)) {
		echo "	<div class=\"col-sm-12 col-md-6 col-lg-6 col-xl-4\">
					<div class=\"small-description\">
						<h1>{$record['title']}</h1>
						<p>{$record['description']}</p>
					</div>
					<div class=\"d-flex justify-content-between small-description-details\">
						<p>{$record['language']}</p>
						<a data-toggle=\"tooltip\" data-bs-tooltip=\"\" href=\"solutions.php?c={$record['id_contest']}\" title=\"Number of Solutions\">{$record['solutions']}</a>
						<p>{$record['difficulty']}</p>
					</div>
				</div>";
	}
	return true;
}

function insertNewContestToSql($connection, $title, $description, $language, $difficulty)
{
	$sql = "INSERT INTO contests (id_contest, title, description, language, difficulty, isclosed, id_user)
	VALUES (NULL, \"$title\", \"$description\", \"$language\", \"$difficulty\", 0, {$_SESSION['id_user']})";
	if (mysqli_query($connection, $sql)) {
	} else {
		die("Error: " . mysqli_error($connection));
		return false;
	}
	return true;
}
