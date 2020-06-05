<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Register - CodTest</title>
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
	<div id="snackbar">Some text some message..</div>
	<script src="assets/js/toast.js"></script>
	<!-- Start: Login Form Dark -->
	<div class="login-dark">
		<form method="POST" action="log_in.php" id="register_form">
			<h2 class="sr-only">Login Form</h2>
			<div class="illustration"><img src="assets/img/logo-orange.png">
				<p>codtest</p>
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="first-name" id="first-name" placeholder="First name" autocomplete="off" autofocus>
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="last-name" id="last-name" placeholder="Last name" autocomplete="off">
			</div>
			<div class="form-group">
				<input class="form-control" type="text" name="user-name" id="user-name" placeholder="User name" autocomplete="off">
			</div>
			<div class="form-group">
				<input class="form-control" type="email" name="email" id="email" placeholder="E-mail" autocomplete="off">
			</div>
			<div class="form-group">
				<input class="form-control" type="password" name="password" id="password" placeholder="Password" autocomplete="off">
			</div>
			<div class="form-group">
				<input class="form-control" type="password" name="password-repeat" id="password-repeat" placeholder="Password repeat" autocomplete="off">
			</div>
			<div class="form-group">
				<input class="btn btn-primary btn-block" type="submit" value="REGISTER" name="register_bt">
			</div>
			<a class="forgot" href="log_in.php">Already registered? Log in here!</a>
		</form>
	</div>
	<!-- End: Login Form Dark -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

	<script src="assets/js/register.js"></script>
</body>

</html>