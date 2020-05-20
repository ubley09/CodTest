"use strict";

let errormsg = null;

var $ = function (id) {
	return document.getElementById(id);
};
window.addEventListener('load', function () {
	$('sortContests_form').addEventListener('submit', function (e) {
		if (!checkForm()) {
			e.preventDefault();
			window.alert(errormsg);
		}
	});
});

var checkForm = function () {
	var isValid = true;
	errormsg = "";
	if (!testDifficulty($('sort-difficulty'))) {
		isValid = false;
		$('sort-difficulty').style.borderColor = "#f00";
	} else {
		$('sort-difficulty').style.borderColor = "#0f0";
	}
	if (!testLanguage($('sort-language'))) {
		isValid = false;
		$('sort-language').style.borderColor = "#f00";
	} else {
		$('sort-language').style.borderColor = "#0f0";
	}
	return isValid;
};

var testDifficulty = function (difficulty) {
	if (difficulty.value != "Easy" && difficulty.value != "Normal" && difficulty.value != "Hard"){
		errormsg = "Must choose a difficulty!";
	} else {
		return true;
	}
	return false;
};

var testLanguage = function (language) {
	if (language.value != "Java" && language.value != "C#" && language.value != "Python"){
		errormsg = "Must choose a programming language!";
	} else {
		return true;
	}
	return false;
};
