<?php

if (isset($_GET['endsolution'])) {
	if ($_GET['endsolution'] == 2) {
		echo '<script language="javascript">';
		echo 'show_toast("There is currently no solution to check!");';
		echo '</script>';
	} else if ($_GET['endsolution'] == 1) {
		echo '<script language="javascript">';
		echo 'show_toast("There is no more solution to check!");';
		echo '</script>';
	}
} else if (isset($_GET['nocontest'])) {
	if ($_GET['nocontest'] == 1) {
		echo '<script language="javascript">';
		echo 'show_toast("There is no contest!");';
		echo '</script>';
	}
} else if (isset($_GET['nosolution'])) {
	if ($_GET['nosolution'] == 1) {
		echo '<script language="javascript">';
		echo 'show_toast("There is no contest!");';
		echo '</script>';
	}
}
