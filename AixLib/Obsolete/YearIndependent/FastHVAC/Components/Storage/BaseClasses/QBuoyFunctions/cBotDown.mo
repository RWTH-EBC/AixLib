within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function cBotDown
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dT13;

  output Real c_bot_down;

protected
  parameter Real a=7.181;
  parameter Real b(unit="1/K")= 0.1012;
  parameter Real c(unit="1/K")=0.6199;
algorithm
  c_bot_down:=a*exp(-b*dTover)*(1 - exp(-c*dT13));

end cBotDown;
