"use strict";

let errormsg = null;
let i = 0;
let arrLength = sortedSolutions.length;

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
		window.location.href = 'index.php?endsolution=2';
	} else if (arrLength == 1) {
		showSolution(i);
		$('icon').innerHTML = "check";
	} else {
		showSolution(i);
	}
	$('next-solution').addEventListener('click', function (e) {
		e.preventDefault();
		nextSolution();
	});
	$('like').addEventListener('click', function (e) {
		e.preventDefault();
		sendSolutionCheck("like");
	});
	$('dislike').addEventListener('click', function (e) {
		e.preventDefault();
		sendSolutionCheck("dislike");
	});
	$('download-button').addEventListener('click', function (e) {
		e.preventDefault();
		downloadCode(sortedSolutions[i].solution);
	});
});

function nextSolution() {
	i++;
	if (i < arrLength - 1) {
		showSolution(i);
	} else if (i < arrLength) {
		showSolution(i);
		$('icon').innerHTML = "check";
		changeTooltip(true);
	} else {
		window.location.href = 'index.php?endsolution=1';
	}
}

function showSolution(i) {
	$('contest-title').innerHTML = sortedSolutions[i].title;
	$('contest-description').innerHTML = sortedSolutions[i].description;
	$('contest-language').innerHTML = sortedSolutions[i].language;
	$('contest-difficulty').innerHTML = sortedSolutions[i].difficulty;
	$('solution-user').innerHTML = sortedSolutions[i].firstname + " " + sortedSolutions[i].lastname;
}

function changeTooltip(isShow) {
	if (isShow) {
		jQuery('#icon').attr('data-original-title', 'Done').tooltip('show');
	} else {
		jQuery('#icon').attr('data-original-title', 'Done').tooltip('hide');
	}
}

var sendSolutionCheck = function (checkValue) {
	if (checkValue == "like") {
		$(checkValue).color = "#0f0";
	} else if (checkValue == "dislike") {
		$(checkValue).color = "#f00";
	}
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText == "OK") {
				nextSolution();
				show_toast("Solution rate successfully send!");
				$(checkValue).color = "#ccae86";
			} else {
				show_toast("ERROR: " + rText);
				$(checkValue).color = "#ccae86";
			}
		}
	};
	xmlhttp.open("GET", "assets/php/check_solutions_p.php?rate=" + checkValue + "&sid=" + sortedSolutions[i].id_solution, true);
	xmlhttp.send();
};

var downloadCode = function (file) {
	window.location.href = "assets/php/check_solutions_p.php?dfile=" + file;
};

