"use strict";

let errormsg = null;
let occ = "";

var $ = function (id) {
	return document.getElementById(id);
};

window.addEventListener('load', function () {
	$('user-name').addEventListener('focus', function () {
		$('user-name').style.color = "#fff";
		occ = "";
	});
	$('user-name').addEventListener('focusout', function () {
		occupied_un();
	});
	$('register_form').addEventListener('submit', function (e) {
		if (!checkForm()) {
			e.preventDefault();
			window.alert(errormsg);
		}
	});
});

var checkForm = function () {
	var isValid = true;
	errormsg = "";

	if (!testPassword($('password'), $('password-repeat'))) {
		isValid = false;
		$('password').style.borderColor = "#f00";
		$('password-repeat').style.borderColor = "#f00";
	} else {
		$('password').style.borderColor = "#0f0";
		$('password-repeat').style.borderColor = "#0f0";
	}

	if (!testEmail($('email'))) {
		isValid = false;
		$('email').style.borderColor = "#f00";
	} else {
		$('email').style.borderColor = "#0f0";
	}

	if (!testUserName($('user-name'))) {
		isValid = false;
		$('user-name').style.borderColor = "#f00";
	} else {
		$('user-name').style.borderColor = "#0f0";
	}

	if (!testLastName($('last-name'))) {
		isValid = false;
		$('last-name').style.borderColor = "#f00";
	} else {
		$('last-name').style.borderColor = "#0f0";
	}

	if (!testFirstName($('first-name'))) {
		isValid = false;
		$('first-name').style.borderColor = "#f00";
	} else {
		$('first-name').style.borderColor = "#0f0";
	}
	return isValid;
};

var occupied_un = function () {
	$('user-name').style.color = "#ff0";
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText == "false") {
				$('user-name').style.color = "#0f0";
				occ = "false";
			} else if (rText == "true") {
				$('user-name').style.color = "#f00";
				occ = "true";
			}
		} else {
			$('user-name').style.color = "#ff0";
			occ = "wait";
		}
	};
	xmlhttp.open("GET", "assets/php/register_p.php?un=" + $('user-name').value.trim(), true);
	xmlhttp.send();
};

var testPassword = function (password, password_repeat) {
	let rex = /^((?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9]).{5,})\S$/;
	if (password.value.trim() == '') {
		errormsg = "The password field is required!";
	} else if (password.value.trim().length < 6 || password.value.trim().length > 24) {
		errormsg = 'The password field is must minimum 6 character and maximum 24 character!';
	} else if (!rex.test(password.value.trim())) {
		errormsg = "The password format! Min 1 uppercase letter, 1 lowercase letter, and 1 number with no space!";
	} else if (password_repeat.value.trim() == '') {
		errormsg = "The password repeat field is required!";
	} else if (password_repeat.value.trim() != password.value.trim()) {
		errormsg = "The passwords must match!";
	} else {
		return true;
	}
	return false;
};

var testEmail = function (email) {
	let rex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
	if (email.value.trim() == '') {
		errormsg = "The email field is required";
	} else if (!rex.test(email.value.trim())) {
		errormsg = 'Incorrect email format';
	} else {
		return true;
	}
	return false;
};

var testUserName = function (user_name) {
	let rex = /^[a-zA-Z]+[a-zA-Z0-9]*[_]?[a-zA-Z0-9]*[a-zA-Z0-9]$/;
	if (user_name.value.trim() == '') {
		errormsg = "The user name field is required!";
	} else if (!rex.test(user_name.value.trim())) {
		errormsg = 'Incorrect user name format, \nmin 3 character, must start with a letter, only one "_" is acceptable, and don\'t end with it!';
	} else if (occ == "") {
		errormsg = "Try write user name again!";
	} else if (occ == "wait") {
		errormsg = "The server checking the username!";
	} else if (occ == "true") {
		errormsg = "The user name is occupied!";
	} else {
		return true;
	}
	return false;
};

var testLastName = function (last_name) {
	let rex = /^[A-Z][a-z]{2,}$/; // Begin with 1 uppercase letter, and continues with lowercase leters with min 3 character.
	if (last_name.value.trim() == '') {
		errormsg = "The last name field is required!";
	} else if (!rex.test(last_name.value.trim())) {
		errormsg = 'Incorrect last name format! Begin with 1 uppercase letter and continue with lowercase letters, min 3 character!';
	} else {
		return true;
	}
	return false;
};

var testFirstName = function (first_name) {
	let rex = /^[A-Z][a-z]{2,}$/; // Begin with 1 uppercase letter, and continues with lowercase leters with min 3 character.
	if (first_name.value.trim() == '') {
		errormsg = "The first name field is required!";
	} else if (!rex.test(first_name.value.trim())) {
		errormsg = 'Incorrect first name format! Begin with 1 uppercase letter and continue with lowercase letters, min 3 character!';
	} else {
		return true;
	}
	return false;
};