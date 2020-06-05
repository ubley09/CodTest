<?php
session_start();
require 'assets/php/session_check_p.php';
?>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>My Contests - CodTest</title>
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

<body>
	<div id="snackbar">Some text some message..</div>
	<script src="assets/js/toast.js"></script>
	<nav class="navbar navbar-light navbar-expand-md fixed-top">
		<div class="container-fluid">
			<a class="navbar-brand" data-toggle="tooltip" data-bs-tooltip="" href="index.php" title="Home">
				<div></div>
			</a><button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1">
				<span class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
			<div class="collapse navbar-collapse" id="navcol-1">
				<ul class="nav navbar-nav flex-grow-1 justify-content-start">
					<li class="nav-item" role="presentation"><a class="nav-link" href="create_contest.php">CREATE CONTEST</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link" href="solve_contests.php">SOLVE CONTESTS</a></li>
					<li class="nav-item" role="presentation"><a class="nav-link active">MY CONTESTS</a></li>
					<li class="nav-item no-right-border" role="presentation"><a class="nav-link" href="check_solutions.php">CHECK SOLUTIONS</a></li>
				</ul>
				<ul class="nav navbar-nav flex-grow-1 justify-content-end">
					<li class="nav-item" role="presentation">
						<a class="nav-link" data-toggle="tooltip" data-bs-tooltip="" href="user_profile.php" title="User Profile">
							<span id="user-name"><?php echo $_SESSION['username']; ?></span> <!-- SESSION USERNAME -->
							<i class="fa fa-user user-profile"></i>
						</a>
					</li>
					<li class="nav-item no-right-border" role="presentation">
						<a class="nav-link" href="log_in.php?logout=1">LOG OUT</a> <!-- LOGOUT -->
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container d-flex flex-column container-large" id="my-contests-list">
		<div class="row">
			<!-- SQL DATABASE OUTPUT -->
			<!-- <div class="col-sm-12 col-md-6 col-lg-6 col-xl-4">
				<div class="small-description">
					<h1>My created contest title</h1>
					<p>My created contest descriptions. My created contest descriptions. My created contest
						descriptions. My created contest descriptions. My created contest descriptions. My created
						contest descriptions. My
						created contest descriptions. My created contest descriptions. My created contest descriptions.
						My created contest descriptions. My created contest descriptions. My created contest
						descriptions. My
						created contest descriptions. My created contest descriptions. My created contest descriptions.
						My created contest descriptions. My created contest descriptions. My created contest
						descriptions. My
						created contest descriptions. My created contest descriptions. My created contest descriptions.
						My created contest descriptions. My created contest descriptions. My created contest
						descriptions. My
						created contest descriptions. My created contest descriptions. </p>
				</div>
				<div class="d-flex justify-content-between small-description-details">
					<p>Java</p><a data-toggle="tooltip" data-bs-tooltip="" href="solutions.php" title="Number of Solutions">0</a>
					<p>Hard</p>
				</div>
			</div> -->
			<!-- SQL DATABASE OUTPUT -->

			<?php require 'assets/php/contests_p.php'; ?>

		</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script src="assets/js/bs-init.js"></script>
</body>

</html>