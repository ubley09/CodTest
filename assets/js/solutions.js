"use strict";

var $ = function (id) {
	return document.getElementById(id);
};

let forms;
let timer;
let jsonArrText = "";

window.addEventListener('load', function () {
	forms = document.querySelectorAll("#solutions-container form");
	solutionsRefresh();
});

var loadSolutions = function () {
	forms = document.querySelectorAll("#solutions-container form");
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
		jQuery('[data-bs-tooltip]').tooltip();
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
			if (jsonArrText != rText) {
				jsonArrText = rText;
				let jsonObj = JSON.parse(jsonArrText);
				buildSolutionForms(jsonObj);
				loadSolutions();
			} else {
				timer = window.setTimeout(solutionsRefresh, 3000);
			}
		}
	};
	xmlhttp.open("GET", "assets/php/solutions_p.php?cc=" + $('contest-id').innerHTML, true);
	xmlhttp.send();
};

var buildSolutionForms = function (jsonArr) {
	let solutionFormsStr = "";
	for (let j = 0; j < jsonArr.length; j++) {
		solutionFormsStr +=
			`<form action="best_solution.php" method="GET" id="form_${jsonArr[j].id_solution}">\n
			<div class="d-flex d-xl-flex flex-column justify-content-between flex-lg-row align-items-lg-center flex-xl-row align-items-xl-center rating solutions">
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" id="full-name" title="Name">${jsonArr[j].firstname} ${jsonArr[j].lastname}</p>
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" title="Like">${jsonArr[j].likes}</p>
				<p data-toggle="tooltip" data-bs-tooltip="" data-placement="left" title="Dislike">${jsonArr[j].dislikes}</p>
				<input type="hidden" name="solution_state" id="ss_${jsonArr[j].id_solution}" value="${jsonArr[j].solution_state}">
				<button class="btn btn-primary" type="submit" name="s" value="${jsonArr[j].id_solution}">CHECK THIS</button>
			</div>
			</form>`;

	}
	$('solutions-container').innerHTML = solutionFormsStr;

};

