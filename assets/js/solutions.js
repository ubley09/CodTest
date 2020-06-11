"use strict";

var $ = function (id) {
	return document.getElementById(id);
};

let forms;
let timer;
let jsonArr = {};

window.addEventListener('load', function () {
	$('isclosed-cb').addEventListener('click', function (e) {
		e.preventDefault();
		e.stopPropagation();
		isClosedChange();
	});
	forms = document.querySelectorAll("#solutions-container form");
	solutionsRefresh();
});

var loadSolutions = function () {
	forms = document.querySelectorAll("#solutions-container form");
	change_formStyle(-1);
	for (let i = 0; i < forms.length; i++) {
		forms[i].addEventListener('submit', function (e) {
			switch (jsonArr[i].solution_state) {
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
					console.warn("ERROR: " + jsonArr[i].solution_state);
					break;
			}
		});
	}
};


var change_formStyle = function (id) {
	if (id == -1) {
		for (let i = 0; i < forms.length; i++) {
			switch (jsonArr[i].solution_state) {
				case "0":
					forms[i][0].innerHTML = "CHECK THIS";
					forms[i][0].style.backgroundColor = "#d8a15a";
					break;
				case "1":
					forms[i][0].innerHTML = "CHECKING";
					forms[i][0].style.backgroundColor = "#d8a15a";
					break;
				case "2":
					forms[i][0].innerHTML = "REMOVE";
					forms[i][0].style.backgroundColor = "#f00";
					break;
				case "3":
					forms[i][0].innerHTML = "VIEW";
					forms[i][0].style.backgroundColor = "#0f0";
					break;
				default:
					console.warn("ERROR");
					console.warn(forms[i]);
					break;
			}
		}
		jQuery('[data-bs-tooltip]').tooltip();
	} else {
		switch (jsonArr[id].solution_state) {
			case "0":
				forms[id][0].innerHTML = "CHECK THIS";
				forms[id][0].style.backgroundColor = "#d8a15a";
				break;
			case "1":
				forms[id][0].innerHTML = "CHECKING";
				forms[id][0].style.backgroundColor = "#d8a15a";
				break;
			case "2":
				forms[id][0].innerHTML = "REMOVE";
				forms[id][0].style.backgroundColor = "#f00";
				break;
			case "3":
				forms[id][0].innerHTML = "VIEW";
				forms[id][0].style.backgroundColor = "#0f0";
				break;
			default:
				console.warn("ERROR");
				console.log(forms[id]);
				break;
		}
	}
};

var solutionStatechange = function (id) {
	window.clearTimeout(timer);
	forms[id][0].innerHTML = "WAIT";
	forms[id][0].style.backgroundColor = "#ff0";
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText == "0" || rText == "1" || rText == "3") {
				jsonArr[id].solution_state = rText;
				change_formStyle(id);
			} else if (rText == "2") {
				show_toast(jsonArr[id].firstname + " " + jsonArr[id].lastname + " solution is removed!");
				jsonArr.splice(id, 1);
				buildSolutionForms();
				loadSolutions();
			} else {
				forms[id][0].innerHTML = "ERROR";
				forms[id][0].style.backgroundColor = "#f00";
				document.writeln(rText);
			}
			timer = window.setTimeout(solutionsRefresh, 3000);
		} else {
			forms[id][0].innerHTML = "WAIT";
			forms[id][0].style.backgroundColor = "#ff0";
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?ss=" + jsonArr[id].id_solution, true);
	xmlhttp.send();
};

var solutionsRefresh = function () {
	window.clearTimeout(timer);
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (JSON.stringify(jsonArr) != rText) {
				jsonArr = JSON.parse(rText);
				buildSolutionForms();
				loadSolutions();
			} else {
			}
			timer = window.setTimeout(solutionsRefresh, 3000);
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?cc=" + $('contest-id').innerHTML, true);
	xmlhttp.send();
};

var buildSolutionForms = function () {
	let solutionFormsStr = "";
	for (let j = 0; j < jsonArr.length; j++) {
		solutionFormsStr +=
			`<form action="best_solution.php" method="GET" id="form_${jsonArr[j].id_solution}">\n
			<div class="d-flex d-xl-flex flex-column justify-content-between flex-lg-row align-items-lg-center flex-xl-row align-items-xl-center rating solutions">
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" id="full-name" title="Name">${jsonArr[j].firstname} ${jsonArr[j].lastname}</p>
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" title="Like">${jsonArr[j].likes}</p>
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" title="Dislike">${jsonArr[j].dislikes}</p>
				<button class="btn btn-primary" type="submit" name="s" value="${jsonArr[j].id_solution}">CHECK THIS</button>
			</div>
			</form>`;
	}
	$('solutions-container').innerHTML = solutionFormsStr;
};

var isClosedChange = function () {
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.onreadystatechange = function () {
		if (this.readyState == 4 && this.status == 200) {
			let rText = this.responseText;
			if (rText = "OK") {
				if ($('isclosed-cb').checked == true) {
					$('isclosed-cb').checked = false;
					show_toast("Your contest is now open!");
				} else {
					$('isclosed-cb').checked = true;
					show_toast("Your contest is now closed!");
				}
			} else {
				show_toast("ERROR: " + rText);
			}
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?ci=" + $('contest-id').innerHTML + "&ic=1", true);
	xmlhttp.send();
};
