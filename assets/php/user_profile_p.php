<?php
require_once "db_config.php";

$sql = "SELECT users.id_user, users.username, users.firstname, users.lastname, users.email, ratings.likes, ratings.dislikes FROM users
		JOIN ratings ON users.id_user = ratings.id_user
		WHERE users.id_user = {$_SESSION['id_user']}";
$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
$record = mysqli_fetch_array($result, MYSQLI_ASSOC);



