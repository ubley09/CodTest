<?php
require_once "db_config.php";


if (isset($_GET['rate'])) {
	$rate = 0;
	if ($_GET['rate'] == "like") {
		$rate = 3;
	} else {
		$rate = 2;
	}
	$sql = "CALL solution_check({$_GET['sid']}, {$rate})";
	$result = mysqli_query($connection, $sql) or die(mysqli_error($connection));
	exit("OK");
}

if (isset($_GET['dfile'])) {
	$file = $_GET['dfile'];
	$target_dir = "../files/";
	header('Content-Description: File Transfer');
	header('Content-Type: application/octet-stream');
	header('Content-Disposition: attachment; filename="solution.txt"');
	header('Expires: 0');
	header('Cache-Control: must-revalidate');
	header('Pragma: public');
	header('Content-Length: ' . filesize($target_dir . basename($file)));
	header("Content-Transfer-Encoding: binary\n");
	readfile($target_dir . basename($file));
	exit();
}
