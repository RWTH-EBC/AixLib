within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function cBotUp
  input Modelica.Units.SI.TemperatureDifference dTover;
  input Modelica.Units.SI.TemperatureDifference dT13;

  output Real c_bot_up;
protected
  parameter Real a= 0.5241;
  parameter Real b(unit="1/K")= 0.08312;
  parameter Real c(unit="1/K")=0.04731;

algorithm
  c_bot_up:=a*exp(-b*dTover)*exp(c*dT13);

end cBotUp;
