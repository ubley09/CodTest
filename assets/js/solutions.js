"use strict";

var $ = function (id) {
	return document.getElementById(id);
};

let forms;
let timer;

window.addEventListener('load', function () {
	solutionsRefresh();
});

var loadSolutions = function () {
	forms = document.querySelectorAll("form");
	change_formStyle(-1);
	for (let i = 0; i < forms.length; i++) {
		forms[i].addEventListener('submit', function (e) {
			window.clearTimeout(timer);
			switch (forms[i][0].value) {
				case "0":
					e.preventDefault();
					solutionStatechange(i);
					break;
				case "1":
					e.preventDefault();
					solutionStatechange(i);
					break;
				case "2":
					e.preventDefault();
					solutionStatechange(i);
					break;
				case "3":
					break;
				default:
					e.preventDefault();
					console.warn("ERROR");
					break;
			}
		});
	}
	timer = window.setTimeout(solutionsRefresh, 3000);
};

var change_formStyle = function (id) {
	if (id == -1) {
		for (let i = 0; i < forms.length; i++) {
			switch (forms[i][0].value) {
				case "0":
					forms[i][1].innerHTML = "CHECK THIS";
					forms[i][1].style.backgroundColor = "#d8a15a";
					break;
				case "1":
					forms[i][1].innerHTML = "CHECKING";
					forms[i][1].style.backgroundColor = "#d8a15a";
					break;
				case "2":
					forms[i][1].innerHTML = "REMOVE";
					forms[i][1].style.backgroundColor = "#f00";
					break;
				case "3":
					forms[i][1].innerHTML = "VIEW";
					forms[i][1].style.backgroundColor = "#0f0";
					break;
				default:
					console.warn("ERROR");
					console.warn(forms[i]);
					break;
			}
		}
	} else {
		switch (forms[id][0].value) {
			case "0":
				forms[id][1].innerHTML = "CHECK THIS";
				forms[id][1].style.backgroundColor = "#d8a15a";
				break;
			case "1":
				forms[id][1].innerHTML = "CHECKING";
				forms[id][1].style.backgroundColor = "#d8a15a";
				break;
			case "2":
				forms[id][1].innerHTML = "REMOVE";
				forms[id][1].style.backgroundColor = "#f00";
				break;
			case "3":
				forms[id][1].innerHTML = "VIEW";
				forms[id][1].style.backgroundColor = "#0f0";
				break;
			default:
				console.warn("ERROR");
				console.log(forms[id]);
				break;
		}
	}
};

var solutionStatechange = function (id) {
	forms[id][1].innerHTML = "WAIT";
	forms[id][1].style.backgroundColor = "#ff0";
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText == "0" || rText == "1" || rText == "3") {
				forms[id][0].value = rText;
				change_formStyle(id);
			} else if (rText == "2") {
				show_toast(document.querySelector("#" + forms[id].id + " div p").innerHTML + " solution is removed!");
				forms[id].innerHTML = "";
			} else {
				forms[id][1].innerHTML = "ERROR";
				forms[id][1].style.backgroundColor = "#f00";
				document.writeln(rText);
			}
			timer = window.setTimeout(solutionsRefresh, 3000);
		} else {
			forms[id][1].innerHTML = "WAIT";
			forms[id][1].style.backgroundColor = "#ff0";
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?ss=" + forms[id][1].value.trim(), true);
	xmlhttp.send();
};

var solutionsRefresh = function () {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			$('solutions-container').innerHTML = rText;
			loadSolutions();
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?cc=" + $('contest-id').innerHTML, true);
	xmlhttp.send();
};


