<?php
session_start();
require 'assets/php/session_check_p.php';
require_once 'assets/php/db_config.php';
?>
<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
	<title>Check Solutions - CodTest</title>
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
					<li class="nav-item" role="presentation"><a class="nav-link" href="my_contests.php">MY CONTESTS</a></li>
					<li class="nav-item no-right-border" role="presentation"><a class="nav-link active">CHECK SOLUTIONS</a></li>
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
	<div id="next-solution" class="next"><a href="" title="Next solution" id="next-solution">
		<i class="material-icons arrow-right" data-toggle="tooltip" data-bs-tooltip="" title="Next solution" id="icon">keyboard_arrow_right</i>
	</a></div>
	<div class="container d-flex flex-column container-big" id="solutions">
		<div class="row">
			<div class="col-lg-12">
				<div id="solution-description" class="description">
					<h1 id="contest-title"></h1>
					<p id="contest-description"></p>
					<p><span id="contest-language"></span> / <span id="contest-difficulty"></span></p>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-8">
				<p style="margin-bottom: 10px;">Rate solution user</p>
				<div class="d-flex d-xl-flex flex-row justify-content-between align-items-xl-center rating">
					<p id="solution-user"></p>
					<a href="" id="like"><i class="fa fa-thumbs-up rating-icon"></i></a>
					<a href="" id="dislike"><i class="fa fa-thumbs-down rating-icon"></i></a>
				</div>
			</div>
			<div class="col-md-4 d-flex flex-column align-items-md-end">
				<p style="margin-bottom: 10px;">Download solution</p>
				<button class="btn btn-primary btn-block" type="button" id="download-button">DOWNLOAD</button>
			</div>
		</div>
	</div>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
	<script src="assets/js/bs-init.js"></script>
	<?php
	$sql = "SELECT
		solutions.id_solution, solutions.solution, contests.title, contests.description, contests.language, contests.difficulty, users.firstname, users.lastname
		FROM solutions
		JOIN contests ON contests.id_contest = solutions.id_contest
		JOIN users ON users.id_user = solutions.id_user
		WHERE solutions.solution_state = 1 AND contests.isclosed = 0 AND solutions.id_user != {$_SESSION['id_user']} AND contests.id_user != {$_SESSION['id_user']}
		ORDER BY RAND()";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	$rngSolutiontArr = mysqli_fetch_all($result, MYSQLI_ASSOC);
	?>
	<script>
		var sortedSolutions = <?php echo json_encode($rngSolutiontArr); ?>;
	</script>
	<script src="assets/js/checkSolutions.js"></script>

</body>

</html>