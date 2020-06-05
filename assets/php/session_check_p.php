<?php

if (!isset($_SESSION['id_user']) || empty($_SESSION['id_user'])) {
	session_unset();
	session_destroy();
	header('Location: log_in.php?logout=2');
	exit();
}
