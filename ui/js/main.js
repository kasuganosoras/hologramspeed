var s_playerID;
var s_Rpm = 0.0;
var s_Speed;
var s_Gear;
var s_IL;
var s_Acceleration;
var s_Handbrake;
var s_Brake;
var s_Abs;
var s_LS_r;
var s_LS_o;
var s_LS_h;
var CalcSpeed;
var speedText = '';
var inVehicle = false;
var o_rpm;
var hasFilter = false;
var OverLoadRPM = false;
var IsOverLoad = false;

$(function() {
	
    window.addEventListener("message", function(event) {
        var item = event.data;
        
        if (item.ShowHud) {
			
			inVehicle      = true;
			s_PlayerID     = item.PlayerID;
			s_Rpm          = item.CurrentCarRPM;
			s_Speed        = item.CurrentCarSpeed;
			s_Gear         = item.CurrentCarGear;
			s_IL           = item.CurrentCarIL;
			s_Acceleration = item.CurrentCarAcceleration;
			s_Handbrake    = item.CurrentCarHandbrake;
			s_Brake        = item.CurrentCarBrake;
			s_Abs          = item.CurrentCarAbs;
			s_LS_r         = item.CurrentCarLS_r;
			s_LS_o         = item.CurrentCarLS_o;
			s_LS_h         = item.CurrentCarLS_h;
			CalcSpeed      = s_Speed;
			CalcRpm        = (s_Rpm * 9);
			
			if(CalcSpeed > 999) {
				CalcSpeed = 999;
			}
			
			// Vehicle Gear display
			if(s_Gear == 0) {
				$(".geardisplay span").html("R");
				$(".geardisplay").removeClass("normalGear");
				$(".geardisplay").addClass("reverseGear");
			} else {
				$(".geardisplay").removeClass("reverseGear");
				$(".geardisplay span").html(s_Gear);
				if(CalcRpm > 7.5) {
					$(".geardisplay").removeClass("normalGear");
					$(".geardisplay").addClass("rpmOverload");
				} else {
					$(".geardisplay").removeClass("rpmOverload");
					$(".geardisplay").addClass("normalGear");
				}
			}
			
			// Vehicle RPM display
			$(".rpm").css('width', (s_Rpm * 100).toFixed(2) + '%');
			
			// Vehicle speed display
			if(CalcSpeed > 100) {
				var tmpSpeed = Math.floor(CalcSpeed) + '';
				speedText = '<span class="int1">' + tmpSpeed.substr(0, 1) + '</span><span class="int2">' + tmpSpeed.substr(1, 1) + '</span><span class="int3">' + tmpSpeed.substr(2, 1) + '</span>';
			} else if(CalcSpeed > 10 && CalcSpeed < 100) {
				var tmpSpeed = Math.floor(CalcSpeed) + '';
				speedText = '<span class="gray int1">0</span><span class="int2">' + tmpSpeed.substr(0, 1) + '</span><span class="int3">' + tmpSpeed.substr(1, 1) + '</span>';
			} else if(CalcSpeed > 0 && CalcSpeed < 10) {
				speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="int3">' + Math.floor(CalcSpeed) + '</span>';
			} else {
				speedText = '<span class="gray int1">0</span><span class="gray int2">0</span><span class="gray int3">0</span>';
			}
			
			// Handbrake
			if(s_Handbrake) {
				$(".handbrake").html("HBK");
			} else {
				$(".handbrake").html('<span class="gray">HBK</span>');
			}
			
			// Brake ABS
			if(s_Brake > 0) {
				if(!s_Abs) {
					$(".abs").html("ABS");
				} else {
					$(".abs").html('<span class="gray">ABS</span>');
				}
			} else {
				$(".abs").html('<span class="gray">ABS</span>');
			}
			
			// Display speed and container
			$(".speeddisplay").html(speedText);
			$(".speedometer").fadeIn(500);
			
        } else if (item.HideHud) {
			
			// Hide GUI
			$(".speedometer").fadeOut(500);
			inVehicle = false;
        }
    });
});