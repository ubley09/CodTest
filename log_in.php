<?php
session_start();
require 'assets/php/logout_p.php';
?>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Log In - CodTest</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400|Roboto:300,400,700">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto+Slab:300,400|Roboto:300,400,700">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-icons/3.0.1/iconfont/material-icons.min.css">
	<link rel="stylesheet" href="assets/css/Login-Form-Dark.css">
	<link rel="stylesheet" href="assets/css/profile.css">
	<link rel="stylesheet" href="assets/css/styles.css">
	<link rel="apple-touch-icon" sizes="152x152" href="assets/img/FavIcon/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="assets/img/FavIcon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="assets/img/FavIcon/favicon-16x16.png">
	<link rel="manifest" href="assets/img/FavIcon/site.webmanifest">
	<link rel="mask-icon" href="assets/img/FavIcon/safari-pinned-tab.svg" color="#5bbad5">
	<meta name="msapplication-TileColor" content="#da532c">
	<meta name="theme-color" content="#ffffff">
</head>

<body class="login">
	<!-- Start: Login Form Dark -->
	<div class="login-dark">
		<form method="POST" action="index.php">
			<h2 class="sr-only">Login Form</h2>
			<div class="illustration"><img src="assets/img/logo-orange.png">
				<p>codtest</p>
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="user-name" placeholder="User" autofocus required>
			</div>
			<div class="form-group">
				<input class="form-control" type="password" name="password" placeholder="Password" required>
			</div>
			<div class="form-group">
				<input class="btn btn-primary btn-block" type="submit" name="login_bt" value="LOG IN">
			</div>
			<a class="forgot" href="register.php">Don't have an account? Register here!</a>
		</form>
	</div>

	<?php
	require 'assets/php/register_p.php';
	require 'assets/php/login_p.php'; // login error
	?>

	<!-- End: Login Form Dark -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

</body>

</html>