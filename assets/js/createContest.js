"use strict";

let errormsg = null;

var $ = function (id) {
	return document.getElementById(id);
};
window.addEventListener('load', function () {
	$('createContest_form').addEventListener('submit', function (e) {
		if (!checkForm()) {
			e.preventDefault();
			window.alert(errormsg);
		}
	});
});

var checkForm = function () {
	var isValid = true;
	errormsg = "";
	if (!testDifficulty($('create-difficulty'))) {
		isValid = false;
		$('create-difficulty').style.borderColor = "#f00";
	} else {
		$('create-difficulty').style.borderColor = "#0f0";
	}
	if (!testLanguage($('create-language'))) {
		isValid = false;
		$('create-language').style.borderColor = "#f00";
	} else {
		$('create-language').style.borderColor = "#0f0";
	}
	if (!testDescription($('write-description'))) {
		isValid = false;
		$('write-description').style.borderColor = "#f00";
	} else {
		$('write-description').style.borderColor = "#0f0";
	}
	if (!testTitle($('write-title'))) {
		isValid = false;
		$('write-title').style.borderWidth = "1px";
		$('write-title').style.borderStyle = "solid";
		$('write-title').style.borderColor = "#f00";
	} else {
		$('write-title').style.borderWidth = "1px";
		$('write-title').style.borderStyle = "solid";
		$('write-title').style.borderColor = "#0f0";
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
var testDescription = function (description) {
	if (description.value.trim().length > 1024){
		errormsg = "The description is max 1024 length!";
	} else {
		return true;
	}
	return false;
};
var testTitle = function (title) {
	let rex = /^[A-Za-z0-9(][A-Za-z0-9 ,)(]+[A-Za-z0-9)]$/;
	if (title.value.trim() == '') {
		errormsg = "The title field is required!";
	}else if (title.value.trim().length > 40 || title.value.trim().length < 4){
		errormsg = "The title is max 40 length and min 4!";
	}else if (!rex.test(title.value.trim())) {
		errormsg = 'Incorrect title format!';
	} else {
		return true;
	}
	return false;
};
