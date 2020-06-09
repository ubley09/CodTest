<?php
require_once "db_config.php";

if (isset($_POST["login_bt"])) {
	$loginReturnCode = logIn($connection, mysqli_real_escape_string($connection, $_POST['user-name']), mysqli_real_escape_string($connection, $_POST['password']));
	if ($loginReturnCode == 0) {
		echo '<script language="javascript">';
		echo 'show_toast("Successfully logged in!");';
		echo '</script>';
	} else if ($loginReturnCode == 1) {
		header('Location: log_in.php?err=1');
		exit();
	} else if ($loginReturnCode == 2) {
		header('Location: log_in.php?err=2');
		exit();
	}
} else if (isset($_GET['err'])) {
	if ($_GET['err'] == 1) {
		echo '<script language="javascript">';
		echo 'show_toast("Wrong username or password!");';
		echo '</script>';
	} else if ($_GET['err'] == 2) {
		echo '<script language="javascript">';
		echo 'show_toast("Your e-mail is not verified!");';
		echo '</script>';
	}
}

function logIn($connection, $user_name, $password)
{
	define("SALT1", "X48z2dWpTSSm");
	define("SALT2", "GB7tgL5GpLFS3jD");
	$password = sha1(SALT1 . $password . SALT2);

	$sql = "SELECT * FROM users WHERE username = '$user_name'";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	if ($record['password'] == $password) {
		if ($record['verified'] == "0") {
			return 2;
		}
		$_SESSION['id_user'] = $record['id_user'];
		$_SESSION['username'] = $record['username'];
		return 0; //"OK"
	} else {
		return 1;
	}
}
