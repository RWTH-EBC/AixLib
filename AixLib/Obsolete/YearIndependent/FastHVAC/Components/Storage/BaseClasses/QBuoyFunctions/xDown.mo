within AixLib.Obsolete.YearIndependent.FastHVAC.Components.Storage.BaseClasses.QBuoyFunctions;
function xDown

  input Modelica.Units.SI.TemperatureDifference dTover;
  input Real dh_gap;
  output Real xdown;

  parameter Real a=0.1336;
  parameter Real b=0.2859;
  parameter Real c(unit="1/K")=0.1442;
  parameter Real d=0.3666;

algorithm

xdown:=a + b*(1 - exp(-c*dTover))*exp(-d*dh_gap);

end xDown;
