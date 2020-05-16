<?php
require_once "db_config.php";


if (isset($_POST["login_bt"])) {
	if (logIn($connection, $_POST['user-name'], $_POST['password'])) {
	} else {
		header('Location: log_in.php?err=1');
		exit();
	}
}else if(isset($_GET['err'])){
		echo '<script language="javascript">';
		echo 'alert("Wrong user name or password!")';
		echo '</script>';
}

function logIn($connection, $user_name, $password)
{
	define("SALT1", "X48z2dWpTSSm");
	define("SALT2", "GB7tgL5GpLFS3jD");
	$password = sha1(SALT1 . $password . SALT2);

	$sql = "SELECT * FROM users WHERE username = '$user_name'";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	
	if ($record['password'] == $password){
		$_SESSION['id_user'] = $record['id_user'];
		$_SESSION['username'] = $record['username'];
		$GLOBALS['last_id'] = $record['id_user'];
		return true;
	}else{
		return false;
	}
}
