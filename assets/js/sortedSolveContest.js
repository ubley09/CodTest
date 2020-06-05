"use strict";

let errormsg = null;
let i = 0;
let arrLength = sortedContests.length;

jQuery(document).ready(function () {
	if (arrLength == 1) {
		changeTooltip(false);
	}
});

let $ = function (id) {
	return document.getElementById(id);
};


window.addEventListener('load', function () {
	if (arrLength == 0) {
		window.location.href = 'solve_contests.php?end=2';
	} else if (arrLength == 1) {
		showContest(i);
		$('icon').innerHTML = "check";
	} else {
		showContest(i);
	}
	$('next-contest').addEventListener('click', function (e) {
		e.preventDefault();
		nextContest();
	});
	$('solution_form').addEventListener('submit', function (e) {
		e.preventDefault();
		if (!checkForm()) {
			show_toast(errormsg);
		} else {
			sendSolution();
		}
	});
});

function nextContest() {
	$('solution_form').reset();
	$('file-label-text').innerHTML = "Select your file...";
	$('user_group_label').style.borderColor = "#d8a15a";
	$('sbutton').value = "UPLOAD";
	i++;
	if (i < arrLength - 1) {
		showContest(i);
	} else if (i < arrLength) {
		showContest(i);
		$('icon').innerHTML = "check";
		changeTooltip(true);
	} else {
		window.location.href = 'solve_contests.php?end=1';
	}
}

function showContest(i) {
	$('contest-id').value = sortedContests[i].id_contest;
	$('contest-title').innerHTML = sortedContests[i].title;
	$('contest-description').innerHTML = sortedContests[i].description;
	$('contest-language').innerHTML = sortedContests[i].language;
	$('contest-diffculty').innerHTML = sortedContests[i].difficulty;
}

function changeTooltip(isShow) {
	if (isShow) {
		jQuery('#icon').attr('data-original-title', 'Done').tooltip('show');
	} else {
		jQuery('#icon').attr('data-original-title', 'Done').tooltip('hide');
	}
}

var checkForm = function () {
	var isValid = true;
	errormsg = "";
	if (!testFile($('user_group_logo'))) {
		isValid = false;
		$('user_group_label').style.borderColor = "#f00";
	} else {
		$('user_group_label').style.borderColor = "#0f0";
	}
	return isValid;
};

var testFile = function (file) {
	if (file.value.trim() == "") {
		errormsg = "Must choose a file!";
	} else {
		return true;
	}
	return false;
};

var sendSolution = function () {
	var form = document.getElementById('solution_form');
	var formData = new FormData(form);

	$('user_group_label').style.borderColor = "#ff0";
	$('sbutton').value = "WAIT";
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText == "OK") {
				nextContest();
				show_toast("Solution successfully send!");
			} else {
				show_toast(rText);
				$('user_group_label').style.borderColor = "#f00";
				$('sbutton').value = "UPLOAD";
			}
		}
	};
	xmlhttp.open("POST", "assets/php/solve_contests_p.php", true);
	xmlhttp.send(formData);
};
