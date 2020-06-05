<?php

if (isset($_GET['logout'])) {
	session_unset();
	session_destroy();
	if ($_GET['logout'] == "1") {
		echo '<script language="javascript">';
		echo 'show_toast("Successfully logged out!");';
		echo '</script>';
	} else {
		echo '<script language="javascript">';
		echo 'show_toast("Please log in!");';
		echo '</script>';
	}
}
