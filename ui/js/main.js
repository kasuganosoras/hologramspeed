const DisplayRoot = document.getElementById("displayRoot");
const GearDisplay = document.getElementById("gearDisplay");
const GearNum = document.getElementById("gearNum");
const UnitDisplay = document.getElementById("unitDisplay");
const AbsIndicator = document.getElementById("absIndicator");
const HBrakeIndicator = document.getElementById("hBrakeIndicator");
const RpmDisplay = document.getElementById("rpmBar");
const SpeedDisplay = [
	document.getElementById("speedDisplayDigit_0"),
	document.getElementById("speedDisplayDigit_1"),
	document.getElementById("speedDisplayDigit_2"),
];
var useMetric = true;

function changeTheme(name) {
	const oldThemeElement = document.getElementById("themeStylesheet");
	
	if (name != "default") {
		const newThemeElement = document.createElement("link");
		newThemeElement.href = `css/themes/${name}.css`;
		newThemeElement.rel = "stylesheet";
		newThemeElement.type = "text/css";
		newThemeElement.id = "themeStylesheet";
		document.head.appendChild(newThemeElement);
	}

	if (oldThemeElement != undefined) oldThemeElement.remove();
}

window.addEventListener("message", function(ev) {
	const data = ev.data;

	if (data.theme != undefined) changeTheme(data.theme);

	if (data.useMetric != undefined) {
		const useMetricNow = data.useMetric != false;
		if (useMetric != useMetricNow) {
			useMetric = useMetricNow;
			UnitDisplay.innerText = useMetric ? "KMH" : "MPH";
		}
	}

	if (data.rawSpeed != undefined) {
		var multiplier = useMetric ? 3.6 : 2.236936;
		var unitSpeed = Math.floor(parseFloat(data.rawSpeed) * multiplier);
		var speedString = unitSpeed.toString().padStart(3, '&');

		if (speedString.length > 3) speedString = "999";

		for (let i = 0; i < 3; i++) {
			SpeedDisplay[i].innerText = speedString[i] == "&" ? "" : speedString[i]; 
		}
	}

	if (data.gear != undefined) {
		const gear = parseInt(data.gear);
		if (gear == 0) {
			GearNum.innerText = "R";
			GearDisplay.classList.add("reverseGear");
			GearDisplay.classList.remove("normalGear");
		} else {
			GearNum.innerText = gear;
			GearDisplay.classList.remove("reverseGear");
			GearDisplay.classList.add("normalGear");
		}
	}

	if (data.rpm != undefined) {
		const rawRpm = parseFloat(data.rpm);
		RpmDisplay.style.width = `${(parseFloat(data.rpm) * 100.0).toFixed(2)}%`;
		GearDisplay.classList.toggle("rpmOverload", (rawRpm * 9) > 7.5);
	}

	if (data.hBrake != undefined) HBrakeIndicator.classList.toggle("inactive", data.hBrake == false);
	
	if (data.abs != undefined) AbsIndicator.classList.toggle("inactive", data.abs == false);

	if (data.display != undefined) DisplayRoot.classList.toggle("hidden", !data.display);
});

// Due to loading order, we need to let the resource side know when *we* are ready.
// Just having the browser "loaded" isn't enough.
fetch(`https://${document.location.host}/duiIsReady`, {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json; charset=UTF-8',
    },
    body: JSON.stringify({ok: true})
})