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
		$('solution_form').reset();
		$('file-label-text').innerHTML = "Select your file...";
		$('user_group_label').style.borderColor = "#d8a15a";
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
	});
	$('solution_form').addEventListener('submit', function (e) {
		if (!checkForm()) {
			e.preventDefault();
			window.alert(errormsg);
		}
	});
});

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
	if (file.value.trim() == ""){
		errormsg = "Must choose a file!";
	} else {
		return true;
	}
	return false;
};