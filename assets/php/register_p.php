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
if (isset($_GET['token'])) {
	if (emailVerification($connection, $_GET['token'])) {
		echo '<script language="javascript">';
		echo 'show_toast("Your account is successfully activated!");';
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
		$encPassword = sha1(SALT1 . $password . SALT2);

		$sql = "SELECT id_user FROM users ORDER BY id_user DESC LIMIT 1";
		$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
		$record = mysqli_fetch_array($result, MYSQLI_ASSOC);
		$token = sha1($record['id_user'] + 1 . generateRandomString(40));

		$sql = "CALL new_user(\"$user_name\", \"$encPassword\", \"$first_name\", \"$last_name\", \"$email\", \"$token\")";
		if (mysqli_query($connection, $sql)) {
			if (!sendEmail($email, $token, $user_name, $password)) {
				return false;
			}
			return true;
		} else {
			die("Error: " . mysqli_error($connection));
			return false;
		}
	} else {
		return false;
	}
}

function sendEmail($email, $token, $user_name, $password)
{
	$to = $email; // Send email to our user
	$subject = 'Signup | Verification'; // Give the email a subject 
	$message = '
 
Thanks for signing up!
Your account has been created, you can login with the following credentials after you have activated your account by pressing the url below.
 
------------------------
Username: ' . $user_name . '
Password: ' . $password . '
------------------------
 
Please click this link to activate your account:
http://localhost/HTML/CodTest/log_in.php?token=' . $token . '
 
'; // Our message above including the link

	$headers = 'From:noreply@codtest.com' . "\r\n"; // Set from headers
	if (mail($to, $subject, $message, $headers)) // Send our email
		return true;
	return false;
}

function emailVerification($connection, $token)
{
	$sql = "SELECT token, verified FROM users WHERE token = '$token' AND verified = 0";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$record = mysqli_fetch_array($result, MYSQLI_ASSOC);

	if (empty($record)) {
		return false;
	}

	$sql = "UPDATE users
			SET verified = 1
			WHERE token = \"$token\"";
	if (mysqli_query($connection, $sql)) {
		return true;
	}
	return false;
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

function generateRandomString($length = 10)
{
	$characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
	$charactersLength = strlen($characters);
	$randomString = '';
	for ($i = 0; $i < $length; $i++) {
		$randomString .= $characters[rand(0, $charactersLength - 1)];
	}
	return $randomString;
}
