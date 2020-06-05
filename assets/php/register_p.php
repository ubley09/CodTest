<?php
require_once "db_config.php";


if (isset($_POST["register_bt"])) {

	if (insertNewUserToSql($connection, trim($_POST["first-name"]), trim($_POST["last-name"]), trim($_POST["user-name"]), trim($_POST["email"]), trim($_POST["password"]))) {
		echo '<script language="javascript">';
		echo 'show_toast("Successfully registered!");';
		echo '</script>';
	} else {
		echo '<script language="javascript">';
		echo 'show_toast("Something wrong!");';
		echo '</script>';
	}
}
if (isset($_GET["un"])) {
	if (occ_username($connection, $_GET["un"])) {
		echo "true";
	} else {
		echo "false";
	}
}

function insertNewUserToSql($connection, $first_name, $last_name, $user_name, $email, $password)
{
	if (!occ_username($connection, $user_name)) {
		define("SALT1", "X48z2dWpTSSm");
		define("SALT2", "GB7tgL5GpLFS3jD");
		$password = sha1(SALT1 . $password . SALT2);
		$sql = "CALL new_user(\"$user_name\", \"$password\", \"$first_name\", \"$last_name\", \"$email\")";
		if (mysqli_query($connection, $sql)) {
			return true;
		} else {
			die("Error: " . mysqli_error($connection));
			return false;
		}
	} else {
		return false;
	}
}

function occ_username($connection, string $user_name)
{
	$sql = "SELECT * FROM users WHERE username = '$user_name'";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	if (isset($record)) {
		return true;
	} else {
		return false;
	}
}
